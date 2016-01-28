shared_examples_for "API Authenticable" do
  context "unauthorized" do
    it 'returns 401 status if request has not access token' do
      do_request(method, api_path)
      # do_request
      expect(response.status).to eq 401
    end

    it 'returns 401 status if access token is invalid' do
      # get api_path, format: :json, access_token: '1234'
      do_request(method, api_path, access_token: '1234')
      # do_request(access_token: '1234')
      expect(response.status).to eq 401
    end
  end
end