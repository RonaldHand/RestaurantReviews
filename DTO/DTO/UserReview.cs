using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class UserReview:DTOBase
    {
        public int Id { get; set; }

        [Required]
        [Display(Name = "Restaurant Id", Description = "Restaurant Id")]
        public int? RestaurantId { get; set; }

        [Required]
        [Display(Name = "User Id", Description = "User Id")]
        public int UserId { get; set; }

        [Display(Name = "Restaurant Name", Description = "Restaurant Name")]
        public string RestaurantName { get; set; }

        [Display(Name = "Review Comment", Description = "Review Comment")]
        public string ReviewComment { get; set; }

        [Display(Name = "Up Votes", Description = "Up Votes")]
        public int? UpVotes { get; set; }

        [Required]
        [Display(Name = "Rating", Description = "Rating")]
        [Range(1, 5)]
        public int? Rating { get; set; }
    }


}
