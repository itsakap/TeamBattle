class Move < ActiveRecord::Base  
  include ActiveModel::Validations
  belongs_to :user
  validate :legal_target!

  def legal_target!
    # add error if team id in (user from target id) is the same as current_user's team id for attack,
    if move_choice == "Attack" || move_choice == "Heal"
      
      if illegal_target?
        errors.add(:target, "must be on appropriate team")
      end
    elsif move_choice == "Defend" || move_choice == "Surrender"
      unless target == 0 || target.nil?
        errors.add(:target, "cannot be any user given Defend or Surrender move_choice")
      end
    end

    # or different for heal
    # or not nil for Defend/Surrender
  end
  def illegal_target?
    current_user = User.find(user_id)
    target_user = User.find(target)
    (move_choice == "Attack" && current_user.team_id == target_user.team_id) || (move_choice == "Heal" && current_user.team_id != target_user.team_id) || target_user.eliminated?
  end
end
