angular.module 'bijyoZukanShop'
.factory 'navService', () ->
  sm = this
  sm.menus = [
    {name:"Dashboard",icon:"fa-dashboard",link:"/shop",activeMenu:"dashboard"}
    {name:"MAP編集",icon:"fa-map-marker",link:"/shop/maps",activeMenu:"map"}
#    {name:"データ",icon:"fa-line-chart",link:"/shop/data",activeMenu:"data"}
    {name:"通知をおくる",icon:"fa-bell",link:"/shop/notifications",activeMenu:"notification"}
    {name:"設定",icon:"fa-cog",link:"/shop/settings/account",activeMenu:"setting"}
  ]
  service =
    menus: sm.menus