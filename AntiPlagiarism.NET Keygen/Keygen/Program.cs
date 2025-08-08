using System;

namespace Keygen
{
    class Program
    {
        public static void Main(string[] args)
        {
            // AntiPlagiarism.NET - https://antiplagiarism.net
            
            Console.WriteLine("AntiPlagiarism.NET Keygen [by RadiXX11]");
            Console.WriteLine("=======================================\n");
            
            Console.WriteLine("Serial: {0}\n", ProgramActivation.GenerateUnlimitedSerialNumber());
            
            Console.Write("Press any key to continue . . . ");
            Console.ReadKey(true);
        }
    }
}