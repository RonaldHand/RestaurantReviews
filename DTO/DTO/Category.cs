using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace DTO
{
    public class Category: DTOBase
    {
        public int Id { get; set; }

        [Required]
        [Display(Name = "Category Name", Description = "Category Name")]
        [DisplayFormat(ConvertEmptyStringToNull = true, NullDisplayText = "[Enter Category Name]")]
        public string CategoryName { get; set; }

    }
}
