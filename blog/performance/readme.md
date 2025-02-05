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

- [ ] write a guide on getting nudel and flok to work well on slower machines. eg: choosing the right settings, switching clients if it helps
- [ ] write a guide on best practice around writing "performant" jam code. like "clip(1)" and so on... keywords/functions could be colour coded to show how much "performance" they suck up
- [ ] port all "performance" settings from flok to nudel
- [ ] make a new flok client that aims for "performance" above all else.
- [x] add a clear "performance" settings section to nudel
- [ ] add helpful defaults and presets to pick from
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
  - browser dev tools -> performance tab -> press record while playing -> press stop after a few seconds -> information overload
- is wasm used for anything at the moment? can it be used in any of the bottle necks?
  - no not used. we don't really know the bottlenecks yet. wasm might or might not help. might also get difficult depending on what is ported to a language that compiles to wasm. i've done a few experiments with assemblyscript, but the performance was actually worse in my (rough) tests: <https://garten.salat.dev/wasm/wasm-worklet.html>
    - one downside of wasm is it becomes less tinker friendly as it involves a build step. might be worth it though
- can we compile anything else? we might be able to eliminate things like repeated multiplication in the web audio api for example
  - that's basically one goal of kabelsalat, which tries to replace the web audio graph with a custom (compiled) graph. still not at a point where it can spawn graphs
- which slows the machine down more - hydra or strudel or?
  - needs to be tested. also depends on complexity of hydra/strudel patch + gpu vs cpu hardware used
- at the moment all the code is run on every machine taking part, right?
  - yes, unless you disable strudel/hydra in the settings
- at the cost of some latency, could audio be streamed out from each machine so they only have to run part of it?
  - sounds complicated, generally i like the simplicity of sending text around
    - I've done some livestreams with it a bit recently and i do wonder how much that can be a good backup for hearing noises or seeing visuals. at the London meetup we talked about setting up a pastagang radio or something [here](https://compute.radio/)
      - that would be super cool
- or could the audio be computed on the server and streamed to each person?
  - theoretically yes, but we can't run strudel as is on the server. also, simplicity of sending text around is kind of neat
    - see radio note above :)
- or for in-person collabs, an option for one machine to do the computation (by switching off making sound in other machines?)
  - that already works, by disabling strudel / hydra in the settings. you can still send code from any pane
    - yes we should remember to do this at meetups! it could be added to the guide(s) mentioned in the task list. side note: is it possible to display strudel highlights but *not* do any audio stuff. could be good for that use case.
      - yeah! good communication can help a lot here. rn, the highlights will also be disabled, because strudel won't do anything, but in theory we could only disable superdough, so web audio won't do a thing, but strudel will still query each frame for highlighting. we still then have the issue that we don't have sync, which is mostly an issue in a local setting (highlights won't match sound)
- in the long term, could a single binary be made to run the fastest part of the sound engine which is sent midi, osc or json "messages" by nudel/flok? it would be something to install, but should be fairly painless. ask Daniel he might have a sound engine somewhere that could do this... or people could use supercollider if that is installed already
  - yeah that's the idea of superdirt, which is tidal's audio engine. the installation is not super easy tho + local setups can differ

while this might all sound a bit "pessimistic", i think there is plenty of room for "optimization". i think there are 2 major ways to tackle this:

- optimize what is there -> start with lowest hanging fruits that improve the experience. for example, we've noticed in the strudel repl that simple css animations might make a huge difference on slow hardware. simply disabling animation improved things alot (thinking of you marquee). i think this is what we should do first to see how far we get.
- write a custom solution, tailored to the problem of spawning audio graphs. there is not a lot in the web landscape that works like that. see <https://github.com/tidalcycles/strudel/discussions/64> for a list of candidates. most audio engines work in a way that you declare your devices/graphs/instances beforehand and then send messages to them to make sound. this is not how tidal/strudel works. here, each event is a separate instance, so you can have full polyphony of effects (think two different filters on 2 overlapping notes etc..). the initial motivation behind kabelsalat was that it could become a custom engine for strudel, so in a way i'm already on that path since last summer.
  - another note on optimism vs pessimism: I'm confident we can make it way way way faster. i live for this stuff too. we're only just getting started with this mass collaboration use case

## long lived flok sessions

we've discovered that performance degrades with a longer lived flok session.
this is one important aspect of pastagang: having a single room for everybody.
the "pastagang" room was used first on december 30 2024 on [todepond.cool/flok](https://github.com/pastagang/dotcool/commit/5ac01e3f8eb203dcbece11119c1038c150e857d4) and one day later on [nudel](https://github.com/pastagang/nudel/commit/f8b21cc8eac70c3b04dc5762b54f3fb82cd66269#diff-27653c212e1cfe533e4eb2f7d0d3f89604c9de48a09583b4cbbbcbd08a07da79L89).
at the time of this writing (feb 5 2025), the room is now over 2 months in (heavy) use.
people have noticed things got slower when more people were in the same room.
in particular, the syncing of the cursor movement seemed to be connected to it.
even with only 2 people in a room, you could hold down the arrow keys to race through the code on one machine,
to slow down the browser of another. the slowdown was most noticeable in the strudel clock, which missed events during cursor movement.
we've tried turning off most features (no hydra, no strudel highlighting, no shaders, no kabelsalat), but still cursor movement was causing strudel clock callbacks to get delayed. the same phenomenon could be observed in both nudel and on flok.cc/s/pastagang.
the slowdown didn't happen anymore in a new room. this is why nudel now uses the pastagang2 room since today.

we haven't fully understood why exactly this happens but, it has to be related to yjs and its "crdt" algorithm, which is used to sync people in a session. it seems that the longer a session lasts, the more memory is used for the editor history.
i'm still not sure how exactly the storage of the session state is working, but one piece of the puzzle in the browser's local indexDB.
you can look up how big your indexDB is in the browser developer tools, (in chromium) going to application -> Storage.
for me, it was around 5MB. i wanted to actually look at the data, but it seems the ui didn't let me see all of it, so i found out how to log it from the browser console:

```js
indexedDB.open("pastagang").onsuccess = function (event) {
  const db = event.target.result;
  const transaction = db.transaction("updates", "readonly");
  const store = transaction.objectStore("updates");
  const request = store.getAll();
  request.onsuccess = () => console.log(JSON.stringify(request.result).length);
  db.close();
};
```

the size i'm getting for this json is 48027941 characters, which is around 48MB!
this is a lot, and seems plausible to have caused slowdowns.
i even get dropped events when running this code in the console, because it takes so long to complete.
when i run the same with `pastagang2`, i get a json of 195934, which is only 0.4% of the size.
this means, we have to switch rooms regularly to preserver performance.
there might be a fix that doesn't involve manual labor, although changing the roomname once in a while is not a lot of maintenance.
one idea by munshkr was that we could append a timestamp to the roomname.
for example, we could use `pastagang-${Math.floor(Date.now() / (1000 * 60 * 60 * 24))}` to get a fresh room each 24 hours, or `pastagang-${Math.floor(Date.now() / (1000 * 60 * 60 * 24 * 7))}` to get a new one every week.
lu had the idea to show a warning like "WARNING: JAM WILL BE PRUNED IN 60 SECONDS".
of course, there might also be a fix on the yjs or flok side to somehow prune the history automatically.
