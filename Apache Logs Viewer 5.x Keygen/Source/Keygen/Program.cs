using System;
using System.Text;

namespace Keygen
{
    class Program
    {
        public static string GenerateUnlockCode()
        {
            var random = new Random();
            var result = new StringBuilder();
            result.Append("F");
            result.Append(random.Next(256).ToString("X2"));
            result.Append("IALV");
            result.Append(random.Next(1000).ToString("D4"));
            result.Append((random.Next(10) <= 4) ? "2" : "3");

            int num = 0;
            byte[] bytes = Encoding.ASCII.GetBytes(result.ToString().Insert(1, ":").Insert(5, ":").Insert(9, ":").Insert(13, ":"));

            for (int i = 0; i < bytes.Length; i++)
            {
                if (bytes[i] % 2 == 0)
                    num++;
            }
            
            result.Append(num.ToString("D2"));
            bytes = Encoding.ASCII.GetBytes(result.ToString());
            result.Clear();
            num = 1;
            
            foreach (byte b in bytes)
            {                
                result.Append(b.ToString("X2"));
                
                if (num < 14 && (num++ % 2) == 0)
                    result.Append("-");
            }

            return result.ToString();        
        }
        
        public static void Main(string[] args)
        {
            Console.WriteLine("Apache Logs Viewer 5.x Keygen [by RadiXX11]");
            Console.WriteLine("===========================================\n");
            Console.WriteLine("Unlock Code: {0}\n", GenerateUnlockCode());
            Console.WriteLine("--------------------------------------------------------------------");
            Console.WriteLine("IMPORTANT! Add the following entry to your hosts file before unlock:\n\n127.0.0.1 www.apacheviewer.com");
            Console.WriteLine("--------------------------------------------------------------------\n");            
            Console.Write("Press any key to continue . . . ");
            Console.ReadKey(true);
        }
    }
}