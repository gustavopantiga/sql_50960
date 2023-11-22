DROP SCHEMA IF EXISTS dbgamer;
CREATE SCHEMA dbgamer;
USE dbgamer;

-- tables
-- Table: CLASS
CREATE TABLE class (
    id_level int NOT NULL,
    id_class int NOT NULL,
    description varchar(200) NOT NULL,
    CONSTRAINT PK_CLASS PRIMARY KEY (id_class,id_level)
);

-- Table: COMMENT
CREATE TABLE comment (
    id_game int NOT NULL,
    id_system_user int NOT NULL,
    first_date date NOT NULL,
    last_date date NULL,
    CONSTRAINT PK_COMMENT PRIMARY KEY (id_game,id_system_user)
);

-- Table: COMMENTARY
CREATE TABLE commentary (
    id_commentary int NOT NULL,
    id_game int NOT NULL,
    id_system_user int NOT NULL,
    comment_date date NOT NULL,
    commentary varchar(200) NOT NULL,
    CONSTRAINT PK_COMMENTARY PRIMARY KEY (id_commentary,id_game,id_system_user)
);

-- Table: GAME
CREATE TABLE game (
    id_game int NOT NULL,
    name varchar(100) NOT NULL,
    description varchar(300) NOT NULL,
    id_level int NOT NULL,
    id_class int NOT NULL,
    CONSTRAINT PK_GAME PRIMARY KEY (id_game)
);


-- Table: LEVEL_GAME
CREATE TABLE level_game (
    id_level int NOT NULL,
    description varchar(200) NOT NULL,
    CONSTRAINT PK_LEVEL_GAME PRIMARY KEY (id_level)
);

-- Table: PLAY
CREATE TABLE play (
    id_game int NOT NULL,
    id_system_user int NOT NULL,
    completed bool NOT NULL,
    CONSTRAINT PK_PLAY PRIMARY KEY (id_game,id_system_user)
);

-- Table: SUGGEST
CREATE TABLE suggest (
    id_suggest int NOT NULL,
    email varchar(30) NOT NULL,
    id_game int NOT NULL,
    id_system_user int NOT NULL,
    CONSTRAINT PK_SUGGEST PRIMARY KEY (id_suggest)
);

-- Table: SYSTEM_USER
CREATE TABLE system_user (
    id_system_user int NOT NULL,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    email varchar(30) NOT NULL,
    password varchar(30) NOT NULL,
    id_user_type int NOT NULL,
    CONSTRAINT PK_SYSTEM_USER PRIMARY KEY (id_system_user)
);

-- Table: USER_TYPE
CREATE TABLE user_type (
    id_user_type int NOT NULL,
    description varchar(200) NOT NULL,
    CONSTRAINT PK_USER_TYPE PRIMARY KEY (id_user_type)
);

-- Table: VOTE
CREATE TABLE vote (
    id_vote int NOT NULL,
    value int NOT NULL,
    id_game int NOT NULL,
    id_system_user int NOT NULL,
    UNIQUE INDEX AK_VOTE (id_game,id_system_user),
    CONSTRAINT PK_VOTE PRIMARY KEY (id_vote)
);

-- foreign keys
-- Reference: FK_CLASS_LEVEL_GAME (table: CLASS)
ALTER TABLE class ADD CONSTRAINT FK_CLASS_LEVEL_GAME FOREIGN KEY FK_CLASS_LEVEL_GAME (id_level)
    REFERENCES level_game (id_level);

-- Reference: FK_COMMENTARY_COMMENT (table: COMMENTARY)
ALTER TABLE commentary ADD CONSTRAINT FK_COMMENTARY_COMMENT FOREIGN KEY FK_COMMENTARY_COMMENT (id_game,id_system_user)
    REFERENCES comment (id_game,id_system_user);

-- Reference: FK_COMMENT_GAME (table: COMMENT)
ALTER TABLE comment ADD CONSTRAINT FK_COMMENT_GAME FOREIGN KEY FK_COMMENT_GAME (id_game)
    REFERENCES game (id_game);

-- Reference: FK_COMMENT_SYSTEM_USER (table: COMMENT)
ALTER TABLE comment ADD CONSTRAINT FK_COMMENT_SYSTEM_USER FOREIGN KEY FK_COMMENT_SYSTEM_USER (id_system_user)
    REFERENCES system_user (id_system_user);

-- Reference: FK_PLAY_GAME (table: PLAY)
ALTER TABLE play ADD CONSTRAINT FK_PLAY_GAME FOREIGN KEY FK_PLAY_GAME (id_game)
    REFERENCES game (id_game);

-- Reference: FK_PLAY_SYSTEM_USER (table: PLAY)
ALTER TABLE play ADD CONSTRAINT FK_PLAY_SYSTEM_USER FOREIGN KEY FK_PLAY_SYSTEM_USER (id_system_user)
    REFERENCES system_user (id_system_user);

-- Reference: FK_SUGGEST_PLAY (table: SUGGEST)
ALTER TABLE suggest ADD CONSTRAINT FK_SUGGEST_PLAY FOREIGN KEY FK_SUGGEST_PLAY (id_game,id_system_user)
    REFERENCES play (id_game,id_system_user);

-- Reference: FK_USER_USER_TYPE (table: USER)
ALTER TABLE system_user ADD CONSTRAINT FK_USER_USER_TYPE FOREIGN KEY FK_USER_USER_TYPE (id_user_type)
    REFERENCES user_type (id_user_type);

-- Reference: FK_VOTE_PLAY (table: VOTE)
ALTER TABLE vote ADD CONSTRAINT FK_VOTE_PLAY FOREIGN KEY FK_VOTE_PLAY (id_game,id_system_user)
    REFERENCES play (id_game,id_system_user);

-- Reference: GAME_CLASS (table: GAME)
ALTER TABLE game ADD CONSTRAINT GAME_CLASS FOREIGN KEY GAME_CLASS (id_class,id_level)
    REFERENCES class (id_class, id_level);

-- End of file.
