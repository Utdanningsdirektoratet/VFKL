-- Legg inn manglende rader i assessment.categorytextresources
IF NOT EXISTS(SELECT * FROM assessment.categorytextresources WHERE language_id_fk IN (4155)) THEN
	INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
	VALUES (1, 'design', 'Design/hábbmim', 4155);
	INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
	VALUES (2, 'pedagåvgålasj', 'Pedagåvgålasj ja didaktalasj kvalitiehtta', 4155);
	INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
	VALUES (3, 'oahppoplánajt', 'Gåktu oahppoplánajt adnet', 4155);
END IF;
IF NOT EXISTS(SELECT * FROM assessment.categorytextresources WHERE language_id_fk IN (6203)) THEN
	INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
	VALUES (1, 'hammoe', 'Hammoe/hammoedimmie', 6203);
	INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
	VALUES (2, 'pedagogisk', 'Pedagogeles jïh didaktihkeles kvaliteete', 6203);
	INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
	VALUES (3, 'learoesoejkesje', 'Åtnoe learoesoejkesje-vierhkeste', 6203);
END IF;

UPDATE assessment.answertypetextresources
   SET language_id_fk = 1044
WHERE language_id_fk = 1083
  AND description in ('Helt enig', 'Delvis enig', 'Delvis uenig', 'Helt uenig', 'ønsker ikke å svare/ikke aktuelt');

IF NOT EXISTS(SELECT * FROM assessment.answertypetextresources WHERE language_id_fk IN (1083)) THEN
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (1, 'heltenig', 'Áibbas ovttaoaivilis', 1083);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (2, 'delvisenig', 'Belohahkii ovttaoaivilis', 1083);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (3, 'delvisuenig', 'Belohahkii sierramielalaš', 1083);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (4, 'heltuenig', 'Áibbas sierramielalaš', 1083);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (5, 'ikkeaktuelt', 'In hálit vástidit / ii áigeguovdil', 1083);
END IF;

IF NOT EXISTS(SELECT * FROM assessment.answertypetextresources WHERE language_id_fk IN (6203)) THEN
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (1, 'heltenig', 'Eevre sïemes', 6203);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (2, 'delvisenig', 'Såemiesmearan sïemes', 6203);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (3, 'delvisuenig', 'Såemiesmearan ov-sïemes', 6203);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (4, 'heltuenig', 'Eevre ov-sïemes', 6203);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (5, 'ikkeaktuelt', 'Im sïjhth vaestiedidh/Ij sjyöhtehke', 6203);
END IF;

IF NOT EXISTS(SELECT * FROM assessment.answertypetextresources WHERE language_id_fk IN (4155)) THEN
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (1, 'heltenig', 'Guorrasav ållu', 4155);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (2, 'delvisenig', 'Guorrasav muhtem mudduj', 4155);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (3, 'delvisuenig', 'Iv ållu guorrasa', 4155);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (4, 'heltuenig', 'Iv åvvånis guorrasa', 4155);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (4, 'ikkeaktuelt', 'Iv sidá vásstedit / ij la ájggeguovddelis', 4155);
END IF;

