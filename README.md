# Bug using Gorm and CockroachDB

In this repository you will find a case that generates a bug in the use of gorm (gorm.io/gorm) with CockroachDB. The same case can be run on Postgres to verify that the bug does not happen in that case.

To run the scenario without bug (Postgres):

`./run_postgres.sh`

To run the scenario with bug (CockroachDB):

`./run_cockroach.sh`

## Versions used

Gorm: v1.25.0
CockroachDB: v22.2.7
Postgres: v15.2
