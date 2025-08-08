using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using System;
using System.IO;
using System.Management;
using System.Security.Cryptography;
using System.Text;

namespace Keygen
{
    public class ProductLicense
    {
        readonly string appCode;
        readonly string appName;
        readonly string licFileExt;
            
        private static string GetMotherBoardID()
        {
            try
            {
                string text = string.Empty;
                
                var query = new SelectQuery("Win32_BaseBoard");
                var managementObjectSearcher = new ManagementObjectSearcher(query);
                ManagementObjectCollection.ManagementObjectEnumerator enumerator = managementObjectSearcher.Get().GetEnumerator();
                
                while (enumerator.MoveNext())
                {
                    ManagementBaseObject managementBaseObject = enumerator.Current;
                    var managementObject = (ManagementObject)managementBaseObject;
                    text += GetNonNullString(Conversions.ToString(managementObject["Model"]));
                    text += GetNonNullString(Conversions.ToString(managementObject["Manufacturer"]));
                    text += GetNonNullString(Conversions.ToString(managementObject["Name"]));
                    text += GetNonNullString(Conversions.ToString(managementObject["SerialNumber"]));
                }

                if (enumerator != null)
                    ((IDisposable)enumerator).Dispose();

                return text;
            }
            catch
            {
                return string.Empty;
            }
        }
        
        private static string GetBiosID()
        {
            try
            {
                string text = string.Empty;

                var query = new SelectQuery("Win32_BIOS");
                var managementObjectSearcher = new ManagementObjectSearcher(query);
                ManagementObjectCollection.ManagementObjectEnumerator enumerator = managementObjectSearcher.Get().GetEnumerator();
                
                while (enumerator.MoveNext())
                {
                    ManagementBaseObject managementBaseObject = enumerator.Current;
                    var managementObject = (ManagementObject)managementBaseObject;
                    text += GetNonNullString(Conversions.ToString(managementObject["Manufacturer"]));
                    text += GetNonNullString(Conversions.ToString(managementObject["SMBIOSBIOSVersion"]));
                    text += GetNonNullString(Conversions.ToString(managementObject["IdentificationCode"]));
                    text += GetNonNullString(Conversions.ToString(managementObject["SerialNumber"]));
                    text += GetNonNullString(Conversions.ToString(managementObject["ReleaseDate"]));
                    text += GetNonNullString(Conversions.ToString(managementObject["Version"]));
                }

                if (enumerator != null)
                    ((IDisposable)enumerator).Dispose();

                return text;
            }
            catch
            {
                return string.Empty;
            }
        }        
        
        private static string GetMachineID(string appName)
        {
            return Strings.UCase(GetMD5Hash(string.Concat(GetProcessorID(), GetMotherBoardID(), GetBiosID(), appName)));
        }
        
        private static string GetMD5Hash(string s)
        {
            var md5CryptoServiceProvider = new MD5CryptoServiceProvider();
            var array = md5CryptoServiceProvider.ComputeHash(Encoding.UTF8.GetBytes(s));
            var stringBuilder = new StringBuilder();
            
            foreach (byte b in array)
                stringBuilder.Append(b.ToString("x2").ToLower());

            return stringBuilder.ToString();
        }        
        
        private static string GetNonNullString(string s)
        {
            return string.IsNullOrEmpty(s) ? string.Empty : s;
        }
        
        private static string GetProcessorID()
        {
            try
            {
                string text = string.Empty;
                
                var query = new SelectQuery("Win32_processor");
                var managementObjectSearcher = new ManagementObjectSearcher(query);
                ManagementObjectCollection.ManagementObjectEnumerator enumerator = managementObjectSearcher.Get().GetEnumerator();
                
                while (enumerator.MoveNext())
                {
                    ManagementBaseObject managementBaseObject = enumerator.Current;
                    var managementObject = (ManagementObject)managementBaseObject;
                    text += GetNonNullString(Conversions.ToString(managementObject["processorId"]));
                    text += GetNonNullString(Conversions.ToString(managementObject["Name"]));
                    text += GetNonNullString(Conversions.ToString(managementObject["Manufacturer"]));
                    text += GetNonNullString(Conversions.ToString(managementObject["MaxClockSpeed"]));
                }
                
                if (enumerator != null)
                    ((IDisposable)enumerator).Dispose();

                return text;
            }
            catch
            {
                return string.Empty;
            }
        }
        
        private static string GetRandomString(int length)
        {
            const string Charset = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";            
            var random = new Random();
            var result = new StringBuilder(length);
            result.Length = length;
            
            for (int i = 0; i < length; i++)
                result[i] = Charset[random.Next(Charset.Length)];
            
            return result.ToString();
        }
        
        public ProductLicense(string appCode, string appName, string licFileExt)
        {
            this.appCode = appCode;
            this.appName = appName;
            this.licFileExt = licFileExt;
        }
        
        public bool GenerateLicenseFile(string fileName, DateTime expirationDate)
        {
            try
            {
                // <AppCode>|<MachineID>|<RefID>|<ExpDate>|<Unknown>|                
                byte[] buffer = Encoding.ASCII.GetBytes(string.Format("{0}|{1}|{2}|{3}|{4}|", appCode, GetMachineID(appName), GetRandomString(32), expirationDate.ToString("yyyyMMdd"), GetRandomString(18)));                
                var rijndaelManaged = new RijndaelManaged();
                rijndaelManaged.Padding = PaddingMode.Zeros;
                rijndaelManaged.Mode = CipherMode.CBC;
                rijndaelManaged.KeySize = 256;
                rijndaelManaged.BlockSize = 256;
                byte[] rgbKey = Encoding.ASCII.GetBytes("allah#most-benificient#merciful$");
                byte[] rgbIV = Encoding.ASCII.GetBytes("741952hheeyy66#cs!9hjv887mxx7@8y");
                ICryptoTransform transform = rijndaelManaged.CreateEncryptor(rgbKey, rgbIV);
                
                using (var stream = new MemoryStream())
                {
                    using (var cryptoStream = new CryptoStream(stream, transform, CryptoStreamMode.Write))
                    {
                        cryptoStream.Write(buffer, 0, buffer.Length);            
                        cryptoStream.FlushFinalBlock();
                    }
                
                    File.WriteAllText(fileName, Convert.ToBase64String(stream.ToArray()));
                }
                
                return true;
            }
            catch
            {
                return false;
            }
        }
        
        public string AppName
        {
            get { return appName; }
        }
        
        public string LicFileExt
        {
            get { return licFileExt; }
        }
    }
    
    public static class License
    {
        public static readonly ProductLicense[] ProductList = {
            new ProductLicense("1006", "Database Cleaner", "licdc"),
            new ProductLicense("1001", "Duplicate File Finder", "licdf"),
            new ProductLicense("1008", "Duplicate Outlook Finder", "licdof"),
            new ProductLicense("1007", "Duplicate Photos Finder", "licdpf"),
            new ProductLicense("1004", "iTunes Duplicate Finder", "licidf"),
            new ProductLicense("1002", "Print Directory", "licpd")
        };
    }
}
