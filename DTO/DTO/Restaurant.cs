
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace DTO
{
    public class Restaurant : DTOBase
    {


        public int Id { get; set; }

        [Required]
        [Display(Name = "Restaurant Name", Description = "Restaurant Name")]
        [DisplayFormat(ConvertEmptyStringToNull = true, NullDisplayText = "[Enter Restaurant Name]")]
        public string Name { get; set; }

        [Required]
        [Display(Name = "Restaurant Description", Description = "Restaurant Description")]
        [DisplayFormat(ConvertEmptyStringToNull = true, NullDisplayText = "[Enter Restaurant Description]")]
        public string Description { get; set; }

        public ContactInformation ContactInfo { get; set; }

        

    }
}
