defmodule Produtex.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :gtin, :string
      add :milk, :boolean, default: nil, null: true
      add :nuts, :boolean, default: nil, null: true
      add :gluten, :boolean, default: nil, null: true
      add :vegan, :boolean, default: nil, null: true
      add :veggie, :boolean, default: nil, null: true

      timestamps()
    end
  end
end
