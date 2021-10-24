------------------------------------

-- TABLES

------------------------------------

-- Departments

insert into Departments (did, dname) values (1, 'Accounts');
insert into Departments (did, dname) values (2, 'Public Relations');
insert into Departments (did, dname) values (3, 'Law');
insert into Departments (did, dname) values (4, 'Human Resources');
insert into Departments (did, dname) values (5, 'Marketing');
insert into Departments (did, dname) values (6, 'Records');
insert into Departments (did, dname) values (7, 'Cash');
insert into Departments (did, dname) values (8, 'Correspondence');
insert into Departments (did, dname) values (9, 'Stores');
insert into Departments (did, dname) values (10, 'Canteen and Staff Recreation');

-- Employees

insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (1, 'Kiersten Oiller', '1_KierstenOiller@company.com', '96169921', null, null, null, 8);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (2, 'Odelinda Scrivner', '2_OdelindaScrivner@company.com', '92961348', '60677089', '55268239', null, 7);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (3, 'Melisenda Epdell', '3_MelisendaEpdell@company.com', '92149399', null, null, '9/11/2021', 5);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (4, 'Cherye Sansbury', '4_CheryeSansbury@company.com', '92354496', null, null, null, 2);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (5, 'Millard Turbefield', '5_MillardTurbefield@company.com', '96321049', '67300160', '56213416', '8/16/2021', 6);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (6, 'Kenneth Twelvetree', '6_KennethTwelvetree@company.com', '91052777', null, null, null, 6);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (7, 'Riane Getcliffe', '7_RianeGetcliffe@company.com', '94905824', '64319495', '50391478', null, 10);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (8, 'Nappy Addison', '8_NappyAddison@company.com', '94825693', '61809996', '51252558', '2/7/2021', 4);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (9, 'Roger Cronk', '9_RogerCronk@company.com', '97013738', null, null, null, 5);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (10, 'Eva Shayler', '10_EvaShayler@company.com', '90084842', '63452573', '54109981', '4/7/2021', 4);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (11, 'Theresina Rundall', '11_TheresinaRundall@company.com', '94018833', null, null, null, 4);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (12, 'Bethanne Danks', '12_BethanneDanks@company.com', '94612249', null, null, null, 9);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (13, 'Lavina Schneider', '13_LavinaSchneider@company.com', '91667935', null, null, null, 4);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (14, 'Sheela Sewter', '14_SheelaSewter@company.com', '91650240', '65925178', '54962073', null, 5);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (15, 'Jewel Tomalin', '15_JewelTomalin@company.com', '90427009', null, null, null, 2);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (16, 'Caspar Sill', '16_CasparSill@company.com', '93708918', '65638738', '51200671', null, 4);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (17, 'Lanie Sickert', '17_LanieSickert@company.com', '98410404', null, null, '2/17/2021', 3);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (18, 'Roderic Heinschke', '18_RodericHeinschke@company.com', '90169892', null, null, null, 3);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (19, 'Dallon Kember', '19_DallonKember@company.com', '92733073', null, null, null, 6);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (20, 'Karney Speke', '20_KarneySpeke@company.com', '95578325', '69455761', '57180661', null, 4);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (21, 'Meris Silverstone', '21_MerisSilverstone@company.com', '94613481', '69342191', '59186629', '4/3/2021', 4);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (22, 'Rosina Sives', '22_RosinaSives@company.com', '99185607', null, null, null, 3);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (23, 'Charyl Skeates', '23_CharylSkeates@company.com', '98876300', '69329229', '58909516', null, 6);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (24, 'Gracie Sprigg', '24_GracieSprigg@company.com', '99443918', '61024658', '55632081', null, 7);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (25, 'Marcie Cordle', '25_MarcieCordle@company.com', '91917563', null, null, null, 8);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (26, 'Alene Bott', '26_AleneBott@company.com', '90817859', '60301192', '53721748', null, 4);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (27, 'Baxter Otto', '27_BaxterOtto@company.com', '99224878', null, null, null, 6);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (28, 'Adamo Hannen', '28_AdamoHannen@company.com', '92341417', null, null, '12/13/2020', 6);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (29, 'Taber Labeuil', '29_TaberLabeuil@company.com', '98949630', null, null, null, 4);
insert into Employees (eid, ename, email, contact_mobile, contact_home, contact_office, resigned_date, dept_id) values (30, 'Barbabra Ambler', '30_BarbabraAmbler@company.com', '93099022', null, null, null, 6);

insert into Juniors (eid) values (1);
insert into Juniors (eid) values (3);
insert into Juniors (eid) values (4);
insert into Juniors (eid) values (6);
insert into Juniors (eid) values (7);
insert into Juniors (eid) values (8);
insert into Juniors (eid) values (12);
insert into Juniors (eid) values (15);
insert into Juniors (eid) values (17);
insert into Juniors (eid) values (18);
insert into Juniors (eid) values (19);
insert into Juniors (eid) values (20);
insert into Juniors (eid) values (21);
insert into Juniors (eid) values (23);
insert into Juniors (eid) values (25);
insert into Juniors (eid) values (27);
insert into Juniors (eid) values (28);
insert into Juniors (eid) values (30);

insert into Bookers (eid) values (5);
insert into Bookers (eid) values (9);
insert into Bookers (eid) values (10);
insert into Bookers (eid) values (11);
insert into Bookers (eid) values (13);
insert into Bookers (eid) values (16);
insert into Bookers (eid) values (22);
insert into Bookers (eid) values (26);
insert into Bookers (eid) values (2);
insert into Bookers (eid) values (14);
insert into Bookers (eid) values (24);
insert into Bookers (eid) values (29);

insert into Seniors (eid) values (5);
insert into Seniors (eid) values (9);
insert into Seniors (eid) values (10);
insert into Seniors (eid) values (11);
insert into Seniors (eid) values (13);
insert into Seniors (eid) values (16);
insert into Seniors (eid) values (22);
insert into Seniors (eid) values (26);

insert into Managers (eid) values (2);
insert into Managers (eid) values (14);
insert into Managers (eid) values (24);
insert into Managers (eid) values (29);

-- Meeting Rooms

insert into MeetingRooms (room, floor, rname, dep_id) values (8, 3, 'Prep Room 3', 7);
insert into MeetingRooms (room, floor, rname, dep_id) values (15, 3, 'Conference Room 26', 6);
insert into MeetingRooms (room, floor, rname, dep_id) values (13, 3, 'Conference Room 7', 10);
insert into MeetingRooms (room, floor, rname, dep_id) values (9, 3, 'Meeting Room 30', 1);
insert into MeetingRooms (room, floor, rname, dep_id) values (27, 3, 'Conference Room 19', 2);
insert into MeetingRooms (room, floor, rname, dep_id) values (4, 3, 'Meeting Room 26', 8);
insert into MeetingRooms (room, floor, rname, dep_id) values (17, 2, 'Prep Room 26', 9);
insert into MeetingRooms (room, floor, rname, dep_id) values (22, 2, 'Conference Room 7', 6);
insert into MeetingRooms (room, floor, rname, dep_id) values (3, 3, 'Meeting Room 15', 6);
insert into MeetingRooms (room, floor, rname, dep_id) values (7, 10, 'Meeting Room 25', 6);
insert into MeetingRooms (room, floor, rname, dep_id) values (8, 10, 'Conference Room 27', 9);
insert into MeetingRooms (room, floor, rname, dep_id) values (25, 9, 'Conference Room 13', 7);
insert into MeetingRooms (room, floor, rname, dep_id) values (8, 8, 'Conference Room 18', 10);
insert into MeetingRooms (room, floor, rname, dep_id) values (23, 5, 'Prep Room 19', 8);
insert into MeetingRooms (room, floor, rname, dep_id) values (19, 3, 'Meeting Room 28', 4);
insert into MeetingRooms (room, floor, rname, dep_id) values (20, 2, 'Conference Room 23', 5);
insert into MeetingRooms (room, floor, rname, dep_id) values (17, 4, 'Meeting Room 14', 9);

-- Health Declaration

insert into HealthDeclarations (eid, ddate, temperature) values (24, '10/23/2021', 36.7);
insert into HealthDeclarations (eid, ddate, temperature) values (6, '10/24/2021', 37.0);
insert into HealthDeclarations (eid, ddate, temperature) values (12, '10/23/2021', 36.4);
insert into HealthDeclarations (eid, ddate, temperature) values (11, '10/22/2021', 36.5);
insert into HealthDeclarations (eid, ddate, temperature) values (19, '10/20/2021', 37.2);
insert into HealthDeclarations (eid, ddate, temperature) values (19, '10/24/2021', 37.2);
insert into HealthDeclarations (eid, ddate, temperature) values (5, '10/21/2021', 37.2);
insert into HealthDeclarations (eid, ddate, temperature) values (5, '10/24/2021', 36.9);
insert into HealthDeclarations (eid, ddate, temperature) values (1, '10/22/2021', 37.4);
insert into HealthDeclarations (eid, ddate, temperature) values (2, '10/21/2021', 37.6);
insert into HealthDeclarations (eid, ddate, temperature) values (29, '10/22/2021', 37.8);
insert into HealthDeclarations (eid, ddate, temperature) values (20, '10/21/2021', 36.8);
insert into HealthDeclarations (eid, ddate, temperature) values (19, '10/22/2021', 37.5);
insert into HealthDeclarations (eid, ddate, temperature) values (17, '10/22/2021', 37.4);
insert into HealthDeclarations (eid, ddate, temperature) values (28, '10/21/2021', 36.8);
insert into HealthDeclarations (eid, ddate, temperature) values (16, '10/24/2021', 37.2);
insert into HealthDeclarations (eid, ddate, temperature) values (7, '10/20/2021', 36.7);
insert into HealthDeclarations (eid, ddate, temperature) values (5, '10/22/2021', 37.1);
insert into HealthDeclarations (eid, ddate, temperature) values (18, '10/20/2021', 37.4);
insert into HealthDeclarations (eid, ddate, temperature) values (14, '10/22/2021', 37.1);
insert into HealthDeclarations (eid, ddate, temperature) values (2, '10/23/2021', 37.2);
insert into HealthDeclarations (eid, ddate, temperature) values (3, '10/24/2021', 37.5);
insert into HealthDeclarations (eid, ddate, temperature) values (22, '10/22/2021', 37.0);
insert into HealthDeclarations (eid, ddate, temperature) values (16, '10/21/2021', 37.6);
insert into HealthDeclarations (eid, ddate, temperature) values (7, '10/21/2021', 37.2);
insert into HealthDeclarations (eid, ddate, temperature) values (9, '10/23/2021', 37.1);