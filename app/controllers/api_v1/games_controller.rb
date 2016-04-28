class ApiV1::GamesController < ApiController
    # before_action :authenticate_user!
    protect_from_forgery except: :create
	  def index

      #Ranking api for 3 game_types
      @single_records = Record.joins(:game).where( games: { team_id: params[:team_id], game_type: "single" } )
      @single_ranking = create_ranking(@single_records)

      @double_records = Record.joins(:game).where( games: { team_id: params[:team_id], game_type: "double" } )
      @double_ranking = create_ranking(@double_records)
      
      @mix_records = Record.joins(:game).where( games: { team_id: params[:team_id], game_type: "mix" } )
      @mix_ranking = create_ranking(@mix_records)

    end

  	def create

    	transaction = Game.transaction do
 			game = Game.create( :team_id => params[:team_id], :game_type => params[:game_type])

    		params[:scores].each do |key, value|

    			game.records.create(:game_id => game, :user_id => value["user"], :score => value["score"], :result => value["result"])
	    	end
    	end

    	if transaction
  	  	render :json => { :message => "Records Save Success." }
    	else
    		render :json => { :message => "Records Save Failed!" }, :status => 401
   		end
   	end

    def stats
      current_user = User.first
      @teams = current_user.teams.all
      
      @stats= @teams.map do |t|
        @user_records = current_user.records.joins(:game).where( games: { team_id: t.id } )
        @wins = @user_records.where( :result => "W" ).count
        @losses = @user_records.where( :result => "L" ).count
        @games = @wins + @losses
        @rate = @wins / (@wins + @losses)
        @points = @wins * 3 + @losses * 1

        { :wins => @wins,
          :losses => @losses,
          :games => @games,
          :rate => @rate,
          :points => @points }
        
      end
      
    end

    private
    def create_ranking(records)

      @records = records.where( :result => "W" ).group( :user_id ).count
      @record_losses = records.where( :result => "L" ).group( :user_id ).count

      @records.each do |p|
          @record_losses.each do |record|
          if record[0] == p[0]
                 p.push(record[1])
                 w = p[1].to_f
                 l = p[2].to_f
                 rate = w / (w + l) * 100
                 points = w * 3 + l * 1
                 p.push(rate.round(2)).push(points.round(0))
          end
       end
      end
        
      @records.each do |p|
          w = p[1].to_f
          unless p[2]
            points = w * 3
            p.push(0).push(1).push(points.round(0))
          end
      end
      
      @records.sort! {|a, b| b[4] <=> a[4] }
    end 

end
