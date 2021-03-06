DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS organizer;
DROP TABLE IF EXISTS option;
DROP TABLE IF EXISTS question;
DROP TABLE IF EXISTS quizz;
DROP TABLE IF EXISTS company;
DROP TABLE IF EXISTS extra_info;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS conference;
DROP TABLE IF EXISTS evaluation;
DROP TABLE IF EXISTS user_quizz;

CREATE TABLE account (
    accountid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR UNIQUE,
    password VARCHAR,
    name VARCHAR,
    phone INT,
    email VARCHAR,
);

CREATE TABLE organizer (
    organizerid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    accountid VARCHAR REFERENCES account,
);

CREATE TABLE company (
    companyid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    locationtext VARCHAR,
    locationimage VARBINARY,
    accountid VARCHAR REFERENCES account,
);

CREATE TABLE user (
    userid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    accountid VARCHAR REFERENCES account,
);

CREATE TABLE extra_info (  
    infoid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    infoType VARCHAR,
    infoContent VARCHAR,
    userid VARCHAR REFERENCES user,
);

CREATE TABLE quizz (
    quizzid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR,
    code VARCHAR NOT NULL UNIQUE,
    qrcode VARCHAR NOT NULL UNIQUE,
    companyid VARCHAR REFERENCES company,
);

CREATE TABLE question (
    questionid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    text VARCHAR,
);

CREATE TABLE option (
    optionid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    text VARCHAR,
    isAnswer BOOLEAN,
    questionid VARCHAR REFERENCES question,
);

CREATE TABLE conference (
    conferenceid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR,
    qrcode BOOLEAN,
);

CREATE TABLE evaluation (
    evaluationid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    rate int,
    comment VARCHAR,
    userid REFERENCES user,
    quizzid REFERENCES quizz
);

CREATE TABLE user_quizz (
    user_quizzid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    rate int,
    comment VARCHAR,
    userid REFERENCES user,
    quizzid REFERENCES quizz
);