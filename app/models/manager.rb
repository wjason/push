class Manager
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String


  field :project_name, type: String
  field :corporation, type: String
  field :contacts, type: String
  field :phone_number, type: String

  field :client_id, type: String
  field :client_secret, type: String
  field :redirect_uri, type: String
  field :status, type: Integer, :default => 0



  has_many :articles

  has_many :users

  # validates_uniqueness_of :project_name
  # validates_presence_of :project_name, :corporation, :phone_number



  def login_url

    scope = %w{
      https://www.googleapis.com/auth/glass.timeline 
      https://www.googleapis.com/auth/userinfo.profile
    }

    params = {
        response_type: 'code',
        client_id: self.client_id,
        redirect_uri: self.redirect_uri,
        scope: scope.join('+'),
        access_type: 'offline',
        approval_prompt: 'force'
    }
    params_string = []
    params.each {|key, value| params_string << "#{key}=#{value}"}
    return "https://accounts.google.com/o/oauth2/auth?#{params_string.join("&")}"
  end


  def get_token(code)
    RestClient.post "https://accounts.google.com/o/oauth2/token", {
      code: code,
      client_id: self.client_id,
      client_secret: self.client_secret,
      redirect_uri: self.redirect_uri,
      grant_type: 'authorization_code'
    }
  end


  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time
end
