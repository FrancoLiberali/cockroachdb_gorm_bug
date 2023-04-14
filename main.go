package main

import (
	"fmt"
	"log"
	"os"
	"time"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

var Tries = 10

func main() {
	dbChoose := os.Args[1]

	var port int
	var user string
	if dbChoose == "postgres" {
		port = 5432
		user = "postgres"
	} else {
		port = 26257
		user = "root"
	}

	db, err := initializeDBFromDsn(
		fmt.Sprintf(
			"user=%s password=postgres host=localhost port=%d sslmode=disable database=postgres",
			user, port,
		),
	)
	if err != nil {
		log.Fatalln(err)
	}

	for _, table := range []any{Model4{}, Model3{}, Model2{}, Model1{}} {
		err := db.Unscoped().Where("1 = 1").Delete(table).Error
		if err != nil {
			log.Fatalln("could not clean database: ", err)
		}
	}

	makeBug(db)

	log.Println("Bug not produced")
	if dbChoose == "postgres" {
		log.Println("This is normal as your are using postgres, now try with cockroach")
	} else {
		log.Println("In cockroach the production of the bug is not deterministic, try again")
	}
}

func initializeDBFromDsn(dsn string) (*gorm.DB, error) {
	var database *gorm.DB
	var err error
	for numberRetry := 0; numberRetry < 10; numberRetry++ {
		database, err = gorm.Open(
			postgres.Open(dsn),
			&gorm.Config{
				Logger: logger.Default.LogMode(logger.Info),
			},
		)
		if err == nil {
			break
		}

		time.Sleep(1 * time.Second)
	}

	if err != nil {
		return nil, err
	}

	err = database.AutoMigrate(Model1{}, Model2{}, Model3{}, Model4{})
	if err != nil {
		return nil, err
	}

	return database, nil
}

func makeBug(db *gorm.DB) {
	model1 := Model1{Value: "model1"}

	model2_1 := Model2{Value: "model2_1"}
	model2_2 := Model2{Value: "model2_2"}

	model1.List = append(model1.List, &model2_1, &model2_2)

	err := db.Create(&model1).Error
	if err != nil {
		log.Fatalln(err)
	}

	model2_1ID := model2_1.ID
	model2_2ID := model2_2.ID

	models3 := []*Model3{}

	for i := 0; i < Tries; i++ {
		models3 = append(models3, createModel3(db, &model1, &model2_1, &model2_2, i))
	}

	for _, model3 := range models3 {
		for _, model4 := range model3.List {
			if (model4.Value%2 == 0 && model4.Model2.ID != model2_1ID) || (model4.Value%2 == 1 && model4.Model2.ID != model2_2ID) {
				log.Printf("Model2 ids have been exchanged, used to be %v, %v; now it is %v %v", model2_1ID, model2_2ID, model2_1.ID, model2_2.ID)
				log.Fatalln("BUG PRODUCED: a model 4 has the incorrect model 2: ", model4)
			}
		}
	}

}

func createModel3(db *gorm.DB, model1 *Model1, model2_1 *Model2, model2_2 *Model2, run int) *Model3 {
	model3 := Model3{Value: fmt.Sprintf("model3_%d", run), Model1: model1}

	model4_1 := Model4{Value: 2 * run, Model2: model2_1}
	model4_2 := Model4{Value: 2*run + 1, Model2: model2_2}

	model3.List = append(model3.List, &model4_1, &model4_2)

	err := db.Create(&model3).Error
	if err != nil {
		log.Fatalln(err)
	}

	return &model3
}
