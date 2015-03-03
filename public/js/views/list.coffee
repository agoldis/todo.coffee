define(
  ['mr','views/item']
  (Mr, ItemView) ->
    Mr.CollectionView.extend
      tagName: 'ul'
      childView: ItemView
)