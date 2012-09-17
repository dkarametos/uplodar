// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery-fileupload/basic
//= require dataTables/jquery.dataTables
//= require twitter/bootstrap
//= require_tree .

function fileupload()
{
  $('#fileupload').fileupload({
    start: function(e, data) {
      $('.progress').parent().siblings().hide();
      $('.progress').parent().show();
    },
    progressall: function (e, data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      $('.progress .bar').css('width', progress + '%');
    },
    stop: function(e, data) {
      $('.progress').parent().hide();
      $('.progress').parent().siblings().show();
    }
  });
}

function dnd()
{
  var fixHelper = function(e){
    //var $originals = $(this).children();
    var $helper    = $(this).closest('tr').clone();
    $helper.children('td').children('span.btn-row').remove();
    $helper.css('background-color', 'white');
    return $helper;
  };

  $("table.fs_table>tbody>tr").draggable({
    helper: fixHelper,
    handle: 'i',
    cursor: 'move',
    addClasses: false,
    zIndex: 100
  });

  $('.droppable').droppable({
    drop: function(e, ui){
      console.log(ui.draggable);

      share    = $('.fs_table').data('share');
      path     = $('.fs_table').data('path');
      new_path = $(this).children('td').data('filename');
      entry    = ui.draggable.children('td').data('filename');
      url      = '/browser/update/'

      console.log(share);
      console.log(path);
      console.log(new_path);
      console.log(entry);
      console.log(url);

      //$.get(url);
      $.post(url, { browser: { share: share, path: path, new_path: new_path, entry: entry} });
      $(this).css('background-color', '');
    },
    over: function() {
      $(this).css('background-color', '#eee');
    },
    out: function() {
      $(this).css('background-color', '');
    }
  });
}

$(document).ready(function(){
  // Initialize the jQuery File Upload widget:
  fileupload();
  dnd();

  $('.btn-url').live('click', function(e){

    if( $(this).closest('td').data('mime') == 'directory')
      return false;

    fname = $(this).closest('td').data('filename');
    size  = $(this).closest('td').data('size');
    entry = fname + " <small>(" + size + ")</small>";

    if( $(this).closest('td').children('.filename').html().trim() == entry )
      {
        url = $(this).closest('table').data('url');
        url = url + '/' + encodeURIComponent(fname);
        url = "<a href='http://" + url + "'>" +url+"</a> <small>(" + size + ")</small>";
        $(this).closest('td').children('.filename').html(url);
      }
      else
        $(this).closest('td').children('.filename').html(entry);

      return false;
  });

  $('.btn-rename').live('click', function(e){
    suburi = $(this).closest('table').data('suburi');
    share  = $(this).closest('table').data('share');
    path   = $(this).closest('table').data('path');
    entry  = $(this).closest('td').data('filename');
    url    = (path == '') ? share : share +'/'+path ;
    url    = 'browser/edit/' + url + '/' + entry;

    if(suburi != '')
      url = suburi + url

    $.get(url);
    return false;
  });

  $('#btn-upload').live('click', function(e){
    $("table tbody").prepend("<tr><td>new row on top</td></tr>");
  });

  $("table.fs_table>tbody>tr").live('hover', function(e){
    $(this).children('td').children('span.btn-row').show();
  });

  $("table.fs_table>tbody>tr").live('mouseleave', function(e){
    $(this).children('td').children('span.btn-row').hide();
  });


});
