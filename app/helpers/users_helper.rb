module UsersHelper
  def user_avatar(name, **options)
    Initials.svg(name, **options)
  end
end
