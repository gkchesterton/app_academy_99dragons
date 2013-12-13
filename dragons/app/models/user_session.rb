class UserSession < ActiveRecord::Base
  attr_accessible :environment, :geo, :session_token, :user_id

  validates :session_token, :user_id, presence: true #TBD on geo and environment

  belongs_to :user


end
