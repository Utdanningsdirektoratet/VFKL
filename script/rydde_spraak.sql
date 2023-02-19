-- Legg inn manglende rader i assessment.categorytextresources
IF NOT EXISTS(SELECT * FROM assessment.categorytextresources WHERE language_id_fk IN (4155)) THEN
	INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
	VALUES (1, 'design', 'Design/h�bbmim', 4155);
	INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
	VALUES (2, 'pedag�vg�lasj', 'Pedag�vg�lasj ja didaktalasj kvalitiehtta', 4155);
	INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
	VALUES (3, 'oahppopl�najt', 'G�ktu oahppopl�najt adnet', 4155);
END IF;
IF NOT EXISTS(SELECT * FROM assessment.categorytextresources WHERE language_id_fk IN (6203)) THEN
	INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
	VALUES (1, 'hammoe', 'Hammoe/hammoedimmie', 6203);
	INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
	VALUES (2, 'pedagogisk', 'Pedagogeles j�h didaktihkeles kvaliteete', 6203);
	INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
	VALUES (3, 'learoesoejkesje', '�tnoe learoesoejkesje-vierhkeste', 6203);
END IF;

UPDATE assessment.answertypetextresources
   SET language_id_fk = 1044
WHERE language_id_fk = 1083
  AND description in ('Helt enig', 'Delvis enig', 'Delvis uenig', 'Helt uenig', '�nsker ikke � svare/ikke aktuelt');

IF NOT EXISTS(SELECT * FROM assessment.answertypetextresources WHERE language_id_fk IN (1083)) THEN
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (1, 'heltenig', '�ibbas ovttaoaivilis', 1083);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (2, 'delvisenig', 'Belohahkii ovttaoaivilis', 1083);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (3, 'delvisuenig', 'Belohahkii sierramielala�', 1083);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (4, 'heltuenig', '�ibbas sierramielala�', 1083);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (5, 'ikkeaktuelt', 'In h�lit v�stidit / ii �igeguovdil', 1083);
END IF;

IF NOT EXISTS(SELECT * FROM assessment.answertypetextresources WHERE language_id_fk IN (6203)) THEN
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (1, 'heltenig', 'Eevre s�emes', 6203);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (2, 'delvisenig', 'S�emiesmearan s�emes', 6203);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (3, 'delvisuenig', 'S�emiesmearan ov-s�emes', 6203);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (4, 'heltuenig', 'Eevre ov-s�emes', 6203);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (5, 'ikkeaktuelt', 'Im s�jhth vaestiedidh/Ij sjy�htehke', 6203);
END IF;

IF NOT EXISTS(SELECT * FROM assessment.answertypetextresources WHERE language_id_fk IN (4155)) THEN
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (1, 'heltenig', 'Guorrasav �llu', 4155);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (2, 'delvisenig', 'Guorrasav muhtem mudduj', 4155);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (3, 'delvisuenig', 'Iv �llu guorrasa', 4155);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (4, 'heltuenig', 'Iv �vv�nis guorrasa', 4155);
	INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
	VALUES (4, 'ikkeaktuelt', 'Iv sid� v�sstedit / ij la �jggeguovddelis', 4155);
END IF;

