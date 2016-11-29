require 'test_helper'

class GladiatorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gladiator = gladiators(:one)
  end

  test "should get index" do
    get gladiators_url
    assert_response :success
  end

  test "should get new" do
    get new_gladiator_url
    assert_response :success
  end

  test "should create gladiator" do
    assert_difference('Gladiator.count') do
      post gladiators_url, params: { gladiator: { birth: @gladiator.birth, chr: @gladiator.chr, con: @gladiator.con, death: @gladiator.death, dex: @gladiator.dex, fightStyle: @gladiator.fightStyle, firstfight: @gladiator.firstfight, hitmod: @gladiator.hitmod, hp: @gladiator.hp, initiative: @gladiator.initiative, intl: @gladiator.intl, name: @gladiator.name, reputation: @gladiator.reputation, spd: @gladiator.spd, str: @gladiator.str, strmod: @gladiator.strmod, wounds: @gladiator.wounds } }
    end

    assert_redirected_to gladiator_url(Gladiator.last)
  end

  test "should show gladiator" do
    get gladiator_url(@gladiator)
    assert_response :success
  end

  test "should get edit" do
    get edit_gladiator_url(@gladiator)
    assert_response :success
  end

  test "should update gladiator" do
    patch gladiator_url(@gladiator), params: { gladiator: { birth: @gladiator.birth, chr: @gladiator.chr, con: @gladiator.con, death: @gladiator.death, dex: @gladiator.dex, fightStyle: @gladiator.fightStyle, firstfight: @gladiator.firstfight, hitmod: @gladiator.hitmod, hp: @gladiator.hp, initiative: @gladiator.initiative, intl: @gladiator.intl, name: @gladiator.name, reputation: @gladiator.reputation, spd: @gladiator.spd, str: @gladiator.str, strmod: @gladiator.strmod, wounds: @gladiator.wounds } }
    assert_redirected_to gladiator_url(@gladiator)
  end

  test "should destroy gladiator" do
    assert_difference('Gladiator.count', -1) do
      delete gladiator_url(@gladiator)
    end

    assert_redirected_to gladiators_url
  end
end
