CREATE TABLE public."VersionInfo" (
    "Version" bigint NOT NULL,
    "AppliedOn" timestamp without time zone,
    "Description" character varying(1024)
);

INSERT INTO public."VersionInfo" ("Version", "AppliedOn", "Description")
VALUES (1, CURRENT_TIMESTAMP, 'Initialize Database' )