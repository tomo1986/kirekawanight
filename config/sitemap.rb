# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://night.kire-kawa.com"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.create do
  add shops_karaoke_path, :priority => 0.7, :changefreq => 'daily'
  add shops_bar_path, :priority => 0.7, :changefreq => 'daily'
  add shops_massage_path, :priority => 0.7, :changefreq => 'daily'

  add casts_karaoke_path, :priority => 0.7, :changefreq => 'daily'
  add casts_bar_path, :priority => 0.7, :changefreq => 'daily'
  add casts_massage_path, :priority => 0.7, :changefreq => 'daily'
  add casts_guide_path, :priority => 0.7, :changefreq => 'daily'


  add blogs_path, :priority => 0.7, :changefreq => 'daily'
  add policy_path, :priority => 0.7, :changefreq => 'daily'
  add contact_path, :priority => 0.7, :changefreq => 'daily'
  add feature_trip_path, :priority => 0.7, :changefreq => 'daily'
  add comsept_path, :priority => 0.7, :changefreq => 'daily'
  add question_path, :priority => 0.7, :changefreq => 'daily'
  add visitor_path, :priority => 0.7, :changefreq => 'daily'

  Shop.find_each do |shop|
    next if shop.deleted_at.present?
    if shop.job_type == 'karaoke'
      add "/shops/karaoke/#{shop.id}/info", :lastmod => shop.updated_at
      add "/shops/karaoke/#{shop.id}/system", :lastmod => shop.updated_at
      add "/shops/karaoke/#{shop.id}/cast", :lastmod => shop.updated_at
      add "/shops/karaoke/#{shop.id}/contact", :lastmod => shop.updated_at
      add "/shops/karaoke/#{shop.id}/reviews", :lastmod => shop.updated_at
      add "/shops/karaoke/#{shop.id}/write_review", :lastmod => shop.updated_at
    elsif shop.job_type == 'bar'
      add "/shops/bar/#{shop.id}/info", :lastmod => shop.updated_at
      add "/shops/bar/#{shop.id}/system", :lastmod => shop.updated_at
      add "/shops/bar/#{shop.id}/cast", :lastmod => shop.updated_at
      add "/shops/bar/#{shop.id}/contact", :lastmod => shop.updated_at
      add "/shops/bar/#{shop.id}/reviews", :lastmod => shop.updated_at
      add "/shops/bar/#{shop.id}/write_review", :lastmod => shop.updated_at
    elsif shop.job_type == 'massage'
      add "/shops/massage/#{shop.id}/info", :lastmod => shop.updated_at
      add "/shops/massage/#{shop.id}/system", :lastmod => shop.updated_at
      add "/shops/massage/#{shop.id}/cast", :lastmod => shop.updated_at
      add "/shops/massage/#{shop.id}/contact", :lastmod => shop.updated_at
      add "/shops/massage/#{shop.id}/reviews", :lastmod => shop.updated_at
      add "/shops/massage/#{shop.id}/write_review", :lastmod => shop.updated_at
    end
  end

  User.find_each do |user|
    next if user.deleted_at.present?
    if user.job_type == 'karaoke'
      add "/casts/karaoke/#{user.id}/info", :lastmod => user.updated_at
      add "/casts/karaoke/#{user.id}/cast", :lastmod => user.updated_at
      add "/casts/karaoke/#{user.id}/contact", :lastmod => user.updated_at
      add "/casts/karaoke/#{user.id}/reviews", :lastmod => user.updated_at
    elsif user.job_type == 'bar'
      add "/casts/bar/#{user.id}/info", :lastmod => user.updated_at
      add "/casts/bar/#{user.id}/cast", :lastmod => user.updated_at
      add "/casts/bar/#{user.id}/contact", :lastmod => user.updated_at
      add "/casts/bar/#{user.id}/reviews", :lastmod => user.updated_at
    elsif user.job_type == 'massage'
      add "/casts/massage/#{user.id}/info", :lastmod => user.updated_at
      add "/casts/massage/#{user.id}/cast", :lastmod => user.updated_at
      add "/casts/massage/#{user.id}/contact", :lastmod => user.updated_at
      add "/casts/massage/#{user.id}/reviews", :lastmod => user.updated_at
    end

    next unless user.can_guided
    add "/casts/guide/#{user.id}/info", :lastmod => user.updated_at
    add "/casts/guide/#{user.id}/contact", :lastmod => user.updated_at
    add "/casts/guide/#{user.id}/reviews", :lastmod => user.updated_at
  end

  Blog.find_each do |blog|
    add blogs_path(blog), :lastmod => blog.updated_at
  end




  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
