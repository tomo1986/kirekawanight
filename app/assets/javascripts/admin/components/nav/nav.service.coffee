angular.module 'bijyoZukanAdmin'
.factory 'navService', () ->
  sm = this
  sm.menus = [
    {name:"Dashboard",icon:"fa-dashboard",link:"/admin",activeMenu:"dashboard"}
    {name:"MAP編集",icon:"fa-map-marker",link:"/admin/maps",activeMenu:"map"}
#    {name:"データ",icon:"fa-line-chart",link:"/admin/data",activeMenu:"data"}
    {name:"通知をおくる",icon:"fa-bell",link:"/admin/notifications",activeMenu:"notification"}
    {name:"設定",icon:"fa-cog",link:"/admin/settings/account",activeMenu:"setting"}
  ]
  service =
    menus: sm.menus