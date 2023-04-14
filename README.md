# Bug using Gorm and CockroachDB

In this repository you will find a case that generates a bug in the use of gorm (gorm.io/gorm) with CockroachDB. The same case can be run on Postgres to verify that the bug does not happen in that case.

To run the scenario without bug (Postgres):

`./run_postgres.sh`

To run the scenario with bug (CockroachDB):

`./run_cockroach.sh`

## Clues to the problem

To generate the bug the model has to be exactly as described. If, for example, we remove Model1 the bug does not occur. In the file with_and_without_model_1.sql we can find the queries that are generated by gorm in each case.

Apparently, the part of the query `ON CONFLICT ("id") DO UPDATE SET "model1_id"="excluded". "model1_id" RETURNING "id"` would be the one generating the problem.

## Versions used

Gorm: v1.25.0
CockroachDB: v22.2.7
Postgres: v15.2
