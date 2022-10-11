# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://my-fullcourse.com"
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-ap-northeast-1.amazonaws.com/#{ENV['S3_BUCKET_NAME']}"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
  ENV['S3_BUCKET_NAME'],
  aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  aws_region: ENV['AWS_DEFAULT_REGION'],
)
SitemapGenerator::Sitemap.create do
  add fullcourses_path
  Fullcourse.find_each do |fullcourse|
    add fullcourse_path(fullcourse.user_id)
  end
  add fullcourse_menus_path
  add map_fullcourse_menus_path
end
