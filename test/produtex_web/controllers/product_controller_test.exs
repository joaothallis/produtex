defmodule ProdutexWeb.ProductControllerTest do
  use ProdutexWeb.ConnCase

  import Produtex.ProductsFixtures

  alias Produtex.Products.Product

  @create_attrs %{
    gluten: true,
    gtin: "some gtin",
    milk: true,
    name: "some name",
    nuts: true,
    vegan: true,
    veggie: true
  }
  @update_attrs %{
    gluten: false,
    gtin: "some updated gtin",
    milk: false,
    name: "some updated name",
    nuts: false,
    vegan: false,
    veggie: false
  }
  @invalid_attrs %{
    gluten: nil,
    gtin: nil,
    milk: nil,
    name: nil,
    nuts: nil,
    vegan: nil,
    veggie: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product" do
    test "renders product when data is valid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.product_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "gluten" => true,
               "gtin" => "some gtin",
               "milk" => true,
               "name" => "some name",
               "nuts" => true,
               "vegan" => true,
               "veggie" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update product" do
    setup [:create_product]

    test "renders product when data is valid", %{conn: conn, product: %Product{id: id} = product} do
      conn = put(conn, Routes.product_path(conn, :update, product), product: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.product_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "gluten" => false,
               "gtin" => "some updated gtin",
               "milk" => false,
               "name" => "some updated name",
               "nuts" => false,
               "vegan" => false,
               "veggie" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, product: product} do
      conn = put(conn, Routes.product_path(conn, :update, product), product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product" do
    setup [:create_product]

    test "deletes chosen product", %{conn: conn, product: product} do
      conn = delete(conn, Routes.product_path(conn, :delete, product))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.product_path(conn, :show, product))
      end
    end
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end
end
