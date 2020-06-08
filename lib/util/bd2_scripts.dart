import 'package:flutter_app/util/constants.dart';

String createTableProfile =
    "CREATE TABLE IF NOT EXISTS `profile` (`name` varchar(25),`origin_city` int(11),`origin_state` int(11),`university_state` int(11),`university_city` int(11),`university` int(11),`hash` varchar(40),`platform` varchar(10), PRIMARY KEY (`hash`));";

String createTableTransaction =
    "CREATE TABLE IF NOT EXISTS `transaction` (`category` int,`date` varchar(11),`description` varchar(21),`id` integer PRIMARY KEY,`paid` int,`value` int);";

String createTableBudget =
    "CREATE TABLE IF NOT EXISTS `budget` (`id` int PRIMARY KEY,`$kAlimentacao` int,`$kBolsaAuxilio` int,`$kHigiene` int,`$kInvestimento` int,`$kLazer` int,`$kMoradia` int,`$kPensao` int,`$kSalario` int,`$kSaude` int,`$kTransporte` int,`$kUniversidade` int,`$kVestimenta` int,`$kOutros` int);";

String inicialBudget =
    "INSERT INTO `budget` (`id`,`$kAlimentacao`,`$kBolsaAuxilio`,`$kHigiene`,`$kInvestimento`,`$kLazer`,`$kMoradia`,`$kPensao`,`$kSalario`,`$kSaude`,`$kTransporte`,`$kUniversidade`,`$kVestimenta`,`$kOutros`) VALUES ('1','0','0','0','0','0','0','0','0','0','0','0','0','0');";
