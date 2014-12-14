module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "TeamBattle").join(" - ")
      end
    end
  end
  
  def team_only(&block) #user should be on a team
    block.call if false
  end
  
  def no_team_only(&block) #user should not have a team
    block.call if false
  end
  
  
  def team_captains_only(&block) #user should be a team captain
    block.call if current_user.try(:captain?)
  end

  def no_game_only(&block)#team captain's team should not have a game
    block.call if false
  end

  def in_game_only(&block) #game should have started
    block.call if current_game.try(:started?)
  end
  
end
