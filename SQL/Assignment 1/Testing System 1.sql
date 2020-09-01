drop database if exists QuanLyBaiThi;
create database QuanLyBaiThi;
use QuanLyBaiThi;

-- create department table
CREATE TABLE Department (
    DepartmentID TINYINT UNSIGNED PRIMARY KEY,
    DepartmentName VARCHAR(50) unique key
);
-- create position table
CREATE TABLE `Position` (
    PositionID TINYINT UNSIGNED PRIMARY KEY,
    PositionName VARCHAR(50) unique key
);
-- create account table
CREATE TABLE Account (
    AccountID SMALLINT UNSIGNED PRIMARY KEY,
    Email VARCHAR(50) unique key,
    UserName VARCHAR(50) unique key,
    FullName VARCHAR(50) not null,
    DepartmentID TINYINT UNSIGNED,
    PositionID TINYINT UNSIGNED,
    CreateDate DATE,
    foreign key(DepartmentID) references Department(DepartmentID),
    foreign key(PositionID) references `Position`(PositionID)
);
-- create group table
CREATE TABLE `Group` (
    GroupID TINYINT UNSIGNED PRIMARY KEY,
    GroupName VARCHAR(50) not null,
    CreatorID SMALLINT UNSIGNED not null,
    CreateDate DATE,
    foreign key(CreatorID) references Account(AccountID)
);
-- create group account table
CREATE TABLE GroupAccount (
    GroupID TINYINT UNSIGNED,
    AccountID SMALLINT UNSIGNED,
    JoinDate DATE,
    PRIMARY KEY (GroupID , AccountID),
    foreign key(GroupID) references `Group`(GroupID),
    foreign key(AccountID) references Account(AccountID)
);
-- create type of question 
CREATE TABLE TypeQuestion (
    TypeID TINYINT UNSIGNED PRIMARY KEY,
    TypeName VARCHAR(50)
);
-- create category of question
CREATE TABLE CategoryQuestion (
    CategoryID TINYINT UNSIGNED PRIMARY KEY,
    CategoryName VARCHAR(100) unique key
);
-- create question table
CREATE TABLE Question (
    QuestionID SMALLINT UNSIGNED PRIMARY KEY,
    Content VARCHAR(500),
    CategoryID TINYINT UNSIGNED,
    TypeID TINYINT UNSIGNED not null,
    CreatorID SMALLINT UNSIGNED not null,
    CreateDate DATE,
    foreign key(CategoryID) references CategoryQuestion(CategoryID),
    foreign key(TypeID) references TypeQuestion(TypeID),
    foreign key(CreatorID) references `Group`(CreatorID)
);
-- create answer table
CREATE TABLE Answer (
    AnswerID SMALLINT UNSIGNED PRIMARY KEY,
    Content VARCHAR(500),
    QuestionID SMALLINT UNSIGNED,
    isCorrect BIT,
    foreign key(QuestionID) references Question(QuestionID)
);
-- create exam table
CREATE TABLE Exam (
    ExamID TINYINT UNSIGNED PRIMARY KEY,
    Code MEDIUMINT UNSIGNED,
    Title VARCHAR(100),
    CategoryID TINYINT UNSIGNED not null,
    Duration DATE,
    CreatorID SMALLINT UNSIGNED not null,
    CreateDate DATE,
    foreign key(CategoryID) references CategoryQuestion(CategoryID),
    foreign key(CreatorID) references `Group`(CreatorID)
);
-- create exam question table
CREATE TABLE ExamQuestion (
    ExamID TINYINT UNSIGNED,
    QuestionID SMALLINT UNSIGNED,
    primary key(ExamID,QuestionID),
    foreign key(ExamID) references Exam(ExamID),
    foreign key(QuestionID) references Question(QuestionID)
);

-- -----------------------------------------------------------------------------
-- Add data into Department table
insert into Department(DepartmentID, DepartmentName)
values 
(1, `Design`),
(2, `Marketing`),
(3, `Accounting`),
(4, `IT`),
(5, `Back Office`),
(6, `Human Resource`),
(7, `Development`);

-- Add data into `Position`
insert into `Position`(PositionID, PositionName)
values
(1, `Communicator`),
(2, `Manager`),
(3, `Accountant`),
(4, `Tester`),
(5, `Assistant`),
(6, `Employer`),
(7, `Developer`);

-- Add data into Account

insert into Account(AccountID,Email,UserName,FullName, DepartmentID, PositionID, CreateDate)
values
(1, `boyloychoy@gmail.com`, `hoang.anhtran`, `Tran Hoang Anh`, 2,6, `20200503`),
(2, `hoangthimai@gmail.com`, `mai.hoangthi`, `Hoang Thi Mai`, 5,2, `20200211`),
(3, `xinloi.cuocdoi@gmail.com`, `nam.nguyenhoang`, `Nguyen Hoang Nam`, 7,7, `20200203`),
(4, `anhvtv13@gmail.com`, `anh.phantuan`, `Phan Tuan Anh`, 4,6, `20200202`),
(5, `lananh.nguyen@gmail.com`, `lan.nguyenthi`, `Nguyen Thi Lan`, 7,4, `20200120`),
(6, `ha.nguyenhai@gmail.com`, `ha.nguyenhai`, `Nguyen Hai Ha`, 1,6, `20200105`),
(7, `trinh.dinh@gmail.com`, `trinh.dinhthi`, `Dinh Thi Trinh`, 3,3, `20191230`),
(8, `hoang.dinhminh@gmail.com`, `hoang.dinhminh`, `Hoang Dinh Minh`, 7,7, `20191119`),
(9, `deptraithisao@gmail.com`, `thanh.phamtuan`, `Pham Tuan Thanh`, 7,1, `20190909`),
(10, `john.pham@gmail.com`, `john.pham`, `John Pham`, 7,2, `20190701`),
(11, `anna.pham@gmail.com`, `phuong.phamthi`, `Pham Thi Phuong`, 5,6, `20190527`),
(12, `khoi.leminh@gmail.com`, `khoi.leminh`, `Le Minh Khoi`, 6,2, `20190320`),
(13, `hoang.nguyenxuan@gmail.com`, `hoang.nguyenxuan`, `Nguyen Xuan Hoang`, 7,1, `20190311`),
(14, `thaibinh.nguyen@gmail.com`, `binh.nguyenthai`, `Nguyen Thai Binh`, 7,7, `20190210`),
(15, `Kemmy.tran@gmail.com`, `kemmy.tran`, `Kemmy Tran`, 1,2, `201801201`),
(16, `an.lethanh@gmail.com`, `an.lethanh`, `Le Thanh An`, 3,6, `20180727`),
(17, `linh.nguyenanhnhat@gmail.com`, `linh.nguyenanhnhat`, `Nguyen Anh Nhat Linh`, 7,4, `20180520`),
(18, `trang.ngothuy@gmail.com`, `trang.ngothuy`, `Ngo Thuy Trang`, 2,2, `20180425`);

-- Add data into `Group`
insert into `Group`(GroupID,GroupName, CreatorID, CreateDate)
values 
(1, `BOD`, 15, `201801201`),
(2, `Tester`, 17, `20180601`),
(3, `Dev`, 14, `20190212`),
(4, `Comtor Group`, 13, `20190312`),
(5, `GA`, 11, `20190601`);

-- Add data into GroupAccount
insert into GroupAccount(GroupID, AccountID, JoinDate)
values
(1, 2, `20200211`),
(1, 10, `20190702`),
(2, 5, `20200122`),
(2, 17, `20180520`),
(3, 3, `20200203`),
(3, 8, `20191119`),
(3, 14, `20190210`),
(4, 9, `20190909`),
(4, 13, `20190311`),
(5, 11, `20190527`),
(5, 2, `20200212`);

-- Add data into 
insert into TypeQuestion(TypeID, TypeName)
values

(1, `True / False Questions`),
(2, `Yes / No Questions`),
(3, `Choice Questions`),
(4, `Wh Question`);

-- Add data into CategoryQuestion
insert into CategoryQuestion(CategoryID, CategoryName)
values

(1, `Security Knowledge`),
(2, `Technical Knowledge`),
(3, `Management Knowleadge`),
(4, `Soft Skill`),
(5, `Advanced Knowledge`);

-- Add data into Question
insert into Question(QuestionID, Content, CategoryID, TypeID, CreatorID,CreateDate)
values

(1, N`Khi vi phạm security mức độ dự án thì bị phạt bao nhiêu?`, 1, 3, 10, `20190812`),
(2, N`Khi bị dính virus trên máy tính, điều đầu tiên là liên lạc với người quản lý đúng hay sai?`, 1, 1, 10, `20190812`),
(3, N`Tại sao không được post cả đoạn code lên trên github?`, 1, 5, 12, `20190810`),
(4, N`Hãy chọn những ngôn ngữ lập trình mà bạn có thể sử dụng.`, 2, 3, 14, `20190511`),
(5, N`Bạn đã từng tham gia một cuộc thi code cấp quốc gia chưa?`, 3, 2, 14, `20190511`),
(6, N`Tài liệu design màn hình thuộc tài liệu Basic design đúng hay sai?`, 3, 1, 8, `20191207`),
(7, N`Trong tam giác cân bằng, ngoài Cost, Resource, thì giá trị nào sau đây còn thiếu?`, 3, 3, 8,`20191207`),
(8, N`Khi nào thì PM cần làm tài liệu 5Why?`, 3, 3, `20191207`),
(9, N`Language skill`, 4, 3, 13, `20190311`),
(10, N`Chứng chỉ khác nếu có`, 4, 3, 13, `20190311`),
(11, N`Theo bạn, cần có những cải tiến gì để tăng doanh thu của công ty?`, 5, 4, 18, `20180425`);

-- Add data into Answer
insert into Answer(AnswerID, Content, QuestionID, isCorrect)
values

(1, `3.000.000VND`, 1, `Correct`),
(2, `True`, 2, `Correct`),
(3, N`Vì sẽ làm lộ key trong sourcecode khách hàng`, 3, `Correct`),
(4, `Java, .Net`, 4 ),
(5, N`No`, 5 ),
(6, N`False`, 6, `Incorrect`),
(7, `Scope`, 7, `Correct`),
(8, N`Khi CSS có item dưới 2 sao`, 8, `Correct`),
(9, `Japanese N3`, 9 ),
(10, `PMP`, 10),
(11, null);

-- Add data into Exam
insert into Exam(ExamID, Code,Title,CategoryID, Duration, CreatorID, CreateDate)
values

(1, `OOO1`, 5, `20200813`, 18, `20180425`),
(2, `OOO2`, 4, `20200813`, 13, `20190311`),
(3, `OOO3`, 3, `20200812`, 8, `20191207`),
(4, `OOO4`, 1, `20200810`, 10, `20190812`),
(5, `OOO5`, 2, `20200810`, 14, `20190511`);

-- Add data into ExamQuestion
insert into ExamQuestion(ExamID, QuestionID)
values

(1, 11),
(2, 9),
(2,10),
(3, 5),
(3, 6),
(3, 7),
(3, 8),
(4, 1),
(4, 2),
(4, 3),
(5, 4);



  


