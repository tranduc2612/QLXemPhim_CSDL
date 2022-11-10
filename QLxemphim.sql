create database QLXemPhim
use QLXemPhim
go
drop database QLXemPhim

create table tDichVu (
	MaDichVu nvarchar(255) primary key,
	TenDichVu nvarchar(255)
)

create table tHoaDon(
	SoHD nvarchar(255) primary key,
	NgayLap datetime,
	MaKH nvarchar(255),
	MaNV nvarchar(255)
)

create table tChiTietHoaDon(
	SoHD nvarchar(255),
	SoLuong int,
	MaDichVu nvarchar(255),
	constraint pk_tChiTietHoaDon primary key (SoHD,MaDichVu),
	CONSTRAINT fk_tChiTietHoaDon_dichVu foreign key (MaDichVu) references tDichVu(MaDichVu),
	CONSTRAINT fk_tChiTietHoaDon_hoaDon foreign key (SoHD) references tHoaDon(SoHD),
)

create table tNhanVien(
	MaNV nvarchar(255) primary key,
	TenNV nvarchar(255),
	SoDT int,
	GioiTinh bit not null,
	DiaChi nvarchar(255),
	Luong money,
	ChucVu nvarchar(255)
)

create table tKhachHang(
	MaKH nvarchar(255) primary key,
	TenKH nvarchar(255),
	DiaChi nvarchar(255),
	NgaySinh datetime,
	GioiTinh bit,
	SoDienThoai nvarchar(255),
)


alter table tHoaDon add
CONSTRAINT fk_tHoaDon_NhanVien foreign key (MaNV) references tNhanVien(MaNV)

alter table tHoaDon add
CONSTRAINT fk_tHoaDon_KhachHang foreign key (MaKH) references tKhachHang(MaKH)

create table tVe(
	MaVe nvarchar(255) primary key,
	MaKH nvarchar(255),
	MaNV nvarchar(255),
	LoaiVe nvarchar(255),
	NgayDat datetime,
	NgayChieu datetime,
	GiaVe money,
	CONSTRAINT fk_ve_KH foreign key (MaKH) references tKhachHang(MaKH),
 	CONSTRAINT fk_ve_NV foreign key (MaNV) references tNhanVien(MaNV)
)

create table tLichChieu(
	MaPhongChieu nvarchar(255),
	MaPhim nvarchar(255),
	NgayChieu datetime,
	SLDaBan int,
	KhuyenMai nvarchar(255),
	CONSTRAINT PK_tLichChieu PRIMARY KEY (NgayChieu)
)

create table tPhim(
	MaPhim nvarchar(255) primary key,
	TenPhim nvarchar(255),
	NoiDungPhim nvarchar(255),
	GiaPhim money,
	ThoiLuongPhim int,
	DaoDien nvarchar(255),
	NgayKhoiChieu date,
	NgayKetThuc date,
	TongThu money,
	MaHangSX nvarchar(255),
	MaNuocSX nvarchar(255),
	MaTheLoai nvarchar(255),
)

alter table tLichChieu
	add constraint fk_lichChieu_phim
	foreign key (MaPhim) references tPhim(MaPhim)

create table tHangSX(
	MaHangSX nvarchar(255) primary key,
	TenHangSX nvarchar(255) not null
)

alter table tPhim add
	CONSTRAINT fk_phim_hangsx FOREIGN KEY (MaHangSX)
	REFERENCES tHangSX(MaHangSX);

create table tNuocSX(
	MaNuocSX nvarchar(255) primary key,
	TenNuocSX nvarchar(255) not null
)

alter table tPhim add
	CONSTRAINT fk_phim_nuocsx FOREIGN KEY (MaNuocSX)
	REFERENCES tNuocSX(MaNuocSX);


create table tTheLoai(
	MaTheLoai nvarchar(255) primary key,
	TenTheLoai nvarchar(255) not null
)

alter table tPhim add
	CONSTRAINT fk_phim_theloai FOREIGN KEY (MaTheLoai)
	REFERENCES tTheLoai(MaTheLoai);


create table tPhongChieu(
	MaPhongChieu nvarchar(255) primary key,
	TongSoGhe int,
	TenPhong nvarchar(255)
)

alter table tLichChieu add
CONSTRAINT fk_tLichChieu_tPhongChieu FOREIGN KEY (MaPhongChieu)
	REFERENCES tPhongChieu(MaPhongChieu)

alter table tPhongChieu add LoaiPhong nvarchar(255)

ALTER TABLE tVe
ADD CONSTRAINT fk_ve_lichchieu
  FOREIGN KEY (NgayChieu)
  REFERENCES tLichChieu (NgayChieu);
-- insert du lieu
-- tDichVu
insert into tDichVu 
values ('DV01',N'Nước 7UP'),
	   ('DV02',N'Nước Pepsi'),
	   ('DV03',N'Nước Mirinda'),
	   ('DV04',N'Bỏng thường'),
	   ('DV05',N'Bỏng caramen'),
	   ('DV06',N'Bỏng bơ');
-- tKhachHang
--1 la nam
--0 la nu
insert into tKhachHang
values 
	('KH01',N'Trần Minh Đức',N'Quảng Ninh','2002/12/26',1,'0367218700'),
	('KH02',N'Nguyễn Quang Hùng',N'Hà Nội','1950/4/14',1,'0323421234'),
	('KH03',N'Lê Xuân Quỳnh',N'Hà Nội','2002/09/29',1,'0345631543'),
	('KH04',N'Phạm Trung Hiếu',N'Hà Nội','2002/12/4',1,'0353333848'),
	('KH05',N'Phùng Tiến Dũng',N'Hà Nội','2002/04/12',1,'0365503654'),
	('KH06',N'Nguyễn Minh Ngọc',N'Hà Nội','2002/10/13',0,'0399620226'),
	('KH07',N'Lê Văn Sỹ',N'Nghệ An','2000/10/10',1,'0971497472'),
	('KH08',N'Lương Văn Duy',N'Quảng Ninh','2002/12/2',1,'0334987319'),
	('KH09',N'Trần Mỹ Linh',N'Hà Nội','2002/06/21',0,'0862861396'),
	('KH10',N'Lư Diệu Lan',N'Hà Nội','1950/11/15',0,'0325137468'),
	('KH11',N'Sơn Ðức Bình',N'Yên Bái','1956/5/13',1,'021673547968'),
	('KH12',N'Ân Sơn Tuyền',N'Hoà Bình','1971/4/21',0,'0395694012'),
	('KH13',N'An Ðức Cường',N'Hà Nam','2009/7/1',1,'0331470536'),
	('KH14',N'Đồng Ðình Sang',N'Kon Tum','1991/3/17',1,'0990921567'),
	('KH15',N'Ngạc Nhật Hòa',N'Cao Bằng','2007/4/25',1,'0701082934')
	;
-- insert NV
insert into tNhanVien
values 
	('NV01',N'Vương Xuân Cao','0227441853',1,N'Thái Bình',3000000,N'Nhân Viên'),
	('NV02',N'Thào Ðình Cường','0948301529',1,N'Khánh Hòa',5000000,N'Nhân Viên'),
	('NV03',N'Cầm Hải My','0364869250',0,N'Đồng Nai',26000000,N'Marketing'),
	('NV04',N'Phùng Kiều Mỹ','0357480659',0,N'Quảng Nam',30000000,N'Giám Đốc'),
	('NV05',N'Trác Thanh Thúy','0949326180',0,N'Hải Dương',3000000,N'Nhân Viên'),
	('NV06',N'Khúc Hữu Minh','0398102563',1,N'Bắc cạn',6000000,N'Nhân Viên')

--insert hoadon
insert into tHoaDon values
	('HD01',N'2021/10/28','KH01','NV01'),
	('HD02',N'2021/10/12','KH02','NV01'),
	('HD03',N'2021/12/04','KH03','NV01'),
	('HD04',N'2021/04/13','KH04','NV01'),
	('HD05',N'2021/03/14','KH01','NV02'),
	('HD06',N'2021/01/15','KH06','NV02'),
	('HD07',N'2021/01/15','KH07','NV02'),
	('HD08',N'2021/01/15','KH11','NV02'),
	('HD09',N'2020/11/05','KH12','NV05'),
	('HD10',N'2020/01/05','KH10','NV05'),
	('HD11',N'2020/04/16','KH12','NV05')

-- insert chitiethoadon
insert into tChiTietHoaDon values
('HD01',2,'DV02'),
('HD01',1,'DV05'),
('HD02',2,'DV01'),
('HD02',1,'DV06'),
('HD03',10,'DV02'),
('HD03',4,'DV05'),
('HD04',2,'DV02'),
('HD04',1,'DV05'),
('HD04',1,'DV06'),
('HD05',2,'DV03'),
('HD05',1,'DV05'),
('HD05',3,'DV06'),
('HD06',1,'DV03'),
('HD07',1,'DV03'),
('HD08',1,'DV02'),
('HD09',1,'DV01'),
('HD09',2,'DV03'),
('HD09',1,'DV04'),
('HD10',1,'DV05'),
('HD11',1,'DV05');

-- insert tTheLoai
insert into tTheLoai values
('TL01',N'Kinh dị'),
('TL02',N'Hài kịch'),
('TL03',N'Lãng mạng'),
('TL04',N'Hành động'),
('TL05',N'Viễn tưởng'),
('TL06',N'Cuộc sống');

--insert tnuocSx
insert into tNuocSX values
('NSX01',N'Việt Nam'),
('NSX02',N'Nhật Bản'),
('NSX03',N'Trung Quốc'),
('NSX04',N'Mỹ'),
('NSX05',N'Úc'),
('NSX06',N'Nga'),
('NSX07',N'Pháp'),
('NSX08',N'Anh'),
('NSX09',N'Hàn Quốc')

--insert tHangSX
insert into tHangSX values
('HSX01',N'Universal Pictures'),
('HSX02',N'Walt Disney Studios Motion Pictures'),
('HSX03',N'Marvel Studios'),
('HSX04',N'Pixar'),
('HSX05',N'Paramount Pictures'),
('HSX06',N'Sony Pictures Studios'),
('HSX07',N'Warner Bros'),
('HSX08',N'DC Films');

--insert tPhim
insert into tPhim(MaPhim,TenPhim,NoiDungPhim,GiaPhim,ThoiLuongPhim,DaoDien,NgayKhoiChieu,NgayKetThuc,MaHangSX,MaNuocSX,MaTheLoai) values
('P01','BLACK ADAM',N'Black Adam là một bộ phim điện ảnh siêu anh hùng của Hoa Kỳ ra mắt năm 2022, dựa trên nhân vật cùng tên của DC Comics. 
Được sản xuất bởi New Line Cinema, DC Films.',100000000,120,'Rich Delia','2022/10/20','2022/12/20','HSX08','NSX08','TL04'),
('P02','Doctor Strange in the multiverse',N'Phù thủy tối thượng trong Đa Vũ trụ hỗn loạn là một bộ phim siêu anh hùng của Mỹ được công chiếu vào năm 2022,
phim dựa trên nhân vật Doctor Strange của Marvel Comics.',150000000,120,'Sam Raimi','2022/06/05','2022/07/05','HSX03','NSX04','TL04'),
('P03','LalaLand',N'Những kẻ khờ mộng mơ là bộ phim nhạc kịch lãng mạn xen lẫn chính kịch hài hước của Hoa Kỳ năm 2016, do Damien Chazelle biên soạn và đạo diễn. 
Bộ phim có diễn xuất của Ryan Gosling, Emma Stone, J. K. Simmons, John Legend và Rosemarie DeWitt.',90000000,120,'Damien Chazelle','2022/11/09','2022/12/09','HSX05','NSX04','TL03'),
('P04','The Witch: Part 2. The Other One',N'The Witch: Part 2. The Other One là một bộ phim kinh dị hành động khoa học viễn tưởng năm 2022 của Hàn Quốc do Park Hoon-jung viết kịch bản và đạo diễn.',120000000,120,'Park Hoon-jung','2022/06/15','2022/07/20','HSX06','NSX09','TL05'),
('P05','Life of Pi',N'Dựa trên cuốn tiểu thuyết cùng tên năm 2001 của Yann Martel, phim có sự tham gia của Suraj Sharma, Irrfan Khan, Rafe Spall, Tabu và Adil Hussain trong các vai chính. ',80000000,120,N'Lý An','2022/03/14','2022/04/14','HSX07','NSX05','TL06'),
('P06','IT',N'Đây là phần đầu tiên trong kế hoạch sản xuất loạt phim It hai phần dựa trên cuốn tiểu thuyết cùng tên của nhà văn Stephen King.
Nhóm biên kịch của phim gồm có Chase Palmer, Cary Fukunaga và Gary Dauberman.',110000000,120,N'Lý An','2022/01/10','2022/02/10','HSX01','NSX06','TL01');


alter table tPhim add Anh nvarchar(255)
update tPhim set Anh = 'C:\Users\OSC\Desktop\BTLCSDL\resource\BlackAdam.jpg' where MaPhim = 'P01'
update tPhim set Anh = 'C:\Users\OSC\Desktop\BTLCSDL\resource\DoctorStrange.jpg' where MaPhim = 'P02'
update tPhim set Anh = 'C:\Users\OSC\Desktop\BTLCSDL\resource\lalaland.jpg' where MaPhim = 'P03'
update tPhim set Anh = 'C:\Users\OSC\Desktop\BTLCSDL\resource\theWitch2.jpg' where MaPhim = 'P04'
update tPhim set Anh = 'C:\Users\OSC\Desktop\BTLCSDL\resource\LifeofPi.jpg' where MaPhim = 'P05'
update tPhim set Anh = 'C:\Users\OSC\Desktop\BTLCSDL\resource\IT.jpeg' where MaPhim = 'P06'
select * from tPhim
-- p01 20/10/2022 -> 20/12/2022
-- p02 05/06/2022 -> 05/07/2022
-- p03 09/11/2022 -> 09/12/2022
-- p04 15/06/2022 -> 20/07/2022
-- p05 14/03/2022 -> 14/04/2022
-- p06 10/02/2022 -> 10/02/2022
-- insert tPhongChieu

insert into tPhongChieu(MaPhongChieu,TenPhong,LoaiPhong) values
('MP01',N'Phòng 1','2D'),
('MP02',N'Phòng 2','2D'),
('MP03',N'Phòng 3','2D'),
('MP04',N'Phòng 4','3D'),
('MP05',N'Phòng 5','3D'),
('MP06',N'Phòng 6','3D');

-- insert tLichChieu
insert into tLichChieu(MaPhim,NgayChieu,MaPhongChieu) values
-- p01 20/10/2022 -> 20/12/2022
('P01','2022/10/21 08:00','MP01'),
('P01','2022/10/21 12:00','MP02'),
('P01','2022/10/21 16:00','MP03'),
('P01','2022/10/21 20:00','MP05'),
('P01','2022/10/21 22:00','MP06'),

('P01','2022/10/22 10:00','MP01'),
('P01','2022/10/22 14:00','MP02'),
('P01','2022/10/22 18:00','MP04'),
('P01','2022/10/22 23:59','MP03'),


('P01','2022/10/23 12:00','MP06'),
('P01','2022/10/23 18:00','MP02'),
('P01','2022/10/23 20:00','MP01'),
('P01','2022/10/23 23:59','MP03'),
-- p02 05/06/2022 -> 05/07/2022
('P02','2022/06/05 08:00','MP06'),
('P02','2022/06/05 16:00','MP06'),
('P02','2022/06/05 18:00','MP03'),
('P02','2022/06/05 20:00','MP02'),
('P02','2022/06/05 22:00','MP05'),
('P02','2022/06/05 23:59','MP01'),


('P02','2022/06/06 16:00','MP06'),
('P02','2022/06/06 18:00','MP02'),
('P02','2022/06/06 20:00','MP01'),
('P02','2022/06/06 22:00','MP06'),
('P02','2022/06/06 23:59','MP04'),

('P02','2022/06/07 08:00','MP01'),
('P02','2022/06/07 10:00','MP02'),
('P02','2022/06/07 12:00','MP04'),
('P02','2022/10/23 14:00','MP05'),
('P02','2022/06/07 16:00','MP06'),
-- p03 09/11/2022 -> 09/12/2022
('P03','2022/11/09 08:00','MP01'),
('P03','2022/11/09 10:00','MP02'),
('P03','2022/11/09 12:00','MP05'),
('P03','2022/11/09 14:00','MP06'),
('P03','2022/11/09 22:00','MP03'),
('P03','2022/11/09 23:59','MP04'),

('P03','2022/11/10 12:00','MP05'),
('P03','2022/11/10 14:00','MP03'),
('P03','2022/11/10 16:00','MP01'),
('P03','2022/11/10 18:00','MP02'),
('P03','2022/11/10 20:00','MP06'),
('P03','2022/11/10 22:00','MP04'),

('P03','2022/11/11 12:00','MP01'),
('P03','2022/11/11 14:00','MP02'),
('P03','2022/11/11 16:00','MP04'),
('P03','2022/11/11 18:00','MP03'),
('P03','2022/11/11 20:00','MP06'),

-- p04 15/06/2022 -> 20/07/2022
('P04','2022/06/15 08:00','MP03'),
('P04','2022/06/15 10:00','MP01'),
('P04','2022/06/15 12:00','MP02'),
('P04','2022/06/15 14:00','MP05'),
('P04','2022/06/15 16:00','MP06'),
('P04','2022/06/15 18:00','MP04'),

('P04','2022/06/16 08:00','MP01'),
('P04','2022/06/16 10:00','MP04'),
('P04','2022/06/16 12:00','MP03'),
('P04','2022/06/16 20:00','MP06'),
('P04','2022/06/16 22:00','MP02'),
('P04','2022/06/16 23:59','MP05'),

('P04','2022/06/17 08:00','MP02'),
('P04','2022/06/17 10:00','MP01'),
('P04','2022/06/17 12:00','MP05'),
('P04','2022/06/17 14:00','MP06'),
('P04','2022/06/17 18:00','MP04'),
('P04','2022/06/17 20:00','MP05'),
('P04','2022/06/17 23:59','MP06'),
-- p05 14/03/2022 -> 14/04/2022
('P05','2022/03/14 08:00','MP03'),
('P05','2022/03/14 10:00','MP01'),
('P05','2022/03/14 12:00','MP02'),
('P05','2022/03/14 14:00','MP05'),
('P05','2022/03/14 16:00','MP06'),
('P05','2022/03/14 18:00','MP04'),
('P05','2022/03/14 22:00','MP04'),
('P05','2022/03/14 23:00','MP04'),

('P05','2022/03/15 08:00','MP01'),
('P05','2022/03/15 10:00','MP04'),
('P05','2022/03/15 12:00','MP03'),
('P05','2022/03/15 20:00','MP06'),
('P05','2022/03/15 22:00','MP02'),
('P05','2022/03/15 23:59','MP05'),

('P05','2022/03/16 08:00','MP02'),
('P05','2022/03/16 10:00','MP01'),
('P05','2022/03/16 12:00','MP05'),
('P05','2022/03/16 14:00','MP06'),
('P05','2022/03/16 18:00','MP04'),
('P05','2022/03/16 20:00','MP05'),
('P05','2022/03/16 23:59','MP06'),
-- p06 10/02/2022 -> 10/02/2022
('P06','2022/02/10 08:00','MP01'),
('P06','2022/02/10 12:00','MP02'),
('P06','2022/02/10 16:00','MP03'),
('P06','2022/02/10 20:00','MP05'),
('P06','2022/02/10 22:00','MP06'),

('P06','2022/02/11 10:00','MP01'),
('P06','2022/02/11 14:00','MP02'),
('P06','2022/02/11 18:00','MP04'),
('P06','2022/02/11 23:59','MP03'),

('P06','2022/02/12 12:00','MP06'),
('P06','2022/02/12 18:00','MP02'),
('P06','2022/02/12 20:00','MP01'),
('P06','2022/02/12 23:59','MP03');

--insert into tLichChieu(maPhim,ngayChieu,maPhongChieu) values -- Xử lí TH 1 phòng không thể chiếu 2 bộ phim cùng 1 lúc vào cùng 1 thời điểm
--('P06','2022/02/12 12:00','MP06'),
--('P05','2022/02/12 12:00','MP06');

--insert into tLichChieu(maPhim,ngayChieu,maPhongChieu) values -- Cũng xử lí luôn được TH 1 phòng có thể chiếu được nhiều bộ phim cùng 1 ngày những mà không được cùng giờ
--('P06','2022/02/12 11:00','MP06'),
--('P05','2022/02/12 8:00','MP06');


-- insert tVe
insert into tVe(MaVe,MaKH,MaNV,LoaiVe,NgayDat,NgayChieu,GiaVe) values -- ngày đặt lúc nào cũng phải bé hơn ngày chiếu
('MV01','KH01','NV01',N'Thường','2022/02/12 08:00','2022/02/12 12:00',65000), 
('MV02','KH01','NV02',N'Vip','2022/03/15 14:00','2022/03/16 08:00',90000),
('MV03','KH01','NV05',N'Thường','2022/06/15 12:30','2022/06/15 14:00',65000),
('MV04','KH01','NV06',N'Thường','2022/10/20 09:00','2022/10/21 08:00',65000),
('MV05','KH01','NV01',N'Thường','2022/06/17 12:00','2022/06/17 18:00',65000),
('MV06','KH01','NV01',N'Vip','2022/06/17 12:00','2022/06/17 18:00',90000),

-- Khách đặt 1 lúc nhiều vé trong cùng 1 thời điểm, cùng 1 nhân viên ,cùng 1 loại
('MV07','KH02','NV01',N'Thường','2022/06/15 9:00','2022/06/15 12:00',65000),
('MV08','KH02','NV01',N'Thường','2022/06/15 9:00','2022/06/15 12:00',65000),
('MV09','KH02','NV01',N'Thường','2022/06/15 9:00','2022/06/15 12:00',65000),
('MV10','KH02','NV01',N'Thường','2022/06/15 9:00','2022/06/15 12:00',65000);

insert into tVe(MaVe,MaKH,MaNV,LoaiVe,NgayDat,NgayChieu,GiaVe) VALUES
-----------------KH03-----------------
('MV11','KH03','NV02',N'Thường','2022/02/12 21:00','2022/02/12 23:59',65000),
('MV12','KH03','NV05',N'Vip','2022/06/17 21:00','2022/06/17 23:59',90000),
('MV13','KH03','NV05',N'Vip','2022/06/17 21:00','2022/06/17 23:59',90000),
('MV14','KH03','NV01',N'Thường','2022/11/11 16:00','2022/11/11 18:00',65000),

-----------------KH04-----------------
('MV15','KH04','NV02',N'Thường','2022/06/16 15:00','2022/06/16 22:00',65000),
('MV16','KH04','NV02',N'Thường','2022/06/16 15:00','2022/06/16 22:00',65000),
('MV17','KH04','NV03',N'Vip','2022/11/08 20:00','2022/11/09 08:00',65000),
('MV18','KH04','NV06',N'Vip','2022/11/08 20:00','2022/11/09 08:00',90000),

-----------------KH05-----------------
('MV19','KH05','NV03',N'Thường','2022/03/14 9:00','2022/03/14 14:00',65000),
('MV20','KH05','NV03',N'Thường','2022/03/14 9:00','2022/03/14 14:00',65000),
('MV21','KH05','NV03',N'Thường','2022/03/14 9:00','2022/03/14 14:00',65000),
('MV22','KH05','NV03',N'Thường','2022/03/14 9:00','2022/03/14 14:00',65000),
('MV23','KH05','NV03',N'Thường','2022/03/14 9:00','2022/03/14 14:00',65000),
-----------------KH06-----------------
('MV24','KH06','NV01',N'Vip','2022/06/07 9:00','2022/06/07 16:00',90000),
('MV25','KH06','NV01',N'Vip','2022/06/07 9:00','2022/06/07 16:00',90000),

-----------------KH07-----------------
('MV26','KH07','NV05',N'Thường','2022/10/23 9:00','2022/10/23 12:00',65000),
('MV27','KH07','NV05',N'Thường','2022/10/23 9:00','2022/10/23 12:00',65000),
('MV28','KH07','NV05',N'Thường','2022/10/23 9:00','2022/10/23 12:00',65000),
('MV29','KH07','NV05',N'Thường','2022/10/23 9:00','2022/10/23 12:00',65000),
('MV30','KH07','NV05',N'Thường','2022/10/23 9:00','2022/10/23 12:00',65000),
('MV31','KH07','NV02',N'Vip','2022/10/18 08:00','2022/10/21 08:00',90000);


--KH08
insert into tVe(MaVe,MaKH,MaNV,LoaiVe,NgayDat,NgayChieu,GiaVe) values
('MV32','KH08','NV02',N'Vip','2022/02/12 08:00','2022/02/12 12:00',90000);
insert into tVe(MaVe,MaKH,MaNV,LoaiVe,NgayDat,NgayChieu,GiaVe) values
('MV33','KH08','NV02',N'Vip','2022/02/12 08:00','2022/02/12 12:00',90000);
--KH09
insert into tVe(MaVe,MaKH,MaNV,LoaiVe,NgayDat,NgayChieu,GiaVe) values
('MV34','KH09','NV05',N'Vip','2022/3/16 07:00','2022/03/16 08:00',90000);

--KH10
insert into tVe(MaVe,MaKH,MaNV,LoaiVe,NgayDat,NgayChieu,GiaVe) values
('MV35','KH10','NV06',N'Vip','2022/6/14 08:00','2022/06/15 08:00',90000);

insert into tVe(MaVe,MaKH,MaNV,LoaiVe,NgayDat,NgayChieu,GiaVe) values
('MV36','KH10','NV06',N'Vip','2022/6/14 08:00','2022/06/15 08:00',90000);
insert into tVe(MaVe,MaKH,MaNV,LoaiVe,NgayDat,NgayChieu,GiaVe) values
('MV37','KH10','NV06',N'Vip','2022/6/14 08:00','2022/06/15 08:00',90000);
--KH15
insert into tVe(MaVe,MaKH,MaNV,LoaiVe,NgayDat,NgayChieu,GiaVe) values
('MV38','KH15','NV01',N'Vip','2022/6/06 08:00','2022/06/06 23:59',90000);

select * from tVe;
delete from tVe where MaVe = 'MV50' 

update tPhongChieu set TongSoGhe = 90 where MaPhongChieu = 'MP01'
update tPhongChieu set TongSoGhe = 90 where MaPhongChieu = 'MP02'
update tPhongChieu set TongSoGhe = 70 where MaPhongChieu = 'MP03'
update tPhongChieu set TongSoGhe = 80 where MaPhongChieu = 'MP04'
update tPhongChieu set TongSoGhe = 100 where MaPhongChieu = 'MP05'
update tPhongChieu set TongSoGhe = 90 where MaPhongChieu = 'MP06'


--view cau 1: View đưa số lượng vé mà khách hàng đã mua từ 2 vé trở lên 
create or alter view view1
as
	select tKhachHang.TenKH, count(tVe.MaVe) as sove
	from tKhachHang join tVe on tKhachHang.MaKH=tVe.MaKH
	group by tKhachHang.TenKH
	having count(tVe.MaVe) >= 2
GO

--view cau 2: Tìm tất các ghế trống của các phòng
create or alter view view2
as
	select tLichChieu.NgayChieu,tLichChieu.MaPhongChieu,TongSoGhe,TongSoGhe - count(MaVe) as SoGheConTrong from tVe 
	join tLichChieu on tVe.NgayChieu = tLichChieu.NgayChieu
	join tPhongChieu on tPhongChieu.MaPhongChieu = tLichChieu.MaPhongChieu 
	group by tLichChieu.NgayChieu,tLichChieu.MaPhongChieu,TongSoGhe
GO

--view 3 in ra top 2 bộ phim ăn khách nhất phim an khach nhat 2022
create or alter view view3
as
	select  TenPhim,count(MaVe) as SLVe from tVe 
	join tLichChieu on tLichChieu.NgayChieu = tVe.NgayChieu
	join tPhim on tPhim.MaPhim = tLichChieu.MaPhim
	group by TenPhim
	having count(MaVe) in (select distinct top 2 count(MaVe) from tVe 
		join tLichChieu on tLichChieu.NgayChieu = tVe.NgayChieu
		group by MaPhim 
		order by count(MaVe) desc
	)
GO

--view 4 cac phim thuoc the loai hanh dong
create or alter view view4
as
	select tPhim.TenPhim
	from tPhim join tTheLoai on tPhim.MaTheLoai=tTheLoai.MaTheLoai
	where tTheLoai.TenTheLoai = N'Hành động'
GO

--view 5 cac phim chieu trong thang 10/2022
create or alter view view5
as
	select distinct tPhim.TenPhim
	from tPhim join tLichChieu on tPhim.MaPhim=tLichChieu.MaPhim
	where year(tLichChieu.NgayChieu)=2022 and month(tLichChieu.NgayChieu)=10
GO

--view 6 so ve tung nhan vien ban duoc
create or alter view view6
as
	select tNhanVien.TenNV, count(tVe.MaVe) as sove
	from tNhanVien join tVe on tNhanVien.MaNV=tVe.MaNV
	group by tNhanVien.TenNV

--view 7 Đưa ra danh sách phim có số lượng bán nhiều nhất
create view view7
as
	select tPhim.*,SLVe from tPhim join (
	select top 1 with ties MaPhim,count(MaVe) as SLVe from tLichChieu join tVe 
	on tVe.NgayChieu = tLichChieu.NgayChieu
	group by MaPhim
	order by SLVe desc
) as BangPhu on tPhim.MaPhim = BangPhu.MaPhim


--- Hàm
-- 1. Hàm đưa ra thông tin nhân viên có địa chỉ ở Thái Bình
CREATE OR ALTER FUNCTION Cau1F (@DiaChi nvarchar(50))
RETURNS TABLE 
RETURN(
	SELECT * FROM dbo.tNhanVien
	WHERE @DiaChi = DiaChi
)

SELECT * FROM Cau1F(N'Thái Bình')

-- 2. Hàm check độ tuổi
CREATE OR ALTER FUNCTION isEnough (@Age int)
RETURNS nvarchar(50)  
AS 
BEGIN 
	IF(@Age - 16 >= 0)
		RETURN N'Đủ tuổi xem phim'
	ELSE 
		RETURN N'Không đủ tuổi để xem phim'
	RETURN N'Không xác định độ tuổi'
END 
GO 

--3. Hàm tính tuổi
CREATE OR ALTER FUNCTION GetAge(@Year date)
RETURNS INT
AS 
BEGIN 
	RETURN YEAR(GETDATE()) - YEAR(@Year)
END 

-- Đưa ra teen khách hàng và tuổi và điều kiện để xem phim trên 16+
SELECT TenKH, dbo.GetAge(NgaySinh) AS N'Độ tuổi', dbo.isEnough(dbo.GetAge(NgaySinh)) AS N'Điều kiện' FROM dbo.tKhachHang

--4. Hàm truyền vào tháng và năm, đưa số lượng hóa đơn bán được trong tất cả các ngày trong tháng và năm đó
CREATE OR ALTER FUNCTION SoLuongHoaDon (@thang int, @nam int)
RETURNS TABLE	
AS RETURN 
(
	SELECT DAY(NgayLap) AS N'Ngày', COUNT(SoHD) AS N'Số lượng hóa đơn' 
	FROM dbo.tHoaDon
	WHERE MONTH(NgayLap) = @thang AND YEAR(NgayLap) = @nam 
	GROUP BY DAY(NgayLap)
)

SELECT * FROM SoLuongHoaDon(1, 2021)

SELECT * FROM SoLuongHoaDon(1, 2021) 

-- 5.Hàm có đầu vào là mã khách hàng đầu ra là số lượng vé của khách hàng đó 
CREATE FUNCTION LaySoLuong(@MaKH nvarchar(50))
RETURNS INT
AS BEGIN 
	DECLARE @SoLuongVe INT 
	SELECT @SoLuongVe = COUNT(*) FROM dbo.tVe WHERE MaKH = @MaKH
	RETURN @SoLuongVe
END 

-- 6. Hàm đưa ra thông tin khách hàng trên 20 tuôi và có địa chỉ ở Hà Nội
CREATE FUNCTION Cau6F (@Age int, @DiaChi nvarchar(20))
RETURNS TABLE 
AS RETURN 
(
	SELECT * FROM dbo.tKhachHang
	WHERE @Age = YEAR(GETDATE()) - YEAR(NgaySinh) AND @DiaChi = DiaChi
)

SELECT * FROM dbo.Cau6F(20, N'Hà Nội')

-- 7. Hàm nhận vào mã Phim trả về danh sách bộ phim cần tìm
CREATE FUNCTION Cau7F (@maPhim nvarchar(255))
RETURNS TABLE 
AS RETURN 
(
	select * from tPhim where MaPhim = @maPhim
)


-- Thủ tục
-- 1. Tạo thủ tục có đầu vào là mã nhân viên, đầu ra là lương của nhân viên đó
CREATE OR ALTER PROCEDURE CAU1proc @mnv NVARCHAR(20), @sl MONEY OUTPUT
AS BEGIN
	SELECT @sl = Luong 
	FROM tNhanVien 	WHERE MaNV = @mnv
END
DECLARE @tl MONEY;
EXEC CAU1proc N'NV01', @tl OUTPUT;
print @tl


-- 2. Tạo thủ tục đàu vào là chức vụ, đầu ra là số lượng nhân viên theo chức vụ
create procedure CAU2proc @cv nvarchar(100), @nv int output as
begin
	select @nv = count(*) from tNhanVien
	where ChucVu = @cv
end

declare @tong int
exec CAU2proc N'Nhân Viên' , @tong output
print @tong

-- 3. Tạo thủ tục đầu là vào số năm, đầu ra là số lượng vé bán ra vào năm đó
create procedure CAU3proc @nam nvarchar(100), @slVe int output as
begin
	select @slVe = count(MaVe) from tNhanVien join tVe on tNhanVien.MaNV = tVe.MaNV
	where year(NgayDat) = @nam
end

declare @slVeBan int
exec CAU3proc 2022, @slVeBan output
print @slVeBan
select * from tPhongChieu
-- 4. Tạo thủ tục đầu vào là mã phim, đầu ra là số lượng lịch chiếu của phim đó
create proc CAU4proc @maphim nvarchar(255), @slLC int output as
begin
	select count(NgayChieu) from tPhim join tLichChieu on tPhim.MaPhim = tLichChieu.MaPhim where tPhim.MaPhim = @maphim
end


-- 5.Tạo thủ tục có đầu vào là tên Nhân viên, Năm, đầu ra là số tiền và Số lượng hóa đơn nhân viên xử lý
CREATE PROC CAU5proc @TenNv NVARCHAR(50), @nam INT, @TienVe money OUTPUT, @SlveDaBan INT OUTPUT
AS
BEGIN
	select @SlveDaBan = count(MaVe) from tVe 
	join tNhanVien on tVe.MaNV = tNhanVien.MaNV where TenNV = @TenNv and YEAR(NgayDat) = @nam
	
	select @TienVe = sum(GiaVe) from tVe 
	join tNhanVien on tVe.MaNV = tNhanVien.MaNV where TenNV = @TenNv and YEAR(NgayDat) = @nam
END

DECLARE @PTien money , @PSlHd INT 
EXEC CAU5proc N'Vương Xuân Cao', 2022, @PTien OUTPUT, @PSlHd OUTPUT 
select @PTien as TongsoTien, @PSlHd as SoluongHoadon



-- trigger
-- câu 1: Khi thêm, sửa, xóa ở bảng vé, tự động cập nhật số lượng vé ở bảng lịch chiếu
select * from tDichVu
select * from tChiTietHoaDon
select * from tHoaDon
select * from tKhachHang
select * from tHangSX
select * from tLichChieu
select * from tNhanVien
select * from tNuocSX
select * from tPhim
select * from tPhongChieu
select * from tVe
select * from tTheLoai

update tLichChieu set SLDaBan = (select count(MaVe) from tVe join tLichChieu on tLichChieu.NgayChieu = tVe.NgayChieu
where tLichChieu.NgayChieu = '2022/06/15 08:00')
where tLichChieu.NgayChieu = '2022/06/15 08:00'

create or alter trigger SLVeBan on tVe
for insert,delete,update
as
begin
	declare @ngayChieuI datetime,@maPhongI nvarchar(255)
	declare @ngayChieuD datetime,@maPhongD nvarchar(255)

	select @ngayChieuI = NgayChieu from inserted
	select @ngayChieuD = NgayChieu from deleted

	update tLichChieu set SLDaBan = isNull(SLDaBan,0) + 1 
	where tLichChieu.NgayChieu = @ngayChieuI

	update tLichChieu set SLDaBan = isNull(SLDaBan,0) - 1 
	where tLichChieu.NgayChieu = @ngayChieuD
end

insert into tVe(MaVe,MaKH,MaNV,LoaiVe,NgayDat,NgayChieu,GiaVe) values
('MV40','KH15','NV01',N'Thường','2022/6/06 08:00','2022/06/15 08:00',65000);

delete from tVe where MaVe = 'MV40'

select * from tLichChieu where NgayChieu = '2022/06/15 08:00'

-- Câu 2 thêm trường tổng tiền cho bảng hóa đơn cập nhật thêm, sửa , xóa cho bảng chi tiết hóa đơn tự động cập nhật tổng tiền ở bảng hóa đơn
alter table tDichVu add GiaTien money

update tDichVu set GiaTien = 10000 where MaDichVu = 'DV01'
update tDichVu set GiaTien = 13000 where MaDichVu = 'DV02'
update tDichVu set GiaTien = 15000 where MaDichVu = 'DV03'
update tDichVu set GiaTien = 25000 where MaDichVu = 'DV04'
update tDichVu set GiaTien = 35000 where MaDichVu = 'DV05'
update tDichVu set GiaTien = 30000 where MaDichVu = 'DV06'

alter table tHoaDon add TongTienHoaDon money 

select * from tHoaDon
select * from tChiTietHoaDon
select * from tDichVu

create or alter trigger tinhTongTienHoaDon on tChiTietHoaDon 
for insert,update,delete as
begin
	declare @SLBanI int,@MaDVI nvarchar(5),@SoHDI nvarchar(5),@tienDVI money 
	select @SLBanI = SoLuong,@MaDVI = MaDichVu,@SoHDI = SoHD from inserted
	select @tienDVI = GiaTien from tDichVu where MaDichVu = @MaDVI

	declare @SLBanD int,@MaDVD nvarchar(5),@SoHDD nvarchar(5),@tienDVD money 
	select @SLBanD = SoLuong,@MaDVD = MaDichVu,@SoHDD = SoHD from deleted
	select @tienDVD = GiaTien from tDichVu where MaDichVu = @MaDVD

	update tHoaDon set TongTienHoaDon = isNull(TongTienHoaDon,0) + isNull((@tienDVI*@SLBanI),0) where SoHD = @SoHDI
	update tHoaDon set TongTienHoaDon = isNull(TongTienHoaDon,0) - isNull((@tienDVD*@SLBanD),0) where SoHD = @SoHDD
end

select * from tHoaDon
select * from tChiTietHoaDon

update tHoaDon set TongTienHoaDon = (select sum(SoLuong*GiaTien) from tDichVu 
join tChiTietHoaDon on tDichVu.MaDichVu = tChiTietHoaDon.MaDichVu where SoHD = 'HD01'
group by SoHD) where SoHD = 'HD01'

insert into tChiTietHoaDon values ('HD01',4,'DV04');

delete tChiTietHoaDon where SoHD = 'HD01' and MaDichVu = 'DV04'

-- Câu 3 Thêm , sửa, xóa ở bảng vé, tự động cập nhật bảng tổng thu của bảng phim
update tPhim set TongThu = (select sum(GiaVe) from tVe join tLichChieu 
on tVe.NgayChieu = tLichChieu.NgayChieu
where MaPhim = 'P04'
group by MaPhim) where MaPhim = 'P04'

create or alter trigger tinhTongDoanhThuCuaPhim on tVe
for insert,delete,update
as
begin
	declare @maPhimI nvarchar(5),@giaVeI money
	select @maPhimI = MaPhim,@giaVeI = GiaVe from inserted join tLichChieu
	on inserted.NgayChieu = tLichChieu.NgayChieu
	declare @maPhimD nvarchar(5),@giaVeD money
	select @maPhimD = MaPhim,@giaVeD = GiaVe from deleted join tLichChieu
	on deleted.NgayChieu = tLichChieu.NgayChieu
	
	update tPhim set TongThu = ISNULL(TongThu,0) + @giaVeI where MaPhim = @maPhimI
	update tPhim set TongThu = ISNULL(TongThu,0) - @giaVeD where MaPhim = @maPhimD
end

insert into tVe values 
('MV41','KH02','NV01',N'Thường','2022/06/15 9:00','2022/06/15 12:00',65000);

select * from tPhim

delete from tVe where MaVe = 'MV41'

-- Câu 4 Thêm trường tổng số vé đã bán cho nhân viên. Thêm, sửa xóa ở bảng vé tự động cập nhật trường tổng số vé ở bảng nhân viên 
select * from tNhanVien
select * from tVe
alter table tNhanVien add SLVe int

create or alter trigger SLVeBanCuaNhanVien on tVe 
for insert,delete,update as
begin
	declare @MaNVI nvarchar(5),@MaNVD nvarchar(5)
	select @MaNVI = MaNV from inserted
	select @MaNVD = MaNV from deleted
	update tNhanVien set SLVe = isNull(SLVe,0) + 1 where MaNV = @MaNVI
	update tNhanVien set SLVe = isNull(SLVe,0) - 1 where MaNV = @MaNVD
end

select * from tNhanVien

update tNhanVien set SLVe = (select count(MaVe) from tVe where MaNV = 'NV01' group by MaNV) where MaNV = 'NV01'

insert into tVe values 
('MV42','KH02','NV01',N'Vip','2022/06/15 9:00','2022/06/15 12:00',90000);

delete from tVe where MaVe = 'MV42'

-- Câu 5 Thêm số lương loại vào trong bảng thể loại. Thêm ,sửa, xóa ở bảng phim trường số lượng loại tự động cập nhật
alter table tTheLoai add soLuongPhim int
create or alter trigger soTheLoai on tPhim
for delete,update,insert as
begin
	declare @maTheLoaiI nvarchar(255),@maTheLoaiD nvarchar(255)
	select @maTheLoaiI = MaTheLoai from inserted
	select @maTheLoaiD = MaTheLoai from deleted

	update tTheLoai set soLuongPhim = isNull(soLuongPhim,0) + 1 where @maTheLoaiI = MaTheLoai
	update tTheLoai set soLuongPhim = isNull(soLuongPhim,0) - 1 where @maTheLoaiD = MaTheLoai
end

update tTheLoai set soLuongPhim = (select count(MaPhim) from tPhim where MaTheLoai = 'TL06') where MaTheLoai = 'TL06'

select * from tPhim
select * from tTheLoai

insert into tPhim(MaPhim,TenPhim,NoiDungPhim,GiaPhim,ThoiLuongPhim,DaoDien,NgayKhoiChieu,NgayKetThuc,MaHangSX,MaNuocSX,MaTheLoai) values
('P07','BLACK ADAM',N'Black Adam là một bộ phim điện ảnh siêu anh hùng của Hoa Kỳ ra mắt năm 2022, dựa trên nhân vật cùng tên của DC Comics. 
Được sản xuất bởi New Line Cinema, DC Films.',100000000,120,'Rich Delia','2022/10/20','2022/12/20','HSX08','NSX08','TL04')

delete from tPhim where MaPhim = 'P07'



select * from tLichChieu



-- Câu 6 Thay đổi bảng tVe, cập nhật tự động cho số lượng phim mà nhân viên đó đã bán
select * from tNhanVien
select * from tVe
select * from tPhongChieu
alter table tNhanVien add SLPhimDaBan int



update tNhanVien set SLPhimDaBan = isNull((select count(distinct MaPhim) from tVe 
join tLichChieu on tLichChieu.NgayChieu = tVe.NgayChieu and tLichChieu.MaPhongChieu = tVe.MaPhongChieu
where MaNV = 'NV01'
group by MaNV
),0) where MaNV = 'NV01'


alter trigger SLPhimDaBan on tVe
for insert,delete,update as
begin
	declare @maNV nvarchar(255),@maPhim nvarchar(255),@luongPhimHienTai int,@luongPhimTruoc int
	select @maPhim = MaPhim,@maNV = MaNV from inserted 
	join tLichChieu on tLichChieu.NgayChieu = inserted.NgayChieu and tLichChieu.MaPhongChieu = inserted.MaPhongChieu
	select @luongPhimTruoc = SLPhimDaBan from tNhanVien

	select @luongPhimHienTai = count(distinct MaPhim) from tVe join tLichChieu on 
					tLichChieu.NgayChieu = tVe.NgayChieu and tLichChieu.MaPhongChieu = tVe.MaPhongChieu 
					where MaNV = @maNV

	IF @luongPhimHienTai > @luongPhimTruoc
		begin
        update tNhanVien set SLPhimDaBan = SLPhimDaBan + 1 where MaNV = @maNV;
		end
	ELSE 
		begin
		print N'Phim này trước đây nhân viên này đã từng đặt cho khách rồi !';	
		end
end
-- phim của nhân viên NV01 gồm 2,3,4

insert into tVe values 
('MV42','KH02','NV01',N'Vip','2022/06/15 9:00','2022/10/21 08:00','MP01',90000); -- phim 01

insert into tVe values 
('MV43','KH02','NV01',N'Vip','2022/06/15 9:00','2022/06/17 08:00','MP02',90000); -- phim 04

select distinct MaPhim from tVe join tLichChieu on 
tLichChieu.NgayChieu = tVe.NgayChieu and tLichChieu.MaPhongChieu = tVe.MaPhongChieu 
where MaNV = 'NV01'

delete from tVe where MaVe = 'MV42'
delete from tVe where MaVe = 'MV43'
select * from tNhanVien

exec sp_addlogin TranMinhDuc,123
exec sp_adduser TranMinhDuc,TranMinhDuc

grant select on tVe to TranMinhDuc with grant option
grant select on tHoaDon to TranMinhDuc with grant option
grant select on tChiTietHoaDon to TranMinhDuc with grant option

