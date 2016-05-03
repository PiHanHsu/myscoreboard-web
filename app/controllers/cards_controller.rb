class CardsController < ApplicationController


before_action :authenticate_user!, :except => [:index]
before_action :set_card, :only => [:show, :update, :destroy]


  def new
    @card = Card.new
  end

  def index
    @cards = Card.all
  end

  def show
  end

  def create

    if params[:card] && params[:card][:avatar] && current_user.cards.create(card_params)
    else
    end

    redirect_to :back

  end

  def update
    @card.update( card_params )
    redirect_to card_path(@card)
  end

  def destroy
    @card.delete
    redirect_to cards_path
  end


  private

  def card_params
    params.require(:card).permit(:avatar)
  end

  def set_card
    @card = Card.find(params[:id])
  end

end
