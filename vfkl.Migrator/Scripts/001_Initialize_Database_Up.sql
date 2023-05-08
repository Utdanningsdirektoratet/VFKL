

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE SCHEMA assessment;
ALTER SCHEMA assessment OWNER TO vfkladmin;

CREATE SCHEMA invitations;
ALTER SCHEMA invitations OWNER TO vfkladmin;

ALTER SCHEMA public OWNER TO azure_pg_admin;

CREATE SCHEMA userprofile;
ALTER SCHEMA userprofile OWNER TO vfkladmin;

CREATE PROCEDURE assessment.insert_answers(assessmentid integer, questionid integer, answertypeid integer, reason character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NOT EXISTS(SELECT * FROM assessment.answers where assessment_id_fk =assessmentid and question_id_fk = questionid) THEN
		INSERT INTO assessment.answers (assessment_id_fk, question_id_fk,answertype_id_fk,reason) VALUES (assessmentid, questionid,answertypeid,reason);
	END IF;
END
$$;
ALTER PROCEDURE assessment.insert_answers(assessmentid integer, questionid integer, answertypeid integer, reason character varying) OWNER TO vfkladmin;

CREATE PROCEDURE assessment.insert_assessment(userid integer, teachingaid character varying, instanceid character varying, groupassessmentid character varying, createddatetime timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NOT EXISTS(SELECT * FROM assessment.assessment where instance_id = instanceid) THEN
		INSERT INTO assessment.assessment (user_id_fk, teachingaid,instance_id, groupassessment_id_fk, created_datetime) VALUES (userid, teachingaid,instanceid,groupassessmentid, createddatetime);
	END IF;
END
$$;
ALTER PROCEDURE assessment.insert_assessment(userid integer, teachingaid character varying, instanceid character varying, groupassessmentid character varying, createddatetime timestamp without time zone) OWNER TO vfkladmin;

CREATE PROCEDURE assessment.insert_assessment(userid integer, teachingaid character varying, instanceid character varying, groupassessmentid character varying, createddatetime timestamp without time zone, usercomments character varying, teachingaidsupplier character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NOT EXISTS(SELECT * FROM assessment.assessment where instance_id = instanceid) THEN
INSERT INTO assessment.assessment (user_id_fk, teachingaid,instance_id, groupassessment_id_fk, created_datetime, user_comments, teachingaid_supplier) VALUES (userid, teachingaid,instanceid,groupassessmentid, createddatetime, usercomments, teachingaidsupplier);
END IF;
END
$$;
ALTER PROCEDURE assessment.insert_assessment(userid integer, teachingaid character varying, instanceid character varying, groupassessmentid character varying, createddatetime timestamp without time zone, usercomments character varying, teachingaidsupplier character varying) OWNER TO vfkladmin;

CREATE PROCEDURE invitations.insert_invitation(userid integer, gvid character varying, frist character varying, laeremiddel character varying, laereplan character varying, mottakereposter character varying, opprettetdato character varying, assessmenttypeid integer, laereplankode character varying, bortvalgtsporsmaal character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NOT EXISTS(SELECT * FROM invitations.invitations where gv_id = gvid) THEN
		INSERT INTO invitations.invitations (user_id_fk, gv_id, frist, laeremiddel, laereplan, mottaker_eposter, opprettet_dato,assessmenttype_id_fk,laereplankode,bortvalgtsporsmaal) 
		VALUES (userid, gvid, frist, laeremiddel, laereplan, mottakereposter,opprettetdato,assessmenttypeid,laereplankode,bortvalgtsporsmaal);
	END IF;
END
$$;
ALTER PROCEDURE invitations.insert_invitation(userid integer, gvid character varying, frist character varying, laeremiddel character varying, laereplan character varying, mottakereposter character varying, opprettetdato character varying, assessmenttypeid integer, laereplankode character varying, bortvalgtsporsmaal character varying) OWNER TO vfkladmin;

CREATE PROCEDURE invitations.insert_invitation(userid integer, gvid character varying, frist character varying, laeremiddel character varying, laereplan character varying, mottakereposter character varying, opprettetdato character varying, assessmenttypeid integer, laereplankode character varying, bortvalgtsporsmaal character varying, laeremiddelleverandor character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NOT EXISTS(SELECT * FROM invitations.invitations where gv_id = gvid) THEN
INSERT INTO invitations.invitations (user_id_fk, gv_id, frist, laeremiddel, laereplan, mottaker_eposter, opprettet_dato,assessmenttype_id_fk,laereplankode,bortvalgtsporsmaal, laeremiddel_leverandor)
VALUES (userid, gvid, frist, laeremiddel, laereplan, mottakereposter,opprettetdato,assessmenttypeid,laereplankode,bortvalgtsporsmaal, laeremiddelleverandor);
END IF;
END
$$;
ALTER PROCEDURE invitations.insert_invitation(userid integer, gvid character varying, frist character varying, laeremiddel character varying, laereplan character varying, mottakereposter character varying, opprettetdato character varying, assessmenttypeid integer, laereplankode character varying, bortvalgtsporsmaal character varying, laeremiddelleverandor character varying) OWNER TO vfkladmin;

CREATE PROCEDURE userprofile.insert_user(feideid character varying, username character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NOT EXISTS(SELECT * FROM userprofile.userprofile where feide_id =feideid) THEN
		INSERT INTO userprofile.userprofile (feide_id, name) VALUES (feideid,username);
	END IF;
END
$$;
ALTER PROCEDURE userprofile.insert_user(feideid character varying, username character varying) OWNER TO vfkladmin;
SET default_tablespace = '';
SET default_table_access_method = heap;

CREATE TABLE assessment.answers (
    id integer NOT NULL,
    assessment_id_fk integer NOT NULL,
    question_id_fk integer NOT NULL,
    answertype_id_fk integer NOT NULL,
    reason character varying
);
ALTER TABLE assessment.answers OWNER TO vfkladmin;

CREATE SEQUENCE assessment.answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE assessment.answers_id_seq OWNER TO vfkladmin;

ALTER SEQUENCE assessment.answers_id_seq OWNED BY assessment.answers.id;

CREATE TABLE assessment.answertype (
    answertype_id integer NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL
);
ALTER TABLE assessment.answertype OWNER TO vfkladmin;

CREATE SEQUENCE assessment.answertype_answertype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE assessment.answertype_answertype_id_seq OWNER TO vfkladmin;

ALTER SEQUENCE assessment.answertype_answertype_id_seq OWNED BY assessment.answertype.answertype_id;

CREATE TABLE assessment.answertypetextresources (
    id integer NOT NULL,
    answertype_id_fk integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    language_id_fk integer NOT NULL
);
ALTER TABLE assessment.answertypetextresources OWNER TO vfkladmin;

CREATE SEQUENCE assessment.answertypetextresources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE assessment.answertypetextresources_id_seq OWNER TO vfkladmin;

ALTER SEQUENCE assessment.answertypetextresources_id_seq OWNED BY assessment.answertypetextresources.id;

CREATE TABLE assessment.assessment (
    assessment_id integer NOT NULL,
    user_id_fk integer NOT NULL,
    teachingaid character varying(1000) NOT NULL,
    instance_id character varying NOT NULL,
    groupassessment_id_fk character varying,
    created_datetime timestamp without time zone,
    user_comments character varying,
    teachingaid_supplier character varying
);
ALTER TABLE assessment.assessment OWNER TO vfkladmin;

CREATE SEQUENCE assessment.assessment_assessment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE assessment.assessment_assessment_id_seq OWNER TO vfkladmin;

ALTER SEQUENCE assessment.assessment_assessment_id_seq OWNED BY assessment.assessment.assessment_id;

CREATE TABLE assessment.category (
    category_id integer NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL
);
ALTER TABLE assessment.category OWNER TO vfkladmin;

CREATE SEQUENCE assessment.category_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE assessment.category_category_id_seq OWNER TO vfkladmin;

ALTER SEQUENCE assessment.category_category_id_seq OWNED BY assessment.category.category_id;

CREATE TABLE assessment.categorytextresources (
    id integer NOT NULL,
    category_id_fk integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    language_id_fk integer NOT NULL
);
ALTER TABLE assessment.categorytextresources OWNER TO vfkladmin;

CREATE SEQUENCE assessment.categorytextresources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE assessment.categorytextresources_id_seq OWNER TO vfkladmin;

ALTER SEQUENCE assessment.categorytextresources_id_seq OWNED BY assessment.categorytextresources.id;

CREATE TABLE assessment.question (
    question_id integer NOT NULL,
    question character varying NOT NULL,
    question_id_inform character varying(4) NOT NULL,
    category_id_fk integer NOT NULL,
    assessmenttype_id_fk integer NOT NULL
);
ALTER TABLE assessment.question OWNER TO vfkladmin;

CREATE TABLE assessment.questiontextresources (
    text_id integer NOT NULL,
    question_id_fk integer NOT NULL,
    question character varying NOT NULL,
    language_id_fk integer NOT NULL
);
ALTER TABLE assessment.questiontextresources OWNER TO vfkladmin;

CREATE SEQUENCE assessment.questiontextresources_text_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE assessment.questiontextresources_text_id_seq OWNER TO vfkladmin;

ALTER SEQUENCE assessment.questiontextresources_text_id_seq OWNED BY assessment.questiontextresources.text_id;

CREATE TABLE invitations.invitations (
    user_id_fk integer NOT NULL,
    gv_id character varying NOT NULL,
    frist character varying,
    laeremiddel character varying,
    laereplan character varying,
    mottaker_eposter character varying,
    opprettet_dato character varying,
    assessmenttype_id_fk integer,
    laereplankode character varying,
    bortvalgtsporsmaal character varying,
    laeremiddel_leverandor character varying
);
ALTER TABLE invitations.invitations OWNER TO vfkladmin;

CREATE TABLE public.assessmenttype (
    assessmenttype_id integer NOT NULL,
    name character varying,
    description character varying
);
ALTER TABLE public.assessmenttype OWNER TO vfkladmin;

CREATE SEQUENCE public.assessmenttype_assessmenttype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.assessmenttype_assessmenttype_id_seq OWNER TO vfkladmin;

ALTER SEQUENCE public.assessmenttype_assessmenttype_id_seq OWNED BY public.assessmenttype.assessmenttype_id;

CREATE TABLE public.languagetype (
    language_id integer NOT NULL,
    language_code character varying NOT NULL,
    language_title character varying NOT NULL
);
ALTER TABLE public.languagetype OWNER TO vfkladmin;

CREATE TABLE userprofile.userprofile (
    user_id integer NOT NULL,
    feide_id character varying,
    personnummer integer,
    name character varying
);
ALTER TABLE userprofile.userprofile OWNER TO vfkladmin;

CREATE SEQUENCE userprofile.userprofile_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE userprofile.userprofile_user_id_seq OWNER TO vfkladmin;

ALTER SEQUENCE userprofile.userprofile_user_id_seq OWNED BY userprofile.userprofile.user_id;

ALTER TABLE ONLY assessment.answers ALTER COLUMN id SET DEFAULT nextval('assessment.answers_id_seq'::regclass);

ALTER TABLE ONLY assessment.answertype ALTER COLUMN answertype_id SET DEFAULT nextval('assessment.answertype_answertype_id_seq'::regclass);

ALTER TABLE ONLY assessment.answertypetextresources ALTER COLUMN id SET DEFAULT nextval('assessment.answertypetextresources_id_seq'::regclass);

ALTER TABLE ONLY assessment.assessment ALTER COLUMN assessment_id SET DEFAULT nextval('assessment.assessment_assessment_id_seq'::regclass);

ALTER TABLE ONLY assessment.category ALTER COLUMN category_id SET DEFAULT nextval('assessment.category_category_id_seq'::regclass);

ALTER TABLE ONLY assessment.categorytextresources ALTER COLUMN id SET DEFAULT nextval('assessment.categorytextresources_id_seq'::regclass);

ALTER TABLE ONLY assessment.questiontextresources ALTER COLUMN text_id SET DEFAULT nextval('assessment.questiontextresources_text_id_seq'::regclass);

ALTER TABLE ONLY public.assessmenttype ALTER COLUMN assessmenttype_id SET DEFAULT nextval('public.assessmenttype_assessmenttype_id_seq'::regclass);

ALTER TABLE ONLY userprofile.userprofile ALTER COLUMN user_id SET DEFAULT nextval('userprofile.userprofile_user_id_seq'::regclass);



INSERT INTO assessment.answertype VALUES (1, 'heltenig', 'Helt enig');
INSERT INTO assessment.answertype VALUES (2, 'delvisenig', 'Delvis enig');
INSERT INTO assessment.answertype VALUES (3, 'delvisuenig', 'Delvis uenig');
INSERT INTO assessment.answertype VALUES (4, 'heltuenig', 'Helt uenig');
INSERT INTO assessment.answertype VALUES (5, 'ikkeaktuelt', 'ønsker ikke å svare/ikke aktuelt');

INSERT INTO assessment.answertypetextresources VALUES (6, 1, 'heltenig', 'Heilt enig', 2068);
INSERT INTO assessment.answertypetextresources VALUES (7, 2, 'delvisenig', 'Delvis enig', 2068);
INSERT INTO assessment.answertypetextresources VALUES (8, 3, 'delvisuenig', 'Delvis uenig', 2068);
INSERT INTO assessment.answertypetextresources VALUES (9, 4, 'heltuenig', 'Heilt uenig', 2068);
INSERT INTO assessment.answertypetextresources VALUES (10, 5, 'ikkeaktuelt', 'Ønsker ikkje å svara/Ikkje aktuelt', 2068);
INSERT INTO assessment.answertypetextresources VALUES (1, 1, 'heltenig', 'Áibbas ovttaoaivilis', 1083);
INSERT INTO assessment.answertypetextresources VALUES (2, 2, 'delvisenig', 'Belohahkii ovttaoaivilis', 1083);
INSERT INTO assessment.answertypetextresources VALUES (3, 3, 'delvisuenig', 'Belohahkii sierramielalaš', 1083);
INSERT INTO assessment.answertypetextresources VALUES (4, 4, 'heltuenig', 'Áibbas sierramielalaš', 1083);
INSERT INTO assessment.answertypetextresources VALUES (5, 5, 'ikkeaktuelt', 'In hálit vástidit / ii áigeguovdil', 1083);
INSERT INTO assessment.answertypetextresources VALUES (11, 1, 'heltenig', 'Eevre sïemes', 6203);
INSERT INTO assessment.answertypetextresources VALUES (12, 2, 'delvisenig', 'Såemiesmearan sïemes', 6203);
INSERT INTO assessment.answertypetextresources VALUES (13, 3, 'delvisuenig', 'Såemiesmearan ov-sïemes', 6203);
INSERT INTO assessment.answertypetextresources VALUES (14, 4, 'heltuenig', 'Eevre ov-sïemes', 6203);
INSERT INTO assessment.answertypetextresources VALUES (15, 5, 'ikkeaktuelt', 'Im sïjhth vaestiedidh/Ij sjyöhtehke', 6203);
INSERT INTO assessment.answertypetextresources VALUES (16, 1, 'heltenig', 'Guorrasav ållu', 4155);
INSERT INTO assessment.answertypetextresources VALUES (17, 2, 'delvisenig', 'Guorrasav muhtem mudduj', 4155);
INSERT INTO assessment.answertypetextresources VALUES (18, 3, 'delvisuenig', 'Iv ållu guorrasa', 4155);
INSERT INTO assessment.answertypetextresources VALUES (19, 4, 'heltuenig', 'Iv åvvånis guorrasa', 4155);
INSERT INTO assessment.answertypetextresources VALUES (21, 1, 'heltenig', 'Helt enig', 1044);
INSERT INTO assessment.answertypetextresources VALUES (22, 2, 'delvisenig', 'Delvis enig', 1044);
INSERT INTO assessment.answertypetextresources VALUES (23, 3, 'delvisuenig', 'Delvis uenig', 1044);
INSERT INTO assessment.answertypetextresources VALUES (24, 4, 'heltuenig', 'Helt uenig', 1044);
INSERT INTO assessment.answertypetextresources VALUES (25, 5, 'ikkeaktuelt', 'ønsker ikke å svare/ikke aktuelt', 1044);
INSERT INTO assessment.answertypetextresources VALUES (20, 5, 'ikkeaktuelt', 'Iv sidá vásstedit / ij la ájggeguovddelis', 4155);



INSERT INTO assessment.category VALUES (1, 'design', 'design/utforming');
INSERT INTO assessment.category VALUES (2, 'pedagogisk', 'Pedagogisk og didaktisk kvalitet');
INSERT INTO assessment.category VALUES (3, 'læreplanverk', 'Bruk av læreplanverket');
INSERT INTO assessment.category VALUES (4, 'føringer', 'Føringer fra læreplanverket');
INSERT INTO assessment.category VALUES (5, 'kvalitet', 'Utforming og tekstlig kvalitet');
INSERT INTO assessment.category VALUES (6, 'kobling', 'Kobling til læreplanverket');

INSERT INTO assessment.categorytextresources VALUES (1, 1, 'design', 'Design/hábmen', 1083);
INSERT INTO assessment.categorytextresources VALUES (2, 2, 'pedagogalaš', 'Pedagogalaš ja didaktihkalaškvalitehta', 1083);
INSERT INTO assessment.categorytextresources VALUES (3, 3, 'oahppoplánabuktos', 'Oahppoplánabuktos a geavaheapmi', 1083);
INSERT INTO assessment.categorytextresources VALUES (4, 1, 'design', 'Design/utforming', 2068);
INSERT INTO assessment.categorytextresources VALUES (5, 2, 'pedagogisk', 'Pedagogisk og didaktisk kvalitet', 2068);
INSERT INTO assessment.categorytextresources VALUES (6, 3, 'læreplanverk', 'Bruk av læreplanverket', 2068);
INSERT INTO assessment.categorytextresources VALUES (7, 4, 'føringer', 'Føringar frå læreplanverket', 2068);
INSERT INTO assessment.categorytextresources VALUES (8, 5, 'kvalitet', 'Utforming og tekstleg kvalitet', 2068);
INSERT INTO assessment.categorytextresources VALUES (9, 6, 'kopling', 'Kopling til læreplanverket', 2068);
INSERT INTO assessment.categorytextresources VALUES (10, 1, 'hammoe', 'Hammoe/hammoedimmie', 6203);
INSERT INTO assessment.categorytextresources VALUES (11, 2, 'pedagogisk', 'Pedagogeles jïh didaktihkeles kvaliteete', 6203);
INSERT INTO assessment.categorytextresources VALUES (12, 3, 'learoesoejkesje', 'Åtnoe learoesoejkesje-vierhkeste', 6203);
INSERT INTO assessment.categorytextresources VALUES (13, 1, 'design', 'Design/hábbmim', 4155);
INSERT INTO assessment.categorytextresources VALUES (14, 2, 'pedagåvgålasj', 'Pedagåvgålasj ja didaktalasj kvalitiehtta', 4155);
INSERT INTO assessment.categorytextresources VALUES (15, 3, 'oahppoplánajt', 'Gåktu oahppoplánajt adnet', 4155);

INSERT INTO assessment.question VALUES (1, 'Jeg ønsker ikke å svare på denne kategorien', '0', 1, 1);
INSERT INTO assessment.question VALUES (2, 'Jeg ønsker ikke å svare på denne kategorien', '0', 2, 1);
INSERT INTO assessment.question VALUES (3, 'Jeg ønsker ikke å svare på denne kategorien', '0', 3, 1);
INSERT INTO assessment.question VALUES (4, 'Læremiddelet oppleves som engasjerende for elevene i målgruppen', '1.1', 1, 1);
INSERT INTO assessment.question VALUES (5, 'Læremiddelet er oversiktlig og intuitivt å bruke for elever og lærere', '1.2', 1, 1);
INSERT INTO assessment.question VALUES (6, 'Læremiddelet bruker et språk som er tilpasset fagets terminologi og elevene i målgruppen', '1.3', 1, 1);
INSERT INTO assessment.question VALUES (7, 'Læremiddelet har multimodalitet som sammen støtter læring', '1.4', 1, 1);
INSERT INTO assessment.question VALUES (8, 'Læremiddelet støtter lærerens arbeid med tilpasset opplæring', '2.1', 2, 1);
INSERT INTO assessment.question VALUES (9, 'Læremiddelet har rikt og variert innhold', '2.2', 2, 1);
INSERT INTO assessment.question VALUES (10, 'Læremiddelet legger til rette for at elevene skal lære å lære', '2.3', 2, 1);
INSERT INTO assessment.question VALUES (11, 'Læremiddelet støtter elevene i å utvikle kritisk tenkning og etisk bevissthet', '2.4', 2, 1);
INSERT INTO assessment.question VALUES (12, 'Læremiddelet inviterer elevene til utforsking i læringsarbeidet', '2.5', 2, 1);
INSERT INTO assessment.question VALUES (13, 'Læremiddelet legger til rette for samhandling i eller utenfor læremiddelet', '2.6', 2, 1);
INSERT INTO assessment.question VALUES (14, 'Læremiddelet fremmer inkludering og mangfold', '3.1', 3, 1);
INSERT INTO assessment.question VALUES (15, 'Læremiddelet bidrar til at elevene får innsikt i det samiske urfolkets historie, kultur, språk, samfunnsliv og rettigheter', '3.2', 3, 1);
INSERT INTO assessment.question VALUES (16, 'Læremiddelet ivaretar fagets relevans og sentrale verdier', '3.3', 3, 1);
INSERT INTO assessment.question VALUES (17, 'Læremiddelet gir mulighet til å arbeide med kjerneelementene i faget', '3.4', 3, 1);
INSERT INTO assessment.question VALUES (18, 'Læremiddelet legger til rette for å se sammenhenger i opplæringen', '3.5', 3, 1);
INSERT INTO assessment.question VALUES (19, 'Læremiddelet legger til rette for at elevene får utvikle og bruke grunnleggende ferdigheter i faget', '3.6', 3, 1);
INSERT INTO assessment.question VALUES (20, 'Læremiddelet har god progresjon i tråd med kompetansemålene i faget', '3.7', 3, 1);
INSERT INTO assessment.question VALUES (21, 'Læremiddelet støtter elevenes og lærerens arbeid med underveisvurdering', '3.8', 3, 1);
INSERT INTO assessment.question VALUES (22, 'Læremiddelet har et rikt og variert utvalg av autentiske og tilpassede tekster som er relevante for elevenes trinn og utdanningsprogram og som lar seg tilpasse elevenes faglige interesser og mestring', '1.1', 4, 2);
INSERT INTO assessment.question VALUES (23, 'Læremiddelet har et rikt og variert utvalg av narrative tekster i ulike sjangre, inkludert tekster relatert til barn og unges liv, erfaringer og interesser', '1.2', 4, 2);
INSERT INTO assessment.question VALUES (24, 'Læremiddelet har tekster, illustrasjoner og aktiviteter som fremmer interkulturell kompetanse', '1.3', 4, 2);
INSERT INTO assessment.question VALUES (25, 'Læremiddelet avspeiler det flerkulturelle og flerspråklige klasserommet', '1.4', 4, 2);
INSERT INTO assessment.question VALUES (26, 'Læremiddelet inviterer eleven til prøving og utforsking i læringsarbeidet', '1.5', 4, 2);
INSERT INTO assessment.question VALUES (27, 'Læremiddelet behandler tema fra ulike perspektiv, lar elevene fordype seg over tid og utfordrer elevene til å stille spørsmål, diskutere og reflektere', '1.6', 4, 2);
INSERT INTO assessment.question VALUES (28, 'Læremiddelet legger til rette for at elevene skal kunne skape noe nytt med kunnskapen som blir presentert og dermed overføre det de kan og har lært til nye og ukjente situasjoner', '1.7', 4, 2);
INSERT INTO assessment.question VALUES (29, 'Læremiddelet spør etter elevens opplevelser, syn, erfaringer og meninger', '1.8', 4, 2);
INSERT INTO assessment.question VALUES (30, 'Læremiddelet legger til rette for egenvurdering ved å formidle formålet med oppgaver og aktiviteter, og ved å stille konkrete spørsmål og invitere eleven til refleksjon over egen læring', '1.9', 4, 2);
INSERT INTO assessment.question VALUES (31, 'Læremiddelet opplyser om hvilke data det samler om eleven, til hvilke formål, og hvem som har tilgang til disse. Læremiddelet gjør rede for dette på en forståelig måte for elever og foresatte', '1.10', 4, 2);
INSERT INTO assessment.question VALUES (32, 'Læremiddelet bygger på et elev- og læringssyn som samsvarer med verdiene og prinsippene for læring i læreplanverket og i opplæringsloven', '1.11', 4, 2);
INSERT INTO assessment.question VALUES (33, 'Læremiddelet støtter opp under en kritisk tilnærming til tekst, også tekst formidlet av læremidler, og tematiserer hvordan mediet former kommunikasjonen', '1.12', 4, 2);
INSERT INTO assessment.question VALUES (34, 'Læremiddelet åpner for elevenes ulike tolkninger og opplevelser av litterære tekster og andre kulturuttrykk', '2.1', 2, 2);
INSERT INTO assessment.question VALUES (35, 'Læremiddelet fremmer en inkluderende holdning og aksept for ulike varianter av engelsk', '2.2', 2, 2);
INSERT INTO assessment.question VALUES (36, 'Læremiddelet formidler flerspråklighet som ressurs i læringsarbeidet', '2.3', 2, 2);
INSERT INTO assessment.question VALUES (37, 'Læremiddelet legger til rette for kommunikasjon og samhandling mellom elevene', '2.4', 2, 2);
INSERT INTO assessment.question VALUES (38, 'Læremiddelet støtter elevene i å velge ut og bevisst bruke kommunikasjonsstrategier', '2.5', 2, 2);
INSERT INTO assessment.question VALUES (39, 'Læremiddelet knytter arbeid med språkstrukturer til forskjellige tema, sammenhenger og kommunikative formål', '2.6', 2, 2);
INSERT INTO assessment.question VALUES (40, 'Læremiddelet åpner for en undrende og utforskende tilnærming til språklige strukturer', '2.7', 2, 2);
INSERT INTO assessment.question VALUES (41, 'Læremiddelet legger til rette for at elevene får lære språk i autentiske situasjoner', '2.8', 2, 2);
INSERT INTO assessment.question VALUES (42, 'Læremiddelet støtter elevene i utviklingen av et stadig bredere og mer nyansert ordforråd og i å bruke ord de har lært, i kjente og nye situasjoner', '2.9', 2, 2);
INSERT INTO assessment.question VALUES (43, 'Læremiddelet lar elevene reflektere over egen språkbruk og støtter utviklingen deres av språkbevissthet', '2.10', 2, 2);
INSERT INTO assessment.question VALUES (44, 'Læremiddelet inkluderer metatekst om teksttyper og sjangre og viser tekst i prosess', '2.11', 2, 2);
INSERT INTO assessment.question VALUES (45, 'Læremiddelet har tekster som gir gode modeller for elevenes egen tekstproduksjon og åpner for intertekstualitet som ressurs for tolking og tekstskaping', '2.12', 2, 2);
INSERT INTO assessment.question VALUES (46, 'Læremiddelet inviterer til bruk av flere sanser, til å bruke praktisk-estetiske arbeidsmåter og til bruk av fysiske aktiviteter i læringsarbeidet', '2.13', 2, 2);
INSERT INTO assessment.question VALUES (47, 'Læremiddelet legger opp til at eleven bearbeider og videreformidler lærestoff på ulike måter og ved bruk av ulike modaliteter', '2.14', 2, 2);
INSERT INTO assessment.question VALUES (48, 'Læremiddelet har et design som kan appellere til målgruppen', '3.1', 5, 2);
INSERT INTO assessment.question VALUES (49, 'Læremiddelet er oversiktlig og tydelig strukturert, og det er enkelt for læreren og elevene å navigere mellom delene i læremiddelet', '3.2', 5, 2);
INSERT INTO assessment.question VALUES (50, 'Læremiddelet bruker tydelige definisjoner, forklaringer og referanser, til støtte for lærere og foresatte med variert kompetanse i engelskfaget', '3.3', 5, 2);
INSERT INTO assessment.question VALUES (51, 'Læremiddelet er utformet slik at mediets affordanser tas i bruk og ulike modaliteter utfyller hverandre, gir ulike innganger til lærestoffet og bidrar til helhetlige og nyanserte framstillinger av tema', '3.4', 5, 2);
INSERT INTO assessment.question VALUES (52, 'Læremiddelet har en tiltalende design for målgruppen', '1.1', 1, 3);
INSERT INTO assessment.question VALUES (53, 'Læremiddelet har en struktur som gir oversikt og sammenheng i elevenes læring', '1.2', 1, 3);
INSERT INTO assessment.question VALUES (54, 'Læremiddelet har en tydelig og intuitiv meny for navigasjon', '1.3', 1, 3);
INSERT INTO assessment.question VALUES (55, 'Læremiddelet har kort vei fra innlogging til ønsket informasjon/ oppgave', '1.4', 1, 3);
INSERT INTO assessment.question VALUES (56, 'Læremiddelet presenterer data fra elevaktivitetene på en oversiktlig og forståelig måte for læreren', '1.5', 1, 3);
INSERT INTO assessment.question VALUES (57, 'Læremiddelet har informasjon som alle målgrupper kan oppfatte', '1.6', 1, 3);
INSERT INTO assessment.question VALUES (58, 'Læremiddelet har navigeringsfunksjoner som alle brukere kan betjene', '1.7', 1, 3);
INSERT INTO assessment.question VALUES (59, 'Læremiddelet har oppgaver som legger til rette for å bruke ulike kognitive prosesser', '2.1', 2, 3);
INSERT INTO assessment.question VALUES (60, 'Læremiddelet har oppgaver som stiller høye kognitive krav til elevene', '2.2', 2, 3);
INSERT INTO assessment.question VALUES (61, 'Læremiddelet bruker ulike representasjoner og forklarer overgangen mellom dem', '2.3', 2, 3);
INSERT INTO assessment.question VALUES (62, 'Læremiddelet har oppgaver som er egnet for samarbeid og diskusjon', '2.4', 2, 3);
INSERT INTO assessment.question VALUES (63, 'Læremiddelet legger opp til varierte arbeidsmåter', '2.5', 2, 3);
INSERT INTO assessment.question VALUES (64, 'Læremiddelet gir mulighet for å bruke varierte strategier og metoder for problemløsning', '2.6', 2, 3);
INSERT INTO assessment.question VALUES (65, 'Læremiddelet bidrar til at elevene får økt engasjement, skaperglede og utforsking', '3.1', 6, 3);
INSERT INTO assessment.question VALUES (66, 'Læremiddelet bidrar til at elevene får øvelse i kritisk tenkning', '3.2', 6, 3);
INSERT INTO assessment.question VALUES (67, 'Læremiddelet bidrar til at elevene lærer å lære', '3.3', 6, 3);
INSERT INTO assessment.question VALUES (68, 'Læremiddelet har gode eksempler som viser hvordan eleven kan bruke ulike problemløsningsstrategier', '3.4', 6, 3);
INSERT INTO assessment.question VALUES (69, 'Læremiddelet har med problemløsingsoppgaver gjennomgående og integrert i de ulike kunnskapsområdene', '3.5', 6, 3);
INSERT INTO assessment.question VALUES (70, 'Læremiddelet har med ulike praktiske eksempler og oppgaver hvor matematikk anvendes', '3.6', 6, 3);
INSERT INTO assessment.question VALUES (71, 'Læremiddelet synliggjør hvordan vi kan bruke matematisk modellering til å løse et praktisk problem', '3.7', 6, 3);
INSERT INTO assessment.question VALUES (72, 'Læremiddelet synliggjør de bærende ideene i de ulike resonnementene som gjøres', '3.8', 6, 3);
INSERT INTO assessment.question VALUES (73, 'Læremiddelet har oppgaver og utfordringer hvor elevene ikke bare må bruke regler og prosedyrer, men hvor de selv må finne resonnement', '3.9', 6, 3);
INSERT INTO assessment.question VALUES (74, 'Læremiddelet legger opp til at eleven må oversette mellom det matematiske symbolspråket, dagligspråk og mellom ulike representasjoner', '3.10', 6, 3);
INSERT INTO assessment.question VALUES (75, 'Læremiddelet legger opp til at elevene skal utvikle algebraisk tenkning. Det vil si at elevene selv skal kunne generalisere og finne sammenhenger ut fra mønstre og strukturer', '3.11', 6, 3);
INSERT INTO assessment.question VALUES (76, 'Læremiddelet har et variert utvalg av tekster på bokmål og nynorsk, fra norsk, nordisk og internasjonal litteratur fra fortid og nåtid som bidrar til å gi elevene felles referanserammer og historisk og kulturell forståelse', '1.1', 4, 4);
INSERT INTO assessment.question VALUES (77, 'Læremiddelet representerer og verdsetter språklig, kulturelt og livssynsmessig mangfold og utnytter variasjonen i elevenes erfaringsbakgrunn', '1.2', 4, 4);
INSERT INTO assessment.question VALUES (78, 'Læremiddelet støtter dybdelæring gjennom struktur, sammenheng mellom kunnskapsområder og utforskende oppgaver og aktiviteter', '1.3', 4, 4);
INSERT INTO assessment.question VALUES (79, 'Læremiddelet legger til rette for refleksjon over egen læreprosess, og for egenvurdering', '1.4', 4, 4);
INSERT INTO assessment.question VALUES (80, 'Læremiddelet lar elevene utforske sammenhengen mellom form, funksjon og innhold i ulike typer tekster og støtter elevens meningsskapende tekstarbeid', '1.5', 4, 4);
INSERT INTO assessment.question VALUES (81, 'Læremiddelet legger opp til at elevene får arbeide kreativt, sammenlignende og utforskende med både sakprosa og skjønnlitteratur og både kortere tekster og hele verk', '1.6', 4, 4);
INSERT INTO assessment.question VALUES (82, 'Læremiddelet støtter eleven i å ta stilling til tekst på en kunnskapsbasert, nyansert og kritisk måte', '1.7', 4, 4);
INSERT INTO assessment.question VALUES (83, 'Læremiddelet legger til rette for god muntlig opplæring der læreren får støtte til å inkludere elevene i åpne samtale- og læringsfellesskap', '1.8', 4, 4);
INSERT INTO assessment.question VALUES (84, 'Læremiddelet lar elevene få innta ulike skriveroller i meningsfylte og relevante skriveoppgaver, både individuelt og i fellesskap', '1.9', 4, 4);
INSERT INTO assessment.question VALUES (85, 'Læremiddelet legger opp til sammenlignende, varierte og utforskende arbeid med språk der elevene inviteres til å ta i bruk et språk om språket (metaspråk)', '1.10', 4, 4);
INSERT INTO assessment.question VALUES (86, 'Læremiddelet gir kunnskap om språksituasjonen i Norge og inviterer til å reflektere over og forstå egen og andres språklige situasjon', '1.11', 4, 4);
INSERT INTO assessment.question VALUES (87, 'Læremiddelet gir god støtte i arbeidet med den første lese- og skriveopplæringen med utgangspunkt i elevens forutsetninger', '1.12', 4, 4);
INSERT INTO assessment.question VALUES (88, 'Læremiddelet støtter opplæringen i og den videre utviklingen av de grunnleggende ferdighetene lesing og skriving, muntlige- og digitale ferdigheter', '1.13', 4, 4);
INSERT INTO assessment.question VALUES (89, 'Læremiddelet bidrar til at elevene utvikler sin digitale dømmekraft, slik at de opptrer etisk og reflektert i kommunikasjon med andre', '1.14', 4, 4);
INSERT INTO assessment.question VALUES (90, 'Læremiddelet tilbyr støtte til differensiering og tilpasset opplæring slik at elevene kan arbeide med tekster og oppgaver på ulike nivå', '2.1', 2, 4);
INSERT INTO assessment.question VALUES (91, 'Læremiddelet har interessante og relevante innganger til fagstoffet og gir eleven hjelp til å forstå hva som er sentralt stoff i faget', '2.2', 2, 4);
INSERT INTO assessment.question VALUES (92, 'Læremiddelet har relevante og varierte oppgaver på ulike nivå som kan løses både individuelt og i samarbeid og ved bruk av ulike modaliteter', '2.3', 2, 4);
INSERT INTO assessment.question VALUES (93, 'Læremiddelet har digitale funksjoner som bygger på et læringssyn som er i tråd med verdigrunnlaget i læreplanen, og som presenterer arbeider og resultater fra elevaktivitetene på en oversiktlig og formålstjenlig måte for læreren og eleven selv', '2.4', 2, 4);
INSERT INTO assessment.question VALUES (94, 'Digitale læremidler oppfyller krav til personvern og universell utforming', '3.1', 5, 4);
INSERT INTO assessment.question VALUES (95, 'Læremiddelet oppfyller kravet til tekster på bokmål og nynorsk i tråd med kravet i opplæringsloven', '3.2', 5, 4);
INSERT INTO assessment.question VALUES (96, 'Læremiddelet har en tiltalende og elevorientert utforming som utnytter samspillet mellom tekst, bilde og andre meningsskapende ressurser', '3.3', 5, 4);
INSERT INTO assessment.question VALUES (97, 'Læremiddelet har en ryddig og logisk struktur som gir oversikt og sammenheng i framstillingen', '3.4', 5, 4);
INSERT INTO assessment.question VALUES (98, 'Læremiddelet bruker et tilgjengelig og eksemplarisk språk som er tilpasset elevgruppen, og som kommuniserer med elevene', '3.5', 5, 4);

INSERT INTO assessment.questiontextresources VALUES (10, 4, 'Oahpponeavvu lea ulbmiljoavkku ohppiid mielas miellagiddevaš', 1083);
INSERT INTO assessment.questiontextresources VALUES (11, 5, 'Oahpponeavvu lea čorgat ja áddehahtti geavahit ohppiide ja oahpaheddjiide', 1083);
INSERT INTO assessment.questiontextresources VALUES (12, 6, 'Oahpponeavvus lea giella mii lea heivehuvvon fága terminologiijai ja ulbmiljoavkku ohppiide', 1083);
INSERT INTO assessment.questiontextresources VALUES (13, 7, 'Oahpponeavvus lea multimodalitehta mii ovttas doarju oahppama', 1083);
INSERT INTO assessment.questiontextresources VALUES (14, 8, 'Oahpponeavvu doarju oahpaheddjiid barggu heivehuvvon oahpahusain', 1083);
INSERT INTO assessment.questiontextresources VALUES (15, 9, 'Oahpponeavvus lea viiddes ja máŋggabealat sisdoallu', 1083);
INSERT INTO assessment.questiontextresources VALUES (16, 10, 'Oahpponeavvu láhčá nu, ahte oahppit galget oahppat', 1083);
INSERT INTO assessment.questiontextresources VALUES (17, 11, 'Oahpponeavvu doarju ohppiid ovdánahttit kritihkalaš jurddašeami ja etihkalaš dihtomielalašvuođa', 1083);
INSERT INTO assessment.questiontextresources VALUES (18, 12, 'Oahpponeavvu hástá ohppiid suokkardit oahpadettiin', 1083);
INSERT INTO assessment.questiontextresources VALUES (19, 13, 'Oahpponeavvu láhčá ovttasdoaibmamii oahpponeavvus dahje dan olggobealde', 1083);
INSERT INTO assessment.questiontextresources VALUES (20, 14, 'Oahpponeavvu ovddida searvadahttima ja girjáivuođa', 1083);
INSERT INTO assessment.questiontextresources VALUES (21, 15, 'Oahpponeavvu veahkeha ohppiid áddet sámi historjjá, kultuvrra, giela, servodateallima ja vuoigatvuođaid', 1083);
INSERT INTO assessment.questiontextresources VALUES (22, 16, 'Oahpponeavvu fuolaha fága relevánssa ja guovddáš árvvuid', 1083);
INSERT INTO assessment.questiontextresources VALUES (23, 17, 'Oahpponeavvu addá vejolašvuođa bargat fága guovddášelemeanttaiguin', 1083);
INSERT INTO assessment.questiontextresources VALUES (24, 18, 'Oahpponeavvu láhčá oaidnit oktavuođaid oahpahusas', 1083);
INSERT INTO assessment.questiontextresources VALUES (25, 19, 'Oahpponeavvu láhčá nu, ahte oahppit besset ovdánahttit ja geavahit vuođđogálggaid fágas', 1083);
INSERT INTO assessment.questiontextresources VALUES (26, 20, 'Oahpponeavvus lea buorre progrešuvdna fága gealbomihttomeriid olis', 1083);
INSERT INTO assessment.questiontextresources VALUES (27, 21, 'Oahpponeavvu doarju ohppiid ja oahpaheddjiid dađistaga árvvoštallama bargguin.', 1083);
INSERT INTO assessment.questiontextresources VALUES (28, 4, 'Learohkh ulmiedåehkesne tuhtjieh learoevierhtie lea ïedtjije', 6203);
INSERT INTO assessment.questiontextresources VALUES (29, 5, 'Learoevierhtie lea tjyölkehke jïh aelhkie guarkedh jïh nuhtjedh learoehkidie jïh lohkehtæjjide', 6203);
INSERT INTO assessment.questiontextresources VALUES (30, 6, 'Learoevierhtie gïelem nuhtjie mij lea sjïehtedamme faagen terminologijese jïh learoehkidie ulmiedåehkesne', 6203);
INSERT INTO assessment.questiontextresources VALUES (31, 7, 'Learoevierhtien lea multimodaliteete mij ektesne lïeremem dåarjohte', 6203);
INSERT INTO assessment.questiontextresources VALUES (32, 8, 'Learoevierhtie lohkehtæjjan barkoem sjïehtedamme lïerehtimmine dåarjohte', 6203);
INSERT INTO assessment.questiontextresources VALUES (33, 9, 'Learoevierhtien lea ræjhkoes jïh jeereldihkie sisvege', 6203);
INSERT INTO assessment.questiontextresources VALUES (34, 10, 'Learoevierhtie sjïehteladta ihke learohkh edtjieh lïeredh lïeredh', 6203);
INSERT INTO assessment.questiontextresources VALUES (35, 11, 'Learoevierhtie learoehkidie dåarjohte laejhtehks ussjedimmiem jïh etihkeles voerkesvoetem evtiedidh', 6203);
INSERT INTO assessment.questiontextresources VALUES (36, 12, 'Learoevierhtie learoehkidie böörede liemmebarkosne goerehtidh', 6203);
INSERT INTO assessment.questiontextresources VALUES (37, 13, 'Learoevierhtieh sjïehteladta aktivyöki barkose learoevierhtesne jallh learoevierhtien ålkolen', 6203);
INSERT INTO assessment.questiontextresources VALUES (38, 14, 'Learoevierhtie feerhmemem jïh gellievoetem eevtjie', 6203);
INSERT INTO assessment.questiontextresources VALUES (39, 15, 'Learoevierhtie viehkehte guktie learohkh daajroem åadtjoeh saemien aalkoeåålmegen histovrijen, kultuvren, gïelen, seabradahkejieleden jïh reaktaj bïjre.', 6203);
INSERT INTO assessment.questiontextresources VALUES (40, 16, 'Learoevierhtie faagen relevaansem jïh vihkeles aarvoeh gorrede', 6203);
INSERT INTO assessment.questiontextresources VALUES (41, 17, 'Learoevierhtie nuepiem vadta jarngebiehkiejgujmie faagesne barkedh', 6203);
INSERT INTO assessment.questiontextresources VALUES (42, 18, 'Learoevierhtie sjïehteladta ektiedimmieh vuejnedh lïerehtimmesne', 6203);
INSERT INTO assessment.questiontextresources VALUES (43, 19, 'Learoevierhtie sjïehteladta ihke learohkh åadtjoeh vihkeles tjiehpiesvoeth faagesne evtiedidh jïh nuhtjedh', 6203);
INSERT INTO assessment.questiontextresources VALUES (44, 20, 'Learoevierhtie hijven progresjovnem åtna maahtoeulmiej mietie faagesne', 6203);
INSERT INTO assessment.questiontextresources VALUES (45, 21, 'Learoevierhtie learohki jïh lohkehtæjjan barkoem jaabnan vuarjasjimmine dåarjohte', 6203);
INSERT INTO assessment.questiontextresources VALUES (46, 4, 'Oahpponævvo la dakkir mij båktå berustimev ulmmejuohkusa oahppij gaskan', 4155);
INSERT INTO assessment.questiontextresources VALUES (47, 5, 'Álgge l gávnnat majt galggá ja oahpponævvo la intuitijvva oahppijda ja åhpadiddjijda', 4155);
INSERT INTO assessment.questiontextresources VALUES (48, 6, 'Oahpponævvo adná gielav mij la hiebadum fáhka terminologijjaj ja ulmmejuohkusa oahppijda', 4155);
INSERT INTO assessment.questiontextresources VALUES (49, 7, 'Oahpponævon la multimodalitiehtta mij aktan oahppamav doarjju', 4155);
INSERT INTO assessment.questiontextresources VALUES (50, 8, 'Oahpponævvo doarjju åhpadiddje bargov hiebadam åhpadimijn', 4155);
INSERT INTO assessment.questiontextresources VALUES (51, 9, 'Oahpponævon la valjes ja målsudahkes sisadno', 4155);
INSERT INTO assessment.questiontextresources VALUES (52, 10, 'Oahpponævvo dilev láhtjá váj oahppe galggi oahppat oahppat', 4155);
INSERT INTO assessment.questiontextresources VALUES (53, 11, 'Oahpponævvo doarjju oahppijt váj sijá lájttális ájádallam ja etalasj diedulasjvuohta nanniduvvá', 4155);
INSERT INTO assessment.questiontextresources VALUES (54, 12, 'Oahpponævvo gåhttju oahppijt åtsådit oahppambargon', 4155);
INSERT INTO assessment.questiontextresources VALUES (55, 13, 'Oahpponævvo dilev láhtjá aktisasjbargguj oahpponævon jali dan ålggolin', 4155);
INSERT INTO assessment.questiontextresources VALUES (56, 14, 'Oahpponævvo åvdet sebradahttemav ja moattebelakvuodav', 4155);
INSERT INTO assessment.questiontextresources VALUES (57, 15, 'Oahppopládna la viehkken váj oahppe bessi oahpásmuvvat sáme álggoálmmuga histåvrråj, kultuvrraj, giellaj, sebrudakiellemij ja riektájda', 4155);
INSERT INTO assessment.questiontextresources VALUES (58, 16, 'Oahpponævvo várajda válldá fága relevánsav ja guovdásj árvojt', 4155);
INSERT INTO assessment.questiontextresources VALUES (59, 17, 'Oahpponævon bæssá fága guovdásj elementaj barggat', 4155);
INSERT INTO assessment.questiontextresources VALUES (60, 18, 'Oahpponævo baktu vuojnná tjanástagájt åhpadimen', 4155);
INSERT INTO assessment.questiontextresources VALUES (61, 19, 'Oahppopládna dilev láhtjá váj oahppe bessi adnet ja åvddånahttet fága vuodulasj tjehpudagájt', 4155);
INSERT INTO assessment.questiontextresources VALUES (62, 20, 'Oahpponævon la buorre progresjåvnnå fága máhtudakulmij gáktuj', 4155);
INSERT INTO assessment.questiontextresources VALUES (63, 21, 'Oahpponævvo doarjju oahppe ja åhpadiddje bargov åhpadattijn árvustallamijn', 4155);
INSERT INTO assessment.questiontextresources VALUES (64, 1, 'Ønsker ikkje å svare på denne kategorien', 2068);
INSERT INTO assessment.questiontextresources VALUES (65, 2, 'Ønsker ikkje å svare på denne kategorien', 2068);
INSERT INTO assessment.questiontextresources VALUES (66, 3, 'Ønsker ikkje å svare på denne kategorien', 2068);
INSERT INTO assessment.questiontextresources VALUES (67, 4, 'Læremiddelet blir opplevd som engasjerande for elevane i målgruppa.', 2068);
INSERT INTO assessment.questiontextresources VALUES (68, 5, 'Læremiddelet er oversiktleg og intuitivt å bruke for elevar og lærarar.', 2068);
INSERT INTO assessment.questiontextresources VALUES (69, 6, 'Læremiddelet bruker eit språk som er tilpassa terminologien i faget og tilpassa elevane i målgruppa.', 2068);
INSERT INTO assessment.questiontextresources VALUES (70, 7, 'Læremiddelet har multimodalitet som saman støttar læring.', 2068);
INSERT INTO assessment.questiontextresources VALUES (2, 1, 'Im sïjhth daam kategorijem vaestiedidh', 6203);
INSERT INTO assessment.questiontextresources VALUES (5, 2, 'Im sïjhth daam kategorijem vaestiedidh', 6203);
INSERT INTO assessment.questiontextresources VALUES (8, 3, 'Im sïjhth daam kategorijem vaestiedidh', 6203);
INSERT INTO assessment.questiontextresources VALUES (3, 1, 'Iv sidá dán kategorijjan vásstedit', 4155);
INSERT INTO assessment.questiontextresources VALUES (6, 2, 'Iv sidá dán kategorijjan vásstedit', 4155);
INSERT INTO assessment.questiontextresources VALUES (9, 3, 'Iv sidá dán kategorijjan vásstedit', 4155);
INSERT INTO assessment.questiontextresources VALUES (71, 8, 'Læremiddelet støttar arbeidet til læraren med tilpassa opplæring.', 2068);
INSERT INTO assessment.questiontextresources VALUES (72, 9, 'Læremiddelet har rikt og variert innhald.', 2068);
INSERT INTO assessment.questiontextresources VALUES (73, 10, 'Læremiddelet legg til rette for at elevane skal lære å lære.', 2068);
INSERT INTO assessment.questiontextresources VALUES (74, 11, 'Læremiddelet støttar elevane i å utvikle kritisk tenking og etisk medvit.', 2068);
INSERT INTO assessment.questiontextresources VALUES (75, 12, 'Læremiddelet inviterer elevane til utforsking i læringsarbeidet.', 2068);
INSERT INTO assessment.questiontextresources VALUES (76, 13, 'Læremiddelet legg til rette for samhandling i eller utanfor læremiddelet.', 2068);
INSERT INTO assessment.questiontextresources VALUES (77, 14, 'Læremiddelet fremjar inkludering og mangfald.', 2068);
INSERT INTO assessment.questiontextresources VALUES (78, 15, 'Læremiddelet bidreg til at elevane får innsikt i historia, kulturen, språket, samfunnslivet og rettane til det samiske urfolket.', 2068);
INSERT INTO assessment.questiontextresources VALUES (79, 16, 'Læremiddelet tek vare på fagrelevans og sentrale verdiar.', 2068);
INSERT INTO assessment.questiontextresources VALUES (80, 17, 'Læremiddelet gir moglegheit til å arbeide med kjerneelementa i faget.', 2068);
INSERT INTO assessment.questiontextresources VALUES (81, 18, 'Læremiddelet legg til rette for å sjå samanhengar i opplæringa.', 2068);
INSERT INTO assessment.questiontextresources VALUES (82, 19, 'Læremiddelet legg til rette for at elevane får utvikle og bruke grunnleggjande ferdigheiter i faget.', 2068);
INSERT INTO assessment.questiontextresources VALUES (83, 20, 'Læremiddelet har god progresjon i tråd med kompetansemåla i faget.', 2068);
INSERT INTO assessment.questiontextresources VALUES (84, 21, 'Læremiddelet støttar arbeidet med undervegsvurdering for elevane og læraren.', 2068);
INSERT INTO assessment.questiontextresources VALUES (85, 22, 'Læremiddelet har eit rikt og variert utval av autentiske og tilpassa tekstar som er relevante for årstrinn og utdanningsprogram, og som lar seg tilpasse faglege interesser og meistring.', 2068);
INSERT INTO assessment.questiontextresources VALUES (86, 23, 'Læremiddelet har eit rikt og variert utval av narrative tekstar i ulike sjangrar, inkludert tekstar som er relaterte til barn og unges liv, erfaringar og interesser.', 2068);
INSERT INTO assessment.questiontextresources VALUES (87, 24, 'Læremiddelet har tekstar, illustrasjonar og aktivitetar som fremmar interkulturell kompetanse.', 2068);
INSERT INTO assessment.questiontextresources VALUES (88, 25, 'Læremiddelet speglar det fleirkulturelle og fleirspråklege klasserommet.', 2068);
INSERT INTO assessment.questiontextresources VALUES (89, 26, 'Læremiddelet inviterer eleven til prøving og utforsking i læringsarbeidet.', 2068);
INSERT INTO assessment.questiontextresources VALUES (90, 27, 'Læremiddelet behandlar tema frå ulike perspektiv, lar elevane fordjupe seg over tid og utfordrar elevane til å stille spørsmål, diskutere og reflektere.', 2068);
INSERT INTO assessment.questiontextresources VALUES (91, 28, 'Læremiddelet legg til rette for at elevane skal kunne skape noko nytt med kunnskapen som blir presentert, og dermed overføre det dei kan og har lært, til nye og ukjende situasjonar.', 2068);
INSERT INTO assessment.questiontextresources VALUES (92, 29, 'Læremiddelet spør etter eleven sine opplevingar, syn, erfaringar og meiningar.', 2068);
INSERT INTO assessment.questiontextresources VALUES (93, 30, 'Læremiddelet legg til rette for eigenvurdering ved å formidle formålet med oppgåver og aktivitetar og ved å stille konkrete spørsmål og invitere eleven til refleksjon over eiga læring.', 2068);
INSERT INTO assessment.questiontextresources VALUES (94, 31, 'Læremiddelet opplyser om kva data det samlar om eleven, til kva formål, og kven som har tilgang til dei. Læremiddelet gjer greie for dette på ein forståeleg måte for elevar og føresette.', 2068);
INSERT INTO assessment.questiontextresources VALUES (95, 32, 'Læremiddelet bygger på eit elev- og læringssyn som samsvarer med verdiane og prinsippa for læring i læreplanverket og i opplæringslova.', 2068);
INSERT INTO assessment.questiontextresources VALUES (96, 33, 'Læremiddelet støttar opp under ei kritisk tilnærming til tekst, også tekst som er formidla av læremiddel, og tematiserer korleis mediet formar kommunikasjonen.', 2068);
INSERT INTO assessment.questiontextresources VALUES (97, 34, 'Læremiddelet opnar for ulike tolkingar og opplevingar frå elevane si side av litterære tekstar og andre kulturuttrykk.', 2068);
INSERT INTO assessment.questiontextresources VALUES (98, 35, 'Læremiddelet fremmar ei inkluderande haldning og aksept for ulike variantar av engelsk.', 2068);
INSERT INTO assessment.questiontextresources VALUES (99, 36, 'Læremiddelet formidlar fleirspråklegheit som ressurs i læringsarbeidet.', 2068);
INSERT INTO assessment.questiontextresources VALUES (100, 37, 'Læremiddelet legg til rette for kommunikasjon og samhandling mellom elevane.', 2068);
INSERT INTO assessment.questiontextresources VALUES (101, 38, 'Læremiddelet støttar elevane i å velje ut og bevisst bruke kommunikasjonsstrategiar.', 2068);
INSERT INTO assessment.questiontextresources VALUES (102, 39, 'Læremiddelet knyter arbeid med språkstrukturar til ulike tema, samanhengar og kommunikative formål.', 2068);
INSERT INTO assessment.questiontextresources VALUES (103, 40, 'Læremiddelet opnar for ei undrande og utforskande tilnærming til språklege strukturar.', 2068);
INSERT INTO assessment.questiontextresources VALUES (104, 41, 'Læremiddelet legg til rette for at elevane får lære språk i autentiske situasjonar.', 2068);
INSERT INTO assessment.questiontextresources VALUES (105, 42, 'Læremiddelet støttar elevane i utviklinga av eit stadig vidare og meir nyansert ordforråd, og i å bruke ord dei har lært, i kjende og nye situasjonar.', 2068);
INSERT INTO assessment.questiontextresources VALUES (106, 43, 'Læremiddelet lar elevane reflektere over eigen språkbruk og støttar utviklinga deira av språkbevisstheit.', 2068);
INSERT INTO assessment.questiontextresources VALUES (107, 44, 'Læremiddelet inkluderer metatekst om teksttypar og sjangrar og viser tekst i prosess.', 2068);
INSERT INTO assessment.questiontextresources VALUES (108, 45, 'Læremiddelet har tekstar som gir gode modellar for elevane sin eigen tekstproduksjon og opnar for intertekstualitet som ressurs for tolking og tekstskaping.', 2068);
INSERT INTO assessment.questiontextresources VALUES (109, 46, 'Læremiddelet inviterer til bruk av fleire sansar, til å bruke praktisk-estetiske arbeidsmåtar og til bruk av fysiske aktivitetar i læringsarbeidet.', 2068);
INSERT INTO assessment.questiontextresources VALUES (110, 47, 'Læremiddelet legg opp til at eleven bearbeider og vidareformidlar lærestoff på ulike måtar og ved bruk av ulike modalitetar.', 2068);
INSERT INTO assessment.questiontextresources VALUES (111, 48, 'Læremiddelet har eit design som kan appellere til målgruppa.', 2068);
INSERT INTO assessment.questiontextresources VALUES (112, 49, 'Læremiddelet er oversiktleg og tydeleg strukturert, og det er enkelt for læraren og elevane å navigere mellom delane i læremiddelet.', 2068);
INSERT INTO assessment.questiontextresources VALUES (113, 50, 'Læremiddelet bruker tydelege definisjonar, forklaringer og referansar, til støtte for lærarar og føresette med variert kompetanse i engelskfaget.', 2068);
INSERT INTO assessment.questiontextresources VALUES (114, 51, 'Læremiddelet er utforma slik at affordansane til mediet blir tatt i bruk og ulike modalitetar utfyller kvarandre, gir ulike inngangar til lærestoffet og bidrar til heilskaplege og nyanserte framstillingar av tema.', 2068);
INSERT INTO assessment.questiontextresources VALUES (115, 52, 'Læremiddelet har ein tiltalande design for målgruppa', 2068);
INSERT INTO assessment.questiontextresources VALUES (116, 53, 'Læremiddelet strukturerer fagstoffet på ein god måte, slik at elevane kan sjå samanhengar', 2068);
INSERT INTO assessment.questiontextresources VALUES (117, 54, 'Læremiddelet har ein tydeleg og intuitiv meny for navigasjon', 2068);
INSERT INTO assessment.questiontextresources VALUES (118, 55, 'Læremiddelet har kort veg frå innlogginga til informasjonen eller oppgåva du søker etter', 2068);
INSERT INTO assessment.questiontextresources VALUES (119, 56, 'Læremiddelet presenterer data frå elevaktivitetane på ein oversiktleg og forståeleg måte for læraren', 2068);
INSERT INTO assessment.questiontextresources VALUES (120, 57, 'Læremiddelet har informasjon som alle målgrupper kan oppfatte', 2068);
INSERT INTO assessment.questiontextresources VALUES (121, 58, 'Læremiddelet har navigeringsfunksjonar som alle brukarar kan betene', 2068);
INSERT INTO assessment.questiontextresources VALUES (122, 59, 'Læremiddelet har oppgåver som legg til rette for å bruke ulike kognitive prosessar', 2068);
INSERT INTO assessment.questiontextresources VALUES (123, 60, 'Læremiddelet har oppgåver som stiller høge kognitive krav til elevane', 2068);
INSERT INTO assessment.questiontextresources VALUES (124, 61, 'Læremiddelet bruker ulike representasjonar og forklarer overgangen mellom dei', 2068);
INSERT INTO assessment.questiontextresources VALUES (125, 62, 'Læremiddelet har oppgåver som eignar seg for samarbeid og diskusjon', 2068);
INSERT INTO assessment.questiontextresources VALUES (126, 63, 'Læremiddelet legg opp til varierte arbeidsmåtar', 2068);
INSERT INTO assessment.questiontextresources VALUES (127, 64, 'Læremiddelet gjer det mogleg å bruke varierte strategiar', 2068);
INSERT INTO assessment.questiontextresources VALUES (128, 65, 'Læremiddelet bidrar til større engasjement, skaparglede og utforskartrong hos elevane', 2068);
INSERT INTO assessment.questiontextresources VALUES (129, 66, 'Læremiddelet bidrar til at elevane får øve seg i kritisk tenking', 2068);
INSERT INTO assessment.questiontextresources VALUES (130, 67, 'Læremiddelet bidrar til at elevane lærer å lære', 2068);
INSERT INTO assessment.questiontextresources VALUES (131, 68, 'Læremiddelet har gode eksempler som viser hvordan eleven kan bruke ulike problemløsningsstrategier', 2068);
INSERT INTO assessment.questiontextresources VALUES (132, 69, 'Læremiddelet har med problemløysingsoppgåver gjennomgåande og integrerte i dei ulike kunnskapsområda', 2068);
INSERT INTO assessment.questiontextresources VALUES (133, 70, 'Læremiddelet har med ulike praktiske eksempel og oppgåver der matematikk blir brukt', 2068);
INSERT INTO assessment.questiontextresources VALUES (134, 71, 'Læremiddelet synleggjer korleis vi kan bruke matematisk modellering til å løyse eit praktisk problem', 2068);
INSERT INTO assessment.questiontextresources VALUES (135, 72, 'Læremiddelet synleggjer dei berande ideane i dei ulike resonnementa', 2068);
INSERT INTO assessment.questiontextresources VALUES (136, 73, 'Læremiddelet har oppgåver og utfordringar der elevane ikkje berre må bruke reglar og prosedyrar, men sjølve finne resonnement', 2068);
INSERT INTO assessment.questiontextresources VALUES (137, 74, 'Læremiddelet legg opp til at eleven må omsette mellom det matematiske symbolspråket og daglegspråket og mellom ulike representasjonar', 2068);
INSERT INTO assessment.questiontextresources VALUES (138, 75, 'Læremiddelet legg opp til at elevane skal utvikle algebraisk tenking. Det vil seie at elevane sjølve skal kunne generalisere og finne samanhengar ut frå mønster og strukturar', 2068);
INSERT INTO assessment.questiontextresources VALUES (139, 76, 'Læremiddelet har eit variert utval av tekstar på bokmål og nynorsk, frå norsk, nordisk og internasjonal litteratur frå fortid og notid som bidrar til å gi elevane felles referanserammer og historisk og kulturell forståing.', 2068);
INSERT INTO assessment.questiontextresources VALUES (140, 77, 'Læremiddelet representerer og verdset språkleg, kulturelt og livssynsmessig mangfald og utnyttar variasjonen i erfaringsbakgrunnen til elevane.', 2068);
INSERT INTO assessment.questiontextresources VALUES (141, 78, 'Læremiddelet støttar djupnelæring gjennom struktur, samanheng mellom kunnskapsområde og utforskande oppgåver og aktivitetar.', 2068);
INSERT INTO assessment.questiontextresources VALUES (142, 79, 'Læremiddelet legg til rette for refleksjon over eigen læreprosess, og for eigenvurdering.', 2068);
INSERT INTO assessment.questiontextresources VALUES (143, 80, 'Læremiddelet lar elevane utforske samanhengen mellom form, funksjon og innhald i ulike typar tekstar og støttar det meiningsskapande tekstarbeidet til eleven.', 2068);
INSERT INTO assessment.questiontextresources VALUES (144, 81, 'Læremiddelet legg opp til at elevane får arbeide kreativt, samanliknande og utforskande med både sakprosa og skjønnlitteratur og både kortare tekstar og heile verk.', 2068);
INSERT INTO assessment.questiontextresources VALUES (145, 82, 'Læremiddelet støttar eleven i å ta stilling til tekst på ein kunnskapsbasert, nyansert og kritisk måte.', 2068);
INSERT INTO assessment.questiontextresources VALUES (146, 83, 'Læremiddelet legg til rette for god munnleg opplæring der læraren får støtte til å inkludere elevane i opne samtale- og læringsfellesskapar.', 2068);
INSERT INTO assessment.questiontextresources VALUES (147, 84, 'Læremiddelet lar elevane få innta ulike skriveroller i meiningsfylte og relevante skriveoppgåver, både individuelt og i fellesskap.', 2068);
INSERT INTO assessment.questiontextresources VALUES (148, 85, 'Læremiddelet legg opp til samanliknande, varierte og utforskande arbeid med språk der elevane blir inviterte til å ta i bruk eit språk om språket (metaspråk).', 2068);
INSERT INTO assessment.questiontextresources VALUES (149, 86, 'Læremiddelet gir kunnskap om språksituasjonen i Noreg og inviterer til å reflektere over og forstå eigen og andres språklege situasjon.', 2068);
INSERT INTO assessment.questiontextresources VALUES (150, 87, 'Læremiddelet gir god støtte i arbeidet med den første lese- og skriveopplæringa med utgangspunkt i føresetnadene til eleven.', 2068);
INSERT INTO assessment.questiontextresources VALUES (151, 88, 'Læremiddelet støttar opplæringa i og den vidare utviklinga av dei grunnleggande ferdigheitene lesing og skriving, munnlege og digitale ferdigheter.', 2068);
INSERT INTO assessment.questiontextresources VALUES (152, 89, 'Læremiddelet bidrar til at elevane utviklar si digitale dømmekraft, slik at dei opptrer etisk og reflektert i kommunikasjon med andre.', 2068);
INSERT INTO assessment.questiontextresources VALUES (153, 90, 'Læremiddelet tilbyr støtte til differensiering og tilpassa opplæring, slik at elevane kan arbeide med tekstar og oppgåver på ulike nivå.', 2068);
INSERT INTO assessment.questiontextresources VALUES (154, 91, 'Læremiddelet har interessante og relevante inngangar til fagstoffet og gir eleven hjelp til å forstå kva som er sentralt stoff i faget.', 2068);
INSERT INTO assessment.questiontextresources VALUES (155, 92, 'Læremiddelet har relevante og varierte oppgåver på ulike nivå som kan løysast både individuelt og i samarbeid og ved bruk av ulike modalitetar.', 2068);
INSERT INTO assessment.questiontextresources VALUES (156, 93, 'Læremiddelet har digitale funksjonar som bygger på eit læringssyn som er i tråd med verdigrunnlaget i læreplanen, og som presenterer arbeid og resultat frå elevaktivitetane på ein oversiktleg og formålstenleg måte for læraren og eleven sjølv.', 2068);
INSERT INTO assessment.questiontextresources VALUES (157, 94, 'Digitale læremiddel oppfyller krav til personvern og universell utforming.', 2068);
INSERT INTO assessment.questiontextresources VALUES (158, 95, 'Læremiddelet oppfyller kravet til tekstar på bokmål og nynorsk i tråd med kravet i opplæringslova.', 2068);
INSERT INTO assessment.questiontextresources VALUES (159, 96, 'Læremiddelet har ei tiltalande og elevorientert utforming som utnyttar samspelet mellom tekst, bilete og andre meiningsskapande ressursar.', 2068);
INSERT INTO assessment.questiontextresources VALUES (160, 97, 'Læremiddelet har ein ryddig og logisk struktur som gir oversikt og samanheng i framstillinga.', 2068);
INSERT INTO assessment.questiontextresources VALUES (161, 98, 'Læremiddelet bruker eit tilgjengeleg og eksemplarisk språk som er tilpassa elevgruppa, og som kommuniserer med elevane.', 2068);
INSERT INTO assessment.questiontextresources VALUES (1, 1, 'In hálit vástidit dán kategoriijas', 1083);
INSERT INTO assessment.questiontextresources VALUES (4, 2, 'In hálit vástidit dán kategoriijas', 1083);
INSERT INTO assessment.questiontextresources VALUES (7, 3, 'In hálit vástidit dán kategoriijas', 1083);



INSERT INTO public.assessmenttype VALUES (1, 'Allefag', 'Allefag');
INSERT INTO public.assessmenttype VALUES (2, 'Engelsk', 'Engelsk');
INSERT INTO public.assessmenttype VALUES (3, 'Matte', 'Matte');
INSERT INTO public.assessmenttype VALUES (4, 'Norsk', 'Norsk');

INSERT INTO public.languagetype VALUES (1044, 'nb-NO', 'Bokmål');
INSERT INTO public.languagetype VALUES (2068, 'nn-NO', 'Nynorsk');
INSERT INTO public.languagetype VALUES (1083, 'se-NO', 'Nordsamisk');
INSERT INTO public.languagetype VALUES (4155, 'se-NO', 'Lulesamisk');
INSERT INTO public.languagetype VALUES (6203, 'se-NO', 'Sørsamisk');



SELECT pg_catalog.setval('assessment.answers_id_seq', 4193, true);

SELECT pg_catalog.setval('assessment.answertype_answertype_id_seq', 5, true);

SELECT pg_catalog.setval('assessment.answertypetextresources_id_seq', 25, true);

SELECT pg_catalog.setval('assessment.assessment_assessment_id_seq', 210, true);

SELECT pg_catalog.setval('assessment.category_category_id_seq', 6, true);

SELECT pg_catalog.setval('assessment.categorytextresources_id_seq', 15, true);

SELECT pg_catalog.setval('assessment.questiontextresources_text_id_seq', 161, true);

SELECT pg_catalog.setval('public.assessmenttype_assessmenttype_id_seq', 4, true);

SELECT pg_catalog.setval('userprofile.userprofile_user_id_seq', 173, true);

ALTER TABLE ONLY assessment.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);

ALTER TABLE ONLY assessment.answertype
    ADD CONSTRAINT answertype_pkey PRIMARY KEY (answertype_id);

ALTER TABLE ONLY assessment.answertypetextresources
    ADD CONSTRAINT answertypetextresources_pkey PRIMARY KEY (id);

ALTER TABLE ONLY assessment.assessment
    ADD CONSTRAINT assessment_pkey PRIMARY KEY (assessment_id);

ALTER TABLE ONLY assessment.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);

ALTER TABLE ONLY assessment.categorytextresources
    ADD CONSTRAINT categorytextresources_pkey PRIMARY KEY (id);

ALTER TABLE ONLY assessment.question
    ADD CONSTRAINT question_pkey PRIMARY KEY (question_id);

ALTER TABLE ONLY assessment.questiontextresources
    ADD CONSTRAINT questiontextresources_pkey PRIMARY KEY (text_id);

ALTER TABLE ONLY invitations.invitations
    ADD CONSTRAINT invitations_pkey PRIMARY KEY (gv_id);

ALTER TABLE ONLY public.assessmenttype
    ADD CONSTRAINT assessmenttype_pkey PRIMARY KEY (assessmenttype_id);

ALTER TABLE ONLY public.languagetype
    ADD CONSTRAINT languagetype_pkey PRIMARY KEY (language_id);

ALTER TABLE ONLY userprofile.userprofile
    ADD CONSTRAINT userprofile_pkey PRIMARY KEY (user_id);

ALTER TABLE ONLY assessment.answers
    ADD CONSTRAINT fk_answertype FOREIGN KEY (answertype_id_fk) REFERENCES assessment.answertype(answertype_id);

ALTER TABLE ONLY assessment.answertypetextresources
    ADD CONSTRAINT fk_answertypeid FOREIGN KEY (answertype_id_fk) REFERENCES assessment.answertype(answertype_id);

ALTER TABLE ONLY assessment.answers
    ADD CONSTRAINT fk_assessment FOREIGN KEY (assessment_id_fk) REFERENCES assessment.assessment(assessment_id);

ALTER TABLE ONLY assessment.question
    ADD CONSTRAINT fk_category FOREIGN KEY (category_id_fk) REFERENCES assessment.category(category_id);

ALTER TABLE ONLY assessment.categorytextresources
    ADD CONSTRAINT fk_categoryid FOREIGN KEY (category_id_fk) REFERENCES assessment.category(category_id);

ALTER TABLE ONLY assessment.assessment
    ADD CONSTRAINT fk_groupid FOREIGN KEY (groupassessment_id_fk) REFERENCES invitations.invitations(gv_id);

ALTER TABLE ONLY assessment.answertypetextresources
    ADD CONSTRAINT fk_language_answertype FOREIGN KEY (language_id_fk) REFERENCES public.languagetype(language_id);

ALTER TABLE ONLY assessment.categorytextresources
    ADD CONSTRAINT fk_language_category FOREIGN KEY (language_id_fk) REFERENCES public.languagetype(language_id);

ALTER TABLE ONLY assessment.questiontextresources
    ADD CONSTRAINT fk_language_question FOREIGN KEY (language_id_fk) REFERENCES public.languagetype(language_id);

ALTER TABLE ONLY assessment.answers
    ADD CONSTRAINT fk_question FOREIGN KEY (question_id_fk) REFERENCES assessment.question(question_id);

ALTER TABLE ONLY assessment.question
    ADD CONSTRAINT fk_question_assessmenttype FOREIGN KEY (assessmenttype_id_fk) REFERENCES public.assessmenttype(assessmenttype_id);

ALTER TABLE ONLY assessment.assessment
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id_fk) REFERENCES userprofile.userprofile(user_id);

ALTER TABLE ONLY invitations.invitations
    ADD CONSTRAINT fk_assessmenttype FOREIGN KEY (assessmenttype_id_fk) REFERENCES public.assessmenttype(assessmenttype_id);

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_advance(text, pg_lsn) TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_create(text) TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_drop(text) TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_oid(text) TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_progress(text, boolean) TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_is_setup() TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_progress(boolean) TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_reset() TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_setup(text) TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_xact_reset() TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_xact_setup(pg_lsn, timestamp with time zone) TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_show_replication_origin_status(OUT local_id oid, OUT external_id text, OUT remote_lsn pg_lsn, OUT local_lsn pg_lsn) TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_stat_reset() TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_stat_reset_shared(text) TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_stat_reset_single_function_counters(oid) TO azure_pg_admin;

GRANT ALL ON FUNCTION pg_catalog.pg_stat_reset_single_table_counters(oid) TO azure_pg_admin;

GRANT SELECT(name) ON TABLE pg_catalog.pg_config TO azure_pg_admin;

GRANT SELECT(setting) ON TABLE pg_catalog.pg_config TO azure_pg_admin;

GRANT SELECT(line_number) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;

GRANT SELECT(type) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;

GRANT SELECT(database) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;

GRANT SELECT(user_name) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;

GRANT SELECT(address) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;

GRANT SELECT(netmask) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;

GRANT SELECT(auth_method) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;

GRANT SELECT(options) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;

GRANT SELECT(error) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;

GRANT SELECT(local_id) ON TABLE pg_catalog.pg_replication_origin_status TO azure_pg_admin;

GRANT SELECT(external_id) ON TABLE pg_catalog.pg_replication_origin_status TO azure_pg_admin;

GRANT SELECT(remote_lsn) ON TABLE pg_catalog.pg_replication_origin_status TO azure_pg_admin;

GRANT SELECT(local_lsn) ON TABLE pg_catalog.pg_replication_origin_status TO azure_pg_admin;

GRANT SELECT(name) ON TABLE pg_catalog.pg_shmem_allocations TO azure_pg_admin;

GRANT SELECT(off) ON TABLE pg_catalog.pg_shmem_allocations TO azure_pg_admin;

GRANT SELECT(size) ON TABLE pg_catalog.pg_shmem_allocations TO azure_pg_admin;

GRANT SELECT(allocated_size) ON TABLE pg_catalog.pg_shmem_allocations TO azure_pg_admin;

GRANT SELECT(starelid) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(staattnum) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stainherit) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stanullfrac) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stawidth) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stadistinct) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stakind1) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stakind2) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stakind3) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stakind4) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stakind5) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(staop1) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(staop2) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(staop3) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(staop4) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(staop5) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stacoll1) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stacoll2) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stacoll3) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stacoll4) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stacoll5) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stanumbers1) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stanumbers2) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stanumbers3) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stanumbers4) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stanumbers5) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stavalues1) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stavalues2) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stavalues3) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stavalues4) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(stavalues5) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;

GRANT SELECT(oid) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;

GRANT SELECT(subdbid) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;

GRANT SELECT(subname) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;

GRANT SELECT(subowner) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;

GRANT SELECT(subenabled) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;

GRANT SELECT(subconninfo) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;

GRANT SELECT(subslotname) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;

GRANT SELECT(subsynccommit) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;

GRANT SELECT(subpublications) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;

