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

  def update_menus(user)
    visit edit_fullcourse_menu_path(user)
    genre = page.all('div.btn.genre-selecter')
    fill_in 'オードブル', with: 'update_zensai'
    fill_in 'name_0', with: 'osaka'
    genre[1].click
    fill_in 'スープ', with: 'update_soup'
    fill_in 'name_1', with: 'osaka'
    genre[2].click
    fill_in '魚料理', with: 'update_fish'
    fill_in 'name_2', with: 'osaka'
    genre[3].click
    fill_in '肉料理', with: 'update_meat'
    fill_in 'name_3', with: 'osaka'
    genre[4].click
    fill_in '主菜(メイン)', with: 'update_main'
    fill_in 'name_4', with: 'osaka'
    genre[5].click
    fill_in 'サラダ', with: 'update_salad'
    fill_in 'name_5', with: 'osaka'
    genre[6].click
    fill_in 'デザート', with: 'update_desert'
    fill_in 'name_6', with: 'osaka'
    genre[7].click
    fill_in 'ドリンク', with: 'update_drink'
    fill_in 'name_7', with: 'osaka'
    click_button '登録'
  end
end
