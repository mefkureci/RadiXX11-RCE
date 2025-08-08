namespace KeysReader
{
    partial class MainForm
    {
        /// <summary>
        /// Designer variable used to keep track of non-visual components.
        /// </summary>
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.ListBox lbKeys;
        private System.Windows.Forms.Label lblKeys;
        private System.Windows.Forms.Button btnReadKeys;
        private System.Windows.Forms.Button btnCopySelected;
        private System.Windows.Forms.Button btnAbout;
        private System.Windows.Forms.LinkLabel lblHomepage;
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.ToolTip toolTip;
        
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            this.lbKeys = new System.Windows.Forms.ListBox();
            this.lblKeys = new System.Windows.Forms.Label();
            this.btnReadKeys = new System.Windows.Forms.Button();
            this.btnCopySelected = new System.Windows.Forms.Button();
            this.btnAbout = new System.Windows.Forms.Button();
            this.lblHomepage = new System.Windows.Forms.LinkLabel();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.toolTip = new System.Windows.Forms.ToolTip(this.components);
            this.SuspendLayout();
            // 
            // lbKeys
            // 
            this.lbKeys.FormattingEnabled = true;
            this.lbKeys.Location = new System.Drawing.Point(6, 30);
            this.lbKeys.Name = "lbKeys";
            this.lbKeys.Size = new System.Drawing.Size(270, 160);
            this.lbKeys.TabIndex = 1;
            this.lbKeys.SelectedIndexChanged += new System.EventHandler(this.LbKeysSelectedIndexChanged);
            this.lbKeys.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.LbKeysMouseDoubleClick);
            // 
            // lblKeys
            // 
            this.lblKeys.Location = new System.Drawing.Point(6, 12);
            this.lblKeys.Name = "lblKeys";
            this.lblKeys.Size = new System.Drawing.Size(270, 18);
            this.lblKeys.TabIndex = 0;
            this.lblKeys.Text = "License &Keys:";
            // 
            // btnReadKeys
            // 
            this.btnReadKeys.Location = new System.Drawing.Point(84, 198);
            this.btnReadKeys.Name = "btnReadKeys";
            this.btnReadKeys.Size = new System.Drawing.Size(72, 24);
            this.btnReadKeys.TabIndex = 3;
            this.btnReadKeys.Text = "&Read Keys";
            this.toolTip.SetToolTip(this.btnReadKeys, "Read license keys from program EXE");
            this.btnReadKeys.UseVisualStyleBackColor = true;
            this.btnReadKeys.Click += new System.EventHandler(this.BtnReadKeysClick);
            // 
            // btnCopySelected
            // 
            this.btnCopySelected.Location = new System.Drawing.Point(162, 198);
            this.btnCopySelected.Name = "btnCopySelected";
            this.btnCopySelected.Size = new System.Drawing.Size(84, 24);
            this.btnCopySelected.TabIndex = 4;
            this.btnCopySelected.Text = "&Copy Selected";
            this.toolTip.SetToolTip(this.btnCopySelected, "Copy selected license key to clipboard");
            this.btnCopySelected.UseVisualStyleBackColor = true;
            this.btnCopySelected.Click += new System.EventHandler(this.BtnCopySelectedClick);
            // 
            // btnAbout
            // 
            this.btnAbout.Location = new System.Drawing.Point(252, 198);
            this.btnAbout.Name = "btnAbout";
            this.btnAbout.Size = new System.Drawing.Size(24, 24);
            this.btnAbout.TabIndex = 5;
            this.btnAbout.Text = "&?";
            this.btnAbout.UseVisualStyleBackColor = true;
            this.btnAbout.Click += new System.EventHandler(this.BtnAboutClick);
            // 
            // lblHomepage
            // 
            this.lblHomepage.Location = new System.Drawing.Point(6, 198);
            this.lblHomepage.Name = "lblHomepage";
            this.lblHomepage.Size = new System.Drawing.Size(72, 24);
            this.lblHomepage.TabIndex = 2;
            this.lblHomepage.TabStop = true;
            this.lblHomepage.Text = "Homepage";
            this.lblHomepage.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.lblHomepage.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.LblHomepageLinkClicked);
            // 
            // openFileDialog
            // 
            this.openFileDialog.Title = "Select main executable file";
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(283, 228);
            this.Controls.Add(this.lblHomepage);
            this.Controls.Add(this.btnAbout);
            this.Controls.Add(this.btnCopySelected);
            this.Controls.Add(this.btnReadKeys);
            this.Controls.Add(this.lblKeys);
            this.Controls.Add(this.lbKeys);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Batch PDF Pro License Keys Reader";
            this.Load += new System.EventHandler(this.MainFormLoad);
            this.ResumeLayout(false);

        }
    }
}
