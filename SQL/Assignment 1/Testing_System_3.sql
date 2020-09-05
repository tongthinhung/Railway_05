use Quanlybaithi;
-- Question 1: Thêm ít nhất 10 record vào mỗi table
insert into Account(AccountID,Email,UserName,FullName, DepartmentID, PositionID, CreateDate)
values
(19, 'tan.tranhai@gmail.com', 'Tan.HaiTran', 'Tran Hai Tan', 7, 7, '20200831');

-- Question 2: lấy ra tất cả các phòng ban
select DepartmentID
from Department
order by DepartmentID ASC;

-- Question 3: lấy ra id của phòng ban "Sale"
select * 
from Department
where DepartmentName = 'Human Resource';

-- Question 4: lấy ra thông tin account có full name dài nhất
select Fullname, length(Fullname) 
from Account;
select max(length(Fullname))
from Account;
    -- -> Gộp câu lệnh lại: 
select *
from Account
where length(Fullname) = (select max(length(Fullname)) from Account);

-- Lấy ra nhân viên có tuổi nhỏ nhất/lớn nhất trong cty
select *
from Account
where Age = (select min(Age) from Account) ;
select *
from Account
where Age = (select max(Age) from Account);

-- Question 5: Lấy ra thông tin account có full name ngắn nhất và thuộc phòng ban có id = 7
select *
from Account
where length(Fullname) = (select min(length(Fullname)) from Account) and DepartmentID = 7;

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
select * 
from QuanLyBaiThi.Group
where CreateDate < '20190212';

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
select * 
from Exam
where Duration >= '60' and CreateDate > 20190201;

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
select CreateDate
from `Group`
order by CreateDate DESC
limit 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
select count(UserName)
from Account
where DepartmentID = 7;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
select *
from Account
where Fullname like 'N%g';

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
select * 
from question
where Content like 'khi%';

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
select * 
from Account;
update Account
set FullName = 'Nguyen Ba Loc', Email = 'loc.nguyenba@vti.com.vn'
where AccountID = 5;

-- Tính độ tuổi trung bình của các nhân viên trong phòng Development
select AVG(Age)
from Account
where DepartmentID = 7;

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
select * 
from `Group`;
update QuanLyBaiThi.Group
set GroupID = 2
where CreatorID = 15;



