SitemapGenerator::Sitemap.default_host = "https://serious-todo.herokuapp.com"
SitemapGenerator::Sitemap.create do
  add about_path, changefreq: "monthly"
  add new_user_registration_path, changefreq: "never"
  add new_user_session_path, changefreq: "never"
end
