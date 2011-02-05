require 'spec_helper'

describe ApplicationController do
  render_views
  
  it "should use the default locale when none specified" do
    controller.set_locale
    I18n.locale.should == I18n.default_locale
  end
  
  it "should use the specified locale when one already provided" do
    session[:locale] = :en
    controller.set_locale
    I18n.locale.should == :en
  end
  
end