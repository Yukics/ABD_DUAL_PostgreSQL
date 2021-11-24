BEGIN TRANSACTION;

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