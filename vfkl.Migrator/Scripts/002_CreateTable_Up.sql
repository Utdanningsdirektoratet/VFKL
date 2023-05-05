-- we will organize our tables under 3 different schemas based on the altinn application. Userprofile is common to both the application


CREATE TABLE public.migratetest(
    language_id integer NOT NULL PRIMARY KEY,
    language_code VARCHAR NOT NULL,
    language_title varchar NOT NULL
    );
	
INSERT INTO public.migratetest(language_id, language_code, language_title)
VALUES(1044, 'nb-NO', 'Bokmål'),
      (2068,'nn-NO', 'Nynorsk'),
      (1083,'se-NO','Nordsamisk'),
	  (4155,'se-NO','Lulesamisk'),
	  (6203,'se-NO','Sørsamisk');
