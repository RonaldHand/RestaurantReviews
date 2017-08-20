using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace DTO
{
    public class ContactInformation : DTOBase
    {
        public int? Id { get; set; }

        [Required]
        [Display(Name = "Address 1", Description = "Address Line 1")]
        public string Address1 { get; set; }

        [Display(Name = "Address 2", Description = "Address Line 2")]
        public string Address2 { get; set; }

        [Required]
        [Display(Name = "City", Description = "City")]
        public string City { get; set; }

        [Required]
        [Display(Name = "State", Description = "State")]
        [StringLength(2, ErrorMessage = "Expects 2 character state abbreviation.")]
        public string State { get; set; }

        [Required]
        [Display(Name = "Zip Code", Description = "Zip Code")]
        public string ZipCode { get; set; }

        [Display(Name = "Phone Number", Description = "Phone Number")]
        public string PhoneNumber { get; set; }

        [Display(Name = "Fax Number", Description = "Fax Number")]
        public string FaxNumber { get; set; }

        [Display(Name = "Email", Description = "Email")]
        public string Email { get; set; }
    }

}
