create database congtrinh;
use congtrinh;

create table kientrucsu(
	MSKTS char(10) not null primary key,
	HOTENKTS varchar(50),
	Ngaysinh date,
	PHAI char(5),
	NOITN varchar(30),
	DIACHIKTS varchar(50)
);
create table chuthau(
	MSCT char(10) not null primary key,
	TENTHAU varchar(50),
	DIENTHOAI char(11),
	DIACHITHAU varchar(50),
);
create table chunhan(
	MSCH char(10) not null primary key,
	TENCHU varchar(50),
	PHAI char(5),
	DIACHICHU varchar(50)
);

create table congnhan(
	MSCN char(10) not null primary key,
	HOTENCN varchar(50),
	NGAYSINH date,
	PHAI char(5),
	CHUYENMON varchar(50)
);
create table congtrinh(
	STTCT char(10) not null primary key,
	TENCT varchar(50),
	DIACHICT varchar(50),
	TINHTHANH varchar(20),
	KINHPHI float,
	MSCH char(10),
	MSCT char(10),
	NGAYBD date
);
create table thamgia_no_duplicate(
	MSCN char(10),
	STTCT char(10),
	NGAYTG date,
	SONGAY int
);
create table thietke_no_duplicate(
	MSKTS char(10),
	STTCT char(10),
	THULAO int
);
bulk insert congtrinh from 'D:\Database_System\TTCSDL_congtrinh\congtrinh.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
);
bulk insert kientrucsu from 'D:\Database_System\TTCSDL_congtrinh\kientrucsu.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
);      
bulk insert chunhan from 'D:\Database_System\TTCSDL_congtrinh\chunhan.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
);     
bulk insert chuthau from 'D:\Database_System\TTCSDL_congtrinh\chuthau.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
);           
bulk insert congnhan from 'D:\Database_System\TTCSDL_congtrinh\congnhan.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
);
bulk insert thamgia_no_duplicate from 'D:\Database_System\TTCSDL_congtrinh\thamgia_no_duplicate.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
); 
bulk insert thietke_no_duplicate from 'D:\Database_System\TTCSDL_congtrinh\thietke_no_duplicate.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
); 

/*Rang buoc khoa chinh khac null cho bang tham gia*/
alter table thamgia_no_duplicate alter column MSCN char(10)not null;
alter table thamgia_no_duplicate alter column STTCT char(10) not null;   
/*Tao khoa chinh cho bang thamgia*/
alter table thamgia_no_duplicate add primary key(MSCN,STTCT);
/*Tao khoa ngoai cho thamgia*/
alter table thamgia_no_duplicate add foreign key(MSCN)references congnhan(MSCN); 
alter table thamgia_no_duplicate add foreign key(STTCT)references congtrinh(STTCT);  
/*Rang buoc khoa chinh khac null cho bang thiet ke*/
alter table thietke_no_duplicate alter column MSKTS char(10) not null;
alter table thietke_no_duplicate alter column STTCT char(10) not null;
/*Tao khoa chinh cho bang thiet ke*/
alter table thietke_no_duplicate add primary key(MSKTS,STTCT); 
/*Tao khoa ngoai cho bang thiet ke*/
alter table thietke_no_duplicate add foreign key(MSKTS) references kientrucsu(MSKTS);
alter table thietke_no_duplicate add foreign key(STTCT) references congtrinh(STTCT);    
/*Tao khoa ngoai cho cac bang con lai*/
alter table congtrinh add foreign key(MSCH) references chunhan(MSCH);
alter table congtrinh add foreign key(MSCT)  references chuthau(MSCT);

backup database congtrinh to disk = 'D:\Database_System\File_Backup\congtrinh.bak'
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
