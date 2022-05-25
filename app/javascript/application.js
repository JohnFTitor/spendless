// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require jquery_ujs
import "@hotwired/turbo-rails"
import "controllers"

//Flash message
$(function() {
  setTimeout(function(){
    $('.flash').slideUp(500);
  }, 2000);
});
