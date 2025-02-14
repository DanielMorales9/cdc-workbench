CREATE TABLE pgbench_history (
    tid int,
    bid int,
    aid int,
    delta int,
    mtime timestamp,
    filler char(22)
);

CREATE TABLE pgbench_tellers (
    tid int NOT NULL,
    bid int,
    tbalance int,
    filler char(84)
)
WITH (
    fillfactor = 100
);

CREATE TABLE pgbench_accounts (
    aid int NOT NULL,
    bid int,
    abalance int,
    filler char(84)
)
WITH (
    fillfactor = 100
);

CREATE TABLE pgbench_branches (
    bid int NOT NULL,
    bbalance int,
    filler char(88)
)
WITH (
    fillfactor = 100
);

ALTER TABLE pgbench_branches
    ADD PRIMARY KEY (bid);

ALTER TABLE pgbench_tellers
    ADD PRIMARY KEY (tid);

ALTER TABLE pgbench_accounts
    ADD PRIMARY KEY (aid);

ALTER TABLE pgbench_history
    ADD PRIMARY KEY (bid, tid, aid);


CREATE USER cdc WITH REPLICATION ENCRYPTED PASSWORD 's3cr3tp4ss';
CREATE USER registry WITH REPLICATION ENCRYPTED PASSWORD 's3cr3tp4ss';

CREATE PUBLICATION cdc_pub FOR ALL TABLES;
CREATE DATABASE registry WITH OWNER registry