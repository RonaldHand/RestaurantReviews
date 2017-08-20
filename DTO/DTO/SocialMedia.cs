using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace DTO
{
    public class SocialMedia : DTOBase
    {
        public int? Id { get; set; }

        [Required]
        [Display(Name = "Social Media Name", Description = "Social Media Name")]
        [DisplayFormat(ConvertEmptyStringToNull = true, NullDisplayText = "[Enter Social Media Name]")]
        public string CategoryName { get; set; }
    }
}
