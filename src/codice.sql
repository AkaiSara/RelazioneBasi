 SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS fornitore;
DROP TABLE IF EXISTS prodotto;
DROP TABLE IF EXISTS uscita;
DROP TABLE IF EXISTS stipendio;
DROP TABLE IF EXISTS entrata;
DROP TABLE IF EXISTS personale;
DROP TABLE IF EXISTS turno;
DROP TABLE IF EXISTS svolgimento;
DROP TABLE IF EXISTS ordine;
DROP TABLE IF EXISTS tavolo;
DROP TABLE IF EXISTS prenotazione;


CREATE TABLE `fornitore` 
(
  `PartitaIva` varchar(11) PRIMARY KEY
   REFERENCES Prodotto(IvaFornitore) ON DELETE CASCADE,
  `NomeAzienda` varchar(20) NOT NULL,
  `Telefono` varchar(10) NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO fornitore (PartitaIva, NomeAzienda, Telefono) VALUES 
(12345678901, 'Crocini', 049875634), -- carne --
(46274891029, 'Frutti di Giorgio', 0498713542), -- frutta e verdura -- 
(892314738291, 'SunMarket', 0498736453), -- pasta e formaggi --
(47361904938, 'Belli Freschi', 0498746352), -- pane --
(36271849284, 'Il Pescatore', 0498715986), -- pesce -- 
(09876543217, 'My American Market', 056281792), -- bevande -- 
(37281930273, 'CantinaVeneta', 0498725021); -- vini -- 

CREATE TABLE `prodotto`
(
	`CodiceProdotto` integer PRIMARY KEY,
    `NomeProdotto` varchar(20) NOT NULL,
    `Marca` varchar(20),
    `Quantità` integer NOT NULL,
    `Annata` integer,
    `DataScadenza` date,
    `Categoria` varchar(20) NOT NULL,
    `Tipo` varchar(20) NOT NULL,
    `Prezzo` integer NOT NULL,
    `IvaFornitore` varchar(20) NOT NULL
)   ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO prodotto (CodiceProdotto, NomeProdotto, Marca, Quantità, Annata, DataScadenza, Categoria, Tipo, Prezzo, IvaFornitore) VALUES
(1111 , 'Finocchiona', NULL, 40, NULL, 2019-10-03, 'Cibo', 'Fresco', 8.50, 12345678901),
(2222, 'Giardiniera', NULL, 3, NULL, 2025-03-04, 'Cibo', 'Lunga Conservazione', 6.80, 12345678901),
(3333, 'Uova', NULL, 30, NULL, 2019-01-25, 'Cibo', 'Fresco', 1.31, 46274891029),
(4444, 'Spinaci', NULL, 5, NULL, 2019-02-26, 'Cibo', 'Fresco', 2.02, 892314738291),
(5555, 'Ricotta', 'Santa Lucia', 3, NULL, 2019-02-10, 'Cibo', 'Fresco', 1.01, 892314738291),
(6666, 'Prosciutto Crudo', NULL, 1, NULL, 2020-12-30, 'Cibo', 'Fresco', 13.35, 12345678901),
(7777, 'Tigelle', NULL, 10, NULL, 2020-04-02, 'Cibo', 'Fresco', 5.20, 47361904938),
(8888, 'Pane Bianco', NULL, 10, NULL, 2019-01-12, 'Cibo', 'Fresco', 5.50, 47361904938),
(9999, 'Baccalà', NULL, 3, NULL, 2020-01-01, 'Cibo', 'Surgelato', 1.5, 36271849284),
(1010, 'Radicchio', NULL, 4, NULL, 2019-02-02, 'Cibo', 'Fresco', 1.4, 46274891029),
(1212, 'Pancetta', NULL, 2, NULL, 2020-01-01, 'Cibo', 'Fresco', 8.75, 12345678901),
(1313, 'Brie', NULL, 5, NULL, 2019-03-04, 'Cibo', 'Fresco', 2.20, 892314738291),
(1414, 'Polenta', NULL, 2, NULL, 2020-05-05, 'Cibo', 'Lunga Conservazione', 2.29, 892314738291),
(1515, 'Tagliatelle', NULL, 6, NULL, 2019-09-08, 'Cibo', 'Fresco', 1.00, 892314738291),
(1616, 'Farina di castagne', NULL, 1, NULL, 2020-07-15, 'Cibo', 'Lunga Conservazione', 1.50, 892314738291),
(1717, 'Porcini', NULL, 20, NULL, 4, NULL, 2020-05-08, 'Cibo', 'Surgelato', 2.50, 46274891029),
(1818, 'Riso', NULL, 4, NULL, 2020-10-10, 'Cibo', 'Lunga Conservazione', 1.56, 892314738291),
(1919, 'Branzino', NULL, 10, NULL, 2019-12-04, 'Cibo', 'Surgelato', 2.36, 36271849284),
(2121, 'Coca Cola', 'Coca Cola', 90, NULL, 2025-01-01, 'Bevanda', 'Analcolica', 3.52, 09876543217),
(2020, 'Coca Cola Zero', 'Coca Cola', 90, NULL, 2025-01-01, 'Bevanda', 'Analcolica',  3.51, 09876543217),
(2323, 'Bionda', 'Leffe', 35, NULL, 2024-03-03, 'Bevanda', 'Birra', 2.25, 09876543217),
(2424, 'Rossa', 'Augustiner', 20, NULL, 2024-02-02, 'Bevanda', 'Birra', 2.53, 09876543217),
(2525, 'Carmenere', 'Alla Costiera', 6, 2008, NULL, 'Bevanda', 'Vino', 20.21, 37281930273),
(2626, 'Valpolicella', 'Terre di Terrarossa', 15, 2007, NULL, 'Bevanda', 17.54, 37281930273),
(2727, 'Pinot Nero', 'Sandro del Bruno', 6, 2008, NULL, 'Bevanda', 'Vino', 20.78, 37281930273);


CREATE TABLE `uscita` 
(
  `CodiceUscita` integer PRIMARY KEY,
  `Causale` varchar(30) NOT NULL,
  `Data` date NOT NULL,
  `Costo` integer NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;


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


CREATE TABLE `entrata` 
(
  `CodiceEntrata` integer PRIMARY KEY,
  `Costo` integer NOT NULL,
  `Data` date NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `personale` 
(
  `CodiceFiscale` varchar(20) PRIMARY KEY,
  `Nome` varchar(20) NOT NULL,
  `Cognome` varchar(20) NOT NULL,
  `GiornoLibero` varchar(10) NOT NULL,
  `Ruolo` varchar(20) NOT NULL,
  `Stipendio` integer NOT NULL,
  UNIQUE(Nome, Cognome)
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO personale (CodiceFiscale, Nome, Cognome, GiornoLibero, Ruolo, Stipendio) VALUES
('RGHNNA26R87T245R', 'Anna', 'Rossi', 'Martedì', 'Cameriere', 54646),
('TNEGGT75R32Z356W', 'Massimo', 'Bertocco', 'Mercoledì', 'Cuoco', 53744),
('CSFMSY23S51T224G', 'Gianni', 'Banzato', 'Lunedì', 'Sommelier', 29478),
('PTISSG56F42T777D', 'Maria', 'Franceschi', 'Giovedì', 'Cameriere', 35262),
('GGWYYR42R61K999S', 'Fabio', 'Marchi', 'Venerdì', 'Cuoco', 63527);

CREATE TABLE `turno` 
(
  `Giorno` varchar(20) PRIMARY KEY
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO turno (Giorno) VALUES
('Lunedì'),
('Martedì'),
('Mercoledì'),
('Giovedì'),
('Venerdì'),
('Sabato'),
('Domenica');

CREATE TABLE `svolgimento` 
(
  `CodiceFiscale` varchar(20) NOT NULL,
  `Giorno` varchar(20) NOT NULL,
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

CREATE TABLE `ordine` 
(
  `CodiceOrdine` integer PRIMARY KEY,
  `NumeroPersone` integer NOT NULL,
  `Giorno` date NOT NULL,
  `Ora` date NOT NULL,
  `ContoTotale` integer NOT NULL,
  `NumeroTavolo` integer NOT NULL,
  `CodiceCameriere` varchar(20) NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `svolgimento` 
(
  `NumeroTavolo` integer PRIMARY KEY,
  `Coperti` integer NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `prenotazione` 
(
  `CodicePrenotazione` integer PRIMARY KEY,
  `NumeroCoperti` integer NOT NULL,
  `Cliente` varchar(20) NOT NULL,
  `Giorno` date NOT NULL,
  `Ora` date NOT NULL,
  `NumeroTavolo` integer NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;


