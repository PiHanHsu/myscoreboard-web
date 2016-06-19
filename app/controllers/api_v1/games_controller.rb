class ApiV1::GamesController < ApiController
    before_action :authenticate_user!
    protect_from_forgery except: :create
	  def index

      #Ranking api for all teams/types ranking 
      @teams_ranking = current_user.teams.map do |team|
        team.users.each do |user|
          user.photo = user.get_photo_url
        end
                  
                   { team: team.name,
      male_single_ranking: team.male_single_ranking,
    female_single_ranking: team.female_single_ranking,
      male_double_ranking: team.male_double_ranking,
    female_double_ranking: team.female_double_ranking,
         male_mix_ranking: team.male_mix_ranking,
       female_mix_ranking: team.female_mix_ranking }
      end
    end

  	def create

    	transaction = Game.transaction do
 			game = Game.create( :team_id => params[:team_id], :game_type => params[:game_type])

    		params[:scores].each do |record|

    			game.records.create(:game_id => game, :user_id => record["user"], :score => record["score"], :result => record["result"])
	    	end
    	end

    	if transaction
  	  	render :json => { :message => "Records Save Success." }
    	else
    		render :json => { :message => "Records Save Failed!" }, :status => 401
   		end
   	end

    def stats
      
      @teams = current_user.teams.all
      
      @stats= @teams.map do |t|
        @user_records = current_user.records.joins(:game).where( games: { team_id: t.id } )
        @wins = @user_records.where( :result => "W" ).count
        @losses = @user_records.where( :result => "L" ).count
        @games = @wins + @losses
        @rate = @wins.to_f / (@wins.to_f + @losses.to_f) * 100
        @points = @wins * 3 + @losses * 1

        @last_3_games = t.last_3_games(current_user)
         
        @best_double_partner, @best_mix_partner = get_best_partners(t) 

        @best_double_partner_name ||= @best_double_partner.username if @best_double_partner.present?
        @best_double_partner_photo ||= @best_double_partner.get_photo_url if @best_double_partner.present?
        
        @best_mix_partner_name ||= @best_mix_partner.username if @best_mix_partner.present?
        @best_mix_partner_photo ||= @best_mix_partner.get_photo_url if @best_mix_partner.present?
         
        { :team => t.name,
          :wins => @wins,
          :losses => @losses,
          :games => @games,
          :rate => @rate.round(2),
          :points => @points,
          :last_3_games => @last_3_games,
          :best_double_partner_name => @best_double_partner_name,
          :best_double_partner_photo => @best_double_partner_photo,
          :best_mix_partner_name => @best_mix_partner_name,
          :best_mix_partner_photo => @best_mix_partner_photo }
      end
      
      @stats = @stats.sort {|a, b| b[:points] <=> a[:points] }

    end

    def today_games
      @team = Team.find(params[:team_id])
      @today_games = @team.today_games
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
      
      @records = @records.sort {|a, b| b[4] <=> a[4] }
    end 

    def get_best_partners(team)

      if current_user.gender == "male"
        double_teammates = team.users.where( :gender => "male" )
        mix_teammates = team.users.where( :gender => "female" )
      else
        double_teammates = team.users.where( :gender => "female" )
        mix_teammates = team.users.where( :gender => "male" )
      end

      #double_teammates.drop(current_user)

      double_teammates_standing = calculate_partner_standing(double_teammates)
      mix_teammates_standing = calculate_partner_standing(mix_teammates)

      return double_teammates_standing[0], mix_teammates_standing[0]

    end

end

    def calculate_partner_standing(teammates)

      user_win_games = current_user.records.where( result: "W").joins(:game).where( games: { team_id: params[:team_id] } ).pluck( :game_id )
      wins_with_teammates = Record.where( game_id: user_win_games ).where( :result => "L" ).group(:user).count

      user_loss_games = current_user.records.where( result: "L").joins(:game).where( games: { team_id: params[:team_id] } ).pluck( :game_id )
      losses_with_teammates = Record.where( game_id: user_loss_games ).where( :result => "W" ).group(:user).count
      
      teammates.map do |teammate|
        wins = 0
        losses = 0
        if wins_with_teammates[teammate]
          wins = wins_with_teammates[teammate]
        end
        if losses_with_teammates[teammate]
          losses = losses_with_teammates[teammate]
        end
        rate = wins.to_f / (wins.to_f + losses.to_f)
        {user: teammate,
         wins: wins,
         losses: losses,
         rate: rate.round(2)}
      end

      teammates = teammates.sort {|a, b| b[:rate] <=> a[:rate] }
    end
