CREATE DATABASE flightplanservice;

USE flightplanservice;

CREATE TABLE flightplans (id int NOT NULL AUTO_INCREMENT ,user NVARCHAR(50) NOT NULL, departure NVARCHAR(4) NOT NULL, arrival NVARCHAR(4) NOT NULL, alternate NVARCHAR(4), route NVARCHAR(500), altitude INT, formation_flight BOOL NOT NULL, formation_elements INT, ifr_flight BOOL NOT NULL, departure_time DATETIME, arrival_time DATETIME, callsign NVARCHAR(20) NOT NULL, type NVARCHAR(20) NOT NULL, squawk INT,fuel_reserve INT, remarks NVARCHAR(500), PRIMARY KEY (id));

CREATE USER 'FlightplanServiceUser'@ IDENTIFIED BY 'ChangeMe';

GRANT ALL PRIVILEGES ON flightplanservice.flightplans TO 'FlightplanServiceUser'@;

FLUSH PRIVILEGES;