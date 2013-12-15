class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :uid, type: String
  field :token, type: String
  field :refresh_token, type: String

  belongs_to :manager
end
