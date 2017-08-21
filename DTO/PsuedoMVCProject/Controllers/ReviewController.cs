using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PsuedoMVCProject.Controllers
{
    public class ReviewController : Controller
    {
        // GET: Review
        [ActionName("PostReview")]
        public ActionResult PostReview(DTO.RestaurantReview data)
        {
            BLL.RestaurantManager.PostReview(data);
            return View();
        }

        [ActionName("DeleteReview")]
        public ActionResult DeleteReview(int id)
        {
            BLL.RestaurantManager.DeleteReview(id);
            return View();
        }

        [ActionName("DeleteReview")]
        public ActionResult GetUserReviews(int userid)
        {
            var x = BLL.UserManager.GetReviews(userid);
            return View(x);
        }

    }
}