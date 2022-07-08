package graph

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.

import (
	"context"
	"fmt"
	"goeats/graph/generated"
	"goeats/graph/model"
	"goeats/utils"
)

func (r *mutationResolver) ProductSave(ctx context.Context, product model.ProductInput) (*model.Product, error) {
	db := utils.GetDB()

	if db == nil {
		return nil, fmt.Errorf("Database connection error")
	}

	row, err := db.Query("CALL ProductSave(?, ?, ?, ?)", product.ProductID, product.ProductName, product.Price, product.Quantity)

	if err != nil {
		return nil, fmt.Errorf("Error: %s", err)
	}

	if row.Next() {
		var prod model.Product

		row.Scan(&prod.ProductID, &prod.ProductName, &prod.Price, &prod.Quantity, &prod.CreatedDate)

		return &prod, nil
	}
	db.Close()
	return nil, fmt.Errorf("Error: Failed to create product")
}

func (r *mutationResolver) OrderSave(ctx context.Context, order *model.OrderInput) (*model.Order, error) {
	db := utils.GetDB()

	if db == nil {
		return nil, fmt.Errorf("Database connection error")
	}

	products := ""

	for _, p := range order.Products {
		products += p
	}

	row, err := db.Query(
		"CALL OrderSave(?, ?, ?, ?)",
		order.OrderID, order.PersonID, products, order.Status,
	)

	if err != nil {
		return nil, fmt.Errorf("Error: %s", err)
	}

	if row.Next() {
		var o model.Order
		row.Scan(&o.OrderID, &o.PersonID, &o.CreatedDate, &o.Status)
		return &o, nil
	}

	db.Close()
	return nil, fmt.Errorf("Error: %s", err)
}

func (r *mutationResolver) PersonSave(ctx context.Context, person *model.PersonInput) (*model.Person, error) {
	db := utils.GetDB()

	if db == nil {
		return nil, fmt.Errorf("Database connection error")
	}

	row, err := db.Query(
		"CALL PersonSave(?, ?, ?, ?)",
		person.PersonID, person.DisplayName, person.PhoneNumber, person.IsActive,
	)

	if err != nil {
		return nil, fmt.Errorf("Error: %s", err)
	}

	if row.Next() {
		var p model.Person
		row.Scan(&p.PersonID, &p.DisplayName, &p.PhoneNumber, &p.IsActive, &p.CreatedDate)

		return &p, nil
	}

	db.Close()
	return nil, fmt.Errorf("Error: %s", err)
}

func (r *queryResolver) Products(ctx context.Context, activeProduct *bool, pageNumber *int, recordCount *int) ([]*model.Product, error) {
	db := utils.GetDB()

	if db == nil {
		return nil, fmt.Errorf("Database connection error")
	}

	fmt.Println(activeProduct, pageNumber, recordCount)

	row, err := db.Query("CALL ProductListGet(?, ?, ?, 0)", activeProduct, pageNumber, recordCount)

	if err != nil {
		return nil, fmt.Errorf("Error: %s", err)
	}

	products := []*model.Product{}

	for row.Next() {
		var prod model.Product
		row.Scan(&prod.ProductID, &prod.ProductName, &prod.Price, &prod.Quantity, &prod.CreatedDate)
		products = append(products, &prod)
	}

	db.Close()
	return products, nil
}

func (r *queryResolver) Product(ctx context.Context, productID string) (*model.Product, error) {
	db := utils.GetDB()

	if db == nil {
		return nil, fmt.Errorf("Db connection error")
	}

	row, err := db.Query("CALL ProductGet(?)", productID)

	if err != nil {
		return nil, fmt.Errorf("Error: %s", err)
	}

	var p model.Product

	if row.Next() {
		row.Scan(&p.ProductID, &p.ProductName, &p.Price, &p.Quantity, &p.CreatedDate)
		db.Close()
		return &p, nil
	}

	db.Close()
	return nil, fmt.Errorf("Product not found")
}

func (r *queryResolver) Orders(ctx context.Context, start *string, end *string, status *model.Status, pageNumber *int, recordCount *int) ([]*model.Order, error) {
	db := utils.GetDB()

	if db == nil {
		return nil, fmt.Errorf("Db connection error")
	}

	fmt.Println(*start, *end, status, *pageNumber, *recordCount)
	row, err := db.Query("CALL OrderListGet(?,?,?,?,?, 0)", *start, *end, status, *pageNumber, *recordCount)

	if err != nil {
		return nil, fmt.Errorf("Error: %s", err)
	}

	orders := []*model.Order{}

	for row.Next() {
		var o model.Order
		row.Scan(&o.OrderID, &o.PersonID, &o.CreatedDate, &o.Status)
		orders = append(orders, &o)
	}

	db.Close()
	return orders, nil
}

func (r *queryResolver) Order(ctx context.Context, orderID string) (*model.Order, error) {
	panic(fmt.Errorf("not implemented"))
}

func (r *queryResolver) Person(ctx context.Context, personID *string, phoneNumber *string) (*model.Person, error) {
	fmt.Println("Person")
	db := utils.GetDB()

	if db == nil {
		return nil, fmt.Errorf("Db connection error")
	}

	row, err := db.Query("CALL PersonGet(?, ?)", personID, phoneNumber)

	if err != nil {
		return nil, fmt.Errorf("Error: %s", err)
	}

	var p model.Person

	if row.Next() {
		row.Scan(&p.PersonID, &p.DisplayName, &p.PhoneNumber, &p.CreatedDate, &p.IsActive)
		db.Close()
		return &p, nil
	}

	db.Close()
	return nil, fmt.Errorf("Person not found")
}

// Mutation returns generated.MutationResolver implementation.
func (r *Resolver) Mutation() generated.MutationResolver { return &mutationResolver{r} }

// Query returns generated.QueryResolver implementation.
func (r *Resolver) Query() generated.QueryResolver { return &queryResolver{r} }

type mutationResolver struct{ *Resolver }
type queryResolver struct{ *Resolver }

// !!! WARNING !!!
// The code below was going to be deleted when updating resolvers. It has been copied here so you have
// one last chance to move it out of harms way if you want. There are two reasons this happens:
//  - When renaming or deleting a resolver the old code will be put in here. You can safely delete
//    it when you're done.
//  - You have helper methods in this file. Move them out to keep these resolver files clean.
func (r *mutationResolver) Createproduct(ctx context.Context, product model.ProductInput) (*model.Product, error) {
	panic(fmt.Errorf("not implemented"))
}
