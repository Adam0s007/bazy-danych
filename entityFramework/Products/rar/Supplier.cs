using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AdamBistaEFProducts
{
    [Table("Suppliers")]
    public class Supplier : Company
    {
        public int SupplierID { get; set; }
        public string BankAccountNumber { get; set; }
    }

}
