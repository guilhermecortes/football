defmodule FootballWeb.ProtobuffsController do
  @moduledoc """
  The `Protobuffs` module is responsible to handle the protocol buffer request.
  """

  use FootballWeb, :controller
  import Ecto.Query

  def index(conn, %{"division" => division, "season" => season}) do
    # results = Football.Result.result_by(division, season)
    # protobuffs = Football.Protobufs.ResultResponse.new(result: results)
    # ========== Got stuck here trying to encode the list \/
    # Football.Protobufs.ResultResponse.encode(result: protobuffs)
    # Because of that, I decided to use only one record, encode it and return it.

    result = from(
      result in Football.Result,
      where: result.season == ^season and result.division == ^division,
      limit: 1
    ) |> Football.Repo.one

    protobuff = Football.Protobufs.Result.new(
      division: result.division,
      season: result.season,
      game_date: Date.to_iso8601(result.game_date),
      home_team: result.home_team,
      away_team: result.away_team,
      fthg: result.fthg,
      ftag: result.ftag,
      ftr: result.ftr,
      hthg: result.hthg,
      htag: result.htag,
      htr: result.htr
    )
    resp = Football.Protobufs.Result.encode(protobuff)

    conn
    |> put_resp_header("content-type", "application/octet-stream")
    |> send_resp(200, resp)
  end
end
