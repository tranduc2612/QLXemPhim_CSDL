using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace QLXemPhim
{
    public partial class fDatVe : Form
    {
        DBConfig db = new DBConfig();
        public fDatVe()
        {
            InitializeComponent();
        }

        private void fDatVe_Load(object sender, EventArgs e)
        {
            dataGridView.DataSource = db.table("Select tPhim.MaPhim,TenPhim,NgayChieu,tLichChieu.MaPhongChieu from tLichChieu join tPhim on tLichChieu.MaPhim = tPhim.MaPhim");
        }

        private void dataGridView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
        private bool isCheck()
        {
            if(txtMaVe.Text == "")
            {
                MessageBox.Show("Hãy nhập mã vẽ");
                return false;
            }
            if(txtMaPhim.Text == "")
            {
                MessageBox.Show("Hãy chọn mã phim");
                return false;
            }
            if(txtMaNV.Text == "")
            {
                MessageBox.Show("Mã nhân viên");
                return false;
            }
            if(txtNgayChieu.Text == "")
            {
                MessageBox.Show("Hãy chọn ngày chiếu");
                return false;
            }
            if (txtLoaiVe.Text == "")
            {
                MessageBox.Show("Hãy chọn loại vé");
                return false;
            }
            if (txtMaKH.Text == "")
            {
                MessageBox.Show("Hãy chọn ngày chiếu");
                return false;
            }
            return true;
        }

        private void reset()
        {
            txtMaVe.Text = "";
            txtMaPhim.Text = "";
            txtLoaiVe.Text = "";
            txtMaNV.Text = "";
            txtMaKH.Text = "";
            MessageBox.Show("Thêm thành công !");
        }

        private void guna2Button1_Click(object sender, EventArgs e)
        {
            if (isCheck())
            {
                string mave = txtMaVe.Text;
                string maKH = txtMaKH.Text;
                string maNV = txtMaNV.Text;
                string loaiVe = txtLoaiVe.Text;
                int money = 65000;
                if (loaiVe == "Vip")
                {
                    money = 90000;
                }
                try
                {
                    db.Excute($"insert into tVe(MaVe,MaKH,MaNV,LoaiVe,NgayDat,NgayChieu,GiaVe) values ('{mave}','{maKH}','{maNV}',N'{loaiVe}',getdate(),'{txtNgayChieu.Value}',{money});");
                    reset();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }

        private void dataGridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            txtMaPhim.Text = dataGridView.SelectedRows[0].Cells[0].Value.ToString();
            txtNgayChieu.Text = dataGridView.SelectedRows[0].Cells[2].Value.ToString();

        }

        private void TimSLve_Click(object sender, EventArgs e)
        {

        }

        private void btnSearchVe_Click(object sender, EventArgs e)
        {
            try
            {
                txtLuongVe.Text = db.ExcuteProc("CAU3proc",txtSoNam.Text,"@nam","@slVe");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
