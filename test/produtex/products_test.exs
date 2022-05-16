defmodule Produtex.ProductsTest do
  use Produtex.DataCase

  alias Produtex.Products

  describe "products" do
    alias Produtex.Products.Product

    import Produtex.ProductsFixtures

    @invalid_attrs %{gluten: nil, gtin: nil, milk: nil, name: nil, nuts: nil, vegan: nil, veggie: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{gluten: true, gtin: "some gtin", milk: true, name: "some name", nuts: true, vegan: true, veggie: true}

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.gluten == true
      assert product.gtin == "some gtin"
      assert product.milk == true
      assert product.name == "some name"
      assert product.nuts == true
      assert product.vegan == true
      assert product.veggie == true
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{gluten: false, gtin: "some updated gtin", milk: false, name: "some updated name", nuts: false, vegan: false, veggie: false}

      assert {:ok, %Product{} = product} = Products.update_product(product, update_attrs)
      assert product.gluten == false
      assert product.gtin == "some updated gtin"
      assert product.milk == false
      assert product.name == "some updated name"
      assert product.nuts == false
      assert product.vegan == false
      assert product.veggie == false
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end
end
