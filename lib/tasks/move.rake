# move.rake
namespace :move do
  desc 'Victory or Death!'
  task fight: :environment do
    Game.in_progress.each do |game|
      game.users.alive.each do |user|
        unless user.move.target.nil? || user.move.target == 0
          target = User.find(user.move.target)
          if user.move.move_choice == 'attack'
            target[:hp] -= user.attack_power unless target.move.move_choice == "defend" || target[:eliminated?]
          elsif user.move.move_choice == "heal"
            target[:hp] += user.heal_power
          end
          target.save
        end
      end
      game.users.alive.each {|user| user.update(:eliminated? => true) if user.move.move_choice == 'surrender' || user.hp <= 0}
      game.teams.alive.each {|team| team.update(:eliminated? => true) if team.users.alive.size == 0 }
      if game.teams.alive.size <= 1
        # game over, draw game if both teams are eliminated, announce the winner if one remains
      end
    end
  end
end