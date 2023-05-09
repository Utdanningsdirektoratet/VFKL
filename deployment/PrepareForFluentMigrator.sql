CREATE TABLE public."VersionInfo" (
	"Version" int8 NOT NULL,
	"AppliedOn" timestamp NULL,
	"Description" varchar(1024) NULL
);
CREATE UNIQUE INDEX "UC_Version" ON public."VersionInfo" USING btree ("Version");

INSERT INTO public."VersionInfo"
("Version", "AppliedOn", "Description")
VALUES(1, '2023-05-08 12:35:36.000', 'InitializeDatabase');