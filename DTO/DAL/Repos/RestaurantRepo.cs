using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Core.EntityClient;
using System.Data.Entity.Core.Objects;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Repos
{
    public static class RestaurantRepo
    {
        public static IEnumerable<DTO.IdNamePair> FindRestaurant(DTO.RestaurantSearchCriteria criteria)
        {
            if (string.IsNullOrEmpty(criteria.Name)) criteria.Name = String.Empty;
            if (string.IsNullOrEmpty(criteria.City)) criteria.City = String.Empty;
            if (string.IsNullOrEmpty(criteria.State)) criteria.State = String.Empty;

            DataSet retVal = new DataSet();
            using (var ctx = new RestaurantReviewEntities())
            {
                var dtFeatures = Helper_CustomTypes.LoadIDList(criteria.Features);
                var dtCategories = Helper_CustomTypes.LoadIDList(criteria.Categories);
                SqlConnection cn = (SqlConnection)ctx.Database.Connection;
                using (var cmd = new System.Data.SqlClient.SqlCommand("[dbo].[Restaurant_Find]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("name", criteria.Name));
                    cmd.Parameters.Add(new SqlParameter("state", criteria.State));
                    cmd.Parameters.Add(new SqlParameter("city", criteria.City));
                    cmd.Parameters.Add(new SqlParameter("featurelist", SqlDbType.Structured) { TypeName = "[dbo].[IdList]", SqlValue = dtFeatures });
                    cmd.Parameters.Add(new SqlParameter("categorylist", SqlDbType.Structured) { TypeName = "[dbo].[IdList]", SqlValue = dtCategories });
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(retVal);
                }
            }
            return retVal.Tables[0].AsEnumerable().Select(row => Transform_RestrauntListItem(row)).ToList();
        }

        /// <summary>
        /// Returns a full restaurant information data.
        /// Used pure EF for this method
        /// </summary>
        /// <param name="id"></param>
        public static DTO.Restaurant GetRestaurant(int id)
        {
            using (var ctx = new RestaurantReviewEntities())
            {
                Restaurant a = ctx.Restaurants.Find(id);
                return Transform_FullRestaurantData(a);
            }
        }

        public static int? AddRestaurant(string name, string description, string address1, string address2, string city, string state, string zipcode, string phonenumber, string faxnumber, string email)
        {
            using (var ctx = new RestaurantReviewEntities())
            {
                ObjectParameter Output = new ObjectParameter("id", typeof(int));
                ctx.Restaurant_Create(name, description, address1, address2, city, state, zipcode, phonenumber, faxnumber, email, Output);
                return Output.Value as int?;
            }
        }

        //TODO: Move to Review Repo
        public static void AddReview(int? userid, int? restaurantid, string comment, int? rating)
        {
            using (var ctx = new RestaurantReviewEntities())
            {
                ctx.Review_Create(userid, restaurantid, comment, rating);
            }
        }

        //TODO: Move to Review Repo
        public static List<DTO.UserReview> GetUserReviews(int userid)
        {
            using (var ctx = new RestaurantReviewEntities())
            {
                User a = ctx.Users.Find(userid);
                return a.Reviews.Select(r => Transform_UserReview(r)).ToList();
            }
        }

        public static void DeleteReview (int reviewId)
        {
            using (var ctx = new RestaurantReviewEntities())
            {
                var x = ctx.Reviews.Find(reviewId);
                ctx.Reviews.Remove(x);
                ctx.SaveChanges();
            }
        }

        #region Transformations

        private static DTO.IdNamePair Transform_RestrauntListItem(DataRow row)
        {
            return new DTO.IdNamePair { Id = row["id"] as int?, ItemName = row["restaurant_name"] as string };
        }

        private static DTO.Restaurant Transform_FullRestaurantData(Restaurant data)
        {
            return new DTO.Restaurant()
            {
                Id = data.id,
                Name = data.restaurant_name,
                Description = data.description,
                ContactInfo = Transform_ContactInfo(data.ContactInformation),
                Features = data.RestaurantFeatures.Select(r => Transform_RestaurantFeature(r)).ToList(),
                SocialMediaLinks = data.RestaurantSocialMedias.Select(r => Transform_RestaurantSocialMedia(r)).ToList(),
                Categories = data.RestaurantCategories.Select(r => Transform_RestaurantCategory(r)).ToList(),
                Reviews = data.Reviews.Select(r => Transform_RestaurantReview(r)).ToList()
            };
        }

        private static DTO.RestaurantFeature Transform_RestaurantFeature(RestaurantFeature data)
        {
            return new DTO.RestaurantFeature()
            {
                Id = data.id,
                FeatureID = data.feature_id,
                FeatureName = data.Feature.feature_name,
                RestaurantId = data.restaurant_id
            };
        }

        private static DTO.RestaurantSocialMediaSetting Transform_RestaurantSocialMedia(RestaurantSocialMedia data)
        {
            return new DTO.RestaurantSocialMediaSetting()
            {
                Id = data.id,
                RestaurantId = data.restaurant_id,
                SocialMediaId = data.social_media_id,
                SocialMediaName = data.SocialMedia.social_media_name,
                SocialMediaLink = data.social_media_link
            };
        }

        private static DTO.RestaurantCategory Transform_RestaurantCategory(RestaurantCategory data)
        {
            return new DTO.RestaurantCategory()
            {
                Id = data.id,
                RestaurantId = data.restaurant_id,
                CategoryId = data.category_id,
                CategoryName = data.Category.category_name
            };
        }

        private static DTO.RestaurantReview Transform_RestaurantReview(Review data)
        {
            return new DTO.RestaurantReview()
            {
                Id = data.id,
                RestaurantId = data.restaurant_id,
                ReviewComment = data.review_comment,
                Rating = data.rating,
                UpVotes = data.up_votes,
                UserId = data.user_id,
                UserName = data.User.login_name
            };
        }
        private static DTO.UserReview Transform_UserReview(Review data)
        {
            return new DTO.UserReview()
            {
                Id = data.id,
                RestaurantId = data.restaurant_id,
                ReviewComment = data.review_comment,
                Rating = data.rating,
                UpVotes = data.up_votes,
                UserId = data.user_id,
                RestaurantName = data.Restaurant.restaurant_name
            };
        }


        

        public static DTO.ContactInformation Transform_ContactInfo(ContactInformation data)
        {
            return new DTO.ContactInformation()
            {
                Id = data.id,
                Address1 = data.address_1,
                Address2 = data.address_2,
                City = data.city,
                State = data.state,
                ZipCode = data.zip_code,
                Email = data.email,
                FaxNumber = data.fax_number,
                PhoneNumber = data.phone_number
            };
        }

        #endregion

    }
}
