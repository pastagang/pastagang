[pastagang blog](/blog)

# "performance" in pasta gang

no I'm not talking about "performing"

I'm talking about "performance" as in... how fast things run on your laptop or phone.

<br>

<hr>

<br>

when jamming in tools like [nudel](https://nudel.cc) and [flok](https://flok.cc), the programs running can get pretty intense and it can start to run slow on your machine. 

this can be sad because it might mean you can't join in with the jam as fully as other people, or even worse... maybe not at all

as a jamming group, it's our duty to make the jam "performant" enough so that every single person can access it. for me it's crucial. in fact, it makes me quite cross sometimes because we are leaving so many people behind. 

it can be easy for us all (me too) to get "excited" about brand new flashy "ideas" that seem cool but only make "performance" worse (both kinds)

<br>

at meetups, i see new joiners struggle to get things to run well on their laptop, and their phone, and i say sorry time and time again. 

it's not good enough! we need to stop saying we'll do something and do something. we need to make the jam open to all.

this blog post is an attempt to wake people up about this, on behalf of all those who we exclude

<br>

## what do we do 

(tick when done and/or add new items to the list)

- [ ] write a guide on getting nudel and flok to work well on slower machines
- [ ] write a guide on best practice around writing "performant" jam code. like "clip(1)" and so on... keywords/functions could be colour coded to show how much "performance" they suck up
- [ ] port all "performance" settings from flok to nudel
- [ ] make a new flok client that aims for "performance" above all else. 
- [ ] add a clear "performance" settings section to nudel with helpful defaults and presets to pick from
- [ ] add "performance" tracking to nudel that gives warnings when it gets bad
- [ ] add the ability to reload strudel and/or hydra within nudel without needing to reload the entire page
- [ ] add more "performance" settings such as
  - [ ] turning off jammer's cursors
  - [ ] changing frame rate.
  - [x] turning off strudel highlights
- [ ] measure and audit and write up what's slowing things down right now
- [x] write a blog post to convince people to care about this
- [ ] collect timestamps of slowdowns. it could give us a better idea of why they happen

<br>

<br>

this blog post was written by pastagang in [two beat style](https://www.todepond.com/wikiblogarden/academia/style/two-beat) to keep it simple enough. all words longer than two beats were put in quotes

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/29KLkK0Vlw0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe> 


## some more questions

there's a huge stack to deal with here (layers of software) which is prob a big reason why things go slow. but web based is really cool and easy to get into.  

- what is a way we can benchmark or otherwise measure different parts while nudel/flok are running to find the bottle necks? (the things that take up the most time)  
- is wasm used for anything at the moment? can it be used in any of the bottle necks?  
- can we compile anything else? we might be able to eliminate things like repeated multiplication in the web audio api for example  
- which slows the machine down more - hydra or strudel or?  
- at the moment all the code is run on every machine taking part, right?  
- at the cost of some latency, could audio be streamed out from each machine so they only have to run part of it?
- or could the audio be computed on the server and streamed to each person?
- or for in-person collabs, an option for one machine to do the computation (by switching off making sound in other machines?)
- in the long term, could a single binary be made to run the fastest part of the sound engine which is sent midi, osc or json "messages" by nudel/flok? it would be something to install, but should be fairly painless. ask Daniel he might have a sound engine somewhere that could do this... or people could use supercollider if that is installed already  
