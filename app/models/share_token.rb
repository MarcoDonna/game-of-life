class ShareToken < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_secure_token :share_token
end
