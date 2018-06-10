defmodule Telefonos.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :telephone, :string
    end
    create unique_index(:users, [:telephone])
  end
end
