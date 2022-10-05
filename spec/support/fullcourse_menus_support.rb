module FullcourseMenusSupport
  def create_menus
    visit new_fullcourse_menu_path
    genre = page.all('div.btn.genre-selecter')
    fill_in 'オードブル', with: 'test_zensai'
    fill_in 'name_0', with: 'tokyo'
    genre[1].click
    fill_in 'スープ', with: 'test_soup'
    fill_in 'name_1', with: 'tokyo'
    genre[2].click
    fill_in '魚料理', with: 'test_fish'
    fill_in 'name_2', with: 'tokyo'
    genre[3].click
    fill_in '肉料理', with: 'test_meat'
    fill_in 'name_3', with: 'tokyo'
    genre[4].click
    fill_in '主菜(メイン)', with: 'test_main'
    fill_in 'name_4', with: 'tokyo'
    genre[5].click
    fill_in 'サラダ', with: 'test_salad'
    fill_in 'name_5', with: 'tokyo'
    genre[6].click
    fill_in 'デザート', with: 'test_desert'
    fill_in 'name_6', with: 'tokyo'
    genre[7].click
    fill_in 'ドリンク', with: 'test_drink'
    fill_in 'name_7', with: 'tokyo'
    click_button '登録'
  end
end