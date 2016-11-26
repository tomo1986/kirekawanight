angular.module 'bijyoZukanAdmin'
.factory 'validationService', () ->
  sm = this
  sm.checks = (values, validations) ->
    errors = {}
    angular.forEach(values,(parent_val,parent_key) ->
      if validations.rules[parent_key]
        angular.forEach(validations.rules[parent_key],(child_val,child_key) ->
          if child_key == 'required' && errors[parent_key] == undefined
            errors[parent_key] =  validations.messages[parent_key][child_key] if parent_val == null || parent_val.length == 0
          if child_key == 'max' && errors[parent_key] == undefined
            errors[parent_key] =  validations.messages[parent_key][child_key] if parent_val.length > child_val
          if child_key == 'min' && errors[parent_key] == undefined
            errors[parent_key] =  validations.messages[parent_key][child_key] if parent_val.length < child_val
          if child_key == 'regexp' && errors[parent_key] == undefined
            errors[parent_key] =  validations.messages[parent_key][child_key] if !child_val.test(parent_val)
          if child_key == 'appraise' && errors[parent_key] == undefined
            return errors if values[parent_key] && values[parent_key].length == 0
            errors[parent_key] = validations.messages[parent_key][child_key] if values[parent_key] != values[validations.rules[parent_key].appraise.target]

        )
    )
    return errors
  sm.checkBusinessType = (map) ->
    error = {}
    if map.business_type == 'quiz'
      error['business_quiz_answer_type'] = '解答出すタイミングを選択してください。' if !map.business_quiz_answer_type
      if map.business_quiz_answer_type == 'show_by_date_time'
        error['business_quiz_answer_at'] = '日付けを選択してくだい。' if !map.business_quiz_answer_at
    else if map.business_type == 'stamp_rally'
      error['business_updating_sort_no'] = 'マス設定をしてください。' if !map.business_setting_cell
    return error
  sm.checkQuizAnswers = (answers) ->
    error = {}
    if answers != undefined
      error['quiz_answers'] = '解答を設定してください。' if !answers[0]
      error['quiz_answers'] = '解答を設定してください。' if !answers[1]
      error['quiz_answers'] = '解答を設定してください。' if !answers[2]
    return error
  sm.checkQuizImageAnswers = (answers) ->
    error = {}
    console.log("soeya",answers)
    if answers != undefined
      error['quiz_answers'] = '解答を設定してください。' if answers[0] && answers[0].data == null
      error['quiz_answers'] = '解答を設定してください。' if answers[1] && answers[1].data == null
      error['quiz_answers'] = '解答を設定してください。' if answers[2] && answers[2].data == null
    return error

  service =
    checks: sm.checks
    checkBusinessType: sm.checkBusinessType
    checkQuizAnswers: sm.checkQuizAnswers
    checkQuizImageAnswers: sm.checkQuizImageAnswers