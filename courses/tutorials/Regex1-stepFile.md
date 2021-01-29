# Regex Steps for Converting Movie Data XML

First step, I used the following expression to find:
```
^.+
```
I used 
```
<movie>\0</movie>
```

Second step I matched this and set capturing groups so i could tag the titles:
```
(<movie>)(.+?)\t
```