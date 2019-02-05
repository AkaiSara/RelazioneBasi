CREATE DATABASE IF NOT EXISTS LaSofiaDB;
USE LaSofiaDB;
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS fornitore;
DROP TABLE IF EXISTS prodotto;
DROP TABLE IF EXISTS uscita;
DROP TABLE IF EXISTS stipendio;
DROP TABLE IF EXISTS entrata;
DROP TABLE IF EXISTS personale;
DROP TABLE IF EXISTS turno;
DROP TABLE IF EXISTS svolgimento_turno;
DROP TABLE IF EXISTS ordine;
DROP TABLE IF EXISTS tavolo;
DROP TABLE IF EXISTS prenotazione;

-- tabella fornitore --
CREATE TABLE `fornitore` 
(
  `PartitaIva` varchar(11) PRIMARY KEY,
  `NomeAzienda` varchar(30) NOT NULL,
  `Telefono` varchar(9) NOT NULL,
  FOREIGN KEY (PartitaIva) REFERENCES prodotto(IvaFornitore)  
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO fornitore (PartitaIva, NomeAzienda, Telefono) VALUES 
(12345678901, 'Crocini', 049875634), -- carne --
(46274891029, 'Frutti di Giorgio', 0498713542), -- frutta e verdura -- 
(89231473829, 'SunMarket', 0498736453), -- pasta e formaggi --
(47361904938, 'Belli Freschi', 0498746352), -- pane --
(36271849284, 'Il Pescatore', 0498715986), -- pesce -- 
(09876543217, 'My American Market', 056281792), -- bevande -- 
(37281930273, 'CantinaVeneta', 0498725021); -- vini -- 

-- tabella prodotto --

CREATE TABLE `prodotto`
(
	`CodiceProdotto` integer PRIMARY KEY,
    `NomeProdotto` varchar(20) UNIQUE NOT NULL,
    `Marca` varchar(20),
    `quantita` integer NOT NULL CHECK (quantita >= 0),
    `Annata` integer,
    `DataScadenza` date,
    `Categoria` varchar(20) NOT NULL CHECK (Categoria in ('Cibo', 'Bevanda')),
    `Tipo` varchar(20) NOT NULL,
    `Prezzo` float NOT NULL,
    `IvaFornitore` varchar(11) NOT NULL
)   ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO prodotto (CodiceProdotto, NomeProdotto, Marca, quantita, Annata, DataScadenza, Categoria, Tipo, Prezzo, IvaFornitore) VALUES
(1111 , 'Finocchiona', NULL, 40, NULL, '2019-10-03', 'Cibo', 'Fresco', 8.50, 12345678901),
(2222, 'Giardiniera', NULL, 3, NULL, '2025-03-04', 'Cibo', 'Lunga Conservazione', 6.80, 12345678901),
(3333, 'Uova', NULL, 30, NULL, '2019-01-25', 'Cibo', 'Fresco', 1.31, 46274891029),
(4444, 'Spinaci', NULL, 5, NULL, '2019-02-26', 'Cibo', 'Fresco', 2.02, 89231473829),
(5555, 'Ricotta', 'Santa Lucia', 3, NULL, '2019-02-10', 'Cibo', 'Fresco', 1.01, 89231473829),
(6666, 'Prosciutto Crudo', NULL, 1, NULL, '2020-12-30', 'Cibo', 'Fresco', 13.35, 12345678901),
(7777, 'Tigelle', NULL, 10, NULL, '2020-04-02', 'Cibo', 'Fresco', 5.20, 47361904938),
(8888, 'Pane Bianco', NULL, 10, NULL, '2019-01-12', 'Cibo', 'Fresco', 5.50, 47361904938),
(9999, 'Baccalà', NULL, 3, NULL, '2020-01-01', 'Cibo', 'Surgelato', 1.5, 36271849284),
(1010, 'Radicchio', NULL, 4, NULL, '2019-02-02', 'Cibo', 'Fresco', 1.4, 46274891029),
(1212, 'Pancetta', NULL, 2, NULL, '2020-01-01', 'Cibo', 'Fresco', 8.75, 1234567890),
(1313, 'Brie', NULL, 5, NULL, '2019-03-04', 'Cibo', 'Fresco', 2.20, 89231473829),
(1414, 'Polenta', NULL, 2, NULL, '2020-05-05', 'Cibo', 'Lunga Conservazione', 2.29, 89231473829),
(1515, 'Tagliatelle', NULL, 6, NULL, '2019-09-08', 'Cibo', 'Fresco', 1.00, 89231473829),
(1616, 'Farina di castagne', NULL, 1, NULL, '2020-07-15', 'Cibo', 'Lunga Conservazione', 1.50, 89231473829),
(1717, 'Porcini', NULL, 20, NULL, 4, NULL, '2020-05-08', 'Cibo', 'Surgelato', 2.50, 46274891029),
(1818, 'Riso', NULL, 4, NULL, '2020-10-10', 'Cibo', 'Lunga Conservazione', 1.56, 89231473829),
(1919, 'Branzino', NULL, 10, NULL, '2019-12-04', 'Cibo', 'Surgelato', 2.36, 36271849284),
(2121, 'Coca Cola', 'Coca Cola', 90, NULL, '2025-01-01', 'Bevanda', 'Analcolica', 3.52, 09876543217),
(2020, 'Coca Cola Zero', 'Coca Cola', 90, NULL, '2025-01-01', 'Bevanda', 'Analcolica',  3.51, 09876543217),
(2323, 'Bionda', 'Leffe', 35, NULL, '2024-03-03', 'Bevanda', 'Birra', 2.25, 09876543217),
(2424, 'Rossa', 'Augustiner', 20, NULL, '2024-02-02', 'Bevanda', 'Birra', 2.53, 09876543217),
(2525, 'Carmenere', 'Alla Costiera', 6, 2008, NULL, 'Bevanda', 'Vino', 20.21, 37281930273),
(2626, 'Valpolicella', 'Terre di Terrarossa', 15, 2007, NULL, 'Bevanda', 17.54, 37281930273),
(2727, 'Pinot Nero', 'Sandro del Bruno', 6, 2008, NULL, 'Bevanda', 'Vino', 20.78, 37281930273);

-- tabella uscita --

CREATE TABLE `uscita` 
(
  `CodiceUscita` integer PRIMARY KEY,
  `Causale` varchar(20) NOT NULL,
  `DataUscita` date NOT NULL,
  `Costo` float NOT NULL,
  FOREIGN KEY(Costo, Causale) REFERENCES prodotto(Prezzo, NomeProdotto),
  FOREIGN KEY(CodiceUscita) REFERENCES stipendio(CodiceUscita),
  FOREIGN KEY (Costo) REFERENCES personale(Stipendio)
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO uscita (CodiceUscita, Causale, DataUscita, Costo) VALUES
(1111, 'Finocchiona', '2019-03-02', 8.50),
(2222, 'Coca Cola', '2019-01-10', 3.52),
(3333, 'Finocchiona', '2019-01-10', 8.50),
(4444, 'Branzino', '2019-01-10', 2.36),
(54646,'Stipendio' , '2019-03-02', 3000),
(5555, 'Riso', '2019-03-02', 1.56);

-- tabella stipendio --

CREATE TABLE `stipendio` 
(
  `CodiceUscita` integer NOT NULL,
  `CodiceFiscale` varchar(20) NOT NULL,
   PRIMARY KEY (CodiceUscita, CodiceFiscale)
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO stipendio (CodiceUscita, CodiceFiscale) VALUES
(54646, 'RGHNNA26R87T245R'),
(53744, 'TNEGGT75R32Z356W'),
(29478, 'CSFMSY23S51T224G'),
(35262, 'PTISSG56F42T777D'),
(63527, 'GGWYYR42R61K999S');

-- tabella entrata --
CREATE TABLE `entrata` 
(
  `CodiceEntrata` integer PRIMARY KEY
  REFERENCES ordine(ContoTotale),
  `Costo`float NOT NULL,
  `DataEntrata` date NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO entrata (CodiceEntrata, Costo, DataEntrata) VALUES
(1111, 50, '2019-01-13'),
(2222, 45.5, '2019-01-13'),
(3333, 36.76, '2019-01-10'),
(4444, 27, '2019-01-10');

-- tabella personale --
CREATE TABLE `personale` 
(
  `CodiceFiscale` varchar(20) PRIMARY KEY
  REFERENCES stipendio(CodiceFiscale),
  `Nome` varchar(20) NOT NULL,
  `Cognome` varchar(20) NOT NULL,
  `GiornoLibero` varchar(10) NOT NULL,
  `Ruolo` varchar(20) NOT NULL CHECK (ruolo in ('Cuoco', 'Cameriere', 'Sommelier')),
  `Stipendio` float NOT NULL,
  UNIQUE(Nome, Cognome),
  FOREIGN KEY (CodiceFiscale) REFERENCES ordine(CodiceCameriere)
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO personale (CodiceFiscale, Nome, Cognome, GiornoLibero, Ruolo, Stipendio) VALUES
('RGHNNA26R87T245R', 'Anna', 'Rossi', 'Martedì', 'Cameriere', 3000),
('TNEGGT75R32Z356W', 'Massimo', 'Bertocco', 'Mercoledì', 'Cuoco', 1500),
('CSFMSY23S51T224G', 'Gianni', 'Banzato', 'Lunedì', 'Sommelier', 2000),
('PTISSG56F42T777D', 'Maria', 'Franceschi', 'Giovedì', 'Cameriere', 2000),
('GGWYYR42R61K999S', 'Fabio', 'Marchi', 'Venerdì', 'Cuoco', 1500);

-- tabella turno --

CREATE TABLE `turno` 
(
  `Giorno` varchar(10) PRIMARY KEY
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO turno (Giorno) VALUES
('Lunedì'),
('Martedì'),
('Mercoledì'),
('Giovedì'),
('Venerdì'),
('Sabato'),
('Domenica');

-- tabella svolgimento turno --

CREATE TABLE `svolgimento_turno` 
(
  `CodiceFiscale` varchar(20) NOT NULL
  REFERENCES personale(CodiceFiscale),
  `Giorno` varchar(10) NOT NULL
  REFERENCES turno(Giorno),
  PRIMARY KEY (CodiceFiscale, Giorno)
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO svolgimento (CodiceFiscale, Giorno) VALUES
('RGHNNA26R87T245R', 'Lunedì'),
('RGHNNA26R87T245R', 'Mercoledì'),
('RGHNNA26R87T245R', 'Giovedì'),
('RGHNNA26R87T245R', 'Venerdì'),
('RGHNNA26R87T245R', 'Sabato'),
('RGHNNA26R87T244R', 'Domenica'),
('TNEGGT75R32Z356W', 'Lunedì'),
('TNEGGT75R32Z356W', 'Martedì'),
('TNEGGT75R32Z356W', 'Giovedì'),
('TNEGGT75R32Z356W', 'Venerdì'),
('TNEGGT75R32Z356W', 'Sabato'),
('CSFMSY23S51T224G', 'Martedì'),
('CSFMSY23S51T224G', 'Mercoledì'),
('CSFMSY23S51T224G', 'Giovedì'),
('CSFMSY23S51T224G', 'Venerdì'),
('CSFMSY23S51T224G', 'Sabato'),
('CSFMSY23S51T224G', 'Domenica'),
('PTISSG56F42T777D', 'Martedì'),
('PTISSG56F42T777D', 'Mercoledì'),
('PTISSG56F42T777D', 'Sabato'),
('PTISSG56F42T777D', 'Domenica'),
('GGWYYR42R61K999S', 'Lunedì'),
('GGWYYR42R61K999S', 'Martedì'),
('GGWYYR42R61K999S', 'Mercoledì'),
('GGWYYR42R61K999S', 'Giovedì'),
('GGWYYR42R61K999S', 'Sabato'),
('GGWYYR42R61K999S', 'Domenica');

-- tabella ordine --

CREATE TABLE `ordine` 
(
  `CodiceOrdine` integer PRIMARY KEY,
  `NumeroPersone` integer NOT NULL,
  `Giorno` date NOT NULL,
  `Ora` time NOT NULL,
  `ContoTotale` float NOT NULL,
  `NumeroTavolo` integer NOT NULL
  REFERENCES tavolo(NumeroTavolo),
  `CodiceCameriere` varchar(20) NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO ordine (CodiceOrdine, NumeroPersone, Giorno, Ora, ContoTotale, NumeroTavolo, CodiceCameriere) VALUES
(12345, 4, '2019-01-01', '20:20:00', 60.45, 13, RGHNNA26R87T245R),
(12346, 2, '2019-01-13', '20:30:00', 50, 10, RGHNNA26R87T245R),
(12347, 3, '2019-01-10', '19:20:00', 36.76, 5, TNEGGT75R32Z356W),
(12348, 4, '2019-01-13', '21:20:00', 40.76, 2, TNEGGT75R32Z356W);

-- tabella tavolo --

CREATE TABLE `tavolo` 
(
  `NumeroTavolo` integer PRIMARY KEY CHECK (NumeroTavolo <= 13),
  `Coperti` integer NOT NULL CHECK (Coperti <= 10)
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO tavolo (NumeroTavolo, Coperti) VALUES
(1, 3),
(2, 8),
(3, 2),
(4, 4),
(5, 4),
(6, 2),
(7, 4),
(8, 2),
(9, 2),
(10, 4),
(11, 10),
(12, 2),
(13, 4);

-- tabella prenotazione --

CREATE TABLE `prenotazione` 
(
  `CodicePrenotazione` integer PRIMARY KEY,
  `NumeroCoperti` integer NOT NULL,
  `Cliente` varchar(20) NOT NULL,
  `Giorno` date NOT NULL,
  `Ora` time NOT NULL,
  `NumeroTavolo` integer NOT NULL
  REFERENCES tavolo(NumeroTavolo)
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO prenotazione (CodicePrenotazione, NumeroCoperti, Cliente, Giorno, Ora, NumeroTavolo) VALUES
(11111, 4, 'Marisa', '2019-02-20', '13:00:00', 10),
(22222, 3, 'Elisa', '2019-02-20', '13:30:00', 7),
(33333, 2, 'Anna', '2019-02-20', '13:00:00', 6),
(44444, 4, 'Erica', '2019-02-10', '19:00:00', 10),
(55555, 7, 'Marco', '2019-02-10', '13:00:00', 11);

-- operazione 1: inserimento nuovo prodotto --
DELIMITER |
CREATE PROCEDURE nuovoProdotto (IN codice INTEGER, IN nome VARCHAR(20), IN marca VARCHAR(20), IN quantita INTEGER, IN scadenza DATE, IN annata DATE, IN categoria VARCHAR(20), IN tipo VARCHAR(20), IN prezzo FLOAT, IN fornitore VARCHAR(11))
BEGIN
    START TRANSACTION;
    INSERT INTO prodotto (CodiceProdotto, NomeProdotto, Marca, quantita, Annata, DataScadenza, Categoria, Tipo, Prezzo, IvaFornitore) VALUES
    (codice, nome, marca, quantita, annata, scadenza, categoria, tipo, prezzo, fornitore);
    COMMIT;
END |
DELIMITER ;

-- operazione 2: cencellazione di un prodotto --
DELIMITER |
CREATE PROCEDURE eliminaProdotto (IN codice INTEGER)
BEGIN
    DELETE FROM prodotto WHERE CodiceProdotto=codice;
END |
DELIMITER ;

-- operazione 3: modificare la quantita di un prodotto --
DELIMITER |
CREATE PROCEDURE modificaquantita (IN codice INTEGER, IN quantita INTEGER)
BEGIN
    UPDATE prodotto AS P
    SET P.quantita = P.quantita + quantita
    WHERE P.CodiceProdotto=codice;
END |
DELIMITER ;
    

-- operazione 4: inserimento di una nuova prenotazione --
DELIMITER |
CREATE PROCEDURE nuovaPrenotazione (IN codice INTEGER, IN coperti INTEGER, IN nomeCliente VARCHAR(20), IN giorno DATE, IN ora DATE, IN tavolo INTEGER)
BEGIN
    START TRANSACTION;
    INSERT INTO prenotazione(CodicePrenotazione, NumeroCoperti, Cliente, Giorno, Ora, NumeroTavolo) VALUES
    (codice, coperti, nomeCliente, giorno, ora, tavolo);
    COMMIT;
END |
DELIMITER ;

-- operazione 5: cancella prenotazione --
DELIMITER |
CREATE PROCEDURE eliminaPrenotazione (IN codice INTEGER)
BEGIN
    DELETE FROM prenotazione WHERE CodicePrenotazione=codice;
END |
DELIMITER ;

-- operazione 6: inserisci nuovo dipendente --
DELIMITER |
CREATE PROCEDURE nuovoDipendente (IN cf VARCHAR(20), IN nome VARCHAR(20), IN cognome VARCHAR(20), IN giorno_libero VARCHAR(10), IN ruolo VARCHAR(20), IN stipendio FLOAT)
BEGIN
    INSERT INTO personale (CodiceFiscale, Nome, Cognome, GiornoLibero, Ruolo, Stipendio) VALUES
    (cf, nome, cognome, giorno_libero, ruolo, stipendio);
END |
DELIMITER ;

-- operazione 7: licenzia dipendente --
DELIMITER |
CREATE PROCEDURE licenziaDipendente (IN dipendente VARCHAR(20))
BEGIN
    DELETE FROM personale WHERE CodiceFiscale=dipendente;
END |
DELIMITER ;

-- operazione 8: modifica turno di lavoro --
DELIMITER |
CREATE PROCEDURE modificaTurno (IN giorno VARCHAR(10), IN dipendente VARCHAR(20))
BEGIN
    UPDATE svolgimento_turno SET CodiceFiscale=dipendente
    WHERE Giorno=giorno;
END |
DELIMITER ;

-- operazione 9:  
-- stampa il nome, il codice e la quantità di tutti i cibi con data di scadenza a febbraio 2019 in ordine cresente di data --

CREATE VIEW CibiInScadenza as
SELECT DISTINCT C.CodiceProdotto, C.NomeProdotto, C.quantita
FROM prodotto AS C
WHERE C.Categoria = 'Cibo' AND DataScadenza >= '2019-02-01' AND DataScadenza <= '2019-02-28'
ORDER BY DataScadenza;

-- operazione 10:
-- stampa il codice, il nome, la marca e l'annata di tutti i vini con annata risalente a massimo il 2008 e prezzo inferiore a 20 euro
-- ordinati per prezzo crescente --

CREATE VIEW viniEconomici as
SELECT DISTINCT V.CodiceProdotto, V.NomeProdotto, V.Marca, V.Annata
FROM prodotto AS V
WHERE V.Categoria='Bevanda' AND V.Tipo='Vino' AND V.Annata <= 2008 AND V.Prezzo < 20
ORDER BY Prezzo;

-- operazione 11:
-- stampa il numero dei tavoli liberi nel giorno 20/02/2019 con almeno 3 coperti 

CREATE VIEW tavoliLberi as
SELECT T.NumeroTavolo
FROM tavolo AS T
WHERE T.Coperti >= 3 AND T.NumeroTavolo NOT IN 
(SELECT P.NumeroTavolo FROM prenotazione AS P WHERE P.Giorno='2019-02-20');

-- operazione 12:
-- stampa nome e cognome di tutti i dipendenti di turno il lunedì --

CREATE VIEW dipendentiDiTurno as
SELECT DISTINCT P.Nome, P.Cognome
FROM personale AS P, svolgimentoTurno AS T
WHERE T.CodiceFiscale=P.CodiceFiscale AND T.Giorno = 'Lunedì';

-- operazione 13:
-- calcola il guadagno mensile dato dalla differenza tra la somma delle entrate e la somma delle uscite --

DELIMITER |
CREATE FUNCTION guadagnoTot (mese DATE) RETURNS FLOAT
BEGIN 
    DECLARE Guadagno FLOAT;
    DECLARE entrate FLOAT;
    DECLARE uscite FLOAT;
    
    SELECT SUM(U.Costo) INTO uscite
    FROM uscita AS U
    WHERE U.DataUscita >= '2019' + MONTH(mese) + '01' AND U.DataUscita <= '2019' + MONTH(mese) + '31';
    
    SELECT SUM(E.Costo) INTO entrate 
    FROM entrata AS E
    WHERE E.DataEntrata >= '2019' + MONTH(mese) + '01' AND E.DataEntrata <= '2019' + MONTH(mese) + '31';
    
    SET Guadagno = entrate-uscite;
    
    RETURN Guadagno;
    
END |

-- operazione 14:
-- trova il cameriere che effettua più ordini in media al giorno per decidere se promuoverlo o no --

CREATE FUNCTION promozione (mese DATE, cameriere VARCHAR(20)) RETURNS BOOL
BEGIN
    DECLARE ordini INTEGER;
    DECLARE promozione BOOL;
    
    SELECT COUNT(*) INTO ordini
    FROM ordine AS O
    WHERE O.CodiceCameriere=cameriere AND O.Giorno >= '2019' + MONTH(mese) + '01' AND O.giorno <= '2019' + MONTH(mese) + '31';
    
    IF ordini >= 20 THEN SET promozione=true;
    ELSE SET promozione=FALSE;
    END IF;
    
    RETURN promozione;
    
END |

-- TRIGGER 1
-- un dipendente non può lavorare nel suo giorno libero--
CREATE TRIGGER noGiorniLiberi
BEFORE INSERT ON svolgimentoTurno
FOR EACH ROW
BEGIN
    DECLARE giornoLibero VARCHAR(10);
    
    SELECT P.GiornoLibero INTO giornoLibero
    FROM personale AS P;
    
    IF giornoLibero NOT IN (SELECT T.Giorno FROM personale AS P, svolgimentoTurno AS T WHERE P.CodiceFiscale=T.CodiceFiscale)
    THEN CALL modificaTurno(new.giorno, new.dipendente);
    END IF;
END |
DELIMITER ;

-- TRIGGER 2
-- un dipenten non può svolgere più di 6 turni a settimana --
DELIMITER |
CREATE TRIGGER MaxTurni
BEFORE INSERT ON svolgimentoTurno
FOR EACH ROW
BEGIN
    DECLARE turni INTEGER;
    
    SELECT COUNT(CodiceFiscale) INTO turni
    FROM svolgimentoTurno
    WHERE CodiceFiscale=new.CodiceFiscale;
    
    IF turni <= 6 THEN CALL inserisciTurno;
    END IF;
    
END |
DELIMITER ;

-- TRIGGER 3
-- Un cliente non può prenotare un tavolo già prenotato. --
DELIMITER |
CREATE TRIGGER tavoliPrenotati
BEFORE INSERT ON prenotazione
FOR EACH ROW
BEGIN
    IF new.tavolo NOT IN (SELECT P.tavolo FROM prenotazione AS P)
    THEN CALL inserisciPrenotazione;
    END IF;
END |
DELIMITER ;

SET FOREIGN_KEY_CHECKS=1;

