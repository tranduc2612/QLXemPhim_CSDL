using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLXemPhim
{
    public partial class fPhim : Form
    {
        DBConfig db = new DBConfig();
        public fPhim()
        {
            InitializeComponent(); 
        }
        private void fPhim_Load(object sender, EventArgs e)
        {
            dataGridView1.DataSource = db.table("Select * from tPhim");
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void pictureBox3_Click(object sender, EventArgs e)
        {

        }

        private void guna2Button1_Click(object sender, EventArgs e)
        {
            fThemPhim fThemPhim = new fThemPhim();
            fThemPhim.Show();
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
           txtTenPhim.Text = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
           txtTacGia.Text = dataGridView1.SelectedRows[0].Cells[5].Value.ToString();
           txtMoTa.Text = dataGridView1.SelectedRows[0].Cells[2].Value.ToString();
           txtNgayChieu.Text = dataGridView1.SelectedRows[0].Cells[6].Value.ToString();
           string path = dataGridView1.SelectedRows[0].Cells[12].Value.ToString();
            if (!File.Exists(path))
            {
                picAnh.Image = null;
            }
            else
            {
                picAnh.ImageLocation = path;
            }

        }

        private void iconPictureBox1_Click(object sender, EventArgs e)
        {
            string maPhim = inputSearch.Text;
            dataGridView1.DataSource = db.table($"select * from Cau7F('{maPhim}')");
        }

        private void btnLuongVe_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = db.table("select * from view7");
        }

        private void btnDanhSachPhim_Click(object sender, EventArgs e)
        {
            dataGridView1.DataSource = db.table("Select * from tPhim");
        }
    }
}
