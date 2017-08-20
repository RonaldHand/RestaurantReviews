using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace DTO
{
    public class Feature : DTOBase
    {
        public int? Id { get; set; }

        [Required]
        [Display(Name = "Feature Name", Description = "Feature Name")]
        [DisplayFormat(ConvertEmptyStringToNull = true, NullDisplayText = "[Enter Feature Name]")]
        public string FeatureName { get; set; }

    }
}
