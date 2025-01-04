// See https://aka.ms/new-console-template for more information


namespace AdamBistaEFProducts
{
    class Program
    {
        static void Main(string[] args)
        {
            ProductContext productContext = new ProductContext();
            // Usuń wszystkie produkty
            /*var AllCustomers = productContext.Customers.ToList();
            productContext.Customers.RemoveRange(AllCustomers);
            productContext.SaveChanges();

            // Usuń wszystkich dostawców
            var allSuppliers = productContext.Suppliers.ToList();
            productContext.Suppliers.RemoveRange(allSuppliers);
            productContext.SaveChanges();*/


            ProductContext context = new ProductContext();

            // Pobieranie danych
            var suppliers = context.Suppliers.ToList();
            var customers = context.Customers.ToList();

            // Wypisywanie danych
            Console.WriteLine("Suppliers:");
            foreach (var supplier in suppliers)
            {
                Console.WriteLine($"SupplierID: {supplier.SupplierID}, CompanyName: {supplier.CompanyName}, Street: {supplier.Street}, City: {supplier.City}, ZipCode: {supplier.ZipCode}, BankAccountNumber: {supplier.BankAccountNumber}");
            }

            Console.WriteLine("\nCustomers:");
            foreach (var customer in customers)
            {
                Console.WriteLine($"CustomerID: {customer.CustomerID}, CompanyName: {customer.CompanyName}, Street: {customer.Street}, City: {customer.City}, ZipCode: {customer.ZipCode}, Discount: {customer.Discount}");
            }


        }
    }
}