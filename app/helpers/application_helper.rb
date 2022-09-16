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
      title: :full_title,          # :full_title とすると、サイトに表示される <title> と全く同じものを表示できる
      description: '俺のフルコースはトリコに登場する美食屋たちのように、自分だけのフルコースを作成するサービスです', # 上に同じ
      url: request.url,
      image: asset_url('fullcourse.jpg')
    }
  end

  def default_twitter_card
    {
      card: 'summary_large_image' # または summary
    }
  end
end
