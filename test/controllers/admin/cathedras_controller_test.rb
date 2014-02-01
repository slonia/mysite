require 'test_helper'

class Admin::CathedrasControllerTest < ActionController::TestCase
  setup do
    @admin_cathedra = admin_cathedras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_cathedras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_cathedra" do
    assert_difference('Admin::Cathedra.count') do
      post :create, admin_cathedra: {  }
    end

    assert_redirected_to admin_cathedra_path(assigns(:admin_cathedra))
  end

  test "should show admin_cathedra" do
    get :show, id: @admin_cathedra
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_cathedra
    assert_response :success
  end

  test "should update admin_cathedra" do
    patch :update, id: @admin_cathedra, admin_cathedra: {  }
    assert_redirected_to admin_cathedra_path(assigns(:admin_cathedra))
  end

  test "should destroy admin_cathedra" do
    assert_difference('Admin::Cathedra.count', -1) do
      delete :destroy, id: @admin_cathedra
    end

    assert_redirected_to admin_cathedras_path
  end
end
