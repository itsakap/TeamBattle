module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "TeamBattle").join(" - ")
      end
    end
  end
  def team_captains_only(&block)
    block.call if current_user.try(:captain?)
  end
end
