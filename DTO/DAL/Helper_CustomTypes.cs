using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public static class Helper_CustomTypes
    {
        public static DataTable LoadIDList(IEnumerable<int> idlist)
        {
            var dt = new DataTable();
            dt.Columns.Add("Id");

            if (idlist != null)
            {
                foreach (var r in idlist)
                {
                    var row = dt.NewRow();
                    row["Id"] = r;
                    dt.Rows.Add(row);
                }
            }
            return dt;
        }
    }
}
