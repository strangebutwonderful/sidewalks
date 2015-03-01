require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "anyone should get user" do
    user = FactoryGirl.create(:user)

    get :show, id: user
    assert_response :success
  end

  test "user should get user" do
    user = FactoryGirl.create(:user)

    get :show, id: user
    assert_response :success
  end

  test "admin should get user" do
    user = FactoryGirl.create(:user)
    sign_in(FactoryGirl.create(:admin_user))

    get :show, id: user
    assert_response :success
  end

  test "user should get edit self" do
    user = FactoryGirl.create(:user)
    sign_in(user)

    get :edit, id: user
    assert_response :success
  end

  test "user should get not edit other user" do
    user = FactoryGirl.create(:user)
    sign_in(user)

    get :edit, id: FactoryGirl.create(:user)
    assert_redirected_to :root
  end

  test "user should update self" do
    user = FactoryGirl.create(:user)
    sign_in(user)

    put :update, id: user, user: { email: Faker::Internet.email }
    assert_redirected_to :root
  end

  test "user should not update other user" do
    user = FactoryGirl.create(:user)
    sign_in(user)

    put :update, id: FactoryGirl.create(:user), user: { email: Faker::Internet.email }
    assert_response 302
  end

  test "admin should get edit self" do
    admin = FactoryGirl.create(:admin_user)
    sign_in(admin)

    get :edit, id: admin
    assert_response :success
  end

  test "admin should get edit other user" do
    admin = FactoryGirl.create(:admin_user)
    sign_in(admin)

    get :edit, id: FactoryGirl.create(:user)
    assert_response :success
  end

  test "admin should update self" do
    admin = FactoryGirl.create(:user)
    sign_in(admin)

    put :update, id: admin, user: { email: Faker::Internet.email }
    assert_redirected_to :root
  end

  test "admin should update other user" do
    admin = FactoryGirl.create(:user)
    sign_in(admin)

    put :update, id: FactoryGirl.create(:user), user: { email: Faker::Internet.email }
    assert_redirected_to :root
  end

end