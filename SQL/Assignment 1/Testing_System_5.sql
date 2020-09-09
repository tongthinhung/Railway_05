drop database if exists QuanLyBaiThi;
use QuanLyBaiThi;
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
create view Account_Of_Sale As
select D.DepartmentID, D.DepartmentName, A.AccountID, A.FullName
from Department D
inner join Account A on D.DepartmentID = A.DepartmentID
where D.DepartmentName = 'Design';

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
create view MaxAccount_Join_Group As
Select GA.GroupID, count(A.AccountID) As So_luong_Account
from `GroupAccount` GA
inner join `Account` A on GA.AccountID = A.AccountID
group by GA.GroupID
having count(A.AccountID) = (select max(So_luong_Account)
							from (Select GA.GroupID, count(A.AccountID) As So_luong_Account
									from `GroupAccount` GA
									inner join `Account` A on GA.AccountID = A.AccountID
									group by GA.GroupID) As Thong_Ke_Account);
                                    
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi    


-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất       
WITH Caculate_Number_Of_Account AS(
select count(A.AccountID) AS So_luong_Account
from `Department` D
inner join `Account` A on D.DepartmentID = A.DepartmentID
group by D.DepartmentID)
select DepartmentID, count(AccountID)
from `Account` 
group by DepartmentID
having count(AccountID) = (select max(So_luong_Account)
							from Caculate_Number_Of_Account);
			
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
create view Question_Created_by_Nguyen As(
WITH User_Nguyen as(
select AccountID, FullName
from `Account` 
where FullName LIKE 'Nguyen%')
select QuestionID, CreatorID, FullName
from Question Q
inner join User_Nguyen on Q.CreatorID = User_Nguyen.AccountID);                 
              
