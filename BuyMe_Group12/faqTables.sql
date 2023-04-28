USE dbproject_buyme;

CREATE TABLE QUESTIONS (
  questionID INT PRIMARY KEY AUTO_INCREMENT,
  userID INT NOT NULL,
  questionText TEXT NOT NULL,
  answered BOOLEAN NOT NULL DEFAULT false,
  createdAt DATETIME NOT NULL,
  FOREIGN KEY (userID) REFERENCES end_user(userID)
);

CREATE TABLE ANSWERS (
  answerID INT PRIMARY KEY AUTO_INCREMENT,
  questionID INT NOT NULL,
  customerRepID INT NOT NULL,
  answerText TEXT NOT NULL,
  createdAt DATETIME NOT NULL,
  FOREIGN KEY (questionID) REFERENCES questions(questionID),
  FOREIGN KEY (customerRepID) REFERENCES end_user(userID)
);