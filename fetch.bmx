Framework bah.libcurl
Import brl.StandardIO
Import brl.FileSystem
Import brl.retro

'make sure user entered at least a url
If (AppArgs.length < 2) Then End

'set constant variables to parameters
Local urlPath$ = AppArgs[1]
Local filePath$ = urlToFileName(AppArgs[1])

'do the thing
Print("fetched " + urlPath$)
httpsGet(urlPath$, filePath$)
End

'turn url into filename
Function urlToFileName$(url$)
	'parse fed url to find the optimal filename
	Local indX = url$.length - (url$.FindLast("/") + 1) 
	Local str$ = Right(url$, indX)
	
	If str$ = "" Then
		Return LaunchDir$ + "/" + "index.html"
	EndIf
	
	'without a path, it's a webpage
	If Not url$.Contains("/") Then
		Return LaunchDir$ + "/" + str$ + ".html"
	EndIf
		
	'without an extention, it's a webpage
	If str$.Contains(".") Then
		Return LaunchDir$ + "/" + str$
	Else
		Return LaunchDir$ + "/" + str$ + ".html"
	EndIf
End Function

'get http thing
Function httpsGet(url$, file$)
	Local curl:TCurlEasy = TCurlEasy.Create()
	
	curl.setWriteString()
	curl.httpHeader(["User-Agent: Fetch/0.8a"])
	
	curl.setOptInt(CURLOPT_FOLLOWLOCATION, 1)
	curl.setOptString(CURLOPT_CAINFO, "./lib/cert/cacert.pem") ' the cert bundle
	curl.setOptString(CURLOPT_URL, url$)
	
	curl.setWriteStream(WriteStream(file$))
	
	Print("writing to " + file$)
	curl.perform()
End Function

'error function
Function error(str$)
	WriteStderr("ERR: " + str$)
	End
End Function