use Quanlybaithi;
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ 
select A.AccountID, A.Fullname, D.DepartmentName
from `Account` A
join Department D on A.DepartmentID = D.DepartmentID;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 
select *
from `Account`
where CreateDate > '20191230';

-- Question 3: Viết lệnh để lấy ra tất cả các developer
select A.AccountID, A.FullName, P.PositionID, P.PositionName
from `Account` A
join Position P on A.PositionID = P.PositionID
where P.PositionID = 7;

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
select DepartmentName, count(D.DepartmentID)
from `Account` A 
join Department D on A.DepartmentID = D.DepartmentID
group by D.DepartmentID
having count(D.DepartmentID) > 3;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
-- Count so luong question de biet so luong nhieu nhat
select count(Q.QuestionID) as So_luong_Question
from Question Q
join ExamQuestion EQ on Q.QuestionID = EQ.QuestionID
group by Q.QuestionID;

select Q.QuestionID AS So_luong_Exam
from Question Q
left join ExamQuestion EQ on Q.QuestionID = EQ.QuestionID
group by Q.QuestionID
having count(EQ.ExamID) =  (select max(So_luong_Exam)
					     from (select count(EQ.ExamID)  as So_luong_Exam
                               from   Question Q
							   join   ExamQuestion EQ on Q.QuestionID = EQ.QuestionID
							   group by Q.QuestionID) as thong_ke_Question_List);
                               							
-- Note: error code 1248. every derived table must have its own alias: mọi bảng dẫn xuất/truy vấn phụ đều cân phải có bí danh (dạng:AS...)
-- mỗi truy vấn trong ngoặc phải có một bí danh (AS bất kỳ), có thể được sử dụng để tham chiếu đến nó trong phần còn lại của truy vấn bên ngoài                      

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question 
select CQ.CategoryID, CQ.CategoryName, count(Q.QuestionID)
from CategoryQuestion CQ
left join Question Q on CQ.CategoryID = Q.CategoryID
group by CQ.CategoryID

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
select EQ.QuestionID, count(E.ExamID)
from ExamQuestion EQ
left join Exam E on EQ.ExamID = E.ExamID
group by EQ.QuestionID;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
select Q.QuestionID, count(AW.AnswerID) AS So_luong_Answer
from Question Q
left join Answer AW on Q.QuestionID = AW.QuestionID
group by Q.QuestionID
having count(AW.AnswerID) = (select max(So_luong_Answer)
						   from (select count(AW.AnswerID) AS So_luong_Answer
                                 from Question Q
                                 left join Answer AW on Q.QuestionID = AW.QuestionID
                                 group by Q.QuestionID) AS thong_ke_so_luong_Question);

-- Question 9: Thống kê số lượng account trong mỗi group
select GA.GroupID, count(A.AccountID)
from `GroupAccount` GA
left join Account A on GA.AccountID = A.AccountID
group by GA.GroupID;

-- Question 10: Tìm chức vụ có ít người nhất

select P.PositionID, count(A.AccountID) AS So_luong_Account
from Position P
left join Account A on P.PositionID = A.PositionID
group by P.PositionID
having count(A.AccountID)  = (select min(So_luong_Account)
                             from (select P.PositionID, count(A.AccountID) AS So_luong_Account
                                  from Position P
                                  left join Account A on P.PositionID = A.PositionID
                                  group by P.PositionID) AS Thong_ke_Position);

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM 
select D.DepartmentID, D.DepartmentName, A.AccountID, A.PositionID, P.PositionName 
from Department D
Left join `Account` A on D.DepartmentID = A.DepartmentID
Left join Position P on A.PositionID = P.PositionID



-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ... 
select Q.QuestionID, Q.Content, Q.TypeID, Q.CreatorID, AW.Content, AW.isCorrect
from Question Q
left join Answer AW on Q.QuestionID = AW.QuestionID;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm 
select TQ.TypeID, TQ.TypeName, Q.QuestionID, count(Q.QuestionID)
from TypeQuestion TQ
left join Question Q on TQ.TypeID = Q.TypeID
group by TQ.TypeID; 

-- Question 14:Lấy ra group không có account nào
select A.AccountID, count(G.GroupID)
from `Account` A
left join GroupAccount G on A.AccountID = G.AccountID
group by A.AccountID
having count(G.GroupID) = '0';

-- Question 16: Lấy ra question không có answer nào

select Q.QuestionID, count(AW.AnswerID)
from Question Q 
left join Answer AW on Q.QuestionID = AW.QuestionID
group by Q.QuestionID
having count(AW.AnswerID) = '0';

-- Exercise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
select *
from `GroupAccount`
where GroupID = '1'
union
select *
from `GroupAccount`
where GroupID = '2';

-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
-- b) Lấy các group có nhỏ hơn 7 thành viên
-- c) Ghép 2 kết quả từ câu a) và câu b)
select GA.GroupID, count(A.AccountID)
from GroupAccount GA
join Account A on GA.AccountID = A.AccountID
group by GA.GroupID
having count(A.AccountID) > 2
union all
select GA.GroupID, count(A.AccountID)
from GroupAccount GA
join Account A on GA.AccountID = A.AccountID
group by GA.GroupID
having count(A.AccountID) < 4;


			
