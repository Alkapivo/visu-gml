# Bright:
source: SRC_ALPHA
target: ONE
eq: ADD
eq-alpha: ADD

# Dark1:
source: SRC_ALPHA
target: ONE
eq: SUBTRACT
eq-alpha: ADD

# color burn
source: SRC_ALPHA
target: ONE
eq: SUBTRACT
eq-alpha: MAX

# Transparent white mask
source: DEST_COLOUR
target: ONE
eq: MAX
eq-alpha: ADD

# Saturation1
source: INV_SRC_COLOUR
target: DEST_COLOUR
eq: ADD
eq-alpha: SUBTRACT

# Flash1
source: ONE
target: INV_SRC_ALPHA
eq: ADD
eq-alpha: ADD

# Shrek1
source: ONE
target: INV_SRC_COLOUR
eq: REVERSE_SUBTRACT
eq-alpha: ADD