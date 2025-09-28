class ShareToken < ApplicationRecord
  belongs_to :game
  has_secure_token :share_token
end
