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
  `PartitaIva` char(11) PRIMARY KEY,
  `NomeAzienda` varchar(30) NOT NULL,
  `Telefono` char(9) NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO fornitore (PartitaIva, NomeAzienda, Telefono) VALUES 
(12345678901, 'Crocini', 049875634), 
(46274891029, 'Frutti di Giorgi', 0498713542),
(89231473829, 'SunMarket', 0498736453), 
(47361904938, 'Belli Freschi', 0498746352), 
(36271849284, 'Il Pescatore', 0498715986), 
(09876543217, 'My American Market', 056281792), 
(37281930273, 'CantinaVeneta', 0498725021);  

-- tabella prodotto --

CREATE TABLE `prodotto`
(
	`CodiceProdotto` bigint PRIMARY KEY,
    `NomeProdotto` varchar(20) UNIQUE NOT NULL,
    `Marca` varchar(20),
    `Quantita` integer NOT NULL CHECK (Quantita >= 0),
    `Annata` bigint,
    `DataScadenza` date,
    `Categoria` varchar(20) NOT NULL CHECK (Categoria in ('Cibo', 'Bevanda')),
    `Tipo` varchar(20) NOT NULL,
    `Prezzo` decimal(8,2) NOT NULL
    `IvaFornitore` char(11) NOT NULL,
    FOREIGN KEY (IvaFornitore) REFERENCES fornitore(PartitaIva), 
    FOREIGN KEY (Prezzo) REFERENCES uscita(CodiceUscita)  
)   ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO prodotto (CodiceProdotto, NomeProdotto, Marca, Quantita, Annata, DataScadenza, Categoria, Tipo, Prezzo, IvaFornitore) VALUES
(1000 , 'Finocchiona', NULL, 40, NULL, '2019-10-03', 'Cibo', 'Fresco', 8.50, '12345678901'),
(1100, 'Giardiniera', NULL, 3, NULL, '2025-03-04', 'Cibo', 'Lunga Conservazione', 6.80, '12345678901'),
(1200, 'Uova', NULL, 30, NULL, '2019-01-25', 'Cibo', 'Fresco', 1.31, '46274891029'),
(1300, 'Spinaci', NULL, 5, NULL, '2019-02-26', 'Cibo', 'Fresco', 2.02, '89231473829'),
(1400, 'Ricotta', NULL, 3, NULL, '2019-02-10', 'Cibo', 'Fresco', 1.01, '89231473829'),
(1500, 'Prosciutto Crudo', NULL, 1, NULL, '2020-12-30', 'Cibo', 'Fresco', 13.35, '12345678901'),
(1600, 'Tigelle', NULL, 10, NULL, '2020-04-02', 'Cibo', 'Fresco', 5.20, '47361904938'),
(1700, 'Pane Bianco', NULL, 10, NULL, '2019-01-12', 'Cibo', 'Fresco', 5.50, '47361904938'),
(1800, 'Baccalà', NULL, 3, NULL, '2020-01-01', 'Cibo', 'Surgelato', 1.50, '36271849284'),
(1900, 'Radicchio', NULL, 4, NULL, '2019-02-02', 'Cibo', 'Fresco', 1.40, '46274891029'),
(2000, 'Pancetta', NULL, 2, NULL, '2020-01-01', 'Cibo', 'Fresco', 8.75, '12345678901'),
(2100, 'Brie', NULL, 5, NULL, '2019-03-04', 'Cibo', 'Fresco', 2.20, '89231473829'),
(2200, 'Polenta', NULL, 2, NULL, '2020-05-05', 'Cibo', 'Lunga Conservazione', 2.29, '89231473829'),
(2300, 'Tagliatelle', NULL, 6, NULL, '2019-09-08', 'Cibo', 'Fresco', 1.00, '89231473829'),
(2400, 'Farina di castagne', NULL, 1, NULL, '2020-07-15', 'Cibo', 'Lunga Conservazione', 1.50, '89231473829'),
(2500, 'Porcini', NULL, 20, NULL, '2020-05-08', 'Cibo', 'Surgelato', 2.50, '46274891029'),
(2600, 'Riso', NULL, 4, NULL, '2020-10-10', 'Cibo', 'Lunga Conservazione', 1.56, '89231473829'),
(2700, 'Branzino', NULL, 10, NULL, '2019-12-04', 'Cibo', 'Surgelato', 2.36, '36271849284'),
(2800, 'Cappuccio viola', NULL, 4, NULL, '2019-10-01', 'Cibo', 'Fresco', 3.50, '46274891029'),
(2900, 'Caprino', NULL, 2, NULL, '2019-02-01', 'Cibo', 'Fresco', 1.50, '89231473829'),
(3000, 'Cipolla rossa', NULL, 10, NULL, '2019-04-02', 'Cibo', 'Fresco', 1.32, '46274891029'),
(3100, 'Acciughe', NULL, 60, NULL, '2020-01-01', 'Cibo', 'Lunga Conservazione', 4.00, '12345678901'),
(3200, 'Gamberi', NULL, 10, NULL, '2020-01-01', 'Cibo', 'Surgelato', 3.40, '36271849284'),
(3300, 'Patate', NULL, 10, NULL, '2019-04-02', 'Cibo', 'Fresco', 2.23, '46274891029'),
(3400, 'Pelati', NULL, 25, NULL, '2021-02-01', 'Cibo', 'Lunga Conservazione', 1.43, '12345678901'),
(1111, 'Coca Cola', 'Coca Cola', 90, NULL, '2025-01-01', 'Bevanda', 'Analcolica', 2.50, '09876543217'),
(1212, 'Coca Cola Zero', 'Coca Cola', 90, NULL, '2025-01-01', 'Bevanda', 'Analcolica',  3.51, '09876543217'),
(1313, 'Bionda', 'Leffe', 35, NULL, '2024-03-03', 'Bevanda', 'Birra', 2.25, '09876543217'),
(1414, 'Rossa', 'Augustiner', 20, NULL, '2024-02-02', 'Bevanda', 'Birra', 2.53, '09876543217'),
(1515, 'Carmenere', 'Alla Costiera', 6, 2008, NULL, 'Bevanda', 'Vino', 20.21, '37281930273'),
(1616, 'Valpolicella', 'Terre di Terrarossa', 15, 2007, NULL, 'Bevanda','Vino', 17.54, '37281930273'),
(1717, 'Pinot Nero', 'Sandro del Bruno', 6, 2008, NULL, 'Bevanda', 'Vino', 20.78, '37281930273'),
(1818, 'Lambrusco', 'Barbolini', 5, 2010, NULL, 'Bevanda', 'Vino', 18.00, '37281930273'),
(1919, 'Zibibbo', 'Alagna', 2, 2009, NULL, 'Bevanda', 'Vino', 10.00, '37281930273'),
(2121, 'Moscato', 'Ambar Florio', 4, 2019, NULL, 'Bevanda', 'Vino', 21.00, '37281930273'),
(2222, 'Prosecco', 'Ca del Sole', 20, 2017, NULL, 'Bevanda', 'Vino', 18.00, '37281930273');

-- tabella uscita --

CREATE TABLE `uscita` 
(
  `CodiceUscita` bigint PRIMARY KEY,
  `Causale` varchar(40) NOT NULL,
  `DataUscita` date NOT NULL,
  `Costo` decimal(8,2) NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO uscita (CodiceUscita, Causale, DataUscita, Costo) VALUES
(1111, 'Finocchiona', '2019-03-02', 8.50),
(2222, 'Coca Cola', '2019-01-10', 3.52),
(3333, 'Tagliatelle', '2019-01-10', 8.00),
(4444, 'Branzino', '2019-01-10', 2.36),
(5555, 'Riso', '2019-03-02', 1.56),
(1222, 'Baccala', '2019-03-02', 1.50),
(1333, 'Coca Cola', '2019-01-10', 3.52),
(1666, 'Finocchiona', '2019-01-10', 8.50),
(1444, 'Baccala', '2019-01-10', 1.50),
(1555, 'Riso', '2019-03-02', 1.56),
(1777, 'Valpolicella', '2019-03-02', 17.54),
(1888, 'Coca Cola', '2019-01-10', 3.52),
(1999, 'Bionda', '2019-01-10', 2.25),
(2111, 'Branzino', '2019-01-10', 2.36),
(2333, 'Bionda', '2019-03-02', 2.25),
(54646,'Stipendio' , '2019-03-02', 3000),
(53744,'Stipendio' , '2019-03-02', 1500),
(29478,'Stipendio' , '2019-03-02', 2000),
(35262,'Stipendio' , '2019-03-02', 2000),
(63527,'Stipendio', '2019-03-02', 1500);

-- tabella stipendio --

CREATE TABLE `stipendio` 
(
  `CodiceUscita` bigint NOT NULL,
  `CodiceFiscale` char(16) NOT NULL,
  FOREIGN KEY (CodiceUscita) REFERENCES uscita(CodiceUscita),
  FOREIGN KEY (CodiceFiscale) REFERENCES personale(CodiceFiscale),
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
  `CodiceEntrata` bigint PRIMARY KEY,
  `Costo`decimal(8,2) NOT NULL,
  `DataEntrata` date NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO entrata (CodiceEntrata, Costo, DataEntrata) VALUES
(1111, 50.00, '2019-01-10'),
(2222, 60.45, '2019-01-10'),
(3333, 36.76, '2019-01-13'),
(4444, 40.76, '2019-01-13'),
(5555, 70.00, '2019-01-10'),
(6666, 30.00, '2010-01-10'),
(7777, 75.00, '2019-01-10'),
(8888, 50.00, '2019-01-10'),
(9999, 62.45, '2019-01-03'),
(1222, 59.39, '2019-01-12'),
(1333, 56.86, '2019-01-20'),
(1444, 25.30, '2019-01-14'),
(1555, 105.25, '2019-01-13'),
(1666, 87.45, '2019-01-01'),
(1777, 35.00, '2019-01-15'),
(1888, 49.34, '2019-01-08');

-- tabella personale --
CREATE TABLE `personale` 
(
  `CodiceFiscale` char(16) PRIMARY KEY,
  `Nome` varchar(20) NOT NULL,
  `Cognome` varchar(20) NOT NULL,
  `GiornoLibero` varchar(10) NOT NULL,
  `Ruolo` varchar(20) NOT NULL CHECK (ruolo in ('Cuoco', 'Cameriere', 'Sommelier')),
  UNIQUE(Nome, Cognome)
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO personale (CodiceFiscale, Nome, Cognome, GiornoLibero, Ruolo) VALUES
('RGHNNA26R87T245R', 'Anna', 'Rossi', 'Martedì', 'Cameriere'),
('TNEGGT75R32Z356W', 'Massimo', 'Bertocco', 'Mercoledì', 'Cuoco'),
('CSFMSY23S51T224G', 'Gianni', 'Banzato', 'Lunedì', 'Sommelier'),
('PTISSG56F42T777D', 'Maria', 'Franceschi', 'Giovedì', 'Cameriere'),
('GGWYYR42R61K999S', 'Fabio', 'Marchi', 'Venerdì', 'Cuoco');

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
  `CodiceFiscale` char(16) NOT NULL,
  `Giorno` varchar(10) NOT NULL,
  PRIMARY KEY (CodiceFiscale, Giorno),
  FOREIGN KEY (CodiceFiscale) REFERENCES personale(CodiceFiscale),
  FOREIGN KEY (Giorno) REFERENCES turno(Giorno),
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO svolgimento_turno (CodiceFiscale, Giorno) VALUES
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
  `CodiceOrdine` bigint PRIMARY KEY,
  `NumeroPersone` integer NOT NULL,
  `Giorno` date NOT NULL,
  `Ora` time NOT NULL,
  `ContoTotale` decimal(8,2) NOT NULL,
  `NumeroTavolo` integer NOT NULL,
  `CodiceCameriere` char(16) NOT NULL,
  FOREIGN KEY (CodiceCameriere) REFERENCES personale(CodiceFiscale),
  FOREIGN KEY (NumeroTavolo) REFERENCES tavolo(NumeroTavolo),
  FOREIGN KEY (ContoTotale) REFERENCES entrate(CodiceEntrata)
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO ordine (CodiceOrdine, NumeroPersone, Giorno, Ora, ContoTotale, NumeroTavolo, CodiceCameriere) VALUES
(12345, 4, '2019-01-10', '20:20:00', 60.45, 13, 'RGHNNA26R87T245R'),
(12346, 2, '2019-01-10', '20:30:00', 50.00, 10, 'RGHNNA26R87T245R'),
(12347, 3, '2019-01-13', '19:20:00', 36.76, 5, 'TNEGGT75R32Z356W'),
(12348, 8, '2019-01-13', '21:20:00', 105.25, 2, 'TNEGGT75R32Z356W'),
(12349, 6, '2019-01-01', '20:15:00', 87.45, 15, 'RGHNNA26R87T245R'),
(12350, 2, '2019-01-15', '21:30:00', 35.00, 19, 'RGHNNA26R87T245R'),
(12351, 3, '2019-01-08', '19:20:00', 49.34, 14, 'TNEGGT75R32Z356W'),
(12352, 3, '2019-01-13', '12:15:00', 40.76, 14, 'TNEGGT75R32Z356W'),
(12353, 4, '2019-01-03', '13:20:00', 62.45, 17, 'RGHNNA26R87T245R'),
(12354, 4, '2019-01-12', '13:15:00', 59.39, 20, 'RGHNNA26R87T245R'),
(12355, 4, '2019-01-20', '19:30:00', 56.86, 7, 'TNEGGT75R32Z356W'),
(12356, 2, '2019-01-14', '20:20:00', 25.30, 16, 'TNEGGT75R32Z356W');

-- tabella tavolo --

CREATE TABLE `tavolo` 
(
  `NumeroTavolo` integer PRIMARY KEY CHECK (NumeroTavolo <= 20),
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
(13, 2),
(14, 3),
(15, 6),
(16, 2),
(17, 4),
(18, 5),
(19, 2),
(20, 4);

-- tabella prenotazione --

CREATE TABLE `prenotazione` 
(
  `CodicePrenotazione` bigint PRIMARY KEY,
  `NumeroCoperti` integer NOT NULL REFERENCES tavolo(Coperti),
  `Cliente` varchar(20) NOT NULL,
  `Giorno` date NOT NULL,
  `Ora` time NOT NULL,
  `NumeroTavolo` integer NOT NULL,
   FOREIGN KEY (NumeroTavolo) REFERENCES tavolo(NumeroTavolo)
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO prenotazione (CodicePrenotazione, NumeroCoperti, Cliente, Giorno, Ora, NumeroTavolo) VALUES
(11111, 4, 'Marisa', '2019-02-20', '13:00:00', 10),
(22222, 3, 'Elisa', '2019-02-20', '13:30:00', 7),
(33333, 2, 'Anna', '2019-02-20', '12:00:00', 6),
(44444, 4, 'Erica', '2019-02-10', '19:00:00', 10),
(55555, 7, 'Marco', '2019-02-10', '21:00:00', 2),
(66666, 2, 'Francesco', '2019-02-16', '20:30:00', 9),
(77777, 3, 'Leonardo', '2019-02-15', '13:30:00', 10),
(88888, 2, 'Alessandro', '2019-02-08', '13:40:00', 16),
(99999, 5, 'Lorenzo', '2019-02-02', '19:40:00', 18),
(12222, 6, 'Mattia', '2019-02-05', '14:10:00', 15),
(13333, 4, 'Andrea', '2019-02-06', '13:00:00', 4),
(14444, 10, 'Sara', '2019-02-21', '13:30:00', 11),
(15555, 2, 'Giulia', '2019-02-14', '12:50:00', 8),
(16666, 4, 'Gabriele', '2019-02-15', '20:00:00', 17),
(17777, 6, 'Riccardo', '2019-02-13', '20:15:00', 15);

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

-- operazione 2: modificare la quantita di un prodotto --
DELIMITER |
CREATE PROCEDURE modificaquantita (IN codice INTEGER, IN quantita INTEGER)
BEGIN
    UPDATE prodotto AS P
    SET P.quantita = P.quantita + quantita
    WHERE P.CodiceProdotto=codice;
END |
DELIMITER ;
    

-- operazione 3: inserimento di una nuova prenotazione --
DELIMITER |
CREATE PROCEDURE nuovaPrenotazione (IN codice INTEGER, IN coperti INTEGER, IN nomeCliente VARCHAR(20), IN giorno DATE, IN ora DATE, IN tavolo INTEGER)
BEGIN
    START TRANSACTION;
    INSERT INTO prenotazione(CodicePrenotazione, NumeroCoperti, Cliente, Giorno, Ora, NumeroTavolo) VALUES
    (codice, coperti, nomeCliente, giorno, ora, tavolo);
    COMMIT;
END |
DELIMITER ;

-- operazione 4: cancella prenotazione --
DELIMITER |
CREATE PROCEDURE eliminaPrenotazione (IN codice INTEGER)
BEGIN
    DELETE FROM prenotazione WHERE CodicePrenotazione=codice;
END |
DELIMITER ;

-- operazione 5: inserisci nuovo dipendente --
DELIMITER |
CREATE PROCEDURE nuovoDipendente (IN cf VARCHAR(20), IN nome VARCHAR(20), IN cognome VARCHAR(20), IN giorno_libero VARCHAR(10), IN ruolo VARCHAR(20), IN stipendio FLOAT)
BEGIN
    INSERT INTO personale (CodiceFiscale, Nome, Cognome, GiornoLibero, Ruolo, Stipendio) VALUES
    (cf, nome, cognome, giorno_libero, ruolo, stipendio);
END |
DELIMITER ;


-- operazione 6: modifica turno di lavoro --
DELIMITER |
CREATE PROCEDURE modificaTurno (IN giorno VARCHAR(10), IN dipendente VARCHAR(20))
BEGIN
    UPDATE svolgimento_turno SET CodiceFiscale=dipendente
    WHERE Giorno=giorno;
END |
DELIMITER ;

-- operazione 7: mostra codice, nome e quantità di tutti i prodotti che sono cibi e che scadono entro il 28 febbraio 2019, che inoltre iniziano con la R, 
-- ordinati in maniera decrescente --

CREATE VIEW CibiInScadenza as
SELECT DISTINCT C.CodiceProdotto, C.NomeProdotto, C.Quantita
FROM prodotto AS C
WHERE C.Categoria = 'Cibo' AND DataScadenza >= '2019-02-01' AND DataScadenza <= '2019-02-28' AND C.NomeProdotto LIKE "R%"
ORDER BY DataScadenza DESC;

-- operazione 8:
-- stampa il codice, il nome, la marca e l annata di tutti i vini con annata risalente a massimo il 2008 e prezzo inferiore a 20 euro
-- ordinati per prezzo crescente --

CREATE VIEW viniEconomici as
SELECT DISTINCT V.CodiceProdotto, V.NomeProdotto, V.Marca, V.Annata
FROM prodotto AS V
WHERE V.Categoria='Bevanda' AND V.Tipo='Vino' AND V.Annata <= 2008 AND V.Prezzo < 20 AND V.Quantita > 0
ORDER BY V.Prezzo;

-- operazione 9:
-- stampa il numero dei tavoli liberi nel giorno 20/02/2019 che non hanno 3 o 4 coperti --

CREATE VIEW tavoliLiberi as
SELECT T.NumeroTavolo
FROM tavolo AS T
WHERE T.NumeroTavolo NOT IN (SELECT P.NumeroTavolo FROM prenotazione AS P WHERE P.Giorno='2019-02-20') AND T.Coperti > 4 OR T.Coperti < 3;

-- operazione 10:
-- stampa nome e cognome di tutti i dipendenti di turno il martedi --

CREATE VIEW dipendentiDiTurno as
SELECT DISTINCT P.Nome, P.Cognome
FROM personale AS P, svolgimento_turno AS T
WHERE T.CodiceFiscale=P.CodiceFiscale AND T.Giorno = 'Martedì';

-- operazione 11:
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
    WHERE E.DataEntrata >= '2019' + MONTH(mese) + '0' AND E.DataEntrata <= '2019' + MONTH(mese) + '31';
    
    SET Guadagno = entrate-uscite;
    
    RETURN Guadagno;
    
END |

-- operazione 12:
-- trova il cameriere che effettua piu ordini in media al giorno per decidere se promuoverlo o no --

CREATE FUNCTION promozione (mese DATE, cameriere VARCHAR(20)) RETURNS BOOL
BEGIN
    DECLARE ordini INTEGER;
    DECLARE promozione BOOL;
    
    SELECT COUNT(*) INTO ordini
    FROM ordine AS O
    WHERE O.CodiceCameriere=cameriere AND O.Giorno >= `2019` + MONTH(mese) + `01` AND O.giorno <= `2019` + MONTH(mese) + `31`;
    
    IF ordini >= 20 THEN SET promozione=true;
    ELSE SET promozione=FALSE;
    END IF;
    
    RETURN promozione;
    
END |

-- TRIGGER 1
-- un dipendente non puo lavorare nel suo giorno libero--
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
-- un dipenten non puo svolgere piu di 6 turni a settimana --
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
-- Un cliente non puo prenotare un tavolo gia prenotato. --
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

