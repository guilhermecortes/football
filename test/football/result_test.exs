defmodule Football.ResultTest do
  use FootballWeb.ConnCase
  use Ecto.Schema
  import Football.Factory

  describe ".available_leagues" do
    test "returns all available leagues and seasons" do
      result1 = insert(:result, division: "SP1", season: "201617", home_team: "Real Madrid")
      result2 = insert(:result, division: "SP1", season: "201718", home_team: "Real Madrid")
      result3 = insert(:result, division: "SP2", season: "201718", home_team: "Real Madrid")
      _result = insert(:result, division: "SP2", season: "201718", home_team: "Barcelona")

      res = Football.Result.available_leagues

      assert(res, [result1, result2, result3])
    end
  end

  describe ".result_by" do
    test "returns all results for given division and season" do
      result1 = insert(:result, division: "SP1", season: "201617", home_team: "Real Madrid")
      result2 = insert(:result, division: "SP1", season: "201617", home_team: "Barcelona")
      result3 = insert(:result, division: "SP1", season: "201617", home_team: "Atletico Madrid")
      _result = insert(:result, division: "SP1", season: "201718", home_team: "Real Madrid")
      _result = insert(:result, division: "SP2", season: "201617", home_team: "Real Madrid")
      _result = insert(:result, division: "SP2", season: "201718", home_team: "Barcelona")

      res = Football.Result.result_by("SP1", "201617")

      assert(res, [result1, result2, result3])
    end
  end
end
