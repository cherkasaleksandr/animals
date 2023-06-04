-- phpMyAdmin SQL Dump
-- version 4.9.10
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Июн 04 2023 г., 01:20
-- Версия сервера: 10.4.13-MariaDB
-- Версия PHP: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `atribut_21_test`
--

-- --------------------------------------------------------

--
-- Структура таблицы `oc_animals_breeds`
--

CREATE TABLE `oc_animals_breeds` (
  `id_breeds` int(11) NOT NULL,
  `id_types` int(11) NOT NULL,
  `name` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `oc_animals_breeds`
--

INSERT INTO `oc_animals_breeds` (`id_breeds`, `id_types`, `name`) VALUES
(9, 23, 'Австралийский мист'),
(10, 23, 'Азиатская'),
(11, 25, 'Акита-ину'),
(12, 25, 'Алабай'),
(13, 25, 'Бернский зенненхунд'),
(14, 24, 'Среднеазиатская сухопутная'),
(16, 24, 'Звездчатая сухопутная'),
(17, 26, 'Петушок'),
(18, 26, 'Скалярия'),
(19, 26, 'Анциструс'),
(20, 24, 'Американская болотная'),
(21, 23, 'Абиссинская');

-- --------------------------------------------------------

--
-- Структура таблицы `oc_animals_customer`
--

CREATE TABLE `oc_animals_customer` (
  `id_animals` int(11) NOT NULL,
  `id_types` int(11) NOT NULL,
  `id_breeds` int(11) NOT NULL,
  `id_customer` int(11) NOT NULL,
  `gender` int(1) NOT NULL DEFAULT 0,
  `age_months` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `oc_animals_customer`
--

INSERT INTO `oc_animals_customer` (`id_animals`, `id_types`, `id_breeds`, `id_customer`, `gender`, `age_months`) VALUES
(16, 25, 12, 1, 2, 15);

-- --------------------------------------------------------

--
-- Структура таблицы `oc_animals_types`
--

CREATE TABLE `oc_animals_types` (
  `id_types` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `gender_flag` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `oc_animals_types`
--

INSERT INTO `oc_animals_types` (`id_types`, `name`, `gender_flag`) VALUES
(23, 'Кошка', 1),
(24, 'Черепаха', 1),
(25, 'Собака', 1),
(26, 'Рыбы', 0);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `oc_animals_breeds`
--
ALTER TABLE `oc_animals_breeds`
  ADD PRIMARY KEY (`id_breeds`);

--
-- Индексы таблицы `oc_animals_customer`
--
ALTER TABLE `oc_animals_customer`
  ADD PRIMARY KEY (`id_animals`);

--
-- Индексы таблицы `oc_animals_types`
--
ALTER TABLE `oc_animals_types`
  ADD PRIMARY KEY (`id_types`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `oc_animals_breeds`
--
ALTER TABLE `oc_animals_breeds`
  MODIFY `id_breeds` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `oc_animals_customer`
--
ALTER TABLE `oc_animals_customer`
  MODIFY `id_animals` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `oc_animals_types`
--
ALTER TABLE `oc_animals_types`
  MODIFY `id_types` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
