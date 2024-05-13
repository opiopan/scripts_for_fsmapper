scripts_for_fsmapper
===

This repository manages configuration scripts for [fsmapper](https://opiopan.github.io/fsmapper) that I use when playing flight simulators.
These scripts are designed to work with the following hardware.

- [SimHID G1000](https://github.com/opiopan/simhid-g1000)
- Touchscrren secandary display in order to display a virtual instrument panel
- Logicool X56 HOTAS

Please refer to [this video](https://youtu.be/lI2umhc4eDA) for a showcase of the typical aircraft supported by this script (note that it supports aircraft beyond those featured in the video).

## How to use

1. **Cloning this repository**<br>
    ```sh
    $ git clone https://github.com/opiopan/scripts_for_fsmapper.git
    ```

2. **Running a script on fsmapper**<br>
    After launching fsmapper, open `scripts_for_fsmapper\config.lua`.


## Adapt to your environment
If your hardware environment differs from mine (which is generally the case), specify the following script in the 'Pre-run script' section of fsmapper's settings page, restart the script.


```lua
override_config = {
    simhid_g1000_display = 1,
    simhid_g1000_display_scale = 0.5,

    simhid_g1000_mock = true, 
    simhid_g1000_mock_proxy = {
        type = 'dinput',
        identifier = {name = 'Saitek Pro Flight X-56 Rhino Throttle'},
        aux_up = 'button19',
        aux_down = 'button18',
        aux_push = 'button2',
    },

    disable_hotas = true,
}
```

The above script needs to be customized to match your environment. Here is the meaning of each parameter.

- **simhid_g1000_display**<br>
    Specify the display number for showing the virtual instrument panel. 
    This display should ideally be a touchscreen, but it can also be operated using a mouse.

- **simhid_g1000_display_scale**<br>
    Specify the size of the virtual instrument panel display. Use `1` to use the entire screen.

- **simhid_g1000_mock**<br>
    If you are not using [SimHID G1000](https://github.com/opiopan/simhid-g1000) or do not own it at all, specify `true`.

- **simhid_g1000_mock_proxy**<br>
    In many aircraft, you can operate multiple virtual instrument panels by switching between them.
    This switching operation is assigned to the left and right AUX switches of [SimHID G1000](https://github.com/opiopan/simhid-g1000).
    If you are not using [SimHID G1000](https://github.com/opiopan/simhid-g1000), you can assign the switching operation to another device using this parameter.<br>

    Specify the device to use for this purpose in the `identifier` parameter.
    Refer to [this guide](https://opiopan.github.io/fsmapper/getting-started/tutorial#handle-an-input-device) for descriptions of the `identifier` parameters corresponding to the devices you own.

    Specify which buttons of the device identified by `identifier` to use for switching virtual instrument panels using `aux_up`, `aux_down`, and `aux_push` parameters.

- **disable_hotas**<br>
    If you are not using the Logicool X56 HOTAS or do not own it at all, specify `true`.