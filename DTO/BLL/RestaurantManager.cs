using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public static class RestaurantManager
    {
        //Software Requirement 1:
        //GET A LIST OF RESTAURANTS BY CITY
        //Added criteria allowing users to search by state, category, and features
       public static IEnumerable<DTO.IdNamePair> Find(DTO.RestaurantSearchCriteria criteria)
        {
            return DAL.Repos.RestaurantRepo.FindRestaurant(criteria);
        }

        public static int? AddRestaurant(string name, string description, string address1, string address2, string city, string state, string zip, string phonenumber, string fax, string email)
        {
             return DAL.Repos.RestaurantRepo.AddRestaurant(name, description, address1, address2, city, state, zip, phonenumber, fax, email);
        }

        public static DTO.Restaurant GetRestaurant(int id)
        {
            return DAL.Repos.RestaurantRepo.GetRestaurant(id);
        }

        public static void PostReview(DTO.RestaurantReview data)
        {
            DAL.Repos.RestaurantRepo.AddReview(data.UserId, data.RestaurantId, data.ReviewComment, data.Rating);
        }
    }
}
