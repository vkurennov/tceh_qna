module ApiHelpers
  def do_request(method, path, options = {})
    send method, path, { format: :json }.merge(options)
  end
end