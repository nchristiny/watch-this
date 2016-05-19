class User
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include ActiveModel::SecurePassword
  include ActiveModel::SecureToken

  validates_presence_of :email, :name
  # validates_uniqueness_of :email, :case_sensitive => false
  validates_presence_of :password, on: :create

  # has_many :films, inverse_of: :user, dependent: :destroy
  # has_many :authentication_tokens, :inverse_of => :user, dependent: :destroy

  has_secure_password
  has_secure_token :auth_token

  ## Database authenticatable
  field :name,            type: String, default: ""
  field :email,           type: String, default: ""
  field :password_digest, type: String, default: ""
  field :auth_token,      type: String

  def generate_auth_token
    self.auth_token
  end
end
