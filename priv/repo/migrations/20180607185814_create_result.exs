defmodule Football.Repo.Migrations.CreateResult do
  use Ecto.Migration

  def change do
    create table(:results) do
      add :division, :string
      add :season, :string
      add :game_date, :date
      add :home_team, :string
      add :away_team, :string
      add :fthg, :integer
      add :ftag, :integer
      add :ftr, :string
      add :hthg, :integer
      add :htag, :integer
      add :htr, :string

      timestamps()
    end
  end
end
