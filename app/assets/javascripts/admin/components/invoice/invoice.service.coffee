angular.module 'bijyoZukanAdmin'
.factory 'invoiceService', (api) ->
  sm = this

  sm.getInvoices = (opt_filter) ->
    api.getPromise('/api/admin/api58', opt_filter).then((res) ->
      return res
    )
  sm.getInvoice = (opt_invoice_id) ->
    api.getPromise('/api/admin/api59',{id: opt_invoice_id}).then((res) ->
      return res
    )
  sm.newInvoice = ->
    api.getPromise('/api/admin/api60',{}).then((res) ->
      return res
    )

  sm.createInvoice = (opt_invoice) ->
    api.postPromise('/api/admin/api61',opt_invoice).then((res) ->
      return res
    )

  sm.updateInvoice = (opt_invoice) ->
    api.postPromise('/api/admin/api62',opt_invoice).then((res) ->
      return res
    )

  sm.deleteInvoice = (opt_prams) ->
    api.postPromise('/api/admin/api55',opt_prams).then((res) ->
      return res
    )
  sm.updateInvoiceDetail = (opt_prams) ->
    api.postPromise('/api/admin/api63',opt_prams).then((res) ->
      return res
    )
  sm.deleteInvoiceDetail = (opt_prams) ->
    api.postPromise('/api/admin/api64',opt_prams).then((res) ->
      return res
    )


  sm.getAdmins = ->
    api.getPromise('/api/admin/all_admins',{}).then((res) ->
      return res
    )

  sm.getGroups = ->
    api.getPromise('/api/admin/all_groups',{}).then((res) ->
      return res
    )

  sm.allGetShops = ->
    api.getPromise('/api/admin/all_shops',{}).then((res) ->
      return res
    )



  sm.getInvoiceDetailValidationRule = -> return sm.invoiceDetailValidations
  sm.invoiceDetailValidations = {
    rules:{
      name:{required: true}
      quantilty:{required: true,regexp: /^[0-9]+$/}
      unit_price:{required: true,regexp: /^[0-9]+$/}
      category:{required: true}
    }
    messages:{
      name:{required: '品名は必須です。'}
      quantilty:{required: '個数は必須です。',regexp:"半角数字のみ"}
      unit_price:{required: '価格は必須です。',regexp:"半角数字のみ"}
      category:{required: '種別を選択してください。'}
    }
  }

  sm.getDate = (opt_id) ->
    api.getPromise('/api/admin/api41',{id: opt_id}).then((res) ->
      return res
    )
  sm.getContacts = (opt_id) ->
    api.getPromise('/api/admin/api43',{id: opt_id}).then((res) ->
      return res
    )
  sm.printIds = null
  sm.postPrintIds = (ids) -> sm.printIds = ids
  sm.getPrintIds = -> return sm.printIds

  service =
    printIds: sm.printIds
    postPrintIds: sm.postPrintIds
    getPrintIds: sm.getPrintIds
    newInvoice: sm.newInvoice
    getInvoice: sm.getInvoice
    createInvoice: sm.createInvoice
    getInvoices: sm.getInvoices
    updateInvoice: sm.updateInvoice
    invoiceDetailValidations : sm.invoiceDetailValidations
    getInvoiceDetailValidationRule: sm.getInvoiceDetailValidationRule
    getDate: sm.getDate
    getContacts: sm.getContacts
    deleteInvoice: sm.deleteInvoice
    updateInvoiceDetail: sm.updateInvoiceDetail
    deleteInvoiceDetail: sm.deleteInvoiceDetail
    getAdmins: sm.getAdmins
    getGroups: sm.getGroups
    allGetShops: sm.allGetShops