class ApiV1::CardsController < ApiController


 # POST /pictures
  # POST /pictures.json
  def create

    if params[:avatar]
   # @card = Card.create(card_params)
    @card = Card.create(:avatar => params[:avatar])
    render :json => { :message => "Get pictures success!!! Yah!!" }, :status => 200
   else
     render :json => { :message => "Fail! " }, :status => 401
   end
  # private
  # def card_params
  #   params.require(:card).permit(:avatar)
  # end
  end


end
