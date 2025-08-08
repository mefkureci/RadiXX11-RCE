namespace Keygen
{
    partial class MainForm
    {
        /// <summary>
        /// Designer variable used to keep track of non-visual components.
        /// </summary>
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.PictureBox picBanner;
        private System.Windows.Forms.LinkLabel lblHomepage;
        private System.Windows.Forms.Button btnGenerateLicFile;
        private System.Windows.Forms.Button btnAbout;
        private System.Windows.Forms.Label lblProduct;
        private System.Windows.Forms.ComboBox cboProduct;
        private System.Windows.Forms.SaveFileDialog saveFileDialog;
        
        /// <summary>
        /// Disposes resources used by the form.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing) {
                if (components != null) {
                    components.Dispose();
                }
            }
            base.Dispose(disposing);
        }
        
        /// <summary>
        /// This method is required for Windows Forms designer support.
        /// Do not change the method contents inside the source code editor. The Forms designer might
        /// not be able to load this method if it was changed manually.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            this.picBanner = new System.Windows.Forms.PictureBox();
            this.lblHomepage = new System.Windows.Forms.LinkLabel();
            this.btnGenerateLicFile = new System.Windows.Forms.Button();
            this.btnAbout = new System.Windows.Forms.Button();
            this.lblProduct = new System.Windows.Forms.Label();
            this.cboProduct = new System.Windows.Forms.ComboBox();
            this.saveFileDialog = new System.Windows.Forms.SaveFileDialog();
            ((System.ComponentModel.ISupportInitialize)(this.picBanner)).BeginInit();
            this.SuspendLayout();
            // 
            // picBanner
            // 
            this.picBanner.Dock = System.Windows.Forms.DockStyle.Top;
            this.picBanner.Image = ((System.Drawing.Image)(resources.GetObject("picBanner.Image")));
            this.picBanner.Location = new System.Drawing.Point(0, 0);
            this.picBanner.Name = "picBanner";
            this.picBanner.Size = new System.Drawing.Size(248, 64);
            this.picBanner.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.picBanner.TabIndex = 0;
            this.picBanner.TabStop = false;
            // 
            // lblHomepage
            // 
            this.lblHomepage.ActiveLinkColor = System.Drawing.SystemColors.Highlight;
            this.lblHomepage.LinkColor = System.Drawing.SystemColors.HotTrack;
            this.lblHomepage.Location = new System.Drawing.Point(6, 120);
            this.lblHomepage.Name = "lblHomepage";
            this.lblHomepage.Size = new System.Drawing.Size(108, 23);
            this.lblHomepage.TabIndex = 7;
            this.lblHomepage.TabStop = true;
            this.lblHomepage.Text = "Products homepage";
            this.lblHomepage.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.lblHomepage.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.LblHomepageLinkClicked);
            // 
            // btnGenerateLicFile
            // 
            this.btnGenerateLicFile.Location = new System.Drawing.Point(114, 120);
            this.btnGenerateLicFile.Name = "btnGenerateLicFile";
            this.btnGenerateLicFile.Size = new System.Drawing.Size(96, 23);
            this.btnGenerateLicFile.TabIndex = 8;
            this.btnGenerateLicFile.Text = "&Generate Lic File";
            this.btnGenerateLicFile.UseVisualStyleBackColor = true;
            this.btnGenerateLicFile.Click += new System.EventHandler(this.BtnGenerateLicFileClick);
            // 
            // btnAbout
            // 
            this.btnAbout.Location = new System.Drawing.Point(216, 120);
            this.btnAbout.Name = "btnAbout";
            this.btnAbout.Size = new System.Drawing.Size(24, 23);
            this.btnAbout.TabIndex = 9;
            this.btnAbout.Text = "&?";
            this.btnAbout.UseVisualStyleBackColor = true;
            this.btnAbout.Click += new System.EventHandler(this.BtnAboutClick);
            // 
            // lblProduct
            // 
            this.lblProduct.Location = new System.Drawing.Point(6, 84);
            this.lblProduct.Name = "lblProduct";
            this.lblProduct.Size = new System.Drawing.Size(48, 18);
            this.lblProduct.TabIndex = 0;
            this.lblProduct.Text = "&Product:";
            this.lblProduct.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // cboProduct
            // 
            this.cboProduct.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboProduct.FormattingEnabled = true;
            this.cboProduct.Location = new System.Drawing.Point(54, 84);
            this.cboProduct.Name = "cboProduct";
            this.cboProduct.Size = new System.Drawing.Size(186, 21);
            this.cboProduct.TabIndex = 1;
            // 
            // saveFileDialog
            // 
            this.saveFileDialog.Title = "Save License File As";
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(248, 149);
            this.Controls.Add(this.cboProduct);
            this.Controls.Add(this.lblProduct);
            this.Controls.Add(this.btnAbout);
            this.Controls.Add(this.btnGenerateLicFile);
            this.Controls.Add(this.lblHomepage);
            this.Controls.Add(this.picBanner);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.KeyPreview = true;
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Load += new System.EventHandler(this.MainFormLoad);
            this.Shown += new System.EventHandler(this.MainFormShown);
            ((System.ComponentModel.ISupportInitialize)(this.picBanner)).EndInit();
            this.ResumeLayout(false);

        }
    }
}
