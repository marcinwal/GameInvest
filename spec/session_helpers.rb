module SessionHelpers

  def user_create(email = "test@test.com",
    password = "test"
    )

    u=User.create(  :email => email,
    :password => password
    )
    u.save
    u
  end

  def asset_create(name = "EURUSD=X",
    description = "test"
    )
    byebug
    a=Asset.create(  :name => name,
    :description => description
    )
    a.save
    a
  end
end
