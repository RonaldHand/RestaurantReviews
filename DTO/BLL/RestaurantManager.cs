using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public static class RestaurantManager
    {
       public static IEnumerable<DTO.Restaurant> GetRestaurantList(string state, string city, IEnumerable<DTO.Category> categories, IEnumerable<DTO.Feature> features)
        {
            return null;
        }
    }
}
