-- USEFULL
BEGIN TRANSACTION;
ROLLBACK;
END TRANSACTION;

-- 4 
BEGIN TRANSACTION;

UPDATE "tab" SET "text"='SUUUUUU' WHERE id=2;

-- 5 
BEGIN TRANSACTION;

UPDATE "tab" SET "text"='NOOOOOO' WHERE id=2;

-- 6
SELECT pid, usename, pg_blocking_pids(pid) as blocked_by, query as blocked_query
FROM pg_stat_activity
WHERE cardinality(pg_blocking_pids(pid)) > 0;

-- 7
BEGIN TRANSACTION;

UPDATE "tab" SET "text"='MAAAAOMENO' WHERE id=2;

-- 8
SELECT pid, usename, pg_blocking_pids(pid) as blocked_by, query as blocked_query
FROM pg_stat_activity
WHERE cardinality(pg_blocking_pids(pid)) > 0;

-- 9 
ROLLBACK;

-- 10
ROLLBACK;

-- 11
ROLLBACK;

-- 13
BEGIN TRANSACTION;

UPDATE "tab" SET "text"='SUUUUUU' WHERE id=2;

-- 14
BEGIN TRANSACTION;

UPDATE "tab" SET "text"='NOOOOOO' WHERE id=1;

-- 15
UPDATE "tab" SET "text"='UYUYUYUYU' WHERE id=1;

-- 16
SELECT pid, usename, pg_blocking_pids(pid) as blocked_by, query as blocked_query
FROM pg_stat_activity
WHERE cardinality(pg_blocking_pids(pid)) > 0;

-- 17
UPDATE "tab" SET "text"='LAQUEMOLIAO' WHERE id=2;