--<ScriptOptions statementTerminator=";"/>

CREATE TABLE users (
		userid VARCHAR(255) NOT NULL,
		dob TIMESTAMP,
		email VARCHAR(255),
		firstname VARCHAR(255),
		lastname VARCHAR(255),
		phonenumber INT8 NOT NULL
	);

CREATE UNIQUE INDEX users_pkey ON users (userid ASC);

ALTER TABLE users ADD CONSTRAINT users_pkey PRIMARY KEY (userid);

