cml - cmus launch idk, for Termux
=================================

## overkill bit-perfect audio on adrod, with no closed source stuff

honestly why

i hope theres an oss app that can do this soon

placeholder text

for the script, requirements:

- [these](https://github.com/fukiame/termux-packages/actions) builds of cmus with ALSA enabled
- alsa-utils
- tmux

if you dont need the volume thing just use the cmus build by itself

also you need an USB DAC

### cmus setup

before setting, check your USB sound card's location first via `aplay -l`, for example:

```
~ $ sudo aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: konamtpsndcard [kona-mtp-snd-card], device 0: MultiMedia1 (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
[ ... ]
card 1: JA11 [JadeAudio JA11], device 0: USB Audio [USB Audio]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
```

note the card number and device number of your USB DAC

now launch cmus with root (e.g `sudo cmus`) and config it to use ALSA, replace the numbers in hw:x,x with the one you noted earlier:

```
:set output_plugin alsa
:set dsp.alsa.device=hw:1,0
```

now use cmus, or check its tutorial if you dont already know how to, and ur good to go i guess

be careful since by default ALSA set its volume to max (the script auto sets it to 1 to account for that)

### credits

- https://github.com/cmus/cmus for cmus
- https://ryan.himmelwright.net/post/scripting-tmux-workspaces for the tmux pane join
