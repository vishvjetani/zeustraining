SELECT DATABASE();
USE WALK_IN_PORTAL_DB;

-- Login query to validate users credentials
SELECT USER_ID,EMAIL FROM USERS WHERE EMAIL="john.doe@email.com" and PASSWORD_HASH="hashed_password_1";

-- Registration query to add users data to the required tables
INSERT INTO USERS (PROFILE_PICTURE_PATH, FIRST_NAME, LAST_NAME, EMAIL, MOBILE_NO, RESUME_PATH, PORTFOLIO_URL, REFFERAL, UPDATES_VIA_MAIL, PASSWORD_HASH) VALUES
('/profiles/profile1.jpg', 'John', 'Doe', 'john.doe@email.com', '1234567890', '/resumes/john_doe_resume.pdf', 'https://john.doe/portfolio', 'REF123', '1', 'hashed_password_1');

SELECT USER_ID FROM USERS WHERE EMAIL="john.doe@email.com";

INSERT INTO user_education_qualifications (USER_ID,AGGREGATE_PERCENTAGE,PASSING_YEAR,QUALIFICATION,STREAM_NAME,COLLEGE,COLLEGE_LOCATION
) VALUES (1, 85, 2022, 'Bachelor of Science', 'Computer Science', 'XYZ College', 'CityA');

INSERT INTO USER_JOB_ROLES(USER_ID,ROLE_ID) VALUES (1,1);
INSERT INTO USER_JOB_ROLES(USER_ID,ROLE_ID) VALUES (1,2);
INSERT INTO user_professional_qualifications(USER_ID,APPLICANT_TYPE,EXPERIENCE,CURRENT_CTC,EXPECTED_CTC,NOTICE_PERIOD,NOTICE_PERIOD_END,NOTICE_PERIOD_DURATION,APPEARED_FOR_TEST,
OTHER_TECHNOLGOIES,APPLIED_PAST_ROLE) VALUES (1, 'Experienced', 5, 80000, 100000, '1', '2023-02-28', 30, '1', 'Java, Python', 'Software Engineer');

INSERT INTO USER_TECHNOLOGIES (USER_ID,TECHNOLOGY_ID,EXPERIENCE) VALUES (1,1,'EXPERT');

-- Query to get the data for walk-in listing page
SELECT W.WALK_IN_ID,WALK_IN_TITLE,WALK_IN_START_DATE,WALK_IN_END_DATE,WALK_IN_LOCATION,EXPIRED_DATE,FLAG_DESC 
FROM WALK_IN W LEFT OUTER JOIN WALK_IN_FLAG WIF ON WIF.WALK_IN_ID=W.WALK_IN_ID;

SELECT W.WALK_IN_ID,WALK_IN_TITLE,ROLE_NAME 
FROM WALK_IN_JOB_ROLES WJR INNER JOIN WALK_IN W ON WJR.WALK_IN_ID = W.WALK_IN_ID INNER JOIN JOB_ROLES J ON J.ROLE_ID=WJR.ROLE_ID; 

SELECT W.WALK_IN_ID,WALK_IN_TITLE,GROUP_CONCAT(J.ROLE_NAME) AS ROLE_NAMES FROM
WALK_IN_JOB_ROLES WJR INNER JOIN WALK_IN W ON WJR.WALK_IN_ID = W.WALK_IN_ID
INNER JOIN JOB_ROLES J ON J.ROLE_ID = WJR.ROLE_ID
GROUP BY W.WALK_IN_ID,W.WALK_IN_TITLE;

-- Get the data for individual walk-in page
SELECT WALK_IN_ID,GENERAL_INSTRUCTIONS,EXAM_INSTRUCTIONS,MIN_SYSTEM_REQUIREMENT,PROCESS_FLOW FROM WALK_IN_INSTRUCTIONS WHERE WALK_IN_ID=1;

SELECT WALK_IN_ID,ROLE_NAME,GROSS_COMPENSATION,ROLE_DESCRIPTION,REQUIREMENTS FROM WALK_IN_JOB_ROLES WJR
INNER JOIN JOB_ROLES J ON J.ROLE_ID=WJR.ROLE_ID 
WHERE WALK_IN_ID=2;

SELECT WALK_IN_ID,DATE,TIME_SLOT_ID,SLOT_DESC FROM WALK_IN_TIME_SLOT  WHERE WALK_IN_ID=2;

-- Query to register for a walk-in
INSERT INTO USER_WALK_IN(USER_ID,WALK_IN_ID,TIME_SLOT_ID) VALUES (1,1,1);
INSERT INTO USER_WALK_IN_JOB_ROLES(USER_ID,WALK_IN_ID,ROLE_ID) VALUES(1,1,2);

-- Query to get the walk-in hall tickets
SELECT USER_ID,W.WALK_IN_ID,UW.TIME_SLOT_ID,DATE,SLOT_DESC,VENUE,THINGS_TO_REMEMBER FROM WALK_IN_TIME_SLOT W 
INNER JOIN USER_WALK_IN UW ON W.WALK_IN_ID=UW.WALK_IN_ID 
AND W.TIME_SLOT_ID=UW.TIME_SLOT_ID
INNER JOIN WALK_IN_INSTRUCTIONS WII ON WII.WALK_IN_ID=UW.WALK_IN_ID
WHERE USER_ID=2
;

