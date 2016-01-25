FactoryGirl.define do
  factory :oauth_application, class: Doorkeeper::Application do
    name 'Test'
    redirect_uri 'urn:ietf:wg:oauth:2.0:oob'
    uid '12345678'
    secret '87654321'
  end

  factory :access_token, class: Doorkeeper::AccessToken do
    application { create(:oauth_application) }
    resource_owner_id { create(:user).id }
  end
end