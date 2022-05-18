defmodule Produtex.Products.Product do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :gluten, :boolean, default: false
    field :gtin, :string
    field :milk, :boolean, default: false
    field :name, :string
    field :nuts, :boolean, default: false
    field :vegan, :boolean, default: false
    field :veggie, :boolean, default: false

    timestamps()
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :gtin, :milk, :nuts, :gluten, :vegan, :veggie])
    |> validate_required([:name, :gtin, :milk, :nuts, :gluten, :vegan, :veggie])
  end
end
