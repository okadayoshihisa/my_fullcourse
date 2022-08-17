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
      description: '俺のフルコースは自分だけのフルコースを作成するサービスです',   # 上に同じ
      url: request.url,
      image: 'https://example.com/hoge.png'
    }
  end

  def default_twitter_card
    {
      card: 'summary_large_image', # または summary
    }
  end
end
