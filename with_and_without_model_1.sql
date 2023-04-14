-- without model 1

023/04/14 16:39:40 /home/user/ditrit/badaas/cockroach_gorm_bug/main.go:127
[1.371ms] [rows:0] INSERT INTO "model2" ("created_at","updated_at","deleted_at","value","id") VALUES ('2023-04-14 16:39:40.459','2023-04-14 16:39:40.459',NULL,'model2_1','d5ca3dbd-455f-4aff-89a0-74a1cda6f44a'),('2023-04-14 16:39:40.469','2023-04-14 16:39:40.469',NULL,'model2_2','740bc117-aa5a-4832-9dbd-5fa307a72853') ON CONFLICT DO NOTHING RETURNING "id"

2023/04/14 16:39:40 /home/user/ditrit/badaas/cockroach_gorm_bug/main.go:127
[6.553ms] [rows:2] INSERT INTO "model4" ("created_at","updated_at","deleted_at","value","model3_id","model2_id") VALUES ('2023-04-14 16:39:40.589','2023-04-14 16:39:40.589',NULL,18,'3c153770-455f-4b40-afc4-f7841796333c','d5ca3dbd-455f-4aff-89a0-74a1cda6f44a'),('2023-04-14 16:39:40.589','2023-04-14 16:39:40.589',NULL,19,'3c153770-455f-4b40-afc4-f7841796333c','740bc117-aa5a-4832-9dbd-5fa307a72853') ON CONFLICT ("id") DO UPDATE SET "model3_id"="excluded"."model3_id" RETURNING "id"

2023/04/14 16:39:40 /home/user/ditrit/badaas/cockroach_gorm_bug/main.go:127
[13.463ms] [rows:1] INSERT INTO "model3" ("created_at","updated_at","deleted_at","value") VALUES ('2023-04-14 16:39:40.586','2023-04-14 16:39:40.586',NULL,'model3_9') RETURNING "id

-- with model 1

2023/04/14 16:37:26 /home/user/ditrit/badaas/cockroach_gorm_bug/main.go:126
[2.593ms] [rows:2] INSERT INTO "model2" ("created_at","updated_at","deleted_at","value","model1_id","id") VALUES ('2023-04-14 16:37:26.474','2023-04-14 16:37:26.474',NULL,'model2_1','edd3f5e9-e8e7-466a-a1a3-e6b6fb28f0d7','37dfd39e-c669-4f17-a81f-6a764fc8dda0'),('2023-04-14 16:37:26.474','2023-04-14 16:37:26.474',NULL,'model2_2','edd3f5e9-e8e7-466a-a1a3-e6b6fb28f0d7','9bc2bb12-30fb-4623-a832-7a8470d676f9') ON CONFLICT ("id") DO UPDATE SET "model1_id"="excluded"."model1_id" RETURNING "id"

2023/04/14 16:37:26 /home/user/ditrit/badaas/cockroach_gorm_bug/main.go:126
[4.261ms] [rows:0] INSERT INTO "model1" ("created_at","updated_at","deleted_at","value","id") VALUES ('2023-04-14 16:37:26.473','2023-04-14 16:37:26.473',NULL,'model1','edd3f5e9-e8e7-466a-a1a3-e6b6fb28f0d7') ON CONFLICT DO NOTHING RETURNING "id"

2023/04/14 16:37:26 /home/user/ditrit/badaas/cockroach_gorm_bug/main.go:126
[3.472ms] [rows:2] INSERT INTO "model4" ("created_at","updated_at","deleted_at","value","model3_id","model2_id") VALUES ('2023-04-14 16:37:26.629','2023-04-14 16:37:26.629',NULL,18,'e42d9707-89e5-4d02-b639-24161edacbfc','37dfd39e-c669-4f17-a81f-6a764fc8dda0'),('2023-04-14 16:37:26.629','2023-04-14 16:37:26.629',NULL,19,'e42d9707-89e5-4d02-b639-24161edacbfc','9bc2bb12-30fb-4623-a832-7a8470d676f9') ON CONFLICT ("id") DO UPDATE SET "model3_id"="excluded"."model3_id" RETURNING "id"

2023/04/14 16:37:26 /home/user/ditrit/badaas/cockroach_gorm_bug/main.go:126
[15.533ms] [rows:1] INSERT INTO "model3" ("created_at","updated_at","deleted_at","value","model1_id") VALUES ('2023-04-14 16:37:26.625','2023-04-14 16:37:26.625',NULL,'model3_9','edd3f5e9-e8e7-466a-a1a3-e6b6fb28f0d7') RETURNING "id"