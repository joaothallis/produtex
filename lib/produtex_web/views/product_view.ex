defmodule ProdutexWeb.ProductView do
  use ProdutexWeb, :view
  alias ProdutexWeb.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      name: product.name,
      gtin: product.gtin,
      milk: product.milk,
      nuts: product.nuts,
      gluten: product.gluten,
      vegan: product.vegan,
      veggie: product.veggie
    }
  end
end
