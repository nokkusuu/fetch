# fetch 0.81a
simple https file fetcher written in blitzmax. 

### dependencies
###### note: these dependencies only apply if you're *compiling* the software. you don't really need any of these if you're just running the software.
this software heavily relies on three of brucey's modules, `BaH.libcurl`, `BaH.mbedtls`, and `BaH.libssl2`. those can be obtained [here](https://github.com/maxmods/bah.mod).
it also seems to require some modules preinstalled by blitzmax ng. support for vanilla blitzmax has not been verified.

this software also relies on a .pem file containing certificates for tls to work properly. this can be obtained [here](https://curl.haxx.se/docs/caextract.html) and must be located at `./lib/cert/cacert.pem`.

### known bugs and issues
currently, the url-to-filename conversion function doesn't seem to be very stable. while most file urls work perfectly fine, i suspect there may be a few out there that won't be properly supported.
