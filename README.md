![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# PWM Generator — Tiny Tapeout

- [Read the documentation for project](docs/info.md)

## How it works

This project implements a 2-bit PWM (Pulse Width Modulation) generator. It uses a free-running
2-bit counter that increments on every rising clock edge. The PWM output is driven high whenever
the counter value is less than the configured reference value (`ref_bits`), and low otherwise.
This produces a periodic signal with a duty cycle determined by `ref_bits`:

| ref_bits | Duty Cycle |
|----------|------------|
| 0        | 0%         |
| 1        | 25%        |
| 2        | 50%        |
| 3        | 75%        |

The counter and output are reset to 0 when the active-low reset signal (`rst_n`) is asserted.

## How to test

1. Assert `rst_n` low briefly to reset the module, then release it high.
2. Set `ui[1:0]` to the desired reference value (0–3) to select the duty cycle.
3. Observe the PWM output on `uo[0]` — it will toggle according to the duty cycle above.
4. Change `ui[1:0]` at runtime to dynamically adjust the duty cycle.

> **Note:** `ui[3:2]` (state_bits) are connected to the submodule input but are not used
> in the current logic. Leave them at `0` unless repurposed in a future revision.

## External hardware

No external hardware is required. The PWM output on `uo[0]` can be connected directly to:
- An LED (with appropriate current-limiting resistor) to observe brightness changes with duty cycle
- A low-pass RC filter to produce an analog voltage proportional to the duty cycle
- A motor driver or other PWM-controlled peripheral

## What is Tiny Tapeout?

Tiny Tapeout is an educational project that aims to make it easier and cheaper than ever to get your digital and analog designs manufactured on a real chip.

To learn more and get started, visit https://tinytapeout.com.

## Set up your Verilog project

1. Add your Verilog files to the `src` folder.
2. Edit the [info.yaml](info.yaml) and update information about your project, paying special attention to the `source_files` and `top_module` properties. If you are upgrading an existing Tiny Tapeout project, check out our [online info.yaml migration tool](https://tinytapeout.github.io/tt-yaml-upgrade-tool/).
3. Edit [docs/info.md](docs/info.md) and add a description of your project.
4. Adapt the testbench to your design. See [test/README.md](test/README.md) for more information.

The GitHub action will automatically build the ASIC files using [LibreLane](https://www.zerotoasiccourse.com/terminology/librelane/).

## Enable GitHub actions to build the results page

- [Enabling GitHub Pages](https://tinytapeout.com/faq/#my-github-action-is-failing-on-the-pages-part)

## Resources

- [FAQ](https://tinytapeout.com/faq/)
- [Digital design lessons](https://tinytapeout.com/digital_design/)
- [Learn how semiconductors work](https://tinytapeout.com/siliwiz/)
- [Join the community](https://tinytapeout.com/discord)
- [Build your design locally](https://www.tinytapeout.com/guides/local-hardening/)

## What next?

- [Submit your design to the next shuttle](https://app.tinytapeout.com/).
- Edit [this README](README.md) and explain your design, how it works, and how to test it.
- Share your project on your social network of choice:
  - LinkedIn [#tinytapeout](https://www.linkedin.com/search/results/content/?keywords=%23tinytapeout) [@TinyTapeout](https://www.linkedin.com/company/100708654/)
  - Mastodon [#tinytapeout](https://chaos.social/tags/tinytapeout) [@matthewvenn](https://chaos.social/@matthewvenn)
  - X (formerly Twitter) [#tinytapeout](https://twitter.com/hashtag/tinytapeout) [@tinytapeout](https://twitter.com/tinytapeout)
  - Bluesky [@tinytapeout.com](https://bsky.app/profile/tinytapeout.com)