drop database if exists ThucTap;

create database ThucTap;
use ThucTap;

-- 1. Tạo table với các ràng buộc và kiểu dữ liệu Thêm ít nhất 3 bản ghi vào table
create table GiangVien(
magv tinyint unsigned primary key,
hoten varchar(100),
luong int unsigned
);

create table SinhVien(
masv tinyint unsigned primary key,
hoten varchar(100),
namsinh date,
quequan varchar(500)
);

create table Detai(
madt tinyint unsigned primary key,
tendt varchar(500),
kinhphi int unsigned,
NoiThucTap varchar(500)
);

create table HuongDan(
id int(10) primary key AUTO_INCREMENT,
masv tinyint unsigned,
madt tinyint unsigned,
magv tinyint unsigned,
ketqua enum('Pass','False'),
foreign key(masv) references SinhVien(masv), 
foreign key(madt) references Detai(madt),
foreign key(magv) references GiangVien(magv)
);

-- Add values

-- Add values into table Giang Vien
Insert into GiangVien(magv,hoten, luong)
values
(111, 'Nguyen Thuy Hang', '5000000'),
(112, 'Tran Thuy Tien', '5000000'),
(113, 'Tran Duc Trung', '9000000');

-- Add values into table Sinh Vien
Insert into SinhVien(masv,hoten, namsinh, quequan)
values
(100, 'Nguyen Thi Nhung', '19920607', 'Thai Binh'),
(101, 'Nguyen Thi Cam Anh', '19911201', 'Hai Duong'),
(102, 'Pham Thanh Son', '19900119', 'Ninh Binh'),
(103, 'Pham Thi Lan', '19890119', 'Ha Noi'),
(104, 'Tran Thi Hai', '19890729', 'Ninh Binh'),
(105, 'Le Bao Anh', '19920629', 'Phu Tho');

-- Add values into table De tai
Insert into Detai(madt,tendt, kinhphi, NoiThucTap)
values
(01, 'Cong Nghe Sinh Hoc', '500000', 'Thai Binh'),
(02, 'Cong Nghe Thuc Pham', '700000', 'Ha Noi'),
(03, 'Cong Nghe May', '800000', 'Ninh Binh'),
(04, 'Vi Sinh', '1000000', 'Ha Noi'),
(05, 'An Toan Thuc Pham', '900000', 'Ha Noi');

-- Add value into table Huong Dan
Insert into HuongDan(id,masv, madt, magv, ketqua)
values
(1, 100, 01, 112, 'Pass'),
(2, 101, 02, 113, 'Pass'),
(3, 103, 01, 111, 'False'),
(4, 104, 03, 112, 'Pass'),
(5, 105, null, null, null);

-- 2. Viết lệnh để
-- a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn
select *
from SinhVien SV
Left join HuongDan HD on SV.masv = HD.masv
where HD.madt is null;

-- b) Lấy ra số sinh viên của khoa ‘CONG NGHE SINH HOC
select DT.madt, DT.tendt, count(masv)
from Detai DT
join HuongDan HD on DT.madt = HD.madt
group by DT.madt
having DT.tendt = 'Cong Nghe Sinh Hoc';

-- 3. Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm: mã số, họ tên và tên đề tài
-- (Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có")
create View SinhVienInfor AS
	select SV.masv, SV.hoten, HD.madt 
	from SinhVien SV
	inner join HuongDan HD on SV.masv = HD.masv;   
select SVI.masv, SVI.hoten, case
							when DT.tendt is null then 'Chua co'
                            else DT.tendt
                            end						
from SinhVienInfor SVI
Left join Detai DT on SVI.madt = DT.madt;

-- 4. Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1900 
-- thì hiện ra thông báo "năm sinh phải > 1900"
use ThucTap;
drop trigger if exists pre_check_insert;
delimiter $$
create trigger pre_check_insert before insert on SinhVien
for each row
	begin
    If new.namsinh <= '1990' then
    signal sqlstate '12345'
    set message_text = 'năm sinh phải > 1990';
    end if;
end$$
delimiter ;

-- 5. Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó 
-- thì sẽ tất cả thông tin trong table HuongDan liên quan tới sinh viên đó
Delete
from SinhVien
where masv = 100

delimiter $$
create trigger trigger_delete_SinhVien before delete on SinhVien
for each row
	begin
    delete
    from HuongDan
    where masv = old.masv;
    end $$
delimiter ;