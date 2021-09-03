# BobaFetch

This SDK which is available for everyone with SPM by adding this [URL](https://github.com/miguelc95/BobaFetch) and selecting the development branch.

<img width="479" alt="Captura de Pantalla 2021-09-03 a la(s) 16 20 33" src="https://user-images.githubusercontent.com/15070387/132066345-2af8cbaa-36c2-413f-839a-533b04816c56.png">

After adding it through SPM you only need to import BobaFetch and that's it:

```swift
import BobaFetch
```

Lets you get information of your favorite Star Wars characters, planets and films.

To test the services there is a Demo App included that you can run by selecting the BobaFetchDemoApp schema.

<img width="439" alt="Captura de Pantalla 2021-09-03 a la(s) 16 22 24" src="https://user-images.githubusercontent.com/15070387/132066479-89453e70-187f-4042-a091-7b356838131d.png">

Demo App:

<img width="448" alt="Captura de Pantalla 2021-09-03 a la(s) 16 27 38" src="https://user-images.githubusercontent.com/15070387/132066861-3a36e368-310a-44e8-a91f-0b2771849097.png">


The services that you can use include:

* Getting the eye color and name of characters, by default the service will bring 5 but you can add the *limit* attribute to bring as much as you want. 
* Getting the planets with their name, population and climate, this one also bring 5 by default but you can ask for more.
* Getting the a list of the StarWars films with their name, release date and opening crawl.

_All of the services return a Swift Result that contains a success event with the results or a failure event with the error._

A search feature is also included so you can pass a String with your query and the matches will be shown.


Example requests:

Both limit and search are optionals

Eyes: 


```swift
BobbaFetcher.getEyeColors(limit: 10, search: searchText) { eyes in }
```


Planets: 

```swift
BobbaFetcher.getPlanets(limit: 10, search: searchText) { planets in }
```


Films: 

```swift
BobbaFetcher.getFilms(search: searchText) { films in }
```


This SDK has unit tests that can be seen in the tests folder:

<img width="279" alt="Captura de Pantalla 2021-09-03 a la(s) 16 36 18" src="https://user-images.githubusercontent.com/15070387/132067469-392cc8cd-baf5-4cdd-b618-dd5d95531cde.png">

BobaFetcher prints a summary of a request in the console: 

<img width="741" alt="Captura de Pantalla 2021-09-03 a la(s) 16 40 03" src="https://user-images.githubusercontent.com/15070387/132067769-4744ac96-cf6d-42b5-8a67-df419902edbb.png">


This package was built using only Swift and no external dependencies or SDK's where added to keep it lightweight and avoid updating issues.


TODOs: 

* Better error handling, get error catalog
* Make requests generic?



