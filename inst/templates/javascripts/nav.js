// creating nav bar and restructuring document

$(document).ready(function() {
    $('body').prepend('<div id="content" class="twelve columns offset-by-three content"></div>');
    var nav='<div id="nav" class="three columns sidebar"><nav><p>Table of contents</p><ul>';
    $(":header").not('.titlet').not('.author').not('.date').attr( 'id', setAltText );
    function setAltText( index, attributeValue ) {
        nav=nav + '<li style="padding-left: ' + (parseInt((this).nodeName.replace('H', ''))* 10)  + 'px;"><a href="#' + 'header' + (index+1) + '">' + $(this).text() + '</a></li>';
        return ( 'header' + (index+1));
    }
    var nav=nav + '</ul><div id="influads_block" class="influads_block"> </div> </nav></div>';
    $('body').prepend(nav);
    $('body').children().not('#content').not('#nav').appendTo("#content");
    $('body').prepend('<div id="container" class="container"></div>');
    $('body').children().not('#container').appendTo("#container");
});