class Website < ActiveRecord::Base
  before_validation :prepend_http
  validates :url, presence: true, url: true

  def prepend_http
    # If the URL doesn't start with http://, and there's not some kind of
    # malformed http in there, then prepend it.
    if !(self.url =~ /^http:\/\//)
      self.url = 'http://' + self.url
    end 
  end
end
