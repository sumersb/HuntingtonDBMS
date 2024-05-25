DROP DATABASE IF EXISTS scenescense;
CREATE DATABASE scenescense;

USE scenescense;

DROP TABLE IF EXISTS PLAYS;
CREATE TABLE plays(
	play_id INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100) NOT NULL,
    AUTHOR VARCHAR(100) DEFAULT NULL
);

DROP TABLE IF EXISTS productions;
CREATE TABLE productions(
	production_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    production_description TEXT,
    billboard_img BLOB,
    premier_date DATE,
    play_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY (play_id) REFERENCES plays(play_id) 
);

DROP TABLE IF EXISTS rehearsals;
CREATE TABLE rehearsals (
	rehearsal_id INT PRIMARY KEY AUTO_INCREMENT,
    rehearsal_day DATE,
    start_time TIME,
    end_time TIME,
    production_id INT,
    CONSTRAINT FOREIGN KEY (production_id) REFERENCES productions(production_id)
);

DROP TABLE IF EXISTS actors;
CREATE TABLE actors (
	actor_id INT PRIMARY KEY AUTO_INCREMENT,
    name varchar(100),
    email varchar(100),
    cell varchar(15)
);

DROP TABLE IF EXISTS scenes;
CREATE TABLE scenes(
	scene_id INT PRIMARY KEY AUTO_INCREMENT,
    title varchar(100),
    seq_no varchar(50),
    play_id INT,
    CONSTRAINT FOREIGN KEY (play_id) REFERENCES plays(play_id)
);

DROP TABLE IF EXISTS characters;
CREATE TABLE characters(
	character_id INT PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    char_description text,
    play_id INT,
    CONSTRAINT FOREIGN KEY (play_id) REFERENCES plays(play_id)
);

DROP TABLE IF EXISTS rehearsal_scene_join;
CREATE TABLE rehearsal_scene_join(
	duration TIME,
	rehearsal_id INT,
    CONSTRAINT FOREIGN KEY (rehearsal_id) REFERENCES rehearsals(rehearsal_id),
    scene_id INT,
    CONSTRAINT FOREIGN KEY (scene_id) REFERENCES scenes(scene_id)
);

DROP TABLE IF EXISTS scene_character_join;
CREATE TABLE scene_character_join(
	scene_id INT,
    CONSTRAINT FOREIGN KEY (scene_id) REFERENCES scenes(scene_id),
    character_id INT,
    CONSTRAINT FOREIGN KEY (character_id) REFERENCES characters(character_id)
);

DROP TABLE IF EXISTS actor_character_production_join;
CREATE TABLE actor_character_production_join(
	actor_id INT,
    CONSTRAINT FOREIGN KEY (actor_id) REFERENCES actors(actor_id),
	character_id INT,
    CONSTRAINT FOREIGN KEY (character_id) REFERENCES characters(character_id),
	production_id INT,
    CONSTRAINT FOREIGN KEY (production_id) REFERENCES productions(production_id)
);   

INSERT INTO plays (title) VALUES
("Julius Caesar"),
("Rosencrants and Guildenstern are Dead");

SELECT * FROM plays;

INSERT INTO productions (name, play_id) VALUES
("Julius Caesar", 1),
("Rosencrants and Guildenstern are Dead", 1);

SELECT * FROM productions;

INSERT INTO characters (name, play_id)
VALUES
	("Caesar", 1),
    ("Brutus", 1),
    ("Cassius", 1),
    ("Antony", 1),
    ("Portia", 1);

SELECT * FROM characters;

INSERT INTO actors (name)
VALUES 
	("Peter O'Toole"),
	("Will Smith"),
	("Brad Pitt"),
	("Russell Crowe"),
	("Portia"),
    ("Scarlett Johansson");
    
SELECT * FROM actors;

INSERT INTO actor_character_production_join VALUES
	(1, 1, 1),
    (2, 2, 1),
    (3, 3, 1),
    (4, 4, 1),
    (5, 5, 1);

SELECT actors.name AS "Actor Name", characters.name AS "Character Name", productions.name AS "Production Title"
FROM actor_character_production_join
JOIN actors ON actor_character_production_join.actor_id = actors.actor_id
JOIN characters ON actor_character_production_join.character_id = characters.character_id
JOIN productions ON actor_character_production_join.production_id = productions.production_id;

INSERT INTO scenes (title, play_id) VALUES
	("Act 3 Scene 1", 1),
    ("Act 3 Scene 2", 1);
    
SELECT * FROM scenes;

INSERT INTO scene_character_join
VALUES
	(1, 1),
    (1, 2),
    (1, 3),
    (1, 5),
    (2, 2),
    (2, 3),
    (2, 4);

SELECT scenes.title AS Title, scenes.seq_No AS Sequence, characters.name AS "Character Name"
FROM scene_character_join
JOIN scenes ON scene_character_join.scene_id = scenes.scene_id
JOIN characters ON scene_character_join.character_id = characters.character_id;

    
INSERT INTO rehearsals (rehearsal_day, start_time, end_time, production_id) 
VALUES 
	("2025-03-15", "140000", "180000", 1),
    ("2025-03-16", "140000", "180000", 1),
    ("2025-03-17", "140000", "180000", 1);

SELECT * FROM rehearsals;

-- CREATE TABLE rehearsal_scene_join(
-- 	duration TIME,
-- 	rehearsal_id INT,
--     CONSTRAINT FOREIGN KEY (rehearsal_id) REFERENCES rehearsals(rehearsal_id),
--     scene_id INT,
--     CONSTRAINT FOREIGN KEY (scene_id) REFERENCES scenes(scene_id)
-- );

INSERT INTO rehearsal_scene_join VALUES
(20000, 1, 1),
(20000, 1, 2),
(40000, 2, 2),
(10000, 3, 1),
(30000, 3, 2);

SELECT duration, rehearsals.rehearsal_day, scenes.title
FROM rehearsal_scene_join
JOIN rehearsals ON rehearsal_scene_join.rehearsal_id = rehearsals.rehearsal_id
JOIN scenes ON rehearsal_scene_join.scene_id = scenes.scene_id
ORDER BY rehearsals.rehearsal_day;