module ApplicationHelper
  include Pagy::Frontend

  def user_avatar(name, **options)
    Initials.svg(name, **options)
  end
end
