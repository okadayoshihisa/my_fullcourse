module ApplicationHelper
  def default_meta_tags
    {
      site: '俺のフルコース',
      reverse: true,
      separator: '|',
      og: defalut_og,
      twitter: default_twitter_card
    }
  end

  private

  def defalut_og
    {
      title: :full_title, # :full_title とすると、サイトに表示される <title> と同じものを表示できる
      description: 'トリコに登場する美食屋たちのように、自分だけのフルコースを作成するサービスです',
      url: request.url,
      image: asset_url('ogp.jpg')
    }
  end

  def default_twitter_card
    {
      card: 'summary_large_image' # または summary
    }
  end
end
