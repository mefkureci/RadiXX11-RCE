using System;

namespace Keygen
{
    class Program
    {
        public static void Main(string[] args)
        {
            Console.WriteLine("Jitbit Software Macro Recorder Keygen [by RadiXX11]");
            Console.WriteLine("===================================================\n");
            Console.Write("Username: ");
            
            var userName = Console.ReadLine();
            
            if (!string.IsNullOrEmpty(userName))
                Console.WriteLine("Serial..: {0}\n", License.GenerateSerial(userName, new DateTime(2050, 1, 1)));

            Console.Write("Press any key to continue...");
            Console.ReadKey(true);
        }
    }
}