# jQuery-Ajax-with-retries-and-abort
Wrapper that enables custom number of retries with retry callback and/or aborting previous unfinished requests


## Usage
Adds several properties (retries, abortPrevious, namespace) and one callback (retry) to jQuery.ajax options object

#### retries
An array specifying how many times and for how long to wait between failed requests. Each error unshifts value from the array.
If you want the request to fail after first error, set this property to false.
```coffeescript
retries: [500, 2000, 4000]
```

#### abortPrevious
Boolean specifying whether previous unfinished ajax requests under the same namespace should be aborted before initializing this request.
```coffeescript
abortPrevious: true
```
#### namespace
String specifying ajax namespace under which to abort previous unfinished requests. You can specify the same namespace under several different $._ajaxWithRetryAbort-s.
```coffeescript
namespace: "something"
```

#### retry
This callback function triggers on error if the retries array isn't empty. If the retries array is empty, normal error callback will trigger.
```coffeescript
retry: (request, status, error) ->
  console.log "Error! Retrying..."
```


## Example

```coffeescript
$._ajaxWithRetryAbort

  url: url
  data: data
  
  retries: [1000, 5000] # default is [500, 2000, 4000], if you don't want retries then false
  abortPrevious: true # default is true
  namespace: "something" # not necessary if abortPrevious: false
  
  retry: (request, status, error) ->
    console.log "Error! Retrying..."
  
  error: (request, status, error) ->
    console.log "Error! No retries left, failed."
  
  success: (data, status, request) ->
    console.log "Success!"
```
