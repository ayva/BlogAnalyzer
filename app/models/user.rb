class User < ActiveRecord::Base


  # Associations
  has_many :accounts, :dependent => :destroy


  attr_reader :provider, :user

  def initialize creds, user = nil
    @auth         = creds
    @user         = user
    @provider     = @auth.provider
    @policy       = "#{@provider}_policy".classify.constantize.new(@auth)
  end


  # Instance Methods
  def has_facebook?
    accounts.where(provider: 'facebook').any?
  end

  def has_twitter?
    accounts.where(provider: 'twitter').any?
  end

  
  def login_or_create
    logged_in? ? create_new_account : (login || create_new_account)
  end

  def logged_in?
    @user.present?
  end

  private
  def login
    @account = Account.where('uid' => @auth.slice("provider", "uid").uid).first
    if @account.present?
      refresh_tokens
      @user = @account.user
      @policy.refresh_callback(@account)
    else
      false
    end
  end

  def refresh_tokens
    @account.update_attributes(
      :oauth_token   => @policy.oauth_token,
      :oauth_expires => @policy.oauth_expires,
      :oauth_secret  => @policy.oauth_secret
    )
  end

  def create_new_account
    create_new_user if @user.nil?

    unless account_already_exists?
      @account = @user.accounts.create!(
        :provider      => @provider,
        :uid           => @policy.uid,
        :oauth_token   => @policy.oauth_token,
        :oauth_expires => @policy.oauth_expires,
        :oauth_secret  => @policy.oauth_secret,
        :username      => @policy.username
      )

      @policy.create_callback(@account)
    end
  end

  def account_already_exists?
    @user.accounts.exists?(provider: @provider, uid: @policy.uid)
  end

  def create_new_user
    @user = User.create!(
      :first_name => @policy.first_name,
      :last_name  => @policy.last_name,
      :email      => @policy.email,
      :picture    => image
    )
  end

  def image
    return @policy.image_url
  end
end
