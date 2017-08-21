using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PsuedoMVCProject.Controllers
{
    public class RestaurantController : Controller
    {
        [ActionName("GetRestaurant")]
        public ActionResult GetRestaurant(int id)
        {
            return View(BLL.RestaurantManager.GetRestaurant(id));
        }
                
        [ActionName("Find")]
        public ActionResult Find(DTO.RestaurantSearchCriteria criteria)
        {
            return View(BLL.RestaurantManager.Find(criteria));
        }

        [ActionName("AddRestaurant")]
        public ActionResult AddRestaurant(string name, string description, string address1, string address2, string city, string state, string zip, string phonenumber, string fax, string email)
        {
            var retval = new DTO.Restaurant();
            try
            {
                var x = BLL.RestaurantManager.AddRestaurant(name, description, address1, address2, city, state, zip, phonenumber, fax, email);
                retval = BLL.RestaurantManager.GetRestaurant(x.Value);
            }
            catch (Exception ex)
            {
                //TODO: Log Error 
                ModelState.AddModelError("", "Unable to create restauranat changes. Try again, and if the problem persists, see your system administrator.");
            }
            return View(retval);
        }

    }
}