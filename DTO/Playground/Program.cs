using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Playground
{
    class Program
    {
        static void Main(string[] args)
        {
            FindRestaurant_Test(string.Empty, string.Empty, string.Empty, new List<int>(), new List<int>());
            FindRestaurant_Test(string.Empty, string.Empty, "PA", new List<int>(), new List<int>());
            FindRestaurant_Test("Panda", string.Empty, string.Empty, new List<int>(), new List<int>());


            GetRestaurant_Test(1);
            GetRestaurant_Test(5);

            GetUserReview_Test(1);




            CreateReview_Test(1, 1, "Good", 5);

            AddRestaurant_Test("New Restaurant 1", "Now Serving Food", "Street Address Name", "", "Hampton", "PA", "", "", "", "");

            Console.ReadLine();
        }

        static private void FindRestaurant_Test(string name, string city, string state, List<int> feature, List<int> category)
        {
            var x = new DTO.RestaurantSearchCriteria()
            {
                Name = name,
                City = city,
                State =  state,
                Features = feature,
                Categories = category
            };

            Console.WriteLine($"Find restaurant where name: {name} city: {city} state: {state} feature: {string.Join(",", feature)} category: {string.Join(",", category)}");

            var y = BLL.RestaurantManager.Find(x);
            foreach (var item in y)
            {
                Console.WriteLine($"Restaurant ID: {item.Id} Restaurant Name: {item.ItemName}");
            }
            Console.WriteLine();
        }

        static private void AddRestaurant_Test(string name, string description, string address1, string address2, string city, string state, string zip, string phonenumber, string fax, string email)
        {
            try
            {
                var x = BLL.RestaurantManager.AddRestaurant(name, description, address1, address2, city, state, zip, phonenumber, fax, email);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }

        static private void GetRestaurant_Test(int id)
        {
            try
            {
                var x = BLL.RestaurantManager.GetRestaurant(id);
                Console.WriteLine($"{x.Name} [city: {x.ContactInfo.City}, state: {x.ContactInfo.State}, zip: {x.ContactInfo.ZipCode}]");
                Console.WriteLine($"Categories: {string.Join(",", x.Categories.Select(e => e.CategoryName))}");
                Console.WriteLine($"Features: {string.Join(",", x.Features.Select(e => e.FeatureName))}");
                Console.WriteLine($"Social Media: {string.Join(",", x.SocialMediaLinks.Select(e => e.SocialMediaLink))}");
                Console.WriteLine();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Oops: Error is: {ex.Message}");
            }
        }

        static private void CreateReview_Test(int userid, int restaurantid, string comment, int rating)
        {
            BLL.RestaurantManager.PostReview(new DTO.RestaurantReview() { UserId = userid, RestaurantId = restaurantid, ReviewComment = comment, Rating = rating });
            Console.WriteLine($"Review Posted");
            Console.WriteLine();
        }

        static private void GetUserReview_Test(int userid)
        {
            var x = BLL.UserManager.GetReviews(userid);
            foreach (var item in x)
            {
                Console.WriteLine($"Restaurant ID: {item.RestaurantName} Rating: {item.Rating} Comment: {item.ReviewComment}");
            }
            Console.WriteLine();
        }

    }
}
