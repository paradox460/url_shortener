class Url < ActiveRecord::Base
  validates :url, format: { with: URI::ABS_URI, message: 'only accepts a valid URI' }

  before_create :generate_salt

  class << self
    def decode(hash)
      fail ArgumentError, 'hash must be valid Base36' unless hash =~ /[[:alnum:]]+/
      find(hash.to_i(36).to_s.reverse.slice(0..-4).to_i)
    end
  end

  def shortcode
    return nil if id.nil?
    id_hash = '%03d%03d' % [id, salt]
    id_hash.reverse.to_i.to_s(36)
  end

  def to_param
    shortcode
  end

  private

  def generate_salt
    # Random salt for just an extra bit of psuedosecurity
    # If i actually wanted urls to be cryptographically secure, I wouldn't use a
    # shortener, as its trivial to just step through base36 brute-force

    # I generate 3 random numbers this way to avoid the 0 being dropped as we do
    # the string manipulations needed to make a psuedosecure hash
    self.salt = 3.times.map { rand(8) + 1 }.join.to_i
  end
end
