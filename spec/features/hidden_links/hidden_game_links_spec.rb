# hidden_game_links_spec.rb
require 'spec_helper'
feature 'hiding game links' do
  let!(:team_a) { FactoryGirl.create(:team) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:team_captain_a) { FactoryGirl.create(:team_captain, team: team_a) }
  let!(:team_b) { FactoryGirl.create(:team) }
  let!(:team_captain_b) { FactoryGirl.create(:team_captain, team: team_b) }
  def cannot_see_any_game_links!
    visit '/'
    assert_no_link_for 'My Game'
    assert_no_link_for 'New Game'
    assert_no_link_for 'Join Game'
  end

  context 'anonymous user' do
    scenario 'cannot see ANY game links' do
      cannot_see_any_game_links!
    end
  end
  context "standard player" do
    before { sign_in_as!(user) }


    context 'not on team' do
      scenario 'cannot see ANY game links' do
        cannot_see_any_game_links!
      end
    end

    context 'on team' do
      before { join_team!(team_a) }
      context 'team not in game' do
        scenario 'cannot see ANY game links' do
          cannot_see_any_game_links!
        end
      end
      context 'team in game' do
        before do
          click_link 'Sign out'
          sign_in_as!(team_captain_a)
          create_game!
          click_link 'Sign out'
          sign_in_as!(user)
        end
        context 'game has not started' do
          scenario 'cannot see ANY game links' do
            cannot_see_any_game_links!
          end
        end
        context 'game has started' do
          before do
            click_link 'Sign out'
            sign_in_as!(team_captain_b)
            join_game!
            click_link 'Sign out'
            sign_in_as!(user)
          end
          scenario 'can see links for making move' do
            visit '/'
            assert_link_for 'My Game'
          end
          scenario 'cannot see game building links' do
            assert_no_link_for 'New Game'
            assert_no_link_for 'Join Game'
          end
        end
      end
    end
  end
  context 'team captain (on a team by default)' do
    before { sign_in_as!(team_captain_a) }
    context 'not in game' do
      scenario 'can see game building links' do
        assert_link_for 'New Game'
        assert_link_for 'Join Game'
      end
      scenario 'cannot see links for making move' do
        assert_no_link_for 'My Game'
      end
    end
    context 'in game' do
      before { create_game! }
      context 'game has not started' do
        scenario 'cannot see game building links' do
          assert_no_link_for 'New Game'
          assert_no_link_for 'Join Game'
        end
        scenario 'cannot see links for making move' do
          # subject to change
          assert_no_link_for 'My Game'
        end
      end
      context 'game has started' do
        before do
          click_link 'Sign out'
          sign_in_as!(team_captain_b)
          join_game!
          click_link 'Sign out'
          sign_in_as!(team_captain_a)
        end
        scenario 'cannot see game building links' do
          assert_no_link_for 'New Game'
          assert_no_link_for 'Join Game'
        end
        scenario 'can see links for making move' do
          assert_link_for 'My Game'
          # expect something to happen when click on My Game that might not happen if you click on it from somewhere else
        end
      end
    end
  end
end