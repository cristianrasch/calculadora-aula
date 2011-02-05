require 'spec_helper'

describe WelcomeController do
  render_views
  
  #it "should render the index action" do
  #  get :index
    
  #  response.should be_success
  #  response.should render_template('index')
  #end
  
  it "should use the specified locale" do
    get :about, :locale => 'en'
    
    response.should be_success
    response.should render_template('about')
    response.should have_selector(:h1, :content => I18n.t('msgs.about.title'))
  end
  
  it "should render the about action" do
    get :about
    
    response.should be_success
    response.should render_template('about')
  end
  
  it "should discard unavailable locales when specified" do
    get :about, :locale => 'es'
    
    response.should be_success
    response.should render_template('about')
    I18n.locale == 'es-AR'
  end
  
end