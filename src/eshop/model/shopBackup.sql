-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 04-02-2014 a las 13:05:42
-- Versión del servidor: 5.5.16
-- Versión de PHP: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `shop`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `books`
--

CREATE TABLE IF NOT EXISTS `books` (
  `book_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(70) DEFAULT NULL,
  `author` varchar(70) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE KEY `book_id` (`book_id`),
  KEY `book_id_key` (`book_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `books`
--

INSERT INTO `books` (`book_id`, `title`, `author`, `price`, `category_id`) VALUES
(1, 'Web Standards', 'Leslie Sikos', 44.99, 1),
(2, 'Getting Started with CSS', 'David Powers', 24.99, 1),
(3, 'The Complete Robot', 'Isaac Asimov', 8.95, 2),
(4, 'Foundation', 'Isaac ASimov', 8.95, 2),
(5, 'Area 7', 'Matthew Reilly', 5.99, 3),
(6, 'Term Limits', 'Vince Flynn', 6.99, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_id` (`category_id`),
  KEY `category_id_key` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'Web Development'),
(2, 'SF'),
(3, 'Action Novels');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` double NOT NULL AUTO_INCREMENT,
  `delivery_name` varchar(70) DEFAULT NULL,
  `delivery_address` varchar(70) DEFAULT NULL,
  `cc_name` varchar(70) DEFAULT NULL,
  `cc_number` varchar(32) DEFAULT NULL,
  `cc_expiry` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `order_id_key` (`order_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1391003866773 ;

--
-- Volcado de datos para la tabla `orders`
--

INSERT INTO `orders` (`order_id`, `delivery_name`, `delivery_address`, `cc_name`, `cc_number`, `cc_expiry`) VALUES
(1391003579371, '', '', '', '', ''),
(1391003866772, '', '', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `order_details`
--

CREATE TABLE IF NOT EXISTS `order_details` (
  `id` double NOT NULL AUTO_INCREMENT,
  `book_id` int(11) DEFAULT NULL,
  `title` varchar(70) DEFAULT NULL,
  `author` varchar(70) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `order_id` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `order_details_id_key` (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `order_details`
--

INSERT INTO `order_details` (`id`, `book_id`, `title`, `author`, `quantity`, `price`, `order_id`) VALUES
(1, 1, 'Web Standards', 'Leslie Sikos', 1, 44.99, 1391003579371),
(2, 6, 'Term Limits', 'Vince Flynn', 1, 6.99, 1391003579371),
(3, 3, 'The Complete Robot', 'Isaac Asimov', 1, 8.95, 1391003579371),
(4, 2, 'Getting Started with CSS', 'David Powers', 1, 24.99, 1391003579371),
(5, 5, 'Area 7', 'Matthew Reilly', 1, 5.99, 1391003866772);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) COLLATE latin1_spanish_ci NOT NULL DEFAULT '',
  `clave` varchar(32) COLLATE latin1_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `usuario` (`usuario`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `clave`) VALUES
(1, 'admin', 'admin'),
(3, 'admin2', 'elrincon');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Filtros para la tabla `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
