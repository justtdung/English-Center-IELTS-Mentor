CREATE DATABASE english_center;
GO

USE english_center;
GO

CREATE TABLE [User] (
    ID INT PRIMARY KEY NOT NULL,
    User_name VARCHAR(255) NOT NULL,
    Password TEXT NOT NULL,
    Full_name VARCHAR(255) NOT NULL
);

CREATE TABLE Class (
    ClassID VARCHAR(50) PRIMARY KEY NOT NULL,
    TeacherID VARCHAR(50) NOT NULL,
    NumStudent INT DEFAULT 0,
    StartDate DATE NOT NULL,
    TotalSessions INT NOT NULL DEFAULT 0,
    SessionsCompleted INT NOT NULL DEFAULT 0
);

CREATE TABLE Student (
    StudentID VARCHAR(50) PRIMARY KEY NOT NULL,
    ClassID VARCHAR(50) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Birthday DATE NULL,
    Gender BIT NULL,
    Phone VARCHAR(20) NULL,
    Email VARCHAR(255) UNIQUE NULL,
    UserID INT UNIQUE,
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID),
    FOREIGN KEY (UserID) REFERENCES [User](ID)
);

CREATE TABLE Teacher (
    TeacherID VARCHAR(50) PRIMARY KEY NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Birthday DATE NULL,
    Gender BIT NULL,
    Phone VARCHAR(20) NULL,
    Email VARCHAR(255) UNIQUE NULL,
    UserID INT UNIQUE,
    FOREIGN KEY (UserID) REFERENCES [User](ID)
);

ALTER TABLE Class
ADD CONSTRAINT FK_Class_Teacher FOREIGN KEY (TeacherID) REFERENCES Teacher(TeacherID);

CREATE TABLE Admin (
    AdminID VARCHAR(50) PRIMARY KEY NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Phone VARCHAR(20) NULL,
    Email VARCHAR(255) UNIQUE NULL,
    UserID INT UNIQUE,
    FOREIGN KEY (UserID) REFERENCES [User](ID)
);

CREATE TABLE Fee (
    FeeID VARCHAR(50) PRIMARY KEY NOT NULL,
    Type VARCHAR(100) NOT NULL,
    OriginalFee INT NOT NULL,
    Discount INT DEFAULT 0,
    FinalFee INT NOT NULL
);

CREATE TABLE Receipt (
    PaymentID VARCHAR(50) PRIMARY KEY NOT NULL,
    StudentID VARCHAR(50) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Date DATE NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Completed', 'Failed')) NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

CREATE TABLE Homework (
    HomeworkID VARCHAR(50) PRIMARY KEY NOT NULL,
    ClassID VARCHAR(50) NOT NULL,
    TeacherID VARCHAR(50) NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Description TEXT NULL,
    Deadline DATE NOT NULL,
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID),
    FOREIGN KEY (TeacherID) REFERENCES Teacher(TeacherID)
);

CREATE TABLE Submission (
    SubmissionID VARCHAR(50) PRIMARY KEY NOT NULL,
    StudentID VARCHAR(50) NOT NULL,
    HomeworkID VARCHAR(50) NOT NULL,
    [File] TEXT NOT NULL,
    Grade DECIMAL(4,2) NULL,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (HomeworkID) REFERENCES Homework(HomeworkID)
);

CREATE TABLE Notification (
    NotificationID VARCHAR(50) PRIMARY KEY NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Content TEXT NOT NULL,
    Date DATE NOT NULL
);
