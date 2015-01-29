do ->

  repo = {}

  $._ajaxWithRetryAbort = (options) ->

    defaults = { retries: [500,2000,4000], abortPrevious: true }
    settings = {}

    # Transfer non-native pairs from options to settings + use defaults
    for key in ["namespace", "retries", "abortPrevious", "retry", "error"]
      if options[key]?
        settings[key] = options[key]
        delete options[key]
      else
        settings[key] = defaults[key] if defaults[key]

    # Create namespace
    n = if settings.abortPrevious then settings.namespace else "noAbort"
    repo[n] ?= {}

    # Setup error callback
    options["error"] = (req, status, error) ->

      if status != "abort"
        retryTimeout = (settings.retries || []).shift()

        # Retry
        if retryTimeout?
          settings.retry.call(this, req, status, error) if settings.retry
          repo[n].timeout = setTimeout(->
            abortAndSend()
          , retryTimeout)

        # Fail if no retries left
        else
          settings.error.call(this, req, status, error) if settings.error


    abortAndSend = ->

      if settings.abortPrevious

        # Abort request
        if repo[n].request
          repo[n].request.abort()
          repo[n].request = null

        # Clear timeout
        if repo[n].timeout
          clearTimeout(repo[n].timeout)

      # Send request
      repo[n].request = $.ajax options


    abortAndSend()