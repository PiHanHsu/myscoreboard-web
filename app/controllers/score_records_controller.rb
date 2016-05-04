class ScoreRecordsController < ApplicationController
  def index
    @team = Team.first
    @males = @team.users.where( :gender => "male")
    @females = @team.users.where( :gender => "female")

  end
end
