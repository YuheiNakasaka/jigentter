$(function(){
/*! jquery.iPreview */
!function(a){"use strict";a.fn.iPreview=function(b){var c=a.extend(!0,{},a.fn.iPreview.defaults,b);return this.filter("input[type=file]").each(function(){a(this).on("change",function(){var b=a(c.container);if(a.each(this.files,function(d,e){if(e.type.match(/^image\/*/)){var f=new FileReader;f.onload=function(){var d=a("<img>").addClass(c.class).css(c.css).attr("src",f.result);c.wrapper&&(d=a(c.wrapper).html(d)),b.append(d)},f.readAsDataURL(e)}$(".jt-body-forms-tweet textarea").trigger('change');}),a(this).on("change",function(){b.remove()}),c.target)switch(c.position){case"prepend":b.prependTo(a(c.target));break;case"before":b.insertBefore(a(c.target));break;case"after":b.insertAfter(a(c.target));break;default:b.appendTo(a(c.target))}else b.insertAfter(this);a(c.hideOnPreview).hide(),a(c.showOnPreview).show(),a(this).parents("form").on("reset",function(){b.remove(),a(c.hideOnPreview).show(),a(c.showOnPreview).hide()})})})},a.fn.iPreview.defaults={target:"",position:"append",container:'<div class="previews"></div>',wrapper:"","class":"thumbnail",css:{maxWidth:"300px",maxHeight:"300px"},hideOnPreview:"",showOnPreview:""}}(jQuery);
  // 文字数
  $(".jt-body-forms-tweet textarea").on('change keyup', function(){
    var text = urlRep($(this).val());
    var count = text.length;
    if (isMedia()) count = count + 24;
    if (count < 141) {
      $('.jt-body-forms-submit').removeClass('over');
      $('.jt-body-forms-words .count').text(count);
    } else {
      var overCount = 140 - count;
      $('.jt-body-forms-submit').addClass('over');
      $('.jt-body-forms-words .count').text(overCount);
    }
  });
  // ファイルアップロード
  $(".jt-body-forms-img-camera").on('click', function(){
    $('.jt-body-form-file').click();
    refreshWordCount();
  });
  $('.jt-body-forms-addtag').on('click', function(){
    var mergedText = $(".jt-body-forms-tweet textarea").val() + " #１時間くらいで消えるツイート";
    $(".jt-body-forms-tweet textarea").val(mergedText);
    refreshWordCount();
  });
  // submit
  $("#new_tweet").submit(function(){
    loading('show');
    refreshWordCount();
    tweetCount = parseInt($('.jt-body-forms-words .count').text());
    if (tweetCount < 1 || tweetCount > 140) {
      loading('hide');
      return false;
    }
  });
  // preview
  $('input[type=file]').iPreview({
      target: '.jt-body-forms-preview'
  });
  $('.jt-body-forms-preview').on('change', function(){
    refreshWordCount();
  });

  function urlRep(str) {
    return str.replace(/https?:\/\/([\w*%#!()~\'-]+\.)+[\w*%#!()~\'-]+(\/[\w*%#!()~\'-.]+)*/ig, '00000000000000000000000');
  }

  function isMedia() {
    return $('.jt-body-form-file').val().length > 0 ? true : false;
  }

  function refreshWordCount() {
    $(".jt-body-forms-tweet textarea").trigger('change');
  }

  function loading(flag) {
    if (flag == 'show') {
      $('#jigentter-loading-overlay').show();
    } else {
      $('#jigentter-loading-overlay').hide();
    }
  }
});