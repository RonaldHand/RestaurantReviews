using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public static class UserManager
    {

        public static List<DTO.UserReview> GetReviews(int userid)
        {
            return DAL.Repos.RestaurantRepo.GetUserReviews(userid);
        }

    }
}
