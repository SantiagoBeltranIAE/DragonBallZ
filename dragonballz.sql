-- ====================================
-- 🐉 BASE DE DATOS DRAGON BALL Z 🐉
-- ====================================

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS dragonballz CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE dragonballz;

-- ====================================
-- TABLA: usuarios (Guerreros Z)
-- ====================================
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password CHAR(60) NOT NULL, -- Cambiado a CHAR(60) para hashes bcrypt
    email VARCHAR(100) UNIQUE,
    nombre_completo VARCHAR(100),
    nivel_poder INT DEFAULT 1000,
    raza ENUM('Saiyajin', 'Humano', 'Namekiano', 'Androide', 'Majin', 'Otro') DEFAULT 'Humano',
    planeta_origen VARCHAR(50) DEFAULT 'Tierra',
    tecnica_especial VARCHAR(100),
    transformacion VARCHAR(50),
    ki_actual INT DEFAULT 1000,
    ki_maximo INT DEFAULT 5000,
    estado ENUM('Activo', 'Entrenando', 'Descansando', 'En Batalla') DEFAULT 'Activo',
    experiencia INT DEFAULT 0,
    victorias INT DEFAULT 0,
    derrotas INT DEFAULT 0,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ultima_conexion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ====================================
-- TABLA: tarjetas (Cartas de Guerreros)
-- ====================================
CREATE TABLE tarjetas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    titulo VARCHAR(150),
    descripcion TEXT,
    imagen_url VARCHAR(255),
    nivel_poder INT DEFAULT 1000,
    raza VARCHAR(50),
    planeta_origen VARCHAR(50),
    tecnica_principal VARCHAR(100),
    transformaciones TEXT,
    ki_base INT DEFAULT 1000,
    fuerza INT DEFAULT 50,
    velocidad INT DEFAULT 50,
    resistencia INT DEFAULT 50,
    inteligencia INT DEFAULT 50,
    rareza ENUM('Común', 'Poco Común', 'Raro', 'Épico', 'Legendario', 'Mítico') DEFAULT 'Común',
    serie ENUM('Dragon Ball', 'Dragon Ball Z', 'Dragon Ball GT', 'Dragon Ball Super') DEFAULT 'Dragon Ball Z',
    saga VARCHAR(50),
    estado ENUM('Activo', 'Bloqueado', 'Especial') DEFAULT 'Activo',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ====================================
-- TABLA: usuario_tarjetas (Colección de cartas por usuario)
-- ====================================
CREATE TABLE usuario_tarjetas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    tarjeta_id INT NOT NULL,
    fecha_obtencion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nivel_carta INT DEFAULT 1,
    experiencia_carta INT DEFAULT 0,
    favorita BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (tarjeta_id) REFERENCES tarjetas(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_card (usuario_id, tarjeta_id)
);

-- ====================================
-- INSERTAR USUARIOS DE EJEMPLO CON PASSWORD HASH (bcrypt generados de ejemplo)
-- PASSWORDS:
-- goku:      kamehameha123
-- vegeta:    principe123
-- gohan:     mystic123
-- piccolo:   namek123
-- krillin:   destructo123
-- yamcha:    lobo123
-- Los hashes aquí son de ejemplo, debes generar los reales en tu backend con bcrypt.
INSERT INTO usuarios (username, password, email, nombre_completo, nivel_poder, raza, planeta_origen, tecnica_especial, transformacion, ki_maximo, victorias, derrotas) VALUES
('goku',    '$2y$10$72bNf1koag6P7WnQ8R6G0uU1JpTnK9FvLxQH8vQ7z1E6N5N3JpZfPO', 'goku@dragonball.com',    'Son Goku',   9000, 'Saiyajin', 'Vegeta (criado en Tierra)', 'Kamehameha',                'Super Saiyajin Blue',          50000, 25, 5),
('vegeta',  '$2y$10$82bNf1koag6P7WnQ8R6G0uU1JpTnK9FvLxQH8vQ7z1E6N5N3JpZfPN', 'vegeta@saiyajin.com',   'Vegeta',     8500, 'Saiyajin', 'Vegeta',                    'Big Bang Attack',            'Super Saiyajin Blue Evolution',48000, 22, 8),
('gohan',   '$2y$10$92bNf1koag6P7WnQ8R6G0uU1JpTnK9FvLxQH8vQ7z1E6N5N3JpZfPQ', 'gohan@dragonball.com',   'Son Gohan',  7500, 'Saiyajin', 'Tierra',                    'Masenko',                    'Ultimate Gohan',               40000, 15, 3),
('piccolo', '$2y$10$A2bNf1koag6P7WnQ8R6G0uU1JpTnK9FvLxQH8vQ7z1E6N5N3JpZfPR', 'piccolo@namek.com',      'Piccolo',    6000, 'Namekiano','Namek',                     'Special Beam Cannon',         'Gigantificación',              25000, 18, 7),
('krillin', '$2y$10$B2bNf1koag6P7WnQ8R6G0uU1JpTnK9FvLxQH8vQ7z1E6N5N3JpZfPS', 'krillin@dragonball.com', 'Krillin',    3000, 'Humano',   'Tierra',                    'Destructo Disc',              'Ninguna',                      15000, 12, 10),
('yamcha',  '$2y$10$C2bNf1koag6P7WnQ8R6G0uU1JpTnK9FvLxQH8vQ7z1E6N5N3JpZfPT', 'yamcha@dragonball.com',  'Yamcha',     2500, 'Humano',   'Tierra',                    'Wolf Fang Fist',              'Ninguna',                      12000, 8, 15);

-- ====================================
-- INSERTAR TARJETAS DE GUERREROS
-- ====================================
INSERT INTO tarjetas (nombre, titulo, descripcion, imagen_url, nivel_poder, raza, planeta_origen, tecnica_principal, transformaciones, ki_base, fuerza, velocidad, resistencia, inteligencia, rareza, serie, saga, estado) VALUES
('Son Goku',   '🥋 El Guerrero Saiyajin Legendario', 'El legendario Guerrero Saiyajin criado en la Tierra. Con su corazón puro y determinación inquebrantable, siempre busca superar sus límites y proteger a sus seres queridos.', 'https://via.placeholder.com/300x400?text=Goku', 9000, 'Saiyajin', 'Vegeta (criado en Tierra)', 'Kamehameha', 'Super Saiyajin, Super Saiyajin Blue, Ultra Instinto', 9000, 95, 95, 90, 80, 'Legendario', 'Dragon Ball Z', 'Saga Freezer', 'Activo'),
('Vegeta',     '👑 El Príncipe de los Saiyajins',     'El Príncipe de los Saiyajins, orgulloso y poderoso. Su rivalidad con Goku lo ha llevado a alcanzar niveles de poder inimaginables en su búsqueda por superar sus límites.', 'https://via.placeholder.com/300x400?text=Vegeta', 8500, 'Saiyajin', 'Vegeta', 'Big Bang Attack', 'Super Saiyajin, Super Saiyajin Blue Evolution', 8500, 90, 93, 88, 85, 'Legendario', 'Dragon Ball Z', 'Saga Majin Buu', 'Activo'),
('Son Gohan',  '📚 El Guerrero Estudioso',            'Hijo de Goku, mitad Saiyajin y mitad humano. Posee un potencial oculto increíble que se desata cuando sus seres queridos están en peligro.', 'https://via.placeholder.com/300x400?text=Gohan', 7500, 'Saiyajin', 'Tierra', 'Masenko', 'Super Saiyajin, Ultimate Gohan', 7500, 87, 90, 85, 90, 'Épico', 'Dragon Ball Z', 'Saga Cell', 'Activo'),
('Piccolo',    '🧘 El Guerrero Namekiano',            'El guerrero Namekiano que pasó de ser enemigo a uno de los protectores más leales de la Tierra. Mentor de Gohan y estratega excepcional.', 'https://via.placeholder.com/300x400?text=Piccolo', 6000, 'Namekiano', 'Namek', 'Special Beam Cannon', 'Gigantificación, Fusión con Kami', 6000, 80, 75, 85, 95, 'Épico', 'Dragon Ball Z', 'Saga Saiyajin', 'Activo'),
('Krillin',    '⚡ El Humano Más Fuerte',             'El humano más fuerte de la Tierra y mejor amigo de Goku. A pesar de no ser Saiyajin, su valentía y técnicas especiales lo convierten en un guerrero formidable.', 'https://via.placeholder.com/300x400?text=Krillin', 3000, 'Humano', 'Tierra', 'Destructo Disc', 'Ninguna', 3000, 70, 80, 60, 75, 'Raro', 'Dragon Ball Z', 'Saga Freezer', 'Activo'),
('Yamcha',     '🐺 El Guerrero del Desierto',         'Ex-bandido del desierto convertido en guerrero Z. Conocido por su técnica del Kamehameha del Lobo y su espíritu luchador inquebrantable.', 'https://via.placeholder.com/300x400?text=Yamcha', 2500, 'Humano', 'Tierra', 'Wolf Fang Fist', 'Ninguna', 2500, 65, 75, 55, 70, 'Común', 'Dragon Ball Z', 'Saga Saiyajin', 'Activo'),
('Freezer',    '❄️ El Emperador del Universo',        'El tirano galáctico que aterrorizó el universo durante décadas. Poderoso y despiadado, responsable de la destrucción del planeta Vegeta.', 'https://via.placeholder.com/300x400?text=Freezer', 14000, 'Otro', 'Desconocido', 'Death Beam', 'Forma Final, Golden Freezer', 14000, 95, 85, 90, 85, 'Legendario', 'Dragon Ball Z', 'Saga Freezer', 'Activo'),
('Cell',       '🧬 El Androide Perfecto',             'El bio-androide creado por el Dr. Gero que absorbió las células de los guerreros más poderosos. Busca alcanzar la perfección absoluta.', 'https://via.placeholder.com/300x400?text=Cell', 12000, 'Androide', 'Laboratorio Gero', 'Kamehameha', 'Forma Perfecta, Super Perfecto', 12000, 93, 88, 92, 88, 'Legendario', 'Dragon Ball Z', 'Saga Cell', 'Activo'),
('Majin Buu',  '🍭 El Demonio Rosa',                  'Una antigua criatura mágica de poder inmenso. A pesar de su apariencia infantil, posee una fuerza destructiva capaz de eliminar planetas enteros.', 'https://via.placeholder.com/300x400?text=Majin+Buu', 12500, 'Majin', 'Desconocido', 'Candy Beam', 'Buu Malvado, Buu Bueno, Kid Buu', 12500, 97, 80, 95, 70, 'Legendario', 'Dragon Ball Z', 'Saga Majin Buu', 'Activo'),
('Trunks',     '⚔️ El Guerrero del Futuro',           'Hijo de Vegeta y Bulma, viene del futuro para advertir sobre los androides. Valiente y determinado a proteger la Tierra.', 'https://via.placeholder.com/300x400?text=Trunks', 8000, 'Saiyajin', 'Tierra', 'Burning Attack', 'Super Saiyajin', 8000, 85, 87, 80, 83, 'Épico', 'Dragon Ball Z', 'Saga Androides', 'Activo'),
('Goten',      '🎮 El Joven Saiyajin',                'Hijo menor de Goku, hermano de Gohan. A pesar de su corta edad, posee un talento natural extraordinario para las artes marciales.', 'https://via.placeholder.com/300x400?text=Goten', 3000, 'Saiyajin', 'Tierra', 'Kamehameha', 'Super Saiyajin', 3000, 72, 80, 65, 78, 'Raro', 'Dragon Ball Z', 'Saga Majin Buu', 'Activo'),
('Gotenks',    '🤸 La Fusión Definitiva',              'La fusión entre Goten y Trunks mediante la Danza de la Fusión. Combina el poder de ambos jóvenes Saiyajins con una personalidad traviesa.', 'https://via.placeholder.com/300x400?text=Gotenks', 9500, 'Saiyajin', 'Tierra', 'Super Ghost Kamikaze Attack', 'Super Saiyajin 3', 9500, 90, 95, 90, 85, 'Épico', 'Dragon Ball Z', 'Saga Majin Buu', 'Activo');

-- ====================================
-- ASIGNAR TARJETAS A USUARIOS
-- ====================================
-- Goku obtiene algunas cartas
INSERT INTO usuario_tarjetas (usuario_id, tarjeta_id, nivel_carta, experiencia_carta, favorita) VALUES
(1, 1, 5, 1000, TRUE),  -- Goku tiene su propia carta como favorita
(1, 2, 3, 500, FALSE),  -- Goku tiene la carta de Vegeta
(1, 3, 4, 750, FALSE),  -- Goku tiene la carta de Gohan
(1, 4, 2, 200, FALSE);  -- Goku tiene la carta de Piccolo

-- Vegeta obtiene algunas cartas
INSERT INTO usuario_tarjetas (usuario_id, tarjeta_id, nivel_carta, experiencia_carta, favorita) VALUES
(2, 2, 5, 1200, TRUE),  -- Vegeta tiene su propia carta como favorita
(2, 1, 4, 800, FALSE),  -- Vegeta tiene la carta de Goku
(2, 10, 3, 600, FALSE), -- Vegeta tiene la carta de Trunks
(2, 7, 2, 300, FALSE);  -- Vegeta tiene la carta de Freezer

-- Gohan obtiene algunas cartas
INSERT INTO usuario_tarjetas (usuario_id, tarjeta_id, nivel_carta, experiencia_carta, favorita) VALUES
(3, 3, 5, 900, TRUE),   -- Gohan tiene su propia carta como favorita
(3, 1, 3, 400, FALSE),  -- Gohan tiene la carta de Goku
(3, 4, 4, 700, FALSE),  -- Gohan tiene la carta de Piccolo
(3, 8, 2, 250, FALSE);  -- Gohan tiene la carta de Cell

-- ====================================
-- ÍNDICES PARA OPTIMIZACIÓN
-- ====================================
CREATE INDEX idx_usuarios_username ON usuarios(username);
CREATE INDEX idx_usuarios_email ON usuarios(email);
CREATE INDEX idx_usuarios_nivel_poder ON usuarios(nivel_poder);
CREATE INDEX idx_tarjetas_nombre ON tarjetas(nombre);
CREATE INDEX idx_tarjetas_rareza ON tarjetas(rareza);
CREATE INDEX idx_tarjetas_nivel_poder ON tarjetas(nivel_poder);
CREATE INDEX idx_usuario_tarjetas_usuario ON usuario_tarjetas(usuario_id);
CREATE INDEX idx_usuario_tarjetas_tarjeta ON usuario_tarjetas(tarjeta_id);
