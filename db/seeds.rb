User.find_or_create_by!(email: "admin@example.com") do |user|
  user.admin = true
  user.password = "password"
end
