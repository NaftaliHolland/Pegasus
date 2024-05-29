defmodule Payment.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string
    end
  end
end
