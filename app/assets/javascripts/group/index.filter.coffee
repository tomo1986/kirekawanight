angular.module 'bijyoZukanGroup'
.filter 'noHTML', ->
  (text) -> text.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;') if text?

.filter 'newlines', ($sce) ->
  (text) ->
    $sce.trustAsHtml(if text? then text.replace(/\n/g, '<br />') else "")
