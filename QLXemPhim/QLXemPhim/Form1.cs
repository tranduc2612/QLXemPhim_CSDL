using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using FontAwesome.Sharp;

namespace QLXemPhim
{
    public partial class Form1 : Form
    {
        private IconButton currentBtn;
        private Form currentFormChild;
        public Form1()
        {
            InitializeComponent();
        }
        private void ActivateButton(object senderBtn)
        {
            Color textColor = Color.FromArgb(255, 255, 255);
            Color buttonColor = Color.FromArgb(238, 46, 36);
            if (senderBtn != null)
            {
                DisableButton();
                //Button
                currentBtn = (IconButton)senderBtn;
                routerNav.Text = currentBtn.Text;
                iconNav.IconChar = currentBtn.IconChar;
                currentBtn.BackColor = buttonColor;
                currentBtn.ForeColor = textColor;
                currentBtn.TextAlign = ContentAlignment.MiddleCenter;
                currentBtn.IconColor = textColor;
                currentBtn.TextImageRelation = TextImageRelation.TextBeforeImage;
                currentBtn.ImageAlign = ContentAlignment.MiddleRight;      
                
            }

        }
        private void DisableButton()
        {

            if (currentBtn != null)
            {
                currentBtn.BackColor = Color.White;
                currentBtn.ForeColor = Color.FromArgb(0, 0, 3, 51);
                currentBtn.TextAlign = ContentAlignment.MiddleLeft;
                currentBtn.IconColor = Color.Red;
                currentBtn.TextImageRelation = TextImageRelation.ImageBeforeText;
                currentBtn.ImageAlign = ContentAlignment.MiddleLeft;
                currentBtn.FlatStyle = FlatStyle.Standard;
            }
        }

        private void OpenChildrenForm(Form childForm)
        {
            if (currentFormChild != null)
            {
                currentFormChild.Close();
            }
            currentFormChild = childForm;
            childForm.TopLevel = false;
            childForm.FormBorderStyle = FormBorderStyle.None;
            childForm.Dock = DockStyle.Fill;
            panelBody.Controls.Add(childForm);
            childForm.Tag = childForm;
            childForm.BringToFront();
            childForm.Show();
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {

        }

        private void iconButton1_Click(object sender, EventArgs e)
        {
            
        }

        private void iconButton8_Click(object sender, EventArgs e)
        {
            OpenChildrenForm(new fPhim());
            ActivateButton(sender);
        }

        private void iconButton1_Click_1(object sender, EventArgs e)
        {
            ActivateButton(sender);
        }

        private void iconButton2_Click(object sender, EventArgs e)
        {
            ActivateButton(sender);
        }

        private void iconButton3_Click(object sender, EventArgs e)
        {
            OpenChildrenForm(new fDatVe());
            ActivateButton(sender);
        }

        private void iconButton4_Click(object sender, EventArgs e)
        {
            ActivateButton(sender);
        }

        private void iconButton5_Click(object sender, EventArgs e)
        {
            ActivateButton(sender);
        }
        private void iconButton7_Click(object sender, EventArgs e)
        {
            ActivateButton(sender);
        }

        private void iconButton6_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void iconButton8_MouseHover(object sender, EventArgs e)
        {

        }

        private void iconPictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void pictureBox1_Click_1(object sender, EventArgs e)
        {
            routerNav.Text = "Home";
            iconNav.IconChar = IconChar.HouseChimney;
            DisableButton();
        }
    }
}
