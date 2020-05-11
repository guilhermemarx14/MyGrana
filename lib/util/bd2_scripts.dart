String createTableProfile =
    "CREATE TABLE IF NOT EXISTS `profile` (`nome` varchar(25),`estado` int(11),`cidade` int(11),`universidade` int(11),`hash` varchar(40),`plataforma` varchar(10), PRIMARY KEY (`hash`));";

String createTableTransaction =
    "CREATE TABLE IF NOT EXISTS `transaction` (`category` int,`date` varchar(11),`descricao` varchar(21),`id` integer PRIMARY KEY,`paid` int,`value` int);";
