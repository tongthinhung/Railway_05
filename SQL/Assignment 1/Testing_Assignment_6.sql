use QuanLyBaiThi;

-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
Delimiter $$
create procedure Get_All_AccountInfo_In_Department (IN in_DepartmentName VARCHAR(50))
begin
Select A.UserName  
from Department D
Join Account A on D.DepartmentID = A.DepartmentID
where D.DepartmentName = in_DepartmentName; 
end $$
Delimiter ;

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
Delimiter $$
create procedure Get_Accounts_In_Group (IN in_GroupID TINYINT UNSIGNED, OUT out_AccountID SMALLINT UNSIGNED)
begin
select count(A.AccountID) into out_AccountID
from `Group` G
Join `Account` A on G.CreatorID = A.AccountID
where G.GroupID = in_GroupID;
end $$
Delimiter ;

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
Delimiter $$
create procedure Get_Questions_Created_by_TypeQuestion (IN in_TypeQuestion TINYINT UNSIGNED, OUT out_QuestionID SMALLINT UNSIGNED)
 begin
 select count(Q.QuestionID) into out_QuestionID
 from TypeQuestion TQ
join Question Q on TQ.TypeID = Q.TypeID
where TQ.TypeID = in_TypeQuestion;
end $$
Delimiter ;

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
delimiter $$
create procedure Get_Questions_By_TypeQuestion (OUT out_TypeID TINYINT UNSIGNED) 
begin
select TQ.TypeID into out_TypeID
from TypeQuestion TQ
join `Question` Q on TQ.TypeID = Q.TypeID
group by TQ.TypeID
having count(Q.QuestionID) = (select max(So_luong_Question)
							from (select count(Q.QuestionID) as So_luong_Question 
									from TypeQuestion TQ
									join `Question` Q on TQ.TypeID = Q.TypeID
									group by TQ.TypeID) as Thong_ke_Question);
end $$
Delimiter ;                                     
 Set @v_out_TypeID = 1;
 
-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
delimiter $$
create procedure Get_TypeName (IN in_TypeID TINYINT UNSIGNED)
begin
Select TypeName 
from TypeQuestion
where @v_out_TypeID = in_TypeID;
end $$
delimiter ;

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào
delimiter $$
create procedure Get_Information (IN in_GroupName VARCHAR(50), IN in_UserName VARCHAR(50))
begin
select *
from `Account`A
join `Group` G on A.AccountID = G.CreatorID
where (G.GroupName like '%Group') OR (A.UserName like '%VTI');
end $$
delimiter ;

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi positionID: sẽ có default là developer departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
delimiter $$
create procedure Get_FullName (IN in_FullName VARCHAR(50), IN in_Email VARCHAR(50))
begin 
select UserName like '%@gmail.com' 
from `Account`
Where FullName = in_FullName or Email = in_Email;
end $$
delimiter ;

set @v_out_UserName = ' ';
delimiter $$
create procedure Get_UserName_by_Email (IN in_UserName VARCHAR(50), OUT out_UserName VARCHAR(50))
begin
select UserName like '%@gmail.com' into out_UserName
from `Account`
where @v_out_UserName = in_UserName;
end $$
delimiter ;



, IN in_Email VARCHAR(50), OUT out_UserName VARCHAR(50), OUT out_PositionName VARCHAR(50), OUT out_DepartmentName VARCHAR(50)) 
begin
select UserName into out_UserName like Email.'%@gmail.com' , PositionName into out_PositionName (default('Employer')), DepartmentName into out_DepartmentName (default('Back Office'))
from `Account`
where FullName li
end $$
delimiter ;



