if( $('#events').length ) {
  var swiper = new Swiper("#events", {
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      }
      ,
      breakpoints: {
        640: {
          slidesPerView: 1.5,
          spaceBetween: 20,
        },
        768: {
          slidesPerView: 2,
          spaceBetween: 40,
        },
        1024: {
          slidesPerView: 3.5,
          spaceBetween: 30,
        },
      },
  });
}
if( $('#clubs').length ) {
  var swiper = new Swiper("#clubs", {
    spaceBetween: 10,
    autoplay: {
      delay: 3000,
      disableOnInteraction: false,
    },
    pagination: {
      el: ".swiper-pagination",
      clickable: true,
    },
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    breakpoints: {
      640: {
        slidesPerView: 2,
        spaceBetween: 20,
      },
      768: {
        slidesPerView: 3,
        spaceBetween: 40,
      },
      1024: {
        slidesPerView: 5,
        spaceBetween: 50,
      },
    }
  });
}

if( $('#demo-mobile-picker-input').length ) {
  mobiscroll.setOptions({
    //locale: mobiscroll.localeFr,  // Specify language like: locale: mobiscroll.localePl or omit setting to use default
    theme: 'ios',                 // Specify theme like: theme: 'ios' or omit setting to use default
    themeVariant: 'light'         // More info about themeVariant: https://docs.mobiscroll.com/5-13-0/javascript/range#opt-themeVariant
  });

  mobiscroll.datepicker('#demo-mobile-picker-input', {
    controls: ['calendar'],       // More info about controls: https://docs.mobiscroll.com/5-13-0/javascript/range#opt-controls
    select: 'range',              // More info about select: https://docs.mobiscroll.com/5-13-0/javascript/range#methods-select
    showRangeLabels: true,
    touchUi: true,
    display: 'anchored',
    dateFormat: 'YYYY/MM/DD',
  });

  var instance = mobiscroll.datepicker('#demo-mobile-picker-button', {
    controls: ['calendar'],       // More info about controls: https://docs.mobiscroll.com/5-13-0/javascript/range#opt-controls
    select: 'range',              // More info about select: https://docs.mobiscroll.com/5-13-0/javascript/range#methods-select
    showRangeLabels: true,
    showOnClick: false,           // More info about showOnClick: https://docs.mobiscroll.com/5-13-0/javascript/range#opt-showOnClick
    showOnFocus: false,           // More info about showOnFocus: https://docs.mobiscroll.com/5-13-0/javascript/range#opt-showOnFocus
  });
}

if ($('#event-picker-start').length) {
  mobiscroll.setOptions({
    //locale: mobiscroll.localeFr,  // Specify language like: locale: mobiscroll.localePl or omit setting to use default
    theme: 'ios',                 // Specify theme like: theme: 'ios' or omit setting to use default
    themeVariant: 'light'         // More info about themeVariant: https://docs.mobiscroll.com/5-13-0/javascript/range#opt-themeVariant
  });
  mobiscroll.datepicker('#event-picker-end', {
    controls: ['calendar', 'time'],
    touchUi: true,
    display: 'anchored',
    timeFormat: 'HH:mm'
  });

  mobiscroll.datepicker('#event-picker-start', {
    controls: ['calendar', 'time'],
    touchUi: true,
    display: 'anchored',
    timeFormat: 'HH:mm'
  });

  var instance = mobiscroll.datepicker('#event-picker-button', {
    controls: ['calendar', 'time'],       // More info about controls: https://docs.mobiscroll.com/5-13-0/javascript/range#opt-controls     // More info about select: https://docs.mobiscroll.com/5-13-0/javascript/range#methods-select
    showOnClick: false,           // More info about showOnClick: https://docs.mobiscroll.com/5-13-0/javascript/range#opt-showOnClick
    showOnFocus: false,           // More info about showOnFocus: https://docs.mobiscroll.com/5-13-0/javascript/range#opt-showOnFocus
  });
}

if($('.form-gp input').length) {
  $('.form-gp input').on('focus', function () {
    $(this).parent('.form-gp').addClass('focused');
  });

  $('.form-gp input').on('focusout', function () {
    $(this).parent('.form-gp').removeClass('focused');
  })
}

if($('.form-gp textarea').length) {
  $('.form-gp textarea').on('focus', function () {
    $(this).parent('.form-gp').addClass('focused');
  });

  $('.form-gp textarea').on('focusout', function () {
    $(this).parent('.form-gp').removeClass('focused');
  })
}