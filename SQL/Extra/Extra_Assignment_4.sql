drop database if exists Quanlynhanvien;
create database Quanlynhanvien;
use Quanlynhanvien;
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- Question 1: Tạo table với các ràng buộc và kiểu dữ liệu
-- Question 2: Thêm ít nhất 10 bản ghi vào table

-- Create table phong ban
create table `Department`(
Department_Number tinyint unsigned primary key,
Department_Name varchar(50) unique check(length(Department_Name) >= 2)
);

-- Create table nhan vien
create table Employee(
Employee_Number tinyint unsigned primary key,
Employee_Name varchar(50) not null check(length(Employee_Name) >= 6),
Department_Number varchar(50)
);

-- Create table skill cua nhan vien
create table Employee_Skill(
Employee_Number tinyint unsigned,
Skill_Code varchar(50),
Date_Registered date
);

insert into `Department`(Department_Number, Department_Name)
values
(1, 'Develop'),
(2, 'Test'),
(3, 'Management'),
(4, 'BA');

insert into Employee(Employee_Number, Employee_Name, Department_Number)
values
(1, 'Tong Thi Nhung', 4),
(2, 'Dinh Minh Hoang', 1),
(3, 'Pham Thi Loan', 2),
(4, 'Nguyen Phuong Thao', 2),
(5, 'Le Dinh Hung', 1),
(6, 'La Van Truong', 1),
(7, 'Nguyen Van Duc', 1),
(8, 'Nguyen Anh Nhat Linh', 3),
(9, 'Pham Van Minh', 4);

insert into Employee_Skill(Employee_Number, Skill_Code, Date_Registered)
values
(1, 'Java', '20190501'),
(2, '.Net', '20190420'),
(3, 'Automation test', '20191207'),
(4, null, null),
(5, '.Net', '20200201'),
(6, '.Net', '20200310'),
(7, 'React', '20190815'),
(8, 'Java', '20180327'),
(9, 'Automation test', '20200720'),
(2, 'C#', '20190708');


-- Question 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java
select E.Employee_Number, E.Employee_Name, ES.Skill_Code
from Employee E
left join Employee_Skill ES on E.Employee_Number = ES.Employee_Number
having ES.Skill_Code = 'Java';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
select D.Department_Number, D.Department_Name, count(E.Employee_Number)
from Department D
left join Employee E on D.Department_Number = E.Department_Number
group by D.Department_Number
having count(E.Employee_Number) > 3;

-- Question 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban.

select D.Department_Number, D.Department_Name, E.Employee_Name
from Department D
left join Employee E on D.Department_Number = E.Department_Number
having D.Department_Number = 1
union
select D.Department_Number, D.Department_Name, E.Employee_Name
from Department D
left join Employee E on D.Department_Number = E.Department_Number
having D.Department_Number = 2
union
select D.Department_Number, D.Department_Name, E.Employee_Name
from Department D
left join Employee E on D.Department_Number = E.Department_Number
having D.Department_Number = 3
union
select D.Department_Number, D.Department_Name, E.Employee_Name
from Department D
left join Employee E on D.Department_Number = E.Department_Number
having D.Department_Number = 4;

-- Question 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills.
select E.Employee_Number, E.Employee_Name, count(ES.Skill_Code)
from Employee E
left join Employee_Skill ES on E.Employee_Number = ES.Employee_Number
group by Employee_Number
having count(ES.Skill_Code) > 1;