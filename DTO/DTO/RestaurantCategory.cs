using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class RestaurantCategory:DTOBase
    {
        public int? Id { get; set; }
        [Required]
        [Display(Name = "Restaurant Id", Description = "Restaurant Id")]
        public int? RestaurantId { get; set; }

        [Required]
        [Display(Name = "Category Id", Description = "Category Id")]
        public int? CategoryId { get; set; }

        [Display(Name = "Category Name", Description = "Category Name")]
        public string CategoryName { get; set; }

    }
}
