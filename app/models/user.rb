class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :validatable, :confirmable
  validates :name, presence: true, uniqueness: { case_sensitive: false },
    format: { with: /\A[a-z0-9_-]+\z/i }

  has_many :todo_apps, dependent: :destroy
  has_many :pledges, dependent: :destroy

  before_save do
    self.name.downcase!
    self.email.downcase!
  end

  after_create do
    Analytics.identify(
      user_id: id,
      traits: {
        name: name,
        email: email,
        registered_at: created_at,
        confirmed_at: confirmed_at
    })

    Analytics.track(
      user_id: id,
      event: "Registered"
    )
  end

  after_update do
    updated = []
    for key, _ in changes do
      updated.push key.to_s unless key == :customer_id
    end

    unless updated.empty?
      Analytics.track(
        user_id: id,
        event: "Updated Profile",
        properties: {
          updated: updated
        }
      )

      Analytics.identify(
        user_id: id,
        traits: {
          name: name,
          email: email,
          registered_at: created_at,
          confirmed_at: confirmed_at
      })
    end
  end

  def to_param
    name
  end

  def after_database_authentication
    Analytics.identify(
      user_id: id,
      traits: {
        name: name,
        email: email,
        registered_at: created_at,
        confirmed_at: confirmed_at
    })

    Analytics.track(
      user_id: id,
      event: "Logged In"
    )
  end

  def after_confirmation
    Analytics.track(
      user_id: id,
      event: "Confirmed Email"
    )
  end

end
