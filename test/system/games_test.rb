require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  #  test "Going to /new gives us a new random grid to play with" do
  #   visit new_url
  #   assert test: "New game"
  #   assert_selector "p", count: 11
  # end
  test "Goint to /new and enter random word will fail" do
    visit new_url
    fill_in "word", with: "zzzzzzz"
    click_on "Play"
    assert_text "Sorry but ZZZZZZZ can't be built out of "
  end

  test "Goint to /new and enter single concenent word will fail" do
    visit new_url
    fill_in "word", with: "c"
    click_on "Play"
    assert_text "Sorry but C does not seem to be a valid English word..."
  end

  # test "Goint to /new and enter real word word will succeed" do
  #   visit new_url
  #   fill_in "word", with: "a"
  #   click_on "Play"
  #   assert_text "Contratulations! A is a valid English word!"
  # end

  # test do
  # end
end
