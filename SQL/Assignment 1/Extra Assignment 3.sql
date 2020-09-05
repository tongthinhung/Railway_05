SELECT * FROM QuanlyFresher.Trainee;

-- Question 2: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào,
--  nhóm chúng thành các tháng sinh khác nhau
select *
from Trainee
where Result = 'Pass';

select ExamDate, count(*)
from Trainee
where Result = 'Pass'
group by ExamDate;

select *
from Trainee
where ExamDate = (select count(*) from Trainee group by ExamDate);

-- Question 3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau: tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table)
select *
from Trainee
where length(Fullname) = (select max(length(Fullname)) from Trainee);

-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là
-- những người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau:ET_IQ + ET_Gmath>=20,ET_IQ>=8,  ET_Gmath>=8, ET_English>=18
select * 
from ExamResult
where Result = 'Pass' and (ET_IQ >= '8' or ET_Gmath >= '8' or ET_English >= '18');


-- Question 5: xóa thực tập sinh có TraineeID = 3
Delete 
from Trainee
where TraineeID = 3;
-- 

