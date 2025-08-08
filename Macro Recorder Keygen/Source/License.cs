using System;
using System.Security.Cryptography;
using System.Text;

namespace Keygen
{
    public static class License
    {
        private const string privateKeyXml = "<DSAKeyValue><P>3N35IcqKMJLdrg5HmSYa6duURBVDNZgj7BCnwcz/ufmuTgBqQSf3cxqHNTX31BTKJWBBdfF2LxA+uLRmTXZGzw==</P><Q>hEN4EgQsu/HHDcZh9Qwxg43wkL8=</Q><G>gYixcJeFwqXYS9td15uvi1o5Ontd6U00qjtvo7aPo4ccNB7jt5SGLEBM9RPsYPKnmC8PRBze5gm2MBgZIm4YsQ==</G><Y>RSijtNxu4sTZc50YrQLR19KX3PEsIGSrvcRYdAUKb1nWGJNY0aAdt/E5HtbMbSqIFPI3mLcOYdgxu9WyzGkRNw==</Y><J>AAAAAat+p7co8MRenHZUQ+BsY94gSFBLvhftoBGgwzmSBZZc+PRlV6daw3iAVN6y</J><Seed>J0VzBGcedEyNe+AWgq/mC/Wf9RU=</Seed><PgenCounter>pg==</PgenCounter><X>EaOoelpYoydZvGFMZHUobAPlfSY=</X></DSAKeyValue>";
       
        private static byte[] Combine(byte[] first, byte[] second)
        {
            byte[] bytes = new byte[first.Length + second.Length];
            Buffer.BlockCopy(first, 0, bytes, 0, first.Length);
            Buffer.BlockCopy(second, 0, bytes, first.Length, second.Length);
            return bytes;
        }

        private static int GetMonthDifference(DateTime startDate, DateTime endDate)
        {
            int monthsApart = 12 * (startDate.Year - endDate.Year) + startDate.Month - endDate.Month;
            return Math.Abs(monthsApart);
        }
        
        private static byte[] IntToDoubleByte(int value)
        {
            return new byte[] {(byte)(value >> 8), (byte)value};
        }
        
        private static byte[] SignData(string message, string privateKeyXml)
        {
            byte[] array;
            
            using (DSACryptoServiceProvider dsacryptoServiceProvider = new DSACryptoServiceProvider(512))
            {
                dsacryptoServiceProvider.FromXmlString(privateKeyXml);
                byte[] bytes = new UTF8Encoding().GetBytes(message);
                array = dsacryptoServiceProvider.SignData(bytes);
                dsacryptoServiceProvider.PersistKeyInCsp = false;
            }
            
            return array;
        }
        
        public static string GenerateSerial(string userName, DateTime expirationDate)
        {
            if (!string.IsNullOrEmpty(userName))
            {
                var signature = SignData(userName, privateKeyXml);
                var months = GetMonthDifference(new DateTime(2000, 1, 1), expirationDate.AddDays(1.0)) << 1;
                var data = Combine(signature, IntToDoubleByte(months));
                return Convert.ToBase64String(data);
            }
            
            return string.Empty;
        }
    }
}
