-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-12-2024 a las 05:29:10
-- Versión del servidor: 10.6.20-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `we_hire`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `api_etapafinal`
--

CREATE TABLE `api_etapafinal` (
  `id` bigint(20) NOT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `observaciones` longtext DEFAULT NULL,
  `archivo` varchar(100) DEFAULT NULL,
  `retroalimentacion` longtext DEFAULT NULL,
  `publicacion_id` bigint(20) DEFAULT NULL,
  `usuario_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `api_etapafinal`
--

INSERT INTO `api_etapafinal` (`id`, `estado`, `observaciones`, `archivo`, `retroalimentacion`, `publicacion_id`, `usuario_id`) VALUES
(1, 'TERMINADO', 'edit Se envía documentación para continuar con la contratación, se informa fecha de ingreso y exámenes médicos. ', '', 'edit El individuo muestra buenas habilidades blandas al comunicarse con los demás, es una persona autocrítica aunque tiende a exigirse de más. Se recomienda trabajar ', 1, 2),
(2, 'COMPLETADO', 'null', '113696cb-3927-48b1-afad-26c7eca53e14.pdf', 'null', 1, 3),
(3, 'COMPLETADO', 'Hemos revisado la evaluación técnica y nos gusta tu perfil, te adjuntamos carta oferta para que ingreses a trabajar con nosotros.', '2b9d5726-8323-4673-8708-a8913498bc7f.pdf', 'En la revisión realizado encontramos que eres una personas responsable y puntual con tus asignaciones, en la entrevista telefonica te notamos un poco nervioso pero no fue motivo para que dejaras de responder las preguntas, felicidades.', 3, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `api_etapainicial`
--

CREATE TABLE `api_etapainicial` (
  `id` bigint(20) NOT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `observaciones` longtext DEFAULT NULL,
  `publicacion_id` bigint(20) DEFAULT NULL,
  `usuario_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `api_etapainicial`
--

INSERT INTO `api_etapainicial` (`id`, `estado`, `observaciones`, `publicacion_id`, `usuario_id`) VALUES
(1, 'CONTINUA', 'El perfil cumple con los requisitos iniciales para el puesto, se continua con la siguiente etapa para iniciar pruebas técnicas', 1, 2),
(2, 'CONTINUA', 'Buen perfil! Esperamos poder contar con tu conocimiento.', 1, 3),
(3, 'TERMINADO', 'Se verifica la experiencia laboral y se corrobora que cuenta con varios conocimientos en varias tecnologías.', 2, 2),
(4, 'CONTINUA', 'Su perfil es acorde a lo que necesitamos, ha pasado a la siguiente etapa ', 3, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `api_etapamedia`
--

CREATE TABLE `api_etapamedia` (
  `id` bigint(20) NOT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `observaciones` longtext DEFAULT NULL,
  `archivo` varchar(100) DEFAULT NULL,
  `publicacion_id` bigint(20) DEFAULT NULL,
  `usuario_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `api_etapamedia`
--

INSERT INTO `api_etapamedia` (`id`, `estado`, `observaciones`, `archivo`, `publicacion_id`, `usuario_id`) VALUES
(1, 'CONTINUA', 'Supera las pruebas propuestas con un dominio excelente del tema y la tecnología, se aprecian buenas habilidades blandas. , editar', '', 1, 2),
(2, 'CONTINUA', NULL, '', 2, 2),
(3, 'TERMINADO', NULL, '', 2, 2),
(4, 'CONTINUA', 'Se adjuntan las pruebas técnicas. Por favor enviarla al correo reclutador@mail.com\r\n\r\nSuper, las pruebas fueron exitosas, continuas con la etapa final, te estaremos adjuntando los documentos en los próximos días. ', 'd4e25b8c-a987-4014-be5a-ffd144a6a3cf.pdf', 1, 3),
(5, 'CONTINUA', 'Se ha evaluado su perfil y lo consideramos apto para realizar la prueba técnica adjunta, una vez finalizada, enviarlo al correo jeny@gmail.com para su revisión', '9ccf3889-9a60-41ea-8e9d-f508222d376b.pdf', 3, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `api_publicaciones`
--

CREATE TABLE `api_publicaciones` (
  `id` bigint(20) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` longtext DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `requisitos` longtext DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `reclutador_id` bigint(20) DEFAULT NULL,
  `candidato_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `api_publicaciones`
--

INSERT INTO `api_publicaciones` (`id`, `titulo`, `descripcion`, `salario`, `requisitos`, `estado`, `reclutador_id`, `candidato_id`) VALUES
(1, 'Desarrollador C# INTERMEDIO', 'Somos una importante empresa del sector TI enfocado a empresas de transporte y logística, llena de personas apasionadas por lo que hacen, donde creemos en el potencial del trabajo en equipo, en los cambios y en la innovación. Si te identificas con este propósito.', 2800000.00, 'Estamos en búsqueda de un Desarrollador Backend con experiencia mínima de TRES años en C#, patrones de diseño y manejo de los principios SOLID para unirse a nuestro equipo. Este rol será clave en la creación, mejora y mantenimiento de nuestras soluciones tecnológicas, asegurando su eficiencia, escalabilidad y seguridad.', 'ABIERTA', 1, NULL),
(2, 'Analista Desarrollador / DevOps', '-GLOBAL S.A. es una compañía dedicada a brindar soluciones integrales del sector TI, de gran reconocimiento y proyección en el ámbito nacional, se encuentra en búsqueda de Tecnólogo(a) o Ingeniero(a) de Sistemas, Telecomunicaciones, Redes, Informática o áreas a fines a la tecnología para el desempeñarse en el rol de Analista Desarrollador con experiencia y conocimientos de 2 años', 3000000.00, '• Actividades relevantes: Mejorar la estructura visual de la aplicación, refactorizar formularios, ajustar nuevos endpoints, y habilitar o deshabilitar módulos en función de los roles. • Experiencia comprobada en el desarrollo Frontend con React.js, HTML, CSS, y TypeScript.', 'ABIERTA', 1, NULL),
(3, 'Analista Desarrollador / DevOps - MODIFICADO', '-GLOBAL S.A. es una compañía dedicada a brindar soluciones integrales del sector TI, de gran reconocimiento y proyección en el ámbito nacional, se encuentra en búsqueda de Tecnólogo(a) o Ingeniero(a) de Sistemas, Telecomunicaciones, Redes, Informática o áreas a fines a la tecnología para el desempeñarse en el rol de Analista Desarrollador con experiencia y conocimientos de 2 años aproximadamente en DevOps ', 3000000.00, ' Manejo de APIs RESTful\r\n• PostgreSQL\r\n• Diseño de bases de datos relacionales\r\n• Optimización de consultas\r\n• Procedimientos almacenados', 'ABIERTA', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `api_rol`
--

CREATE TABLE `api_rol` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `api_rol`
--

INSERT INTO `api_rol` (`id`, `nombre`) VALUES
(1, 'Reclutador'),
(2, 'Candidato');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `api_usuarios`
--

CREATE TABLE `api_usuarios` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `correo` varchar(255) NOT NULL,
  `clave` varchar(255) DEFAULT NULL,
  `rol_id` bigint(20) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `celular` varchar(50) DEFAULT NULL,
  `fecha_nacimiento` datetime(6) DEFAULT NULL,
  `hoja_vida` varchar(100) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `api_usuarios`
--

INSERT INTO `api_usuarios` (`id`, `nombre`, `correo`, `clave`, `rol_id`, `apellido`, `celular`, `fecha_nacimiento`, `hoja_vida`, `telefono`) VALUES
(1, 'Jennifer Andrea Luisa', 'jquiceno@tredasolutions.com', '1234564', 1, 'Quiceno Aristizabal', 'undefined', '2000-01-01 00:00:00.000000', '', 'undefined'),
(2, 'Andrea Sofia', 'andre@mail.com', '123', 2, 'Cárdenas ', '3203285100', '2000-02-05 00:00:00.000000', 'af6d24c9-52a5-4585-8e6d-5e29d7f6795d.pdf', '5855068'),
(3, 'Jennifer Andrea', 'jenyaristizabal99@gmail.com', '123456', 2, 'Q.', '3203285100', '2000-02-06 00:00:00.000000', 'uploads/finaicero.pdf', '4223480'),
(4, 'Emerson ', 'emerson@mail.com', '147', 2, 'Quiceno', '3054549189', '2024-12-05 00:00:00.000000', 'e19a46a7-0c01-49b1-9a28-602b25ad6db1.pdf', '2352615'),
(5, 'Jennifer ', 'jenyaristizabal@gmail.com', '12345', 2, 'Quiceno aristizabal ', '3203285100', '2000-06-02 00:00:00.000000', '51f19774-1446-49db-8c87-8eb96d7d9c51.pdf', '32032444');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add usuarios', 7, 'add_usuarios'),
(26, 'Can change usuarios', 7, 'change_usuarios'),
(27, 'Can delete usuarios', 7, 'delete_usuarios'),
(28, 'Can view usuarios', 7, 'view_usuarios'),
(29, 'Can add rol', 8, 'add_rol'),
(30, 'Can change rol', 8, 'change_rol'),
(31, 'Can delete rol', 8, 'delete_rol'),
(32, 'Can view rol', 8, 'view_rol'),
(33, 'Can add publicaciones', 9, 'add_publicaciones'),
(34, 'Can change publicaciones', 9, 'change_publicaciones'),
(35, 'Can delete publicaciones', 9, 'delete_publicaciones'),
(36, 'Can view publicaciones', 9, 'view_publicaciones'),
(37, 'Can add etapa media', 10, 'add_etapamedia'),
(38, 'Can change etapa media', 10, 'change_etapamedia'),
(39, 'Can delete etapa media', 10, 'delete_etapamedia'),
(40, 'Can view etapa media', 10, 'view_etapamedia'),
(41, 'Can add etapa inicial', 11, 'add_etapainicial'),
(42, 'Can change etapa inicial', 11, 'change_etapainicial'),
(43, 'Can delete etapa inicial', 11, 'delete_etapainicial'),
(44, 'Can view etapa inicial', 11, 'view_etapainicial'),
(45, 'Can add etapa final', 12, 'add_etapafinal'),
(46, 'Can change etapa final', 12, 'change_etapafinal'),
(47, 'Can delete etapa final', 12, 'delete_etapafinal'),
(48, 'Can view etapa final', 12, 'view_etapafinal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$260000$cgYeqYK5rKW6RPtaot8coc$NdYiMugKmqTwPhNInS6VuN9KJcn0UGBIzaKwnjCTed8=', NULL, 1, 'jenny', '', '', 'jenyaristizabal@gmail.com', 1, 1, '2024-11-17 00:19:57.490523'),
(2, 'pbkdf2_sha256$260000$R38yVcXXriHEmBrczj1vf6$MLLDmwKuZA9bTAHoYCOuS62EUAQJIPLMtH4ZogLGaRI=', '2024-11-17 00:27:43.140902', 1, 'jennifer', '', '', 'jenyaristizabal@gmail.com', 1, 1, '2024-11-17 00:27:27.281275');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2024-11-17 00:28:56.421193', '1', 'Usuarios object (1)', 1, '[{\"added\": {}}]', 7, 2),
(2, '2024-11-17 00:30:02.722694', '2', 'Usuarios object (2)', 1, '[{\"added\": {}}]', 7, 2),
(3, '2024-11-19 19:45:39.075132', '1', 'Administrador', 1, '[{\"added\": {}}]', 8, 2),
(4, '2024-11-19 21:52:30.635680', '2', 'andrea', 2, '[{\"changed\": {\"fields\": [\"Correo\", \"Clave\"]}}]', 7, 2),
(5, '2024-11-19 21:52:39.599493', '1', 'andrea', 2, '[{\"changed\": {\"fields\": [\"Correo\", \"Clave\"]}}]', 7, 2),
(6, '2024-11-19 22:11:14.422638', '1', 'Prueba publicaicon', 1, '[{\"added\": {}}]', 9, 2),
(7, '2024-11-19 22:22:29.926267', '2', 'publicaicon 2', 1, '[{\"added\": {}}]', 9, 2),
(8, '2024-11-20 23:06:52.572958', '1', 'Etapa Inicial de jennifer en Prueba EDITADAAAAAAAAAAAAAAAAAA', 1, '[{\"added\": {}}]', 11, 2),
(9, '2024-11-20 23:07:45.548278', '1', 'Etapa media de andrea en publicaicon 2', 1, '[{\"added\": {}}]', 10, 2),
(10, '2024-11-20 23:08:19.696434', '1', 'Etapa final de andrea en Prueba 3', 1, '[{\"added\": {}}]', 12, 2),
(11, '2024-11-21 02:49:08.853627', '1', 'andrea user 1', 2, '[{\"changed\": {\"fields\": [\"Nombre\"]}}]', 7, 2),
(12, '2024-11-21 02:49:17.091298', '2', 'andrea user 2', 2, '[{\"changed\": {\"fields\": [\"Nombre\"]}}]', 7, 2),
(13, '2024-11-21 02:49:34.421195', '3', 'jennifer user 3', 2, '[{\"changed\": {\"fields\": [\"Nombre\", \"Clave\"]}}]', 7, 2),
(14, '2024-11-21 02:49:42.621324', '4', 'Prueba 3', 2, '[]', 9, 2),
(15, '2024-11-21 02:49:46.747937', '3', 'Prueba 3', 2, '[]', 9, 2),
(16, '2024-11-21 02:49:51.065866', '2', 'publicaicon 2', 2, '[]', 9, 2),
(17, '2024-11-21 02:49:56.487215', '1', 'Prueba E88TADAAAAAAAAAAAAAAAAAA', 2, '[{\"changed\": {\"fields\": [\"Reclutador\"]}}]', 9, 2),
(18, '2024-11-27 02:53:47.592344', '1', 'Reclutador', 2, '[{\"changed\": {\"fields\": [\"Nombre\"]}}]', 8, 2),
(19, '2024-11-27 02:54:21.528065', '2', 'Candidato', 1, '[{\"added\": {}}]', 8, 2),
(20, '2024-11-27 05:57:56.066395', '10', '4520452', 2, '[]', 9, 2),
(21, '2024-11-27 05:58:08.952451', '7', 'Prueba 3', 2, '[]', 9, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(12, 'api', 'etapafinal'),
(11, 'api', 'etapainicial'),
(10, 'api', 'etapamedia'),
(9, 'api', 'publicaciones'),
(8, 'api', 'rol'),
(7, 'api', 'usuarios'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-11-16 23:23:46.077304'),
(2, 'auth', '0001_initial', '2024-11-16 23:23:47.125902'),
(3, 'admin', '0001_initial', '2024-11-16 23:23:47.359714'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-11-16 23:23:47.383918'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-11-16 23:23:47.414103'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-11-16 23:23:47.554929'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-11-16 23:23:47.653659'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-11-16 23:23:47.686662'),
(9, 'auth', '0004_alter_user_username_opts', '2024-11-16 23:23:47.716430'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-11-16 23:23:47.825507'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-11-16 23:23:47.836140'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-11-16 23:23:47.866821'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-11-16 23:23:47.907050'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-11-16 23:23:47.946224'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-11-16 23:23:48.026720'),
(16, 'auth', '0011_update_proxy_permissions', '2024-11-16 23:23:48.057574'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-11-16 23:23:48.097011'),
(18, 'sessions', '0001_initial', '2024-11-16 23:23:48.173668'),
(19, 'api', '0001_initial', '2024-11-17 00:21:34.454974'),
(20, 'api', '0002_auto_20241119_1424', '2024-11-19 19:25:18.790282'),
(21, 'api', '0003_usuarios_rol', '2024-11-19 19:34:31.009689'),
(22, 'api', '0004_auto_20241119_1650', '2024-11-19 21:52:55.039863'),
(23, 'api', '0005_alter_usuarios_correo', '2024-11-19 21:52:55.195894'),
(24, 'api', '0006_auto_20241121_2213', '2024-11-22 03:14:00.880373'),
(25, 'api', '0007_usuarios_apellido_usuarios_celular_and_more', '2024-11-23 21:34:08.469431'),
(26, 'api', '0008_publicaciones_candidato', '2024-11-23 22:35:49.993672'),
(27, 'api', '0009_alter_publicaciones_estado_and_more', '2024-11-28 05:10:32.043879'),
(28, 'api', '0010_alter_publicaciones_titulo_alter_usuarios_correo', '2024-11-28 05:14:13.436141');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('hudtqu59l47f27ghi3ldzqmgk7urlpqt', '.eJxVjM0OwiAQhN-FsyHLKrB49N5nIMtPpWogKe3J-O62SQ-azGm-b-YtPK9L8WvPs5-SuAoUp98ucHzmuoP04HpvMra6zFOQuyIP2uXQUn7dDvfvoHAv29rg6JyifDZRMSYdtmBKF0bL6DBoHYlGdoYBLFlQhjI5BQogsiYjPl_ZNzcS:1tCT8h:g5cKlNmYMALurQn-6Ib_yJeLztI1DpHng6BqGfA9SAg', '2024-12-01 00:27:43.147912');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `api_etapafinal`
--
ALTER TABLE `api_etapafinal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_etapafinal_publicacion_id_d8f54adf_fk_api_publicaciones_id` (`publicacion_id`),
  ADD KEY `api_etapafinal_usuario_id_edc5de59_fk_api_usuarios_id` (`usuario_id`);

--
-- Indices de la tabla `api_etapainicial`
--
ALTER TABLE `api_etapainicial`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_etapainicial_publicacion_id_a580df52_fk_api_publicaciones_id` (`publicacion_id`),
  ADD KEY `api_etapainicial_usuario_id_a1989438_fk_api_usuarios_id` (`usuario_id`);

--
-- Indices de la tabla `api_etapamedia`
--
ALTER TABLE `api_etapamedia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_etapamedia_publicacion_id_096d9685_fk_api_publicaciones_id` (`publicacion_id`),
  ADD KEY `api_etapamedia_usuario_id_6a19987b_fk_api_usuarios_id` (`usuario_id`);

--
-- Indices de la tabla `api_publicaciones`
--
ALTER TABLE `api_publicaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_publicaciones_reclutador_id_58f7e3cf_fk_api_usuarios_id` (`reclutador_id`),
  ADD KEY `api_publicaciones_candidato_id_146a869c_fk_api_usuarios_id` (`candidato_id`);

--
-- Indices de la tabla `api_rol`
--
ALTER TABLE `api_rol`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `api_usuarios`
--
ALTER TABLE `api_usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_usuarios_rol_id_7cec5696_fk_api_rol_id` (`rol_id`);

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `api_etapafinal`
--
ALTER TABLE `api_etapafinal`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `api_etapainicial`
--
ALTER TABLE `api_etapainicial`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `api_etapamedia`
--
ALTER TABLE `api_etapamedia`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `api_publicaciones`
--
ALTER TABLE `api_publicaciones`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `api_rol`
--
ALTER TABLE `api_rol`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `api_usuarios`
--
ALTER TABLE `api_usuarios`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `api_etapafinal`
--
ALTER TABLE `api_etapafinal`
  ADD CONSTRAINT `api_etapafinal_publicacion_id_d8f54adf_fk_api_publicaciones_id` FOREIGN KEY (`publicacion_id`) REFERENCES `api_publicaciones` (`id`),
  ADD CONSTRAINT `api_etapafinal_usuario_id_edc5de59_fk_api_usuarios_id` FOREIGN KEY (`usuario_id`) REFERENCES `api_usuarios` (`id`);

--
-- Filtros para la tabla `api_etapainicial`
--
ALTER TABLE `api_etapainicial`
  ADD CONSTRAINT `api_etapainicial_publicacion_id_a580df52_fk_api_publicaciones_id` FOREIGN KEY (`publicacion_id`) REFERENCES `api_publicaciones` (`id`),
  ADD CONSTRAINT `api_etapainicial_usuario_id_a1989438_fk_api_usuarios_id` FOREIGN KEY (`usuario_id`) REFERENCES `api_usuarios` (`id`);

--
-- Filtros para la tabla `api_etapamedia`
--
ALTER TABLE `api_etapamedia`
  ADD CONSTRAINT `api_etapamedia_publicacion_id_096d9685_fk_api_publicaciones_id` FOREIGN KEY (`publicacion_id`) REFERENCES `api_publicaciones` (`id`),
  ADD CONSTRAINT `api_etapamedia_usuario_id_6a19987b_fk_api_usuarios_id` FOREIGN KEY (`usuario_id`) REFERENCES `api_usuarios` (`id`);

--
-- Filtros para la tabla `api_publicaciones`
--
ALTER TABLE `api_publicaciones`
  ADD CONSTRAINT `api_publicaciones_candidato_id_146a869c_fk_api_usuarios_id` FOREIGN KEY (`candidato_id`) REFERENCES `api_usuarios` (`id`),
  ADD CONSTRAINT `api_publicaciones_reclutador_id_58f7e3cf_fk_api_usuarios_id` FOREIGN KEY (`reclutador_id`) REFERENCES `api_usuarios` (`id`);

--
-- Filtros para la tabla `api_usuarios`
--
ALTER TABLE `api_usuarios`
  ADD CONSTRAINT `api_usuarios_rol_id_7cec5696_fk_api_rol_id` FOREIGN KEY (`rol_id`) REFERENCES `api_rol` (`id`);

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
