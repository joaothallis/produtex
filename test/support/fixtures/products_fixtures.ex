defmodule Produtex.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Produtex.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        gluten: true,
        gtin: "some gtin",
        milk: true,
        name: "some name",
        nuts: true,
        vegan: true,
        veggie: true
      })
      |> Produtex.Products.create_product()

    product
  end
end
