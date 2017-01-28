require 'test_helper'

class FightStylesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fight_style = fight_styles(:one)
  end

  test "should get index" do
    get fight_styles_url
    assert_response :success
  end

  test "should get new" do
    get new_fight_style_url
    assert_response :success
  end

  test "should create fight_style" do
    assert_difference('FightStyle.count') do
      post fight_styles_url, params: { fight_style: { name: @fight_style.name } }
    end

    assert_redirected_to fight_style_url(FightStyle.last)
  end

  test "should show fight_style" do
    get fight_style_url(@fight_style)
    assert_response :success
  end

  test "should get edit" do
    get edit_fight_style_url(@fight_style)
    assert_response :success
  end

  test "should update fight_style" do
    patch fight_style_url(@fight_style), params: { fight_style: { name: @fight_style.name } }
    assert_redirected_to fight_style_url(@fight_style)
  end

  test "should destroy fight_style" do
    assert_difference('FightStyle.count', -1) do
      delete fight_style_url(@fight_style)
    end

    assert_redirected_to fight_styles_url
  end
end
