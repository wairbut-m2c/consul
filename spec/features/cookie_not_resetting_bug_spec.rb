require 'rails_helper'

module I18n

  def self.locale=(locale)
    puts "Setting locale to #{locale} by #{caller.first}"
    config.locale = locale
  end
end

feature 'debug cookie thing' do

  background do
    admin = create(:administrator)
    login_as(admin.user)
  end

  context "Debug cookie thing" do
    scenario 'Change locale', :js do
      visit admin_root_path

      expect(page).to have_content "ADMINISTRATION"

      select('Español', from: 'locale-switcher')

      expect(page).to have_content "ADMINISTRACIÓN"
    end

    scenario 'Locale by default is english', :js do
      page.driver.reset!
      page.driver.browser.manage.delete_all_cookies
      Capybara.current_session.driver.reset!
      Capybara.reset_sessions!

      page.visit admin_root_path(a: 'b')

      expect(page).to have_content "ADMINISTRATION"
    end
  end
end
