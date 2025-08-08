using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Windows.Forms;

namespace KeysReader
{
    /// <summary>
    /// Description of MainForm.
    /// </summary>
    public partial class MainForm : Form
    {
        private const string TargetFileName = "Main.exe";
        
        private string GetTargetFile()
        {
            string fileName = Path.Combine(Environment.CurrentDirectory, TargetFileName);
            
            if (!File.Exists(fileName))
            {
                openFileDialog.Filter = TargetFileName + "|" + TargetFileName;                
                fileName = openFileDialog.ShowDialog() != DialogResult.Cancel ? openFileDialog.FileName : string.Empty;
            }
            
            return fileName;
        }
        
        private string[] ReadLicenseKeys(string fileName)
        {
            string[] keys = null;
            
            try
            {
                var assembly = Assembly.LoadFrom(fileName);
                
                if (assembly != null)
                {
                    var type = assembly.GetType("BatchPDFPro.Licensing.LicenseKeys");
                    
                    if (type != null)
                    {                    
                        var field = type.GetField("Keys", BindingFlags.NonPublic | BindingFlags.Static);
                        
                        if (field != null)
                            keys = (field.GetValue(null) as string[]);
                    }
                }                
            }
            catch
            {
                keys = null;
            }
            
            return keys;
        }
        
        public MainForm()
        {
            //
            // The InitializeComponent() call is required for Windows Forms designer support.
            //
            InitializeComponent();
            
            //
            // TODO: Add constructor code after the InitializeComponent() call.
            //
        }        
        
        void BtnReadKeysClick(object sender, EventArgs e)
        {            
            var fileName = GetTargetFile();
            
            if (!string.IsNullOrEmpty(fileName))
            {
                var keys = ReadLicenseKeys(fileName);
                
                if (keys != null)
                {
                    lbKeys.Items.Clear();
                    lbKeys.Items.AddRange(keys);
                    lblKeys.Text = string.Format("License &Keys ({0}):", lbKeys.Items.Count);
                    lbKeys.Enabled = lbKeys.Items.Count > 0;
                }
                else
                    MessageBox.Show("Error while reading license keys from file or keys not found!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }
        
        void MainFormLoad(object sender, EventArgs e)
        {
            openFileDialog.InitialDirectory = Environment.CurrentDirectory;
            lbKeys.Enabled = false;
            btnCopySelected.Enabled = false;
        }
        
        void BtnCopySelectedClick(object sender, EventArgs e)
        {
            if (lbKeys.SelectedItem != null)
            {
                try
                {
                    Clipboard.SetText(lbKeys.SelectedItem.ToString());
                }
                catch
                {
                    MessageBox.Show("Cannot copy selected key to clipboard!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
        }
        
        void LbKeysMouseDoubleClick(object sender, MouseEventArgs e)
        {
            btnCopySelected.PerformClick();
        }
        
        void BtnAboutClick(object sender, EventArgs e)
        {
            MessageBox.Show(string.Format("{0}\n\nVersion {1}\n\n© 2019, RadiXX11", Text, "1.0"), "About", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
        
        void LbKeysSelectedIndexChanged(object sender, EventArgs e)
        {
            btnCopySelected.Enabled = lbKeys.SelectedItem != null;
        }
        
        void LblHomepageLinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            try
            {
                Process.Start("http://www.pdfbatch.com");
            }
            catch
            {
                MessageBox.Show("Cannot start default web browser!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }
    }
}
