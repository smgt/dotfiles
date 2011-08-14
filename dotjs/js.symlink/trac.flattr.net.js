Array.prototype.unique = function () {
    var arrVal = this;
    var uniqueArr = [];
    for (var i = arrVal.length; i--; ) {
        var val = arrval[i];
        if ($.inarray(val, uniquearr) === -1) {
            uniquearr.unshift(val);
        }
    }
    return uniqueArr;
};


var my_tickets_url = "/query?owner=~%24USER&status=accepted&status=assigned&status=new&status=reopened&groupdesc=1&group=status&col=id&col=summary&col=status&col=type&col=priority&col=milestone&col=component&report=12&order=priority";
var menu = [];

menu.push('<a href="/query?owner=~$USER&status=accepted&status=assigned&status=new&status=reopened&group=status&col=id&col=summary&col=status&col=type&col=priority&col=milestone&col=component&report=12&order=priority">My tickets</a>');
menu.push('<a href="/newticket">New ticket</a>');

var element = jQuery("<div id='extra-toolbar'></div>");
element.css({
  "position" : "fixed",
  "top" : "0",
  "right" : "10px",
  "background-color" : "#F0F0F0",
  "padding" : "0 5px",
  "border-left" : "1px solid #D2D2D2",
  "border-right" : "1px solid #D2D2D2",
  "border-bottom" : "1px solid #D2D2D2",
  "z-index" : 10000000
 
});

$.ajax({
  url: my_tickets_url,
  success: function(data) {
    var tickets = [];
    var milestones = [];

    jQuery(data).find("table.tickets").each(function() {
      var ar = /assigned/m;

      $(this).find("td.status").each(function() {
        if(String(this.innerHTML).search(ar) != -1) {
          tickets.push($(this).parent().find("td.id a")[0].outerHTML);
        }
      });
    });

    jQuery(data).find("td.milestone").each(function() {
      milestones.push(this.innerHTML);
    });

    var unique_milestones = [];
    for (var i = milestones.length; i--; ) {
        var val = milestones[i];
        if (jQuery.inArray(val, unique_milestones) === -1) {
            unique_milestones.unshift(val);
        }
    }


    element.html(tickets.join(", "));
    element.append(" | ");
    element.append(unique_milestones.join(", "));
    element.append(" | ");
    element.append(menu.join(" | "));

  }
});

jQuery("body").prepend(element);
