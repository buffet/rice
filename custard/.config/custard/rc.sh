#!/bin/bash

xsetroot -solid \#1d1f21

custardctl --configure debug_mode false

custardctl --configure grid_rows 6
custardctl --configure grid_columns 8

custardctl --configure grid_gap 32
custardctl --configure grid_margin_top 24
custardctl --configure grid_margin_bottom 24
custardctl --configure grid_margin_left 24
custardctl --configure grid_margin_right 24

custardctl --configure border_focused_color \#7d3750ff
custardctl --configure border_unfocused_color \#191b1dff
custardctl --configure border_background_color \#000000ff

custardctl --configure border_inner_size 0
custardctl --configure border_outer_size 8
custardctl --configure border_type 1

custardctl --configure groups 9
