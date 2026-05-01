# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value    = 1
    dut.ui_in.value  = 0
    dut.uio_in.value = 0
    dut.rst_n.value  = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value  = 1

    dut._log.info("Test project behavior")

    # ref_bits=1, state_bits=2 → ui_in = (2<<2)|1 = 9
    dut.ui_in.value  = (0b10 << 2) | 0b01
    dut.uio_in.value = 0
    await ClockCycles(dut.clk, 20)

    # uo_out[0] is PWM, bits[7:1] must be 0
    assert (dut.uo_out.value & 0xFE) == 0, "uo_out[7:1] must be 0"
    assert dut.uio_out.value == 0,         "uio_out must be 0"
    assert dut.uio_oe.value  == 0,         "uio_oe must be 0"

    dut._log.info(f"PWM out = {dut.uo_out.value & 1}")
