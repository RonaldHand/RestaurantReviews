using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public  class RestaurantSocialMediaSetting: DTOBase
    {
        public int? Id { get; set; }

        [Required]
        [Display(Name = "Restaurant Id", Description = "Restaurant Id")]
        public int? RestaurantId { get; set; }

        [Required]
        [Display(Name = "Social Media Id", Description = "Social Media Id")]
        public int? SocialMediaId { get; set; }

        [Required]
        [Display(Name = "Social Media Name", Description = "Social Media Name")]
        public string SocialMediaName { get; set; }

        [Required]
        [Display(Name = "Social Media Link", Description = "Social Media Link")]
        public string SocialMediaLink { get; set; }
    }
}
