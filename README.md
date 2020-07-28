# docker-wfuzz

Docker image for [wfuzz](https://wfuzz.readthedocs.io/en/latest/)

## Build
```
docker build -t adioss/wfuzz .
```

## Usage

### wfuzz basics
More info in [documentation](https://wfuzz.readthedocs.io/en/latest/user/basicusage.html#fuzzing-parameters-in-urls)
```
// directories
docker run --rm adioss/wfuzz -w wordlist/general/common.txt --hc 404 http://testphp.vulnweb.com/FUZZ
// files  
docker run --rm adioss/wfuzz -w wordlist/general/common.txt --hc 404 http://testphp.vulnweb.com/FUZZ.php  
// url params
docker run --rm adioss/wfuzz -z range,0-10 --hl 97 http://testphp.vulnweb.com/listproducts.php?cat=FUZZ
// post params
docker run --rm adioss/wfuzz -z file,wordlist/others/common_pass.txt -d "uname=FUZZ&pass=FUZZ"  --hc 302 http://testphp.vulnweb.com/userinfo.php
// cookies
docker run --rm adioss/wfuzz -z file,wordlist/general/common.txt -b cookie=FUZZ http://testphp.vulnweb.com
// headers 
docker run --rm adioss/wfuzz -z file,wordlist/general/common.txt -H "User-Agent: FUZZ" http://testphp.vulnweb.com/
// verbs
docker run --rm adioss/wfuzz -z list,GET-HEAD-POST-TRACE-OPTIONS -X FUZZ http://testphp.vulnweb.com
// combine: chain
docker run --rm adioss/wfuzz -z list,a-b-c -z list,1-2-3 -m chain http://testphp.vulnweb.com/FUZZ
// combine: product (use FUZZ,..., FUZnZ keywords)
docker run --rm adioss/wfuzz -z list,a-b-c -z list,1-2-3 -m product http://testphp.vulnweb.com/FUZZ/FUZ2Z
// combine: zip
docker run --rm adioss/wfuzz -z list,a-b-c -z list,1-2-3 -m zip http://testphp.vulnweb.com/FUZZ/FUZ2Z
```

```
// configure a proxy
docker run --rm adioss/wfuzz -z file,wordlist/general/common.txt -p localhost:2222:SOCKS5 http://testphp.vulnweb.com/FUZZ
// output as json
docker run --rm adioss/wfuzz -o json -w wordlist/general/common.txt --hc 404 http://testphp.vulnweb.com/FUZZ
```