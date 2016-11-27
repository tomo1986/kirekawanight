angular.module 'bijyoZukanGroup'
.factory 'navService', () ->
  sm = this
  sm.menus = [
    {name:"Dashboard",icon:"fa-dashboard",link:"/group",activeMenu:"dashboard"}
    {name:"MAP編集",icon:"fa-map-marker",link:"/group/maps",activeMenu:"map"}
#    {name:"データ",icon:"fa-line-chart",link:"/group/data",activeMenu:"data"}
    {name:"通知をおくる",icon:"fa-bell",link:"/group/notifications",activeMenu:"notification"}
    {name:"設定",icon:"fa-cog",link:"/group/settings/account",activeMenu:"setting"}
  ]
  service =
    menus: sm.menus