class AuthenticationToken
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include ActiveModel::SecureToken

  belongs_to :user, :inverse_of => :authentication_tokens

  # Set expiration upon save
  before_save :set_expiration

  ### Validations ###
  validates :user, :presence => true
  validates :token, :presence => true, :uniqueness => true

  default_scope -> { where('expires_at > :now', :now => DateTime.now) }
  scope :expired, -> { unscoped.where('expires_at <= :now', :now => DateTime.now) }

  private

    def set_expiration
      self.expires_at ||= DateTime.now + 3.days
    end
end
