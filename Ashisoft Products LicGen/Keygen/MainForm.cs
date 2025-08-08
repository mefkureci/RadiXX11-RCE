using System;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;

namespace Keygen
{
    public partial class MainForm : Form
    {        
        public MainForm()
        {
            InitializeComponent();
        }
        
        void MainFormLoad(object sender, EventArgs e)
        {
            Text = Application.ProductName;
            saveFileDialog.InitialDirectory = Directory.GetCurrentDirectory();
            
            foreach (var productLicense in License.ProductList)
                cboProduct.Items.Add(productLicense.AppName);
            
            cboProduct.SelectedIndex = 0;
        }
        
        void MainFormShown(object sender, EventArgs e)
        {
            btnGenerateLicFile.Focus();
        }
        
        void BtnAboutClick(object sender, EventArgs e)
        {
            MessageBox.Show(string.Format("{0}\n\nVersion 1.0\n\n© 2019, RadiXX11 [RdX11]", Text), "About", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }     
      
        void LblHomepageLinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            try
            {
                Process.Start("https://www.ashisoft.com");
            }
            catch
            {
                MessageBox.Show("Cannot open default web browser!", Text, MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }
        
        void BtnGenerateLicFileClick(object sender, EventArgs e)
        {
            if (cboProduct.SelectedIndex >= 0)
            {
                string appName = License.ProductList[cboProduct.SelectedIndex].AppName;
                string licFileExt = License.ProductList[cboProduct.SelectedIndex].LicFileExt;
                
                saveFileDialog.Filter = string.Format("{0} License Files (*.{1})|*.{1}", appName, licFileExt);
                saveFileDialog.FileName = appName;
                saveFileDialog.DefaultExt = licFileExt;                
                
                if (saveFileDialog.ShowDialog() == DialogResult.OK)
                {
                    if (License.ProductList[cboProduct.SelectedIndex].GenerateLicenseFile(saveFileDialog.FileName, new DateTime(2050, 1, 1)))
                        MessageBox.Show(string.Format("License file created successfully.\n\n{0}\n\nHow to activate:\n\n1. Start the program and open the Activation Wizard.\n2. Select \"Already have an activation file\" and click on \"Locate license file\".\n3. Select the generated license file and open it.\n4. Restart the program after activation.\n\nDon't forget to block the app with your firewall!", saveFileDialog.FileName), Text, MessageBoxButtons.OK, MessageBoxIcon.Information);
                    else
                        MessageBox.Show(string.Format("Cannot create license file {0}!", saveFileDialog.FileName), Text, MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
        }
    }
}
