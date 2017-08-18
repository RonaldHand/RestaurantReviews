//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class Review
    {
        public int id { get; set; }
        public int user_id { get; set; }
        public int restaurant_id { get; set; }
        public string review_comment { get; set; }
        public Nullable<int> up_votes { get; set; }
        public Nullable<int> reported_abuse { get; set; }
        public Nullable<int> rating { get; set; }
        public Nullable<System.DateTime> date_created { get; set; }
        public Nullable<System.DateTime> date_modified { get; set; }
    
        public virtual Restaurant Restaurant { get; set; }
        public virtual User User { get; set; }
    }
}