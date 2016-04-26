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
    @card = Card.create( card_params)
  end

  def create
   @card = Card.create( card_params)

   redirect_to cards_path

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
    params.require(:card).permit(:id, :user_id, :avatar, :card , :card_id)
  end

  def set_card
    @card = Card.find(params[:id])
  end

end
