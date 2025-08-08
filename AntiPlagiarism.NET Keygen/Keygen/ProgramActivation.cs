using System;
using System.Text;
using System.Security.Cryptography;

namespace Keygen
{
    public static class ProgramActivation
    {
        private static byte[] GetMD5Hash(string input)
        {
            HashAlgorithm hashAlgorithm = new MD5CryptoServiceProvider();
            byte[] bytes = Encoding.UTF8.GetBytes(input);
            return hashAlgorithm.ComputeHash(bytes);
        }
        
        public static string GenerateUnlimitedSerialNumber()
        {            
            const string text = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            var array = new int[]
            {
                4,
                29,
                7,
                0,
                15,
                3,
                33,
                17,
                13,
                5,
                12,
                0,
                19,
                29,
                11,
                23,
                9,
                35,
                17,
                1,
                12,
                33,
                4,
                13,
                0,
                30,
                11,
                32,
                17,
                10
            };          
            
            var stringBuilder = new StringBuilder(30);
            byte[] md5Hash = GetMD5Hash(new Random().Next(100000).ToString());
                
            for (int j = 0; j < 30; j++)
            {
                if (j % 5 == 0 && j != 0)
                    stringBuilder.Append('-');

                int num = (j <= 15) ? ((int)md5Hash[j]) : ((int)md5Hash[30 - j] + j);
                int index = (array[j] + num) % text.Length;
                stringBuilder.Append(text[index]);
            }
                
            return stringBuilder.ToString();
        }
    }
}
