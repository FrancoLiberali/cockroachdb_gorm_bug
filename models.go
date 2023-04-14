package main

import (
	"time"

	uuid "github.com/google/uuid"
	"gorm.io/gorm"
)

type BaseModel struct {
	ID        uuid.UUID `gorm:"primarykey;type:uuid;default:uuid_generate_v4()"`
	CreatedAt time.Time
	UpdatedAt time.Time
	DeletedAt gorm.DeletedAt `gorm:"index"`
}

type Model1 struct {
	BaseModel

	Value string
	List  []*Model2 // HasMany Model2
}

type Model2 struct {
	BaseModel

	Value string

	// GORM relations
	Model1ID uuid.UUID // foreign key
}

type Model3 struct {
	BaseModel

	Value string
	List  []*Model4 // HasMany Model4

	// GORM relations
	Model1ID uuid.UUID // BelongsTo Model1
	Model1   *Model1   // BelongsTo Model1
}

type Model4 struct {
	BaseModel

	Value int

	// GORM relations
	Model3ID uuid.UUID // foreign key
	Model2ID uuid.UUID // BelongsTo Model2
	Model2   *Model2   // BelongsTo Model2
}
