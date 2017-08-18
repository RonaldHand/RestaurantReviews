using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class RestaurantSearchCriteria
    {
        public string Name { get; set; }
        public string State { get; set; }
        public string City { get; set; }

        public IEnumerable<int> Features { get; set; }
        public IEnumerable<int> Categories { get; set; }
    }
}
