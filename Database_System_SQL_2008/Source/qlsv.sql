/*Database System - SQL Server 2008*/
/*Database Management Student - By Nguyen Huu Nhan*/

create database qlsv;
--Tạo CSDL có tên là quản lí sinh viên
use qlsv;
-- Từ khóa use được khai báo để sử dụng CSDL vừa được tạo

/*Tạo các bảng có trong CSDL quản lí sinh viên*/

--Not null primary key là ràng buộc khóa chính khác null và tạo luôn khóa chính cho table 
create table sinhvien(
	MSSV char(10) not null primary key,
	HoTenSv varchar(50),
	Ngaysinh date
);
create table giaovien(
	MaGV char(10) not null primary key,
	HoTenGV varchar(50),
	NSGV date
);
create table mon(
	MaMon char(10) not null primary key,
	TenMon varchar(50),
	SoTC int,
	Khong_tinh_diem_TL char(1)
);
create table lopMH(
	Malop char(10) not null primary key,
	HKNH char(10),
	MaMon char(10),
	magv char(10),
);
create table diem_no_uplicate(
	MSSV char(10), 
	Malop char(10),
	Diem float
);
/*Import dữ liệu từ các file csv(các quan hệ của CSDL)*/
bulk insert sinhvien from 'D:\Database_System\File_Data\Thuoctinh_qlsv\sinhvien.csv'
with(
	firstrow = 2,
	--Bắt đầu nhận dữ liệu từ hàng thứ 2
	fieldterminator = ',',
	--Ngăn cách nhau bởi dấu ,
	rowterminator = '\n'
	--Kết thúc hàng bằng kí tự xuống dòng
);
bulk insert giaovien from 'D:\Database_System\File_Data\Thuoctinh_qlsv\giaovien.csv'
with(
	firstrow = 2,
	--Bắt đầu nhận dữ liệu từ hàng thứ 2
	fieldterminator = ';',
	--Ngăn cách nhau bởi dấu ;
	rowterminator = '\n'
	--Kết thúc hàng bằng kí tự xuống dòng
);
bulk insert mon from 'D:\Database_System\File_Data\Thuoctinh_qlsv\mon.csv'
with(
	firstrow = 2,
	--Bắt đầu nhận dữ liệu từ hàng thứ 2
	fieldterminator = ';',
	--Ngăn cách nhau bởi dấu ;
	rowterminator = '\n'
	--Kết thúc hàng bằng kí tự xuống dòng
);
bulk insert lopMH from 'D:\Database_System\File_Data\Thuoctinh_qlsv\lopMH.csv'
with(
	firstrow = 2,
	--Bắt đầu nhận dữ liệu từ hàng thứ 2
	fieldterminator = ';',
	--Ngăn cách nhau bởi dấu ;
	rowterminator = '\n'
	--Kết thúc hàng bằng kí tự xuống dòng
);
bulk insert diem_no_uplicate from 'D:\Database_System\File_Data\Thuoctinh_qlsv\diem_no_uplicate.csv'
with(
	firstrow = 2,
	--Bắt đầu nhận dữ liệu từ hàng thứ 2
	fieldterminator = ',',
	--Ngăn cách nhau bởi dấu ,
	rowterminator = '\n'
	--Kết thúc hàng bằng kí tự xuống dòng
);
/*Kiểm tra dữ liệu đã được chèn vào bảng của CSDL quản lí sinh viên hay chưa*/
select * from sinhvien
select * from giaovien
select * from mon
select * from lopMH
select * from diem_no_uplicate

/*Có nhiều cách để tạo khóa chính dưới đây là 1 cách khác dùng lệnh alter table*/

--Trước khi tạo khóa chính thì phải ràng buộc khóa chính khác NULL(rỗng) bằng dòng lệnh
--Ta thực hiện ràng buộc trên bảng điểm, bảng điểm lúc này có khóa chính gồm 2 thuộc tính(MSSV,Malop)
 
alter table diem_no_uplicate alter column MSSV char(10) not null;
alter table diem_no_uplicate alter column Malop char(10) not null;

--Sau khi đã cho khóa chinh khác null thì ta tạo khóa chinh bằng câu lệnh dưới đây, với các bảng có khóa chính gồm nhiều thuộc tính trong trường hợp này bảng Điểm gồm khóa chính chứa 2 thuộc tính là MSSV và Malop
alter table diem_no_uplicate add primary key(MSSV, Malop);

/*Tạo khóa ngoại cho bảng*/
/*Cũng có nhiều cách để tạo khóa ngoại và dưới đây là 1 cách*/
alter table diem_no_uplicate add foreign key(MSSV) references sinhvien(MSSV);
alter table diem_no_uplicate add foreign key(Malop) references lopMH(Malop);
alter table lopMH add foreign key(MaMon) references mon(MaMon);
alter table lopMH add foreign key(MaGV) references giaovien(MaGV);

/*Backup file lại để lần sau sử dùng mà không cần phảo tạo bảng và ràng buộc cũng như tạo các khóa chính,ngoại nữa*/
backup database qlsv to disk = 'D:\Database_System\File_Backup\qlsv.bak'

/*Để lần sau sử dụng lại CSDL qlsv chỉ cần dùng lệnh*/
restore database qlsv from disk = 'D:\Database_System\File_Backup\qlsv.bak' with replace

---Ở các phiên bản khác nếu restore không được thì hãy thuẻ sử dụng lệnh sau đây
restore database qlsv from disk = 'D:\Database_System\File_Backup\qlsv.bak' with replace, move 'qlsv' to
'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS1\MSSQL\DATA\qlsv.mdf',
move 'qlsv_Log' to 'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS1\MSSQL\DATA\qlsv_log.mdf'
--Lưu ý đường dẫn C:\..... nêu trên phụ thuộc tùy bản sql mà nó sẽ có tên thư mục khác nhau các bạn phải biết để sửa lại cho đúng với thư mục hiện hành !
