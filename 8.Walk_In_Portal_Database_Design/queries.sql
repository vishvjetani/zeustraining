CREATE DATABASE WALK_IN_PORTAL_DB;
USE WALK_IN_PORTAL_DB;

CREATE TABLE IF NOT EXISTS `walk_in_portal_DB`.`users` (
  `USER_ID` INT NOT NULL AUTO_INCREMENT,
  `PROFILE_PICTURE_PATH` VARCHAR(100) NULL DEFAULT NULL,
  `FIRST_NAME` VARCHAR(100) NOT NULL,
  `LAST_NAME` VARCHAR(100) NOT NULL,
  `EMAIL` VARCHAR(100) NOT NULL,
  `MOBILE_NO` VARCHAR(15) NOT NULL,
  `RESUME_PATH` VARCHAR(255) NULL DEFAULT NULL,
  `PORTFOLIO_URL` VARCHAR(255) NULL DEFAULT NULL,
  `REFFERAL` VARCHAR(100) NULL DEFAULT NULL,
  `UPDATES_VIA_MAIL` ENUM('0', '1') NULL DEFAULT '0',
  `PASSWORD_HASH` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE INDEX `EMAIL_UNIQUE` (`EMAIL` ASC) VISIBLE
  );


INSERT INTO USERS (PROFILE_PICTURE_PATH, FIRST_NAME, LAST_NAME, EMAIL, MOBILE_NO, RESUME_PATH, PORTFOLIO_URL, REFFERAL, UPDATES_VIA_MAIL, PASSWORD_HASH) VALUES
('/profiles/profile1.jpg', 'John', 'Doe', 'john.doe@email.com', '1234567890', '/resumes/john_doe_resume.pdf', 'https://john.doe/portfolio', 'REF123', '1', 'hashed_password_1'),
('/profiles/profile2.jpg', 'Jane', 'Smith', 'jane.smith@email.com', '9876543210', '/resumes/jane_smith_resume.pdf', 'https://jane.smith/portfolio', 'REF456', '0', 'hashed_password_2'),
('/profiles/profile3.jpg', 'Alice', 'Johnson', 'alice.johnson@email.com', '5556667777', '/resumes/alice_johnson_resume.pdf', 'https://alice.johnson/portfolio', 'REF789', '1', 'hashed_password_3');


CREATE TABLE IF NOT EXISTS `walk_in_portal_DB`.`job_roles` (
  `ROLE_ID` INT NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ROLE_ID`));

INSERT INTO JOB_ROLES(ROLE_NAME) VALUES ('Instructional Designer'),('Software Engineer'),('Software Quality Engineer');

CREATE TABLE IF NOT EXISTS `walk_in_portal_db`.`user_job_roles` (
  `USER_ID` INT NOT NULL,
  `ROLE_ID` INT NOT NULL,
  PRIMARY KEY (`USER_ID`, `ROLE_ID`),
  INDEX `ROLE_ID` (`ROLE_ID` ASC) VISIBLE,
  CONSTRAINT `user_job_roles_ibfk_1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `walk_in_portal_db`.`users` (`USER_ID`),
  CONSTRAINT `user_job_roles_ibfk_2`
    FOREIGN KEY (`ROLE_ID`)
    REFERENCES `walk_in_portal_db`.`job_roles` (`ROLE_ID`));


-- ALTER TABLE table_name ADD COLUMN DT_CREATED DATETIME DEFAULT CURRENT_TIMESTAMP;
-- ALTER TABLE table_name ADD COLUMN DT_MODIFIED DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- GETTING THE DETAILS OF USER WHO OPTED FOR PARTICULAR ROLE
SELECT EMAIL,FIRST_NAME,LAST_NAME,ROLE_NAME FROM USERS U INNER JOIN USER_JOB_ROLES UJR ON U.USER_ID=UJR.USER_ID INNER JOIN JOB_ROLES JR ON UJR.ROLE_ID=JR.ROLE_ID WHERE JR.ROLE_NAME="Software Engineer";

-- GETTING THE DETAILS OF PARTICULAR USER SELECTED WHICH ROLES
SELECT EMAIL,FIRST_NAME,LAST_NAME,ROLE_NAME FROM USERS U INNER JOIN USER_JOB_ROLES UJR ON U.USER_ID=UJR.USER_ID INNER JOIN JOB_ROLES JR ON UJR.ROLE_ID=JR.ROLE_ID WHERE U.FIRST_NAME='John';


CREATE TABLE IF NOT EXISTS `walk_in_portal_db`.`user_education_qualifications` (
  `USER_ID` INT NOT NULL,
  `AGGREGATE_PERCENTAGE` INT NULL DEFAULT NULL,
  `PASSING_YEAR` INT NULL DEFAULT NULL,
  `QUALIFICATION` VARCHAR(100) NULL DEFAULT NULL,
  `STREAM_NAME` VARCHAR(100) NULL DEFAULT NULL,
  `COLLEGE` VARCHAR(100) NULL DEFAULT NULL,
  `COLLEGE_LOCATION` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  CONSTRAINT `user_education_qualifications_ibfk_1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `walk_in_portal_db`.`users` (`USER_ID`));

INSERT INTO `walk_in_portal_db`.`user_education_qualifications` (
    `USER_ID`,
    `AGGREGATE_PERCENTAGE`,
    `PASSING_YEAR`,
    `QUALIFICATION`,
    `STREAM_NAME`,
    `COLLEGE`,
    `COLLEGE_LOCATION`
) VALUES
    (1, 85, 2022, 'Bachelor of Science', 'Computer Science', 'XYZ College', 'CityA'),
    (2, 78, 2021, 'Bachelor of Arts', 'English Literature', 'ABC University', 'CityB'),
    (3, 92, 2023, 'Bachelor of Engineering', 'Mechanical Engineering', 'DEF Institute', 'CityC');

CREATE TABLE IF NOT EXISTS `walk_in_portal_db`.`qualifications` (
  `QUALIFICATION_ID` INT NOT NULL AUTO_INCREMENT,
  `QUALIFICATION_NAME` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`QUALIFICATION_ID`)
);
ALTER TABLE qualifications ADD COLUMN DT_CREATED DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE qualifications ADD COLUMN DT_MODIFIED DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

INSERT INTO `walk_in_portal_db`.`qualifications` (`QUALIFICATION_NAME`) VALUES
    ('Bachelor of Science'),
    ('Bachelor of Technology'),
    ('Bachelor of Engineering'),
    ('Master of Science'),
    ('Master of Business Administration');

CREATE TABLE IF NOT EXISTS `walk_in_portal_db`.`streams` (
  `STREAM_ID` INT NOT NULL AUTO_INCREMENT,
  `STREAM_NAME` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`STREAM_ID`)
);

INSERT INTO `walk_in_portal_db`.`streams` (`STREAM_NAME`) VALUES
    ('Computer Science'),
    ('Electronics and Communication Engineering'),
    ('Information Technology'),
    ('Others');

CREATE TABLE IF NOT EXISTS `walk_in_portal_db`.`colleges` (
  `COLLEGE_ID` INT NOT NULL AUTO_INCREMENT,
  `COLLEGE_NAME` VARCHAR(100) NOT NULL,
  `COLLEGE_LOCATION` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`COLLEGE_ID`)
);


INSERT INTO `walk_in_portal_db`.`colleges` (`COLLEGE_NAME`, `COLLEGE_LOCATION`) VALUES
    ('XYZ College', 'CityA'),
    ('ABC University', 'CityB'),
    ('DEF Institute', 'CityC'),
    ('LMN College', 'CityD'),
    ('PQR University', 'CityE');




CREATE TABLE IF NOT EXISTS `walk_in_portal_db`.`user_professional_qualifications` (
  `USER_ID` INT NOT NULL,
  `APPLICANT_TYPE` VARCHAR(20) NOT NULL CHECK (APPLICANT_TYPE IN ('FRESHER', 'EXPERIENCED')),
  `EXPERIENCE` INT NULL DEFAULT NULL,
  `CURRENT_CTC` INT NULL DEFAULT NULL,
  `EXPECTED_CTC` INT NULL DEFAULT NULL,
  `NOTICE_PERIOD` ENUM('0', '1') NULL DEFAULT NULL,
  `NOTICE_PERIOD_END` DATE NULL DEFAULT NULL,
  `NOTICE_PERIOD_DURATION` INT NULL DEFAULT NULL,
  `APPEARED_FOR_TEST` ENUM('0', '1') NOT NULL,
  `OTHER_TECHNOLGOIES` VARCHAR(255) NULL DEFAULT NULL,
  `APPLIED_PAST_ROLE` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  CONSTRAINT `user_professional_qualifications_ibfk_1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `walk_in_portal_db`.`users` (`USER_ID`));

INSERT INTO `walk_in_portal_db`.`user_professional_qualifications` (
    `USER_ID`,
    `APPLICANT_TYPE`,
    `EXPERIENCE`,
    `CURRENT_CTC`,
    `EXPECTED_CTC`,
    `NOTICE_PERIOD`,
    `NOTICE_PERIOD_END`,
    `NOTICE_PERIOD_DURATION`,
    `APPEARED_FOR_TEST`,
    `OTHER_TECHNOLGOIES`,
    `APPLIED_PAST_ROLE`
) VALUES
    (1, 'Experienced', 5, 80000, 100000, '1', '2023-02-28', 30, '1', 'Java, Python', 'Software Engineer'),
    (2, 'Fresher', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL),
    (3, 'Experienced', 8, 120000, 150000, '0', NULL, NULL, '1', 'C++, JavaScript', 'Senior Developer');

CREATE TABLE IF NOT EXISTS `walk_in_portal_db`.`technologies` (
  `TECHNOLOGY_ID` INT NOT NULL AUTO_INCREMENT,
  `TECHNOLOGY_NAME` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`TECHNOLOGY_ID`));
  
  ALTER TABLE technologies ADD COLUMN DT_CREATED DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE technologies ADD COLUMN DT_MODIFIED DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
  -- Dummy data for technologies
INSERT INTO `walk_in_portal_db`.`technologies` (`TECHNOLOGY_NAME`) VALUES
    ('Java'),
    ('Python'),
    ('JavaScript'),
    ('C++'),
    ('HTML/CSS'),
    ('React'),
    ('Angular'),
    ('Node.js'),
    ('SQL'),
    ('MongoDB');

CREATE TABLE IF NOT EXISTS `walk_in_portal_db`.`user_technologies` (
  `USER_ID` INT NOT NULL,
  `TECHNOLOGY_ID` INT NOT NULL,
  `EXPERIENCE` VARCHAR(20) NOT NULL CHECK (EXPERIENCE IN ('FAMILIAR', 'EXPERT')),
  PRIMARY KEY (`USER_ID`, `TECHNOLOGY_ID`),
  CONSTRAINT `user_technologies_ibfk_1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `walk_in_portal_db`.`users` (`USER_ID`),
  CONSTRAINT `user_technologies_ibfk_2`
    FOREIGN KEY (`TECHNOLOGY_ID`)
    REFERENCES `walk_in_portal_db`.`technologies` (`TECHNOLOGY_ID`));


INSERT INTO `walk_in_portal_db`.`user_technologies` (`USER_ID`, `TECHNOLOGY_ID`, `EXPERIENCE`) VALUES
    (1, 1, 'EXPERT'),  
    (1, 2, 'FAMILIAR'), 
    (2, 3, 'EXPERT'),  
    (2, 4, 'FAMILIAR'), 
    (3, 5, 'EXPERT'),  
    (3, 6, 'FAMILIAR'); 


CREATE TABLE IF NOT EXISTS `walk_in_portal_db`.`walk_in` (
  `WALK_IN_ID` INT NOT NULL AUTO_INCREMENT,
  `WALK_IN_TITLE` VARCHAR(100) NOT NULL,
  `WALK_IN_START_DATE` DATE NOT NULL,
  `WALK_IN_END_DATE` DATE NOT NULL,
  `WALK_IN_LOCATION` VARCHAR(255) NOT NULL,
  `EXPIRED` BOOLEAN DEFAULT FALSE,
  `EXPIRED_DATE` DATE NOT NULL,
  PRIMARY KEY (`WALK_IN_ID`));

ALTER TABLE walk_in ADD COLUMN DT_CREATED DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE walk_in ADD COLUMN DT_MODIFIED DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP; 

INSERT INTO `walk_in_portal_db`.`walk_in` (`WALK_IN_TITLE`, `WALK_IN_START_DATE`, `WALK_IN_END_DATE`, `WALK_IN_LOCATION` , `EXPIRED_DATE`,`EXPIRED`) VALUES
    ('Walk In for Designer Job Role', '2021-07-10', '2021-07-11', 'Mumbai','2012-06-30',0),
    ('Walk In for Multiple Job Roles', '2021-07-03', '2021-07-04', 'Mumbai','2012-06-30',0),
    ('Walk In for Design and Development Job Role', '2021-07-10', '2021-07-11', 'Mumbai','2012-06-30',0);

CREATE TABLE IF NOT EXISTS `WALK_IN_PORTAL_DB`.`walk_in_instructions`(
`WALK_IN_ID` INT PRIMARY KEY,
 `GENERAL_INSTRUCTIONS` TEXT,
  `EXAM_INSTRUCTIONS` TEXT,
  `MIN_SYSTEM_REQUIREMENT` TEXT,
  `PROCESS_FLOW` TEXT,
  `VENUE` TEXT,
  `THINGS_TO_REMEMBER` TEXT,
  FOREIGN KEY (WALK_IN_ID) REFERENCES WALK_IN(WALK_IN_ID)
);

ALTER TABLE walk_in_instructions ADD COLUMN DT_CREATED DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE walk_in_instructions ADD COLUMN DT_MODIFIED DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP; 

INSERT INTO `WALK_IN_PORTAL_DB`.`walk_in_instructions` (
    `WALK_IN_ID`,
    `GENERAL_INSTRUCTIONS`,
    `EXAM_INSTRUCTIONS`,
    `MIN_SYSTEM_REQUIREMENT`,
    `PROCESS_FLOW`,
    `VENUE`,
    `THINGS_TO_REMEMBER`
) VALUES (
    1,
    '- We have a two-year indemnity for permanent candidates. We will provide training to the selected candidates.
Candidates who have appeared for any test held by Zeus Learning in the past 12 months will not be allowed to appear for this recruitment test.',
    'Candidates are requested to log in half an hour prior to the exam start time as they would need to capture their image using a web camera. By taking this test, you are permitting the examination system to capture your video for invigilation purposes.
Candidates would not be able to appear for the exam if the web camera attached to their system is not functional.
The web camera of your system must be enabled and must remain switched on throughout the examination. In the event of non-receipt of a webcam, your examination will be considered null and
void.
- Candidate\'s audio and video will be recorded during the examination and will also be monitored by a live proctor. The proctor may terminate your exam in case he/she observes any malpractice during the exam.
Candidates are advised to use their own Laptop/PC with a stable internet connection (min 1 Mbps) during the exam.
Candidates cannot use an iOS system/device for this exam.',
    'Personal Laptop or Desktop computer in working condition with good quality camera (you can use
Windows 7 and above).
The latest version of Google Chrome Browser only.
Please note that Internet speed should be minimum 1 Mbps.
Do not use a MacBook or iPad for the proctored exam.',
    '- Every round is an elimination round. Candidates need to clear all rounds to get selected.
Round 1: 4th August, 2018
Aptitude Test: 25 Questions
Round II (Interview): 4th August, 2018.',
    'Zeus Systems Pvt. Ltd.
1402, 14th Floor, Tower B, Peninsula Business Park. Ganpatrao Kadam Marg
Lower Parel (W)
Mumbai-400 013
Phone: +91-22-66600000',
    '- Please report 30 MINUTES prior to your reporting time.
- Download your Hall Ticket from below and carry it with you during your Walk-in.'
), 
(
    2,
    'Bring a copy of your resume and a valid ID.',
    'Technical interview will be conducted in the second round.',
    'Ensure your laptop has a stable internet connection.',
    'Registration -> Initial screening -> Technical interview -> HR interview.',
    'ABC University Auditorium',
    'Dress professionally.'
),
(
    3,
    'Candidates should bring their portfolio.',
    'Coding test will be conducted in the first round.',
    'Recommended system requirement: 8GB RAM, Quad-core processor.',
    'Portfolio review -> Coding test -> Final interview.',
    'XYZ Tech Park',
    'Prepare for a coding challenge.'
);

CREATE TABLE IF NOT EXISTS `walk_in_portal_db`.`walk_in_job_roles` (
`WALK_IN_JOB_ROLE_ID` PRIMARY KEY AUTO_INCREMENT,
  `WALK_IN_ID` INT NOT NULL,
  `ROLE_ID` INT NOT NULL,
  `GROSS_COMPENSATION` INT NOT NULL,
  `ROLE_DESCRIPTION` TEXT NOT NULL,
  `REQUIREMENTS` TEXT NOT NULL,
  CONSTRAINT `walk_in_job_roles_ibfk_1`
    FOREIGN KEY (`WALK_IN_ID`)
    REFERENCES `walk_in_portal_db`.`walk_in` (`WALK_IN_ID`),
  CONSTRAINT `walk_in_job_roles_ibfk_2`
    FOREIGN KEY (`ROLE_ID`)
    REFERENCES `walk_in_portal_db`.`job_roles` (`ROLE_ID`));

ALTER TABLE walk_in_job_roles ADD COLUMN DT_CREATED DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE walk_in_job_roles ADD COLUMN DT_MODIFIED DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP; 

INSERT INTO `walk_in_portal_db`.`walk_in_job_roles` (
    `WALK_IN_ID`,
    `ROLE_ID`,
    `GROSS_COMPENSATION`,
    `ROLE_DESCRIPTION`,
    `REQUIREMENTS`
) VALUES (
    1,
    1,
    500000,
    '- Generate highly interactive and innovative
instructional strategies for e-learning solutions
- Develop course structure and learning
specifications addressing the requirements of
the target audience
- Construct appropriate testing strategies to
ensure learners\' understanding and performance
- Address usability issues
- Keep abreast of new trends in e-learning
- Ensure that the instructional strategies are as per global standards
- Prepare instructional design checklists and guidelines
- Check for quality assurance',
    '- Experience in creating instructional plans and course maps.
- Experience in the use of media like graphics, illustrations, photographs, audio, video, animations, and simulations in instruction
- Awareness of different instructional design
models and familiarity with instructional and learning theories
- Awareness of latest trends in e-learning and instructional design
- Strong client consulting/interfacing skills.
- Ability to guide clients to focus on specific objectives and teaching points
- Strong meeting facilitation, presentation and interpersonal skills
- A thorough understanding of the web as an instructional medium
- Post graduate degree in Education, Instructional Design, Mass Communication or Journalism'
),
(
    1,
    2,
    90000,
    'Data Analyst',
    'Bachelor\'s degree in Statistics or related field, strong analytical skills.'
),
(
    2,
    3,
    85000,
    'Marketing Specialist',
    'Bachelor\'s degree in Marketing, experience in digital marketing.'
),
(
    2,
    2,
    95000,
    'Financial Analyst',
    'Bachelor\'s degree in Finance, strong financial analysis skills.'
),
(
    3,
    3,
    100000,
    'Full Stack Developer',
    'Bachelor\'s degree in Computer Science, proficiency in HTML, CSS, JavaScript, and Node.js.'
),
(
    3,
    1,
    110000,
    'UX/UI Designer',
    'Bachelor\'s degree in Design, experience in creating user-centric designs.'
);



CREATE TABLE IF NOT EXISTS `walk_in_portal_DB`.`walk_in_flag` (
  `FLAG_ID` INT NOT NULL AUTO_INCREMENT,
  `WALK_IN_ID` INT NOT NULL,
  `FLAG_DESC` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`FLAG_ID`),
  UNIQUE INDEX `WALK_IN_ID` (`WALK_IN_ID` ASC, `FLAG_DESC` ASC) VISIBLE,
  CONSTRAINT `walk_in_flag_ibfk_1`
    FOREIGN KEY (`WALK_IN_ID`)
    REFERENCES `walk_in_portal_DB`.`walk_in` (`WALK_IN_ID`));

ALTER TABLE walk_in_flag ADD COLUMN DT_CREATED DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE walk_in_flag ADD COLUMN DT_MODIFIED DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP; 

INSERT INTO `walk_in_portal_DB`.`walk_in_flag` (`WALK_IN_ID`, `FLAG_DESC`) VALUES
    (2, 'Internship Opportunity for MCA Students');


CREATE TABLE IF NOT EXISTS `walk_in_portal_db`.`walk_in_time_slot` (
  `TIME_SLOT_ID` INT NOT NULL AUTO_INCREMENT,
  `WALK_IN_ID` INT NOT NULL,
  `DATE` DATE NOT NULL,
  `SLOT_DESC` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`TIME_SLOT_ID`),
  UNIQUE `WALK_IN_ID_key` (`WALK_IN_ID`,`SLOT_DESC`),
  CONSTRAINT `time_slot_ibfk_1`
    FOREIGN KEY (`WALK_IN_ID`)
    REFERENCES `walk_in_portal_db`.`walk_in` (`WALK_IN_ID`));
  
INSERT INTO `walk_in_portal_db`.`walk_in_time_slot` (`WALK_IN_ID`, `DATE`, `SLOT_DESC`) VALUES
    (1, '2021-07-10', '9:00 AM TO 11:00 AM'),
    (1, '2021-07-10', '1:00 PM TO 3:00 PM'),  
    (2, '2021-07-10', '9:00 AM TO 11:00 AM'),
    (2, '2021-07-10', '1:00 PM TO 3:00 PM'),
	(3, '2021-07-10', '9:00 AM TO 11:00 AM'),
    (3, '2021-07-10', '1:00 PM TO 3:00 PM');
  
CREATE TABLE IF NOT EXISTS `walk_in_portal_DB`.`user_walk_in` (
`USER_WALK_IN_ID` INT PRIMARY KEY AUTO_INCREMENT,
  `USER_ID` INT NOT NULL,
  `WALK_IN_ID` INT NOT NULL,
  `TIME_SLOT_ID` INT NOT NULL,
  `UPDATED_RESUME_PATH` VARCHAR(100),
   UNIQUE `user_walk_in_key` (`USER_ID`, `WALK_IN_ID`, `TIME_SLOT_ID`),
  CONSTRAINT `user_walk_in_ibfk_1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `walk_in_portal_DB`.`users` (`USER_ID`),
  CONSTRAINT `user_walk_in_ibfk_2`
    FOREIGN KEY (`WALK_IN_ID`)
    REFERENCES `walk_in_portal_DB`.`walk_in` (`WALK_IN_ID`),
  CONSTRAINT `user_walk_in_ibfk_3`
    FOREIGN KEY (`TIME_SLOT_ID`)
    REFERENCES `walk_in_portal_DB`.`walk_in_time_slot` (`TIME_SLOT_ID`));
    

INSERT INTO `walk_in_portal_DB`.`user_walk_in` (
    `USER_ID`,
    `WALK_IN_ID`,
    `TIME_SLOT_ID`,
    `UPDATED_RESUME_PATH`
) 
VALUES (1,1,1,'/resumes/user1_resume.pdf'),
(2,1,2,'/resumes/user2_resume.docx'),
(3,2,3,'/resumes/user3_resume.pdf');


