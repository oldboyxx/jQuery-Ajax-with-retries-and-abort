# jQuery-Ajax-with-retries-and-abort
Wrapper that enables custom number of retries with retry callback and/or aborting previous unfinished requests

## Usage:

    $._ajaxWithRetryAbort

        url: url
        data: data

        retries: [1000, 5000] # default is [500, 2000, 4000], if you don't want retries then false
        abortPrevious: true # default is true

        retry: (request, status, error) ->
          console.log "Retrying..."

        error: (request, status, error) ->
          console.log "No retries left, failed."

        success: (data, status, request) ->
          console.log "Success!"
          
