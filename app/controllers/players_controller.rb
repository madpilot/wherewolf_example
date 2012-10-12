class PlayersController < ApplicationController
  def index
    @players = Player.where_query(params[:query]) unless params[:query].empty? if params[:query]
    @players = Player.all unless params[:query]

    @players = @players.order_query(params[:order]) unless params[:order].empty? if params[:order]
  rescue Wherewolf::ParseError => e
    @players = Player.all
    @error = e
    range = params[:query][e.position-4..e.position+4]
    flash.now[:error] = "Parsing query failed near position: #{e.position}"
  end
end
