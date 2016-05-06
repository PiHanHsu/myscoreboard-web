class ScoreRecordsController < ApplicationController
  def index

    # 若使用者沒有id 會跳到輸入id的頁面
    if current_user.userid == nil
      redirect_to enteruserid_path
    end
    # 若使用者沒有id 會跳到輸入id的頁面

    @team = Team.first
    @males = @team.users.where( :gender => "male")
    @females = @team.users.where( :gender => "female")

  end
end
