package utils

import (
	"database/sql"
	"fmt"

	_ "github.com/go-sql-driver/mysql"
)

func GetDB() (*sql.DB) {
	db, ok := sql.Open("mysql", "root:password@tcp(127.0.0.1:3306)/goeats")

	if ok != nil {
		fmt.Println("Error:", ok)
		return  nil
	}

	return db
}