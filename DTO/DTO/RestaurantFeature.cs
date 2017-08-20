using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class RestaurantFeature: DTOBase
    {
        public int? Id { get; set; }

        [Required]
        [Display(Name = "Category Id", Description = "Category Id")]
        public int? RestaurantId { get; set; }

        [Required]
        [Display(Name = "Feature Id", Description = "Feature Id")]
        public int? FeatureID { get; set; }

        [Required]
        [Display(Name = "Category Name", Description = "Category Name")]
        public string FeatureName { get; set; }

    }
}
