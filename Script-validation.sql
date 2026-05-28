CREATE TABLE IF NOT EXISTS snils_validation (
    id INTEGER PRIMARY KEY,
    snils TEXT NOT NULL,
    is_valid INTEGER GENERATED ALWAYS AS (
        CASE
            WHEN length(snils) = 11
                 AND snils GLOB '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
                 AND (
                     CAST(substr(snils, 1, 9) AS INTEGER) <= 1001998
                     OR
                     CAST(
                         CASE
                             WHEN (
                                 CAST(substr(snils, 1, 1) AS INTEGER) * 9 +
                                 CAST(substr(snils, 2, 1) AS INTEGER) * 8 +
                                 CAST(substr(snils, 3, 1) AS INTEGER) * 7 +
                                 CAST(substr(snils, 4, 1) AS INTEGER) * 6 +
                                 CAST(substr(snils, 5, 1) AS INTEGER) * 5 +
                                 CAST(substr(snils, 6, 1) AS INTEGER) * 4 +
                                 CAST(substr(snils, 7, 1) AS INTEGER) * 3 +
                                 CAST(substr(snils, 8, 1) AS INTEGER) * 2 +
                                 CAST(substr(snils, 9, 1) AS INTEGER) * 1
                             ) % 101 IN (100, 101) THEN 0
                             ELSE (
                                 CAST(substr(snils, 1, 1) AS INTEGER) * 9 +
                                 CAST(substr(snils, 2, 1) AS INTEGER) * 8 +
                                 CAST(substr(snils, 3, 1) AS INTEGER) * 7 +
                                 CAST(substr(snils, 4, 1) AS INTEGER) * 6 +
                                 CAST(substr(snils, 5, 1) AS INTEGER) * 5 +
                                 CAST(substr(snils, 6, 1) AS INTEGER) * 4 +
                                 CAST(substr(snils, 7, 1) AS INTEGER) * 3 +
                                 CAST(substr(snils, 8, 1) AS INTEGER) * 2 +
                                 CAST(substr(snils, 9, 1) AS INTEGER) * 1
                             ) % 101
                         END
                     AS INTEGER) = CAST(substr(snils, 10, 2) AS INTEGER)
                 )
            THEN 1
            ELSE 0
        END
    ) STORED
);