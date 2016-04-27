document.addEventListener "click", (e) ->
  tag = e.target
  while tag
    if tag.dataset.removeOnClick
      tag.remove()
      break

    if tag.parentNode and tag.parentNode != document.body
      tag = tag.parentNode
    else
      break
