# FVL

a tool created with the aim to minimize path transerval attack mostly in web apps

> am doing this caused am bored 

fvl is written in the zig programming language because i wanted it to be  fast hahaha got an obession with wanting something fast lmao

it expose some set of api(s) uses minimal memory 

## setup:
  - fvl is still in development phase no sure its worthy yet nevertheless you can try it out tho 
  - you should download the binary from the release page 
  
run

```bash
 ./fvl --start
 ```
 
 on linux subsystems this starts a web app at  `127.0.0.1:8080` endpoints include:
 
 
 - GET `http://127.0.0.1:8080/check/:id` 
 
 assumme you have the id pass it has params to the url to the check endpoint 
 on sucess it returns 
```text
status: 200
   body: the id received
   ```
on error returns 
```text
status: 404
body: id doesnt match file
```


- GET `http://127.0.0.1:8080/content/:id`

pass the id it returns 

on success 
```text
status: 200
body: file bytes(content)
```

on error 
```text
status: 400
body: invalid id
```

- POST `127.0.0.1:8080/create` 

send the file bytes that is read the file and pass the bytes as `body:` to this endpoint 

on succes it returns the file id else returns 400


- GET `127.0.0.1:8080/delete/:id`

just as the name says it deletes a file with that id 



### fvl internals 

the purpose is to stop attacks by storing files as random usigned 32bytes integers and returning it has the id 

while am still developing most stuffs wont change and probability i will maintain is quite low 

directory fvl uses is `fvlBin` 


future roadmap is to introduce 

`./fvl --setup`

where fvl reads all files in its fvlBin dir renames them to an id and returns each so you can esily serve files to users imo 



if you have better suggestion am all hears 



- zendrx 
