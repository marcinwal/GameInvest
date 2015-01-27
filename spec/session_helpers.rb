module SessionHelpers

  def user_create(email = "test@test.com",
    password = "test",
    password_confirmation = "test"
    )
    u=User.create(  :email => email,
    :password => password, :password_confirmation => password_confirmation
    )
    u.save
    u
  end

  def asset_create(name = "EURUSD=X",
    description = "test"
    )
    a=Asset.create(  :name => name,
    :description => description
    )
    a.save
    a
  end
end
