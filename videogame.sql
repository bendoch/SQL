CREATE DATABASE Videogames;

USE Videogames;

CREATE TABLE Store(
      StoreID TINYINT PRIMARY KEY
      ,StoreAddress VARCHAR(50)
      ,StorePhone VARCHAR(50));
      
      INSERT INTO Store VALUES
         ( 1, 'Via Roma 123, Milano', '+39 02 1234567')
         ,( 2, 'Corso Italia 456, Roma', '+39 06 7654321')
         ,( 3, 'Piazza San Marco 789, Venezia', '+39 041 9876543')
         ,( 4, 'Viale degli Ulivi 234, Napoli', '+39 081 3456789')   
         ,( 5, 'Via Torino 567, Torino', '+39 011 8765432')
         ,( 6, 'Corso Vittorio Emanuele 890, Firenze', '+39 055 2345678')
         ,( 7, 'Piazza del Duomo 123, Bologna', '+39 051 8765432')
		 ,( 8, 'Via Garibaldi 456, Genova', '+39 010 2345678')
         ,( 9, 'Lungarno Mediceo 789, Pisa', '+39 050 8765432') 
         ,( 10, 'Corso Cavour 101, Palermo', '+39 091 2345678');
      
CREATE TABLE Employee(
       EmployeeCF VARCHAR(13) PRIMARY KEY
       ,EmployeeName VARCHAR(50)
       ,EmployeeDegree VARCHAR(50)
       ,EmployeePhone VARCHAR(50));    
       
       ALTER TABLE Employee MODIFY COLUMN EmployeeCF VARCHAR(16);
       
       INSERT INTO Employee VALUES
       ( 'ABC12345XYZ67890', 'Mario Rossi', 'Laurea in Economia', 'mario.rossi@email.com')                                                                                               
       ,( 'DEF67890XYZ12345', 'Anna Verdi', 'Diploma di Ragioneria', 'anna.verdi@email.com')
       ,( 'GHI12345XYZ67890', 'Luigi Bianchi', 'Laurea in Informatica', 'luigi.bianchi@email.com')
       ,( 'JKL67890XYZ12345', 'Laura Neri', 'Laurea in Lingue', 'laura.neri@email.com')
       ,( 'MNO12345XYZ67890', 'Andrea Moretti', 'Diploma di Geometra', 'andrea.moretti@email.com')
       ,( 'PQR67890XYZ12345', 'Giulia Ferrara', 'Laurea in Psicologia', 'giulia.ferrara@email.com')
       ,( 'STU12345XYZ67890', 'Marco Esposito', 'Diploma di Elettronica', 'marco.esposito@email.com')
       ,( 'VWX67890XYZ12345', 'Sara Romano', 'Laurea in Giurisprudenza', 'sara.romano@email.com')
       ,( 'YZA12345XYZ67890', 'Roberto De Luca', 'Diploma di Informatica', 'roberto.deluca@email.com')
       ,( 'BCD67890XYZ12345', 'Elena Santoro', 'Laurea in Lettere', 'elena.santoro@emailcom');
       
 CREATE TABLE Roles(
        Position VARCHAR(50) 
        , StoreID TINYINT 
        , EmployeeCF VARCHAR(13) 
        , StartDate DATE 
        , EndDate DATE
        , ContractDuration TINYINT
        , PRIMARY KEY (Position, StoreID, EmployeeCF)) ;
        
    ALTER TABLE Roles
      ADD FOREIGN KEY (StoreID) REFERENCES Store(StoreID);
    ALTER TABLE Roles
      ADD FOREIGN KEY (EmployeeCF) REFERENCES Employee(EmployeeCF); 
      
      ALTER TABLE Roles MODIFY COLUMN EmployeeCF VARCHAR(16);
      ALTER TABLE Roles DROP ContractDuration;
      
        INSERT INTO Roles VALUES
        ( 'Cassiere', 1, 'ABC12345XYZ67890', '2023-01-01',  '2023-12-31')                                             
        ,( 'Commesso', 2, 'DEF67890XYZ12345', '2023-02-01', '2023-11-30')
        ,( 'Magazziniere', 3, 'GHI12345XYZ67890', '2023-03-01', '2023-10-31')
        ,( 'Addetto alle vendite', 4, 'JKL67890XYZ12345', '2023-04-01', '2023-09-30')
        ,( 'Addetto alle pulizie', 5, 'MNO12345XYZ67890', '2023-05-01', '2023-08-31')
        ,( 'Commesso', 6, 'PQR67890XYZ12345', '2023-06-01', '2023-07-31')
        ,( 'Commesso', 7, 'STU12345XYZ67890', '2023-07-01', '2023-06-30')
        ,( 'Cassiere', 8, 'VWX67890XYZ12345',  '2023-08-01', '2023-05-31')
        ,( 'Cassiere', 9, 'YZA12345XYZ67890', '2023-09-01', '2023-04-30')
        ,( 'Cassiere', 10, 'BCD67890XYZ12345', '2023-10-01', '2023-03-31');
      
CREATE TABLE Sector(
         SectorID TINYINT PRIMARY KEY
         , StoreID TINYINT) ;
    ALTER TABLE Sector
      ADD FOREIGN KEY (StoreID) REFERENCES Store(StoreID);
      
    INSERT INTO Sector VALUES
    ( 11, 1)
    ,( 12, 1)
    ,( 21, 2)
    ,( 22, 2)
    ,( 31,3)
    ,(32,3)
    ,(41,4)
    ,(42,4)
    ,(51,5)
    ,(52,5)
    ,(61,6)
    ,(62,6)
    ,(71,7)
    ,(72,7)
    ,(81,8)
    ,(82,8)
    ,(91,9)
    ,(92,9)
    ,(101,10)
    ,(102,10);
    
      
CREATE TABLE Developer(
		DevID TINYINT PRIMARY KEY
        , DeveloperName VARCHAR(50));
        
        INSERT INTO Developer VALUES
        ( 1, 'EA Sports')
        ,( 2, 'Ubisoft')
        ,( 3, 'Nintendo')
        ,( 4, 'Naughty Dog')
        ,( 5, 'CD Projekt Red')
        ,( 6, 'Nintendo')
        ,( 7, 'Infinity Ward')
        ,( 8, 'Nintendo')
        ,( 9, 'Epic Games')
        ,( 10, 'Rockstar Games');
        
        
CREATE TABLE Videogame(
        GameID TINYINT PRIMARY KEY
        , GameName VARCHAR(50)
        , DevID TINYINT
        , ReleaseDate DATE
        , UnitPrice TINYINT
        , Genre VARCHAR(50));
	ALTER TABLE Videogame
      ADD FOREIGN KEY (DevID) REFERENCES Developer(DevID);
      
      ALTER TABLE Videogame MODIFY COLUMN ReleaseDate YEAR;
      
      INSERT INTO Videogame VALUES
      ( 1, 'Fifa 2023', 1, '2023', '49.99', 'Football')
      ,( 2, 'Assassins Creed: Valhalla', 2, '2020', '59.99', 'Action')
      ,( 3, 'Super Mario Odyssey', 3, '2017', '39.99', 'Platform')
      ,( 4, 'The Last of Us Part II', 4, '2020', '69.99', 'Action')
      ,( 5, 'Cyberpunk 2077', 5, '2020', '49.99', 'RPG')
      ,( 6, 'Animal Crossing: New Horizons', 6, '2020', '54.99', 'Simulation')
      ,( 7, 'Call of Duty: Warzone', 7, '2020', '0.00', 'FPS')
      ,( 8, 'The Legend of Zelda: Breath of the Wild', 8, '2017', '59.99', 'Action-Adventure')
      ,( 9, 'Fortnite', 9, '2017', '0.00', 'Battle Royale')
      ,( 10, 'Red Dead Redemption 2', 10, '2018', '39.99', 'Action-Adventure');
      
CREATE TABLE Positions(
        StoreID TINYINT
        , SectorID TINYINT
        , GameID TINYINT
        , CopiesNumber TINYINT
        , PRIMARY KEY (GameID, SectorID)) ;
	ALTER TABLE Positions
	  ADD FOREIGN KEY (StoreID) REFERENCES Store(StoreID);
	ALTER TABLE Positions
	  ADD FOREIGN KEY (SectorID) REFERENCES Sector(SectorID);
	ALTER TABLE Positions
      ADD FOREIGN KEY (GameID) REFERENCES Videogame(GameID);
      
      INSERT INTO Positions VALUES
      (1,11,3,'5')
      ,(1,12,7,'2')
      ,(2,21,4,'1');
      

