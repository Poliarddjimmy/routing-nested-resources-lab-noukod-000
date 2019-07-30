class Artist < ActiveRecord::Base
  has_many :songs

  def display_artist(song)
  end
end
