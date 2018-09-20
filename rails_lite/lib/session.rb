require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    cookie = req.cookies['_rails_lite_app']
    if cookie 
      res.delete!('{}\"\\')
      key, val = res.split(":")
      @session = {key.to_sym => val.to_sym}
    else
      @session = {}
    end
  end

  def [](key)
    @session[key]
  end

  def []=(key, val)
    @session[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    @session.join("/")
    res.set_cookie('_rails_lite_app', @session)
  end
end

