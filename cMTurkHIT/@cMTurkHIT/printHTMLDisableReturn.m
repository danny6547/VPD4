function [ html ] = printHTMLDisableReturn()
%printHTMLDisableReturn Summary of this function goes here
%   Detailed explanation goes here

html = ['<script type="text/javascript"> function stopRKey(evt) { '...
'var evt = (evt) ? evt : ((event) ? event : null); '...
'var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null); '...
'if ((evt.keyCode == 13) && (node.type=="text")) {return false;} '...
'} '...
'document.onkeypress = stopRKey; '...
'</script>'];

end