using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AdamBistaEFProducts
{
    [Table("Customers")]
    public class Customer : Company
    {
        public int CustomerID { get; set; }
        public double Discount { get; set; }
    }

}
