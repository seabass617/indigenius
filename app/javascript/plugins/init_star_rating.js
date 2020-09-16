import "jquery-bar-rating";
import $ from 'jquery';

const initStarRating = () => {
  $(".form-control.select.required").barrating({
      theme: "css-stars",
    });
};

export { initStarRating };