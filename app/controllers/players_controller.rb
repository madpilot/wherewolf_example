class PlayersController < ApplicationController
  def index
    @players = Player.from_query(params[:query]) if params[:query]
    @players = Player.all unless params[:query]
  rescue Wherewolf::ParseError => e
    @players = Player.all
    @error = e
    range = params[:query][e.position-4..e.position+4]
    flash.now[:error] = "Parsing query failed near position: #{e.position}"
  end
end
