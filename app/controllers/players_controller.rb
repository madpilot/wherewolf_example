class PlayersController < ApplicationController
  def index
    @players = Player.from_query(params[:query]) if params[:query]
    @players = Player.all unless params[:query]
  rescue Parslet::ParseFailed
    @players = Player.all 
    flash.now[:error] = "Parsing query failed"
  end
end
