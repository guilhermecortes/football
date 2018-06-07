defmodule Football.Result do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Football.{Result, Repo}

  schema "results" do
    field :division, :string
    field :season, :string
    field :game_date, :date
    field :home_team, :string
    field :away_team, :string
    field :fthg, :integer
    field :ftag, :integer
    field :ftr, :string
    field :hthg, :integer
    field :htag, :integer
    field :htr, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:division, :season, :game_date, :home_team, :away_team, :fthg, :ftag, :ftr, :hthg, :htag, :htr])
    |> validate_required([:division, :season, :game_date, :home_team, :away_team, :fthg, :ftag, :ftr, :hthg, :htag, :htr])
  end

  def available_leagues do
    query = from(result in Result, distinct: [result.division, result.season])
    query |> Repo.all
  end

  def result_by(division, season) do
    query = from(result in Result, where: result.season == ^season and result.division == ^division)

    query |> Repo.all
  end
end
