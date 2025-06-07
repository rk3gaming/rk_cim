CREATE TABLE IF NOT EXISTS `cim_markers` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `coords` longtext NOT NULL,
    `description` text NOT NULL,
    `days` int(11) NOT NULL,
    `created_by` varchar(50) NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `expires_at` timestamp NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE EVENT IF NOT EXISTS `cleanup_expired_markers`
ON SCHEDULE EVERY 1 DAY
DO
    DELETE FROM `cim_markers` WHERE `expires_at` < NOW();
