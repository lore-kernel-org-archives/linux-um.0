Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 24 Aug 2017 21:12:17 +0200
From: Thomas Meyer <thomas@m3y3r.de>
Subject: kselftests results under uml
Message-ID: <20170824191217.hhx746ot2hl4szaj@olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: thomas@m3y3r.de
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi,

I am writing a script which bundles all kselftests and run them under an UML
kernel.

The script is available here:
https://github.com/thomasmey/uml/blob/master/uml-fedora-kselftest.sh

kselftests needed some fixing on debian. See the commits here:
https://github.com/thomasmey/linux/commits/devel

The results are against 4.13.0-rc5-00220-g770414c23190-dirty

Is anybody interested in those results? If so I can try to further automate
these runs.

Some tests fails because either the distro used still misses
some packages, or the uml is buggy, or the tests are buggy. It's on my todo
list to look at all errors in details.

script output:

Running tests in bpf
========================================
#0/u add+sub+mul OK
#0/p add+sub+mul OK
#1/u unreachable OK
#1/p unreachable OK
#2/u unreachable2 OK
#2/p unreachable2 OK
#3/u out of range jump OK
#3/p out of range jump OK
#4/u out of range jump2 OK
#4/p out of range jump2 OK
#5/u test1 ld_imm64 OK
#5/p test1 ld_imm64 OK
#6/u test2 ld_imm64 OK
#6/p test2 ld_imm64 OK
#7/u test3 ld_imm64 OK
#7/p test3 ld_imm64 OK
#8/u test4 ld_imm64 OK
#8/p test4 ld_imm64 OK
#9/u test5 ld_imm64 OK
#9/p test5 ld_imm64 OK
#10/u test6 ld_imm64 OK
#10/p test6 ld_imm64 OK
#11/u test7 ld_imm64 OK
#11/p test7 ld_imm64 OK
#12/u test8 ld_imm64 OK
#12/p test8 ld_imm64 OK
#13/u test9 ld_imm64 OK
#13/p test9 ld_imm64 OK
#14/u test10 ld_imm64 OK
#14/p test10 ld_imm64 OK
#15/u test11 ld_imm64 OK
#15/p test11 ld_imm64 OK
#16/u test12 ld_imm64 OK
#16/p test12 ld_imm64 OK
#17/u test13 ld_imm64 OK
#17/p test13 ld_imm64 OK
#18/u no bpf_exit OK
#18/p no bpf_exit OK
#19/u loop (back-edge) OK
#19/p loop (back-edge) OK
#20/u loop2 (back-edge) OK
#20/p loop2 (back-edge) OK
#21/u conditional loop OK
#21/p conditional loop OK
#22/u read uninitialized register OK
#22/p read uninitialized register OK
#23/u read invalid register OK
#23/p read invalid register OK
#24/u program doesn't init R0 before exit OK
#24/p program doesn't init R0 before exit OK
#25/u program doesn't init R0 before exit in all branches OK
#25/p program doesn't init R0 before exit in all branches OK
#26/u stack out of bounds OK
#26/p stack out of bounds OK
#27/u invalid call insn1 OK
#27/p invalid call insn1 OK
#28/u invalid call insn2 OK
#28/p invalid call insn2 OK
#29/u invalid function call OK
#29/p invalid function call OK
#30/u uninitialized stack1 OK
#30/p uninitialized stack1 OK
#31/u uninitialized stack2 OK
#31/p uninitialized stack2 OK
#32/u invalid fp arithmetic OK
#32/p invalid fp arithmetic OK
#33/u non-invalid fp arithmetic OK
#33/p non-invalid fp arithmetic OK
#34/p invalid argument register OK
#35/p non-invalid argument register OK
#36/u check valid spill/fill OK
#36/p check valid spill/fill OK
#37/u check valid spill/fill, skb mark OK
#37/p check valid spill/fill, skb mark OK
#38/u check corrupted spill/fill OK
#38/p check corrupted spill/fill OK
#39/u invalid src register in STX OK
#39/p invalid src register in STX OK
#40/u invalid dst register in STX OK
#40/p invalid dst register in STX OK
#41/u invalid dst register in ST OK
#41/p invalid dst register in ST OK
#42/u invalid src register in LDX OK
#42/p invalid src register in LDX OK
#43/u invalid dst register in LDX OK
#43/p invalid dst register in LDX OK
#44/u junk insn OK
#44/p junk insn OK
#45/u junk insn2 OK
#45/p junk insn2 OK
#46/u junk insn3 OK
#46/p junk insn3 OK
#47/u junk insn4 OK
#47/p junk insn4 OK
#48/u junk insn5 OK
#48/p junk insn5 OK
#49/u misaligned read from stack OK
#49/p misaligned read from stack OK
#50/u invalid map_fd for function call OK
#50/p invalid map_fd for function call OK
#51/u don't check return value before access OK
#51/p don't check return value before access OK
#52/u access memory with incorrect alignment OK
#52/p access memory with incorrect alignment OK
#53/u sometimes access memory with incorrect alignment OK
#53/p sometimes access memory with incorrect alignment OK
#54/u jump test 1 OK
#54/p jump test 1 OK
#55/u jump test 2 OK
#55/p jump test 2 OK
#56/u jump test 3 OK
#56/p jump test 3 OK
#57/u jump test 4 OK
#57/p jump test 4 OK
#58/u jump test 5 OK
#58/p jump test 5 OK
#59/u access skb fields ok OK
#59/p access skb fields ok OK
#60/u access skb fields bad1 OK
#60/p access skb fields bad1 OK
#61/u access skb fields bad2 OK
#61/p access skb fields bad2 OK
#62/u access skb fields bad3 OK
#62/p access skb fields bad3 OK
#63/u access skb fields bad4 OK
#63/p access skb fields bad4 OK
#64/u check skb->mark is not writeable by sockets OK
#64/p check skb->mark is not writeable by sockets OK
#65/u check skb->tc_index is not writeable by sockets OK
#65/p check skb->tc_index is not writeable by sockets OK
#66/u check cb access: byte OK
#66/p check cb access: byte OK
#67/u __sk_buff->hash, offset 0, byte store not permitted OK
#67/p __sk_buff->hash, offset 0, byte store not permitted OK
#68/u __sk_buff->tc_index, offset 3, byte store not permitted OK
#68/p __sk_buff->tc_index, offset 3, byte store not permitted OK
#69/u check skb->hash byte load permitted OK
#69/p check skb->hash byte load permitted OK
#70/u check skb->hash byte load not permitted 1 OK
#70/p check skb->hash byte load not permitted 1 OK
#71/u check skb->hash byte load not permitted 2 OK
#71/p check skb->hash byte load not permitted 2 OK
#72/u check skb->hash byte load not permitted 3 OK
#72/p check skb->hash byte load not permitted 3 OK
#73/p check cb access: byte, wrong type OK
#74/u check cb access: half OK
#74/p check cb access: half OK
#75/u check cb access: half, unaligned OK
#75/p check cb access: half, unaligned OK
#76/u check __sk_buff->hash, offset 0, half store not permitted OK
#76/p check __sk_buff->hash, offset 0, half store not permitted OK
#77/u check __sk_buff->tc_index, offset 2, half store not permitted OK
#77/p check __sk_buff->tc_index, offset 2, half store not permitted OK
#78/u check skb->hash half load permitted OK
#78/p check skb->hash half load permitted OK
#79/u check skb->hash half load not permitted OK
#79/p check skb->hash half load not permitted OK
#80/p check cb access: half, wrong type OK
#81/u check cb access: word OK
#81/p check cb access: word OK
#82/u check cb access: word, unaligned 1 OK
#82/p check cb access: word, unaligned 1 OK
#83/u check cb access: word, unaligned 2 OK
#83/p check cb access: word, unaligned 2 OK
#84/u check cb access: word, unaligned 3 OK
#84/p check cb access: word, unaligned 3 OK
#85/u check cb access: word, unaligned 4 OK
#85/p check cb access: word, unaligned 4 OK
#86/u check cb access: double OK
#86/p check cb access: double OK
#87/u check cb access: double, unaligned 1 OK
#87/p check cb access: double, unaligned 1 OK
#88/u check cb access: double, unaligned 2 OK
#88/p check cb access: double, unaligned 2 OK
#89/u check cb access: double, oob 1 OK
#89/p check cb access: double, oob 1 OK
#90/u check cb access: double, oob 2 OK
#90/p check cb access: double, oob 2 OK
#91/u check __sk_buff->ifindex dw store not permitted OK
#91/p check __sk_buff->ifindex dw store not permitted OK
#92/u check __sk_buff->ifindex dw load not permitted OK
#92/p check __sk_buff->ifindex dw load not permitted OK
#93/p check cb access: double, wrong type OK
#94/p check out of range skb->cb access OK
#95/u write skb fields from socket prog OK
#95/p write skb fields from socket prog OK
#96/p write skb fields from tc_cls_act prog OK
#97/u PTR_TO_STACK store/load OK
#97/p PTR_TO_STACK store/load OK
#98/u PTR_TO_STACK store/load - bad alignment on off OK
#98/p PTR_TO_STACK store/load - bad alignment on off OK
#99/u PTR_TO_STACK store/load - bad alignment on reg OK
#99/p PTR_TO_STACK store/load - bad alignment on reg OK
#100/u PTR_TO_STACK store/load - out of bounds low OK
#100/p PTR_TO_STACK store/load - out of bounds low OK
#101/u PTR_TO_STACK store/load - out of bounds high OK
#101/p PTR_TO_STACK store/load - out of bounds high OK
#102/u unpriv: return pointer OK
#102/p unpriv: return pointer OK
#103/u unpriv: add const to pointer OK
#103/p unpriv: add const to pointer OK
#104/u unpriv: add pointer to pointer OK
#104/p unpriv: add pointer to pointer OK
#105/u unpriv: neg pointer OK
#105/p unpriv: neg pointer OK
#106/u unpriv: cmp pointer with const OK
#106/p unpriv: cmp pointer with const OK
#107/u unpriv: cmp pointer with pointer OK
#107/p unpriv: cmp pointer with pointer OK
#108/u unpriv: check that printk is disallowed OK
#108/p unpriv: check that printk is disallowed FAIL
Failed to load prog 'Invalid argument'!
0: (7a) *(u64 *)(r10 -8) = 0
1: (bf) r1 = r10
2: (07) r1 += -8
3: (b7) r2 = 8
4: (bf) r3 = r1
5: (85) call bpf_trace_printk#6
unknown func bpf_trace_printk#6
#109/u unpriv: pass pointer to helper function OK
#109/p unpriv: pass pointer to helper function OK
#110/u unpriv: indirectly pass pointer on stack to helper function OK
#110/p unpriv: indirectly pass pointer on stack to helper function OK
#111/u unpriv: mangle pointer on stack 1 OK
#111/p unpriv: mangle pointer on stack 1 OK
#112/u unpriv: mangle pointer on stack 2 OK
#112/p unpriv: mangle pointer on stack 2 OK
#113/u unpriv: read pointer from stack in small chunks OK
#113/p unpriv: read pointer from stack in small chunks OK
#114/u unpriv: write pointer into ctx OK
#114/p unpriv: write pointer into ctx OK
#115/u unpriv: spill/fill of ctx OK
#115/p unpriv: spill/fill of ctx OK
#116/p unpriv: spill/fill of ctx 2 OK
#117/p unpriv: spill/fill of ctx 3 OK
#118/p unpriv: spill/fill of ctx 4 OK
#119/p unpriv: spill/fill of different pointers stx OK
#120/p unpriv: spill/fill of different pointers ldx FAIL
Unexpected error message!
#121/u unpriv: write pointer into map elem value OK
#121/p unpriv: write pointer into map elem value OK
#122/u unpriv: partial copy of pointer OK
#122/p unpriv: partial copy of pointer OK
#123/u unpriv: pass pointer to tail_call OK
#123/p unpriv: pass pointer to tail_call OK
#124/u unpriv: cmp map pointer with zero OK
#124/p unpriv: cmp map pointer with zero OK
#125/u unpriv: write into frame pointer OK
#125/p unpriv: write into frame pointer OK
#126/u unpriv: spill/fill frame pointer OK
#126/p unpriv: spill/fill frame pointer OK
#127/u unpriv: cmp of frame pointer OK
#127/p unpriv: cmp of frame pointer OK
#128/u unpriv: adding of fp OK
#128/p unpriv: adding of fp OK
#129/u unpriv: cmp of stack pointer OK
#129/p unpriv: cmp of stack pointer OK
#130/u stack pointer arithmetic OK
#130/p stack pointer arithmetic OK
#131/p raw_stack: no skb_load_bytes OK
#132/p raw_stack: skb_load_bytes, negative len OK
#133/p raw_stack: skb_load_bytes, negative len 2 OK
#134/p raw_stack: skb_load_bytes, zero len OK
#135/p raw_stack: skb_load_bytes, no init OK
#136/p raw_stack: skb_load_bytes, init OK
#137/p raw_stack: skb_load_bytes, spilled regs around bounds OK
#138/p raw_stack: skb_load_bytes, spilled regs corruption OK
#139/p raw_stack: skb_load_bytes, spilled regs corruption 2 OK
#140/p raw_stack: skb_load_bytes, spilled regs + data OK
#141/p raw_stack: skb_load_bytes, invalid access 1 OK
#142/p raw_stack: skb_load_bytes, invalid access 2 OK
#143/p raw_stack: skb_load_bytes, invalid access 3 OK
#144/p raw_stack: skb_load_bytes, invalid access 4 OK
#145/p raw_stack: skb_load_bytes, invalid access 5 OK
#146/p raw_stack: skb_load_bytes, invalid access 6 OK
#147/p raw_stack: skb_load_bytes, large access OK
#148/p direct packet access: test1 OK
#149/p direct packet access: test2 OK
#150/p direct packet access: test3 OK
#151/p direct packet access: test4 (write) OK
#152/p direct packet access: test5 (pkt_end >= reg, good access) OK
#153/p direct packet access: test6 (pkt_end >= reg, bad access) OK
#154/p direct packet access: test7 (pkt_end >= reg, both accesses) OK
#155/p direct packet access: test8 (double test, variant 1) OK
#156/p direct packet access: test9 (double test, variant 2) OK
#157/p direct packet access: test10 (write invalid) OK
#158/p direct packet access: test11 (shift, good access) OK
#159/p direct packet access: test12 (and, good access) OK
#160/p direct packet access: test13 (branches, good access) OK
#161/p direct packet access: test14 (pkt_ptr += 0, CONST_IMM, good access) OK
#162/p direct packet access: test15 (spill with xadd) OK
#163/p direct packet access: test16 (arith on data_end) OK
#164/p direct packet access: test17 (pruning, alignment) OK
#165/p direct packet access: test18 (imm += pkt_ptr, 1) OK
#166/p direct packet access: test19 (imm += pkt_ptr, 2) OK
#167/p direct packet access: test20 (x += pkt_ptr, 1) FAIL
Failed to load prog 'Permission denied'!
0: (61) r2 = *(u32 *)(r1 +76)
1: (61) r3 = *(u32 *)(r1 +80)
2: (b7) r0 = -1
3: (7b) *(u64 *)(r10 -8) = r0
4: (79) r0 = *(u64 *)(r10 -8)
5: (57) r0 &= 65535
6: (bf) r4 = r0
7: (0f) r4 += r2
8: (bf) r5 = r4
9: (07) r4 += 65534
10: (2d) if r4 > r3 goto pc+1
 R0=inv48,min_value=0,max_value=65535,min_align=1 R1=ctx R2=pkt(id=0,off=0,r=0) R3=pkt_end R4=pkt(id=1,off=65534,r=65534) R5=pkt(id=1,off=0,r=65534) R10=fp
11: (7b) *(u64 *)(r5 +0) = r4
misaligned packet access off 2+0+0 size 8
#168/p direct packet access: test21 (x += pkt_ptr, 2) FAIL
Failed to load prog 'Permission denied'!
0: (61) r2 = *(u32 *)(r1 +76)
1: (61) r3 = *(u32 *)(r1 +80)
2: (bf) r0 = r2
3: (07) r0 += 8
4: (2d) if r0 > r3 goto pc+9
 R0=pkt(id=0,off=8,r=8) R1=ctx R2=pkt(id=0,off=0,r=8) R3=pkt_end R10=fp
5: (b7) r4 = -1
6: (7b) *(u64 *)(r10 -8) = r4
7: (79) r4 = *(u64 *)(r10 -8)
8: (57) r4 &= 65535
9: (0f) r4 += r2
10: (bf) r5 = r4
11: (07) r4 += 65534
12: (2d) if r4 > r3 goto pc+1
 R0=pkt(id=0,off=8,r=8) R1=ctx R2=pkt(id=0,off=0,r=8) R3=pkt_end R4=pkt(id=1,off=65534,r=65534) R5=pkt(id=1,off=0,r=65534) R10=fp
13: (7b) *(u64 *)(r5 +0) = r4
misaligned packet access off 2+0+0 size 8
#169/p direct packet access: test22 (x += pkt_ptr, 3) OK
#170/p direct packet access: test23 (x += pkt_ptr, 4) OK
#171/p direct packet access: test24 (x += pkt_ptr, 5) FAIL
Failed to load prog 'Permission denied'!
0: (61) r2 = *(u32 *)(r1 +76)
1: (61) r3 = *(u32 *)(r1 +80)
2: (b7) r0 = -1
3: (7b) *(u64 *)(r10 -8) = r0
4: (79) r0 = *(u64 *)(r10 -8)
5: (57) r0 &= 255
6: (bf) r4 = r0
7: (b7) r0 = 64
8: (0f) r0 += r4
9: (0f) r0 += r2
10: (bf) r5 = r0
11: (07) r0 += 65534
12: (2d) if r0 > r3 goto pc+1
 R0=pkt(id=1,off=65534,r=65534) R1=ctx R2=pkt(id=0,off=0,r=0) R3=pkt_end R4=inv56,min_value=0,max_value=255,min_align=1 R5=pkt(id=1,off=0,r=65534) R10=fp
13: (7b) *(u64 *)(r5 +0) = r0
misaligned packet access off 2+0+0 size 8
#172/p helper access to packet: test1, valid packet_ptr range OK
#173/p helper access to packet: test2, unchecked packet_ptr OK
#174/p helper access to packet: test3, variable add OK
#175/p helper access to packet: test4, packet_ptr with bad range OK
#176/p helper access to packet: test5, packet_ptr with too short range OK
#177/p helper access to packet: test6, cls valid packet_ptr range OK
#178/p helper access to packet: test7, cls unchecked packet_ptr OK
#179/p helper access to packet: test8, cls variable add OK
#180/p helper access to packet: test9, cls packet_ptr with bad range OK
#181/p helper access to packet: test10, cls packet_ptr with too short range OK
#182/p helper access to packet: test11, cls unsuitable helper 1 OK
#183/p helper access to packet: test12, cls unsuitable helper 2 OK
#184/p helper access to packet: test13, cls helper ok OK
#185/p helper access to packet: test14, cls helper fail sub OK
#186/p helper access to packet: test15, cls helper fail range 1 OK
#187/p helper access to packet: test16, cls helper fail range 2 OK
#188/p helper access to packet: test17, cls helper fail range 3 OK
#189/p helper access to packet: test18, cls helper fail range zero OK
#190/p helper access to packet: test19, pkt end as input OK
#191/p helper access to packet: test20, wrong reg OK
#192/u valid map access into an array with a constant OK
#192/p valid map access into an array with a constant OK
#193/u valid map access into an array with a register OK
#193/p valid map access into an array with a register OK (NOTE: reject due to unknown alignment)
#194/u valid map access into an array with a variable OK
#194/p valid map access into an array with a variable OK (NOTE: reject due to unknown alignment)
#195/u valid map access into an array with a signed variable OK
#195/p valid map access into an array with a signed variable OK (NOTE: reject due to unknown alignment)
#196/u invalid map access into an array with a constant OK
#196/p invalid map access into an array with a constant OK
#197/u invalid map access into an array with a register OK
#197/p invalid map access into an array with a register OK (NOTE: reject due to unknown alignment)
#198/u invalid map access into an array with a variable OK
#198/p invalid map access into an array with a variable OK (NOTE: reject due to unknown alignment)
#199/u invalid map access into an array with no floor check OK
#199/p invalid map access into an array with no floor check OK (NOTE: reject due to unknown alignment)
#200/u invalid map access into an array with a invalid max check OK
#200/p invalid map access into an array with a invalid max check OK (NOTE: reject due to unknown alignment)
#201/u invalid map access into an array with a invalid max check OK
#201/p invalid map access into an array with a invalid max check OK (NOTE: reject due to unknown alignment)
#202/p multiple registers share map_lookup_elem result OK
#203/p alu ops on ptr_to_map_value_or_null, 1 OK
#204/p alu ops on ptr_to_map_value_or_null, 2 OK
#205/p alu ops on ptr_to_map_value_or_null, 3 OK
#206/p invalid memory access with multiple map_lookup_elem calls OK
#207/p valid indirect map_lookup_elem access with 2nd lookup in branch OK
#208/p multiple registers share map_lookup_elem bad reg type OK
#209/u invalid map access from else condition OK
#209/p invalid map access from else condition OK (NOTE: reject due to unknown alignment)
#210/p constant register |= constant should keep constant type FAIL
Failed to load prog 'Invalid argument'!
#211/p constant register |= constant should not bypass stack boundary checks FAIL
Unexpected error message!
#212/p constant register |= constant register should keep constant type FAIL
Failed to load prog 'Invalid argument'!
#213/p constant register |= constant register should not bypass stack boundary checks FAIL
Unexpected error message!
#214/p invalid direct packet write for LWT_IN OK
#215/p invalid direct packet write for LWT_OUT OK
#216/p direct packet write for LWT_XMIT OK
#217/p direct packet read for LWT_IN OK
#218/p direct packet read for LWT_OUT OK
#219/p direct packet read for LWT_XMIT OK
#220/p overlapping checks for direct packet access OK
#221/u invalid access of tc_classid for LWT_IN OK
#221/p invalid access of tc_classid for LWT_IN OK
#222/u invalid access of tc_classid for LWT_OUT OK
#222/p invalid access of tc_classid for LWT_OUT OK
#223/u invalid access of tc_classid for LWT_XMIT OK
#223/p invalid access of tc_classid for LWT_XMIT OK
#224/u leak pointer into ctx 1 OK
#224/p leak pointer into ctx 1 OK
#225/u leak pointer into ctx 2 OK
#225/p leak pointer into ctx 2 OK
#226/u leak pointer into ctx 3 OK
#226/p leak pointer into ctx 3 OK
#227/u leak pointer into map val OK
#227/p leak pointer into map val OK
#228/p helper access to map: full range FAIL
Failed to load prog 'Invalid argument'!
#229/p helper access to map: partial range FAIL
Failed to load prog 'Invalid argument'!
#230/p helper access to map: empty range FAIL
Unexpected error message!
#231/p helper access to map: out-of-bound range FAIL
Unexpected error message!
#232/p helper access to map: negative range FAIL
Unexpected error message!
#233/p helper access to adjusted map (via const imm): full range FAIL
Failed to load prog 'Invalid argument'!
#234/p helper access to adjusted map (via const imm): partial range FAIL
Failed to load prog 'Invalid argument'!
#235/p helper access to adjusted map (via const imm): empty range FAIL
Unexpected error message!
#236/p helper access to adjusted map (via const imm): out-of-bound range FAIL
Unexpected error message!
#237/p helper access to adjusted map (via const imm): negative range (> adjustment) FAIL
Unexpected error message!
#238/p helper access to adjusted map (via const imm): negative range (< adjustment) FAIL
Unexpected error message!
#239/p helper access to adjusted map (via const reg): full range FAIL
Failed to load prog 'Invalid argument'!
#240/p helper access to adjusted map (via const reg): partial range FAIL
Failed to load prog 'Invalid argument'!
#241/p helper access to adjusted map (via const reg): empty range FAIL
Unexpected error message!
#242/p helper access to adjusted map (via const reg): out-of-bound range FAIL
Unexpected error message!
#243/p helper access to adjusted map (via const reg): negative range (> adjustment) FAIL
Unexpected error message!
#244/p helper access to adjusted map (via const reg): negative range (< adjustment) FAIL
Unexpected error message!
#245/p helper access to adjusted map (via variable): full range FAIL
Failed to load prog 'Invalid argument'!
#246/p helper access to adjusted map (via variable): partial range FAIL
Failed to load prog 'Invalid argument'!
#247/p helper access to adjusted map (via variable): empty range FAIL
Unexpected error message!
#248/p helper access to adjusted map (via variable): no max check FAIL
Unexpected error message!
#249/p helper access to adjusted map (via variable): wrong max check FAIL
Unexpected error message!
#250/u map element value is preserved across register spilling OK
#250/p map element value is preserved across register spilling OK
#251/u map element value or null is marked on register spilling OK
#251/p map element value or null is marked on register spilling OK
#252/u map element value store of cleared call register OK
#252/p map element value store of cleared call register OK
#253/u map element value with unaligned store OK
#253/p map element value with unaligned store OK (NOTE: reject due to unknown alignment)
#254/u map element value with unaligned load OK
#254/p map element value with unaligned load OK (NOTE: reject due to unknown alignment)
#255/u map element value illegal alu op, 1 OK
#255/p map element value illegal alu op, 1 OK
#256/u map element value illegal alu op, 2 OK
#256/p map element value illegal alu op, 2 OK
#257/u map element value illegal alu op, 3 OK
#257/p map element value illegal alu op, 3 OK
#258/u map element value illegal alu op, 4 OK
#258/p map element value illegal alu op, 4 OK
#259/u map element value illegal alu op, 5 OK
#259/p map element value illegal alu op, 5 OK
#260/u map element value is preserved across register spilling OK
#260/p map element value is preserved across register spilling OK (NOTE: reject due to unknown alignment)
#261/p helper access to variable memory: stack, bitwise AND + JMP, correct bounds FAIL
Failed to load prog 'Invalid argument'!
#262/p helper access to variable memory: stack, bitwise AND, zero included FAIL
Unexpected error message!
#263/p helper access to variable memory: stack, bitwise AND + JMP, wrong max FAIL
Unexpected error message!
#264/p helper access to variable memory: stack, JMP, correct bounds FAIL
Failed to load prog 'Invalid argument'!
#265/p helper access to variable memory: stack, JMP (signed), correct bounds FAIL
Failed to load prog 'Invalid argument'!
#266/p helper access to variable memory: stack, JMP, bounds + offset FAIL
Unexpected error message!
#267/p helper access to variable memory: stack, JMP, wrong max FAIL
Unexpected error message!
#268/p helper access to variable memory: stack, JMP, no max check FAIL
Unexpected error message!
#269/p helper access to variable memory: stack, JMP, no min check FAIL
Unexpected error message!
#270/p helper access to variable memory: stack, JMP (signed), no min check FAIL
Unexpected error message!
#271/p helper access to variable memory: map, JMP, correct bounds FAIL
Failed to load prog 'Invalid argument'!
#272/p helper access to variable memory: map, JMP, wrong max FAIL
Unexpected error message!
#273/p helper access to variable memory: map adjusted, JMP, correct bounds FAIL
Failed to load prog 'Invalid argument'!
#274/p helper access to variable memory: map adjusted, JMP, wrong max FAIL
Unexpected error message!
#275/p helper access to variable memory: size > 0 not allowed on NULL OK
#276/p helper access to variable memory: size = 0 not allowed on != NULL OK
#277/p helper access to variable memory: 8 bytes leak FAIL
Unexpected error message!
#278/p helper access to variable memory: 8 bytes no leak (init memory) FAIL
Failed to load prog 'Invalid argument'!
#279/u invalid and of negative number OK
#279/p invalid and of negative number OK (NOTE: reject due to unknown alignment)
#280/u invalid range check OK
#280/p invalid range check OK (NOTE: reject due to unknown alignment)
#281/u map in map access OK
#281/p map in map access OK
#282/u invalid inner map pointer OK
#282/p invalid inner map pointer OK
#283/u forgot null checking on the inner map pointer OK
#283/p forgot null checking on the inner map pointer OK
#284/u ld_abs: check calling conv, r1 OK
#284/p ld_abs: check calling conv, r1 OK
#285/u ld_abs: check calling conv, r2 OK
#285/p ld_abs: check calling conv, r2 OK
#286/u ld_abs: check calling conv, r3 OK
#286/p ld_abs: check calling conv, r3 OK
#287/u ld_abs: check calling conv, r4 OK
#287/p ld_abs: check calling conv, r4 OK
#288/u ld_abs: check calling conv, r5 OK
#288/p ld_abs: check calling conv, r5 OK
#289/u ld_abs: check calling conv, r7 OK
#289/p ld_abs: check calling conv, r7 OK
#290/u ld_ind: check calling conv, r1 OK
#290/p ld_ind: check calling conv, r1 OK
#291/u ld_ind: check calling conv, r2 OK
#291/p ld_ind: check calling conv, r2 OK
#292/u ld_ind: check calling conv, r3 OK
#292/p ld_ind: check calling conv, r3 OK
#293/u ld_ind: check calling conv, r4 OK
#293/p ld_ind: check calling conv, r4 OK
#294/u ld_ind: check calling conv, r5 OK
#294/p ld_ind: check calling conv, r5 OK
#295/u ld_ind: check calling conv, r7 OK
#295/p ld_ind: check calling conv, r7 OK
#296/p check bpf_perf_event_data->sample_period byte load permitted FAIL
Failed to load prog 'Invalid argument'!
#297/p check bpf_perf_event_data->sample_period half load permitted FAIL
Failed to load prog 'Invalid argument'!
#298/p check bpf_perf_event_data->sample_period word load permitted FAIL
Failed to load prog 'Invalid argument'!
#299/p check bpf_perf_event_data->sample_period dword load permitted FAIL
Failed to load prog 'Invalid argument'!
#300/u check skb->data half load not permitted OK
#300/p check skb->data half load not permitted OK
#301/p check skb->tc_classid half load not permitted for lwt prog OK
#302/u bounds checks mixing signed and unsigned, positive bounds OK
#302/p bounds checks mixing signed and unsigned, positive bounds OK
#303/u bounds checks mixing signed and unsigned OK
#303/p bounds checks mixing signed and unsigned OK
#304/u bounds checks mixing signed and unsigned, variant 2 OK
#304/p bounds checks mixing signed and unsigned, variant 2 OK
#305/u bounds checks mixing signed and unsigned, variant 3 OK
#305/p bounds checks mixing signed and unsigned, variant 3 OK
#306/u bounds checks mixing signed and unsigned, variant 4 OK
#306/p bounds checks mixing signed and unsigned, variant 4 OK
#307/u bounds checks mixing signed and unsigned, variant 5 OK
#307/p bounds checks mixing signed and unsigned, variant 5 OK
#308/u bounds checks mixing signed and unsigned, variant 6 OK
#308/p bounds checks mixing signed and unsigned, variant 6 OK
#309/u bounds checks mixing signed and unsigned, variant 7 OK
#309/p bounds checks mixing signed and unsigned, variant 7 OK
#310/u bounds checks mixing signed and unsigned, variant 8 OK
#310/p bounds checks mixing signed and unsigned, variant 8 OK
#311/u bounds checks mixing signed and unsigned, variant 9 OK
#311/p bounds checks mixing signed and unsigned, variant 9 OK
#312/u bounds checks mixing signed and unsigned, variant 10 OK
#312/p bounds checks mixing signed and unsigned, variant 10 OK
#313/u bounds checks mixing signed and unsigned, variant 11 OK
#313/p bounds checks mixing signed and unsigned, variant 11 OK
#314/u bounds checks mixing signed and unsigned, variant 12 OK
#314/p bounds checks mixing signed and unsigned, variant 12 OK
#315/u bounds checks mixing signed and unsigned, variant 13 OK
#315/p bounds checks mixing signed and unsigned, variant 13 OK
#316/u bounds checks mixing signed and unsigned, variant 14 OK
#316/p bounds checks mixing signed and unsigned, variant 14 OK
#317/u bounds checks mixing signed and unsigned, variant 15 OK
#317/p bounds checks mixing signed and unsigned, variant 15 OK
#318/u bounds checks mixing signed and unsigned, variant 16 OK
#318/p bounds checks mixing signed and unsigned, variant 16 OK
#319/u subtraction bounds (map value) OK
#319/p subtraction bounds (map value) OK
Summary: 453 PASSED, 51 FAILED
selftests: test_verifier [FAIL]
test_tag: test_tag.c:124: tag_from_alg: Assertion `fd_base > 0' failed.
/opt/run_kselftest.sh: line 8:   956 Aborted                 ./test_tag
selftests: test_tag [FAIL]
Failed to retrieve # possible CPUs!
selftests: test_maps [FAIL]
Failed to retrieve # possible CPUs!
selftests: test_lru_map [FAIL]
test_lpm: OK
selftests: test_lpm_map [PASS]
test_pkt_access:PASS:ipv4 589 nsec
test_pkt_access:PASS:ipv6 471 nsec
test_xdp:PASS:ipv4 8704 nsec
test_xdp:PASS:ipv6 2816 nsec
Failed to retrieve # possible CPUs!
selftests: test_progs [FAIL]
Test   0: mov ... PASS
Test   1: shift ... PASS
Test   2: addsub ... PASS
Test   3: mul ... PASS
Test   4: unknown shift ... PASS
Test   5: unknown mul ... PASS
Test   6: packet const offset ... PASS
Test   7: packet variable offset ... PASS
Results: 8 pass 0 fail
selftests: test_align [PASS]
sysctl: cannot stat /proc/sys/net/core/bpf_jit_enable: No such file or directory
sysctl: cannot stat /proc/sys/net/core/bpf_jit_harden: No such file or directory
sysctl: cannot stat /proc/sys/net/core/bpf_jit_enable: No such file or directory
sysctl: cannot stat /proc/sys/net/core/bpf_jit_harden: No such file or directory
[ JIT enabled:0 hardened:0 ]
sysctl: cannot stat /proc/sys/net/core/bpf_jit_enable: No such file or directory
sysctl: cannot stat /proc/sys/net/core/bpf_jit_harden: No such file or directory
[ JIT enabled:1 hardened:0 ]
sysctl: cannot stat /proc/sys/net/core/bpf_jit_enable: No such file or directory
sysctl: cannot stat /proc/sys/net/core/bpf_jit_harden: No such file or directory
[ JIT enabled:1 hardened:1 ]
sysctl: cannot stat /proc/sys/net/core/bpf_jit_enable: No such file or directory
sysctl: cannot stat /proc/sys/net/core/bpf_jit_harden: No such file or directory
[ JIT enabled:1 hardened:2 ]
sysctl: malformed setting "net.core.bpf_jit_enable="
sysctl: malformed setting "net.core.bpf_jit_harden="
selftests: test_kmod.sh [FAIL]
Running tests in breakpoints
========================================
TAP version 13
Bail out! open("/sys/power/state") failed (is this test running as root?)
1..0
selftests: step_after_suspend_test [FAIL]
Running tests in capabilities
========================================
[OK]	Capabilities after execve were correct
[OK]	Capabilities after execve were correct
[OK]	Capabilities after execve were correct
[OK]	Capabilities after execve were correct
[OK]	Capabilities after execve were correct
[OK]	Capabilities after execve were correct
[OK]	Capabilities after execve were correct
[OK]	Capabilities after execve were correct
[RUN]	+++ Tests with uid == 0 +++
[NOTE]	Using global UIDs for tests
[RUN]	Root => ep
[OK]	Child succeeded
[OK]	Check cap_ambient manipulation rules
[OK]	PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
[OK]	PR_CAP_AMBIENT_RAISE failed on non-permitted cap
[OK]	PR_CAP_AMBIENT_RAISE worked
[OK]	Basic manipulation appears to work
[RUN]	Root +i => eip
[OK]	Child succeeded
[RUN]	UID 0 +ia => eipa
[OK]	Child succeeded
[RUN]	Root +ia, suidroot => eipa
[OK]	Child succeeded
[RUN]	Root +ia, suidnonroot => ip
[OK]	Child succeeded
[RUN]	Root +ia, sgidroot => eipa
[OK]	Child succeeded
[RUN]	Root +ia, sgidnonroot => eip
[OK]	Child succeeded
[OK]	Capabilities after execve were correct
[OK]	Capabilities after execve were correct
[OK]	Capabilities after execve were correct
[OK]	Capabilities after execve were correct
[OK]	Child succeeded
selftests: test_execve [PASS]
Running tests in cpufreq
========================================
pid 1045's current affinity mask: 1
pid 1045's new affinity mask: 1
skip all tests: cpufreq directory not available in sysfs
selftests: main.sh [FAIL]
Running tests in cpu-hotplug
========================================
pid 1054's current affinity mask: 1
pid 1054's new affinity mask: 1
CPU online/offline summary:
	 Cpus in online state: 0
	 Cpus in offline state: 0
Limited scope test: one hotplug cpu
	 (leaves cpu in the original state):
	 online to offline to online: cpu 0
./cpu-on-off-test.sh: line 83: /sys/devices/system/cpu/cpu0/online: Permission denied
offline_cpu_expect_success 0: unexpected fail
./cpu-on-off-test.sh: line 78: /sys/devices/system/cpu/cpu0/online: Permission denied
online_cpu_expect_success 0: unexpected fail
selftests: cpu-on-off-test.sh [PASS]
Running tests in efivarfs
========================================
skip all tests: efivarfs is not mounted on /sys/firmware/efi/efivars
selftests: efivarfs.sh [PASS]
Running tests in exec
========================================
/bin/sh: /dev/fd/5/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
 xxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
 xxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxx
 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/yyyyyyyyyyyyyyyyyyyyyyyy
 yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
yyyyyyyyyyyyyyyy: File name too long
Check success of execveat(3, '../execveat', 0)... [OK]
Check success of execveat(5, 'execveat', 0)... [OK]
Check success of execveat(6, 'execveat', 0)... [OK]
Check success of execveat(-100, '/opt/exec/execveat', 0)... [OK]
Check success of execveat(99, '/opt/exec/execveat', 0)... [OK]
Check success of execveat(8, '', 4096)... [OK]
Check success of execveat(17, '', 4096)... [OK]
Check success of execveat(9, '', 4096)... [OK]
Check success of execveat(14, '', 4096)... [OK]
Check success of execveat(15, '', 4096)... [OK]
Check failure of execveat(8, '', 0) with ENOENT... [OK]
Check failure of execveat(8, '(null)', 4096) with EFAULT... [OK]
Check success of execveat(5, 'execveat.symlink', 0)... [OK]
Check success of execveat(6, 'execveat.symlink', 0)... [OK]
Check success of execveat(-100, '/opt/exec/execveat.symlink', 0)... [OK]
Check success of execveat(10, '', 4096)... [OK]
Check success of execveat(10, '', 4352)... [OK]
Check failure of execveat(5, 'execveat.symlink', 256) with ELOOP... [OK]
Check failure of execveat(6, 'execveat.symlink', 256) with ELOOP... [OK]
Check failure of execveat(-100, '/opt/exec/execveat.symlink', 256) with ELOOP... [OK]
Check success of execveat(3, '../script', 0)... [OK]
Check success of execveat(5, 'script', 0)... [OK]
Check success of execveat(6, 'script', 0)... [OK]
Check success of execveat(-100, '/opt/exec/script', 0)... [OK]
Check success of execveat(13, '', 4096)... [OK]
Check success of execveat(13, '', 4352)... [OK]
Check failure of execveat(18, '', 4096) with ENOENT... [OK]
Check failure of execveat(7, 'script', 0) with ENOENT... [OK]
Check success of execveat(16, '', 4096)... [OK]
Check success of execveat(4, '../script', 0)... [OK]
Check success of execveat(4, 'script', 0)... [OK]
Check success of execveat(4, '../script', 0)... [OK]
Check failure of execveat(4, 'script', 0) with ENOENT... [OK]
Check failure of execveat(5, 'execveat', 65535) with EINVAL... [OK]
Check failure of execveat(5, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(6, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(-100, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(5, '', 4096) with EACCES... [OK]
Check failure of execveat(5, 'Makefile', 0) with EACCES... [OK]
Check failure of execveat(11, '', 4096) with EACCES... [OK]
Check failure of execveat(12, '', 4096) with EACCES... [OK]
Check failure of execveat(99, '', 4096) with EBADF... [OK]
Check failure of execveat(99, 'execveat', 0) with EBADF... [OK]
Check failure of execveat(8, 'execveat', 0) with ENOTDIR... [OK]
Invoke copy of 'execveat' via filename of length 4093:
Check success of execveat(19, '', 4096)... [OK]
Check success of execveat(5, 'xxxxxxxxxxxxxxxxxxxx...yyyyyyyyyyyyyyyyyyyy', 0)... [OK]
Invoke copy of 'script' via filename of length 4093:
Check success of execveat(20, '', 4096)... [OK]
Check success of execveat(5, 'xxxxxxxxxxxxxxxxxxxx...yyyyyyyyyyyyyyyyyyyy', 0)... [OK]
selftests: execveat [PASS]
Running tests in firmware
========================================
./fw_filesystem.sh: timeout works
./fw_filesystem.sh: filesystem loading works
./fw_filesystem.sh: async filesystem loading works
selftests: fw_filesystem.sh [PASS]
./fw_fallback.sh: timeout works
./fw_fallback.sh: firmware comparison works
./fw_fallback.sh: fallback mechanism works
./fw_fallback.sh: cancelling fallback mechanism works
./fw_fallback.sh: custom fallback loading mechanism works
./fw_fallback.sh: cancelling custom fallback mechanism works
selftests: fw_fallback.sh [PASS]
Running tests in ftrace
========================================
=== Ftrace unit tests ===
[1] Basic trace file check	[PASS]
[2] Basic test for tracers	[PASS]
[3] Basic trace clock test	[PASS]
[4] Basic event tracing check	[PASS]
[5] event tracing - enable/disable with event level files	[PASS]
[6] event tracing - restricts events based on pid	[PASS]
[7] event tracing - enable/disable with subsystem level files	[PASS]
[8] event tracing - enable/disable with top level files	[PASS]
[9] ftrace - function graph filters with stack tracer	[UNSUPPORTED]
[10] ftrace - function graph filters	[UNSUPPORTED]
[11] ftrace - test for function event triggers	[UNSUPPORTED]
[12] ftrace - function glob filters	[UNSUPPORTED]
[13] ftrace - function pid filters	[UNSUPPORTED]
[14] ftrace - function profiler with function tracing	[UNSUPPORTED]
[15] ftrace - test reading of set_ftrace_filter	[UNSUPPORTED]
[16] ftrace - test for function traceon/off triggers	[UNSUPPORTED]
[17] Test creation and deletion of trace instances while setting an event	[PASS]
[18] Test creation and deletion of trace instances	[PASS]
[19] Kprobe dynamic event - adding and removing	[UNSUPPORTED]
[20] Kprobe dynamic event - busy event check	[UNSUPPORTED]
[21] Kprobe dynamic event with arguments	[UNSUPPORTED]
[22] Kprobes event arguments with types	[UNSUPPORTED]
[23] Kprobe event auto/manual naming	[UNSUPPORTED]
[24] Kprobe dynamic event with function tracer	[UNSUPPORTED]
[25] Kprobe dynamic event - probing module	[UNSUPPORTED]
[26] Kretprobe dynamic event with arguments	[UNSUPPORTED]
[27] Kretprobe dynamic event with maxactive	[UNSUPPORTED]
[28] Register/unregister many kprobe events	[FAIL]
[29] event trigger - test event enable/disable trigger	[PASS]
[30] event trigger - test trigger filter	[PASS]
[31] event trigger - test histogram modifiers	[UNSUPPORTED]
[32] event trigger - test histogram trigger	[UNSUPPORTED]
[33] event trigger - test multiple histogram triggers	[UNSUPPORTED]
[34] event trigger - test snapshot-trigger	[PASS]
[35] event trigger - test stacktrace-trigger	[PASS]
[36] event trigger - test traceon/off trigger	[PASS]
[37] (instance)  Basic test for tracers	[PASS]
[38] (instance)  Basic trace clock test	[PASS]
[39] (instance)  event tracing - enable/disable with event level files	[PASS]
[40] (instance)  event tracing - restricts events based on pid	[PASS]
[41] (instance)  event tracing - enable/disable with subsystem level files	[PASS]
[42] (instance)  ftrace - test for function event triggers	[UNSUPPORTED]
[43] (instance)  ftrace - test for function traceon/off triggers	[UNSUPPORTED]
[44] (instance)  event trigger - test event enable/disable trigger	[PASS]
[45] (instance)  event trigger - test trigger filter	[PASS]
[46] (instance)  event trigger - test histogram modifiers	[UNSUPPORTED]
[47] (instance)  event trigger - test histogram trigger	[UNSUPPORTED]
[48] (instance)  event trigger - test multiple histogram triggers	[UNSUPPORTED]
# of passed:  22
# of failed:  1
# of unresolved:  0
# of untested:  0
# of unsupported:  25
# of xfailed:  0
# of undefined(test bug):  0
selftests: ftracetest [FAIL]
Running tests in futex
========================================
tput: terminal attributes: No such device or address
tput: terminal attributes: No such device or address
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=0 locked=0 owner=0 timeout=0ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=1 locked=0 owner=0 timeout=0ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=1 locked=1 owner=0 timeout=0ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=1 locked=0 owner=1 timeout=0ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=0 locked=1 owner=0 timeout=0ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=0 locked=0 owner=1 timeout=0ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=1 locked=1 owner=0 timeout=5000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=0 locked=1 owner=0 timeout=5000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=1 locked=1 owner=0 timeout=500000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=0 locked=1 owner=0 timeout=500000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=1 locked=0 owner=0 timeout=5000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=0 locked=0 owner=0 timeout=5000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=1 locked=0 owner=0 timeout=500000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=0 locked=0 owner=0 timeout=500000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=1 locked=0 owner=1 timeout=5000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=0 locked=1 owner=0 timeout=5000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=1 locked=0 owner=1 timeout=500000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=0 locked=1 owner=0 timeout=500000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=1 locked=1 owner=0 timeout=2000000000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi: Test requeue functionality
	Arguments: broadcast=0 locked=1 owner=0 timeout=2000000000ns
selftests: futex-requeue-pi [ PASS]
futex_requeue_pi_mismatched_ops: Detect mismatched requeue_pi operations
selftests: futex-requeue-pi-mismatched-ops [ PASS]
futex_requeue_pi_signal_restart: Test signal handling during requeue_pi
	Arguments: <none>
selftests: futex-requeue-pi-signal-restart [ PASS]
futex_wait_timeout: Block on a futex and wait for timeout
	Arguments: timeout=100000ns
selftests: futex-wait-timeout [ PASS]
futex_wait_wouldblock: Test the unexpected futex value in FUTEX_WAIT
selftests: futex-wait-wouldblock [ PASS]
futex_wait_uninitialized_heap: Test the uninitialized futex value in FUTEX_WAIT
selftests: futex-wait-uninitialized-heap [ PASS]
futex_wait_private_mapped_file: Test the futex value of private file mappings in FUTEX_WAIT
selftests: futex-wait-private-mapped-file [ PASS]
Running tests in gpio
========================================
/opt/run_kselftest.sh: line 64: cd: gpio: No such file or directory
/opt/run_kselftest.sh: line 65: ./gpio-mockup.sh: No such file or directory
selftests: gpio-mockup.sh [FAIL]
Running tests in intel_pstate
========================================
./run.sh: line 35: gcc: command not found
Problem compiling aperf.c.
selftests: run.sh [FAIL]
Running tests in ipc
========================================
1..0
selftests: msgque [PASS]
Running tests in kcmp
========================================
pid1:   2808 pid2:   2809 FD:  2 FILES:  2 VM:  1 FS:  1 SIGHAND:  2 IO:  2 SYSVSEM:  0 INV: -1
PASS: 0 returned as expected
1..2
1..0
selftests: kcmp_test [PASS]
Running tests in lib
========================================
printf: ok
selftests: printf.sh [PASS]
bitmap: ok
selftests: bitmap.sh [PASS]
Running tests in membarrier
========================================
TAP version 13
ok 1 sys_membarrier available
ok 2 sys membarrier invalid command test: command = -1, flags = 0. Failed as expected
ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags = 1. Failed as expected
ok 4 sys membarrier MEMBARRIER_CMD_SHARED test: flags = 0
1..4
selftests: membarrier_test [PASS]
Running tests in memfd
========================================
fuse: device not found, try 'modprobe fuse' first
selftests: run_fuse_test.sh [FAIL]
Running tests in memory-hotplug
========================================
skip all tests: memory hotplug is not supported
Running tests in mount
========================================
Running tests in mqueue
========================================
Initial system state:
	Using queue path:		/test1
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10
Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10
Test series 1, behavior when no attr struct passed to mq_open:
Kernel supports setting defaults separately from maximums:		PASS
Given sane values, mq_open without an attr struct succeeds:		PASS
Kernel properly honors default setting knobs:				PASS
Kernel properly limits default values to lesser of default/max:		PASS
Kernel properly fails to create queue when defaults would
exceed rlimit:								PASS
Test series 2, behavior when attr struct is passed to mq_open:
Queue open in excess of rlimit max when euid = 0 failed:		PASS
Queue open with mq_maxmsg > limit when euid = 0 succeeded:		PASS
Queue open with mq_msgsize > limit when euid = 0 succeeded:		PASS
Queue open with total size > 2GB when euid = 0 failed:			PASS
Queue open in excess of rlimit max when euid = 99 failed:		PASS
Queue open with mq_maxmsg > limit when euid = 99 failed:		PASS
Queue open with mq_msgsize > limit when euid = 99 failed:		PASS
Queue open with total size > 2GB when euid = 99 failed:			PASS
Initial system state:
	Using queue path:			/mq_perf_tests
	RLIMIT_MSGQUEUE(soft):			819200
	RLIMIT_MSGQUEUE(hard):			819200
	Maximum Message Size:			8192
	Maximum Queue Size:			10
	Nice value:				0
Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):			(unlimited)
	RLIMIT_MSGQUEUE(hard):			(unlimited)
	Maximum Message Size:			16777216
	Maximum Queue Size:			65530
	Nice value:				-20
	Continuous mode:			(disabled)
	CPUs to pin:				0
	Queue /mq_perf_tests created:
		mq_flags:			O_NONBLOCK
		mq_maxmsg:			65530
		mq_msgsize:			16
		mq_curmsgs:			0
	Started mqueue performance test thread on CPU 0
		Max priorities:			32768
		Clock resolution:		1 nsec
	Test #1: Time send/recv message, queue empty
		(10000000 iterations)
		Send msg:			644.770000000s total time
						64477 nsec/msg
		Recv msg:			1167.830000000s total time
						116783 nsec/msg
	Test #2a: Time send/recv message, queue full, constant prio
:
		(100000 iterations)
		Filling queue...done.		3.230000000s
		Testing...done.
		Send msg:			6.280000000s total time
						62800 nsec/msg
		Recv msg:			6.420000000s total time
						64200 nsec/msg
		Draining queue...done.		3.70000000s
	Test #2b: Time send/recv message, queue full, increasing prio
:
		(100000 iterations)
		Filling queue...done.		4.100000000s
		Testing...done.
		Send msg:			6.530000000s total time
						65300 nsec/msg
		Recv msg:			9.680000000s total time
						96800 nsec/msg
		Draining queue...done.		3.480000000s
	Test #2c: Time send/recv message, queue full, decreasing prio
:
		(100000 iterations)
		Filling queue...done.		4.40000000s
		Testing...done.
		Send msg:			6.100000000s total time
						61000 nsec/msg
		Recv msg:			8.890000000s total time
						88900 nsec/msg
		Draining queue...done.		3.440000000s
	Test #2d: Time send/recv message, queue full, random prio
:
		(100000 iterations)
		Filling queue...done.		4.210000000s
		Testing...done.
		Send msg:			6.810000000s total time
						68100 nsec/msg
		Recv msg:			9.600000000s total time
						96000 nsec/msg
		Draining queue...done.		3.740000000s
Running tests in net
========================================
--------------------
running socket test
--------------------
[PASS]
selftests: run_netsocktests [PASS]
--------------------
running psock_fanout test
--------------------
test: control single socket
socket packet: Address family not supported by protocol
[FAIL]
--------------------
running psock_tpacket test
--------------------
test: TPACKET_V1 with PACKET_RX_RING socket: Address family not supported by protocol
[FAIL]
selftests: run_afpackettests [PASS]
test_bpf: ok
selftests: test_bpf.sh [PASS]
selftests: netdevice.sh [PASS]
Running tests in nsfs
========================================
selftests: owner [PASS]
selftests: pidns [PASS]
Running tests in powerpc
========================================
/opt/run_kselftest.sh: line 130: cd: powerpc: No such file or directory
Running tests in pstore
========================================
=== Pstore unit tests (pstore_tests) ===
UUID=a2b01b72-fdb6-48df-8713-0b9c73ef3a2b
Checking pstore backend is registered ... cat: /sys/module/pstore/parameters/backend: No such file or directory
FAIL
	backend=
	cmdline=mem=1280m ubd0=Fedora-Cloud-Base-26-1.5.x86_64.raw.cow,Fedora-Cloud-Base-26-1.5.x86_64.raw ubd1=Fedora-Cloud-Base-Init.iso ubd2=Fedora-Cloud-Base-kselftests.img ubd3=Fedora-Cloud-Base-modules.img ubd4=Fedora-Cloud-Base-Result.img ro rhgb quiet LANG=de_DE.UTF-8 plymouth.enable=0 con=pts con0=fd:0,fd:1 loadpin.enabled=0 selinux=0 root=98:0
selftests: pstore_tests [FAIL]
=== Pstore unit tests (pstore_post_reboot_tests) ===
UUID=2cc9e36a-8347-40a8-9f5b-205da74307b5
Checking pstore backend is registered ... cat: /sys/module/pstore/parameters/backend: No such file or directory
FAIL
	backend=
	cmdline=mem=1280m ubd0=Fedora-Cloud-Base-26-1.5.x86_64.raw.cow,Fedora-Cloud-Base-26-1.5.x86_64.raw ubd1=Fedora-Cloud-Base-Init.iso ubd2=Fedora-Cloud-Base-kselftests.img ubd3=Fedora-Cloud-Base-modules.img ubd4=Fedora-Cloud-Base-Result.img ro rhgb quiet LANG=de_DE.UTF-8 plymouth.enable=0 con=pts con0=fd:0,fd:1 loadpin.enabled=0 selinux=0 root=98:0
selftests: pstore_post_reboot_tests [FAIL]
Running tests in ptrace
========================================
PASS
selftests: peeksiginfo [PASS]
Running tests in seccomp
========================================
[==========] Running 52 tests from 1 test cases.
[ RUN      ] global.mode_strict_support
[       OK ] global.mode_strict_support
[ RUN      ] global.mode_strict_cannot_call_prctl
[       OK ] global.mode_strict_cannot_call_prctl
[ RUN      ] global.no_new_privs_support
[       OK ] global.no_new_privs_support
[ RUN      ] global.mode_filter_support
[       OK ] global.mode_filter_support
[ RUN      ] global.mode_filter_without_nnp
[       OK ] global.mode_filter_without_nnp
[ RUN      ] global.filter_size_limits
[       OK ] global.filter_size_limits
[ RUN      ] global.filter_chain_limits
[       OK ] global.filter_chain_limits
[ RUN      ] global.mode_filter_cannot_move_to_strict
[       OK ] global.mode_filter_cannot_move_to_strict
[ RUN      ] global.mode_filter_get_seccomp
[       OK ] global.mode_filter_get_seccomp
[ RUN      ] global.ALLOW_all
[       OK ] global.ALLOW_all
[ RUN      ] global.empty_prog
[       OK ] global.empty_prog
[ RUN      ] global.unknown_ret_is_kill_inside
[       OK ] global.unknown_ret_is_kill_inside
[ RUN      ] global.unknown_ret_is_kill_above_allow
[       OK ] global.unknown_ret_is_kill_above_allow
[ RUN      ] global.KILL_all
[       OK ] global.KILL_all
[ RUN      ] global.KILL_one
[       OK ] global.KILL_one
[ RUN      ] global.KILL_one_arg_one
[       OK ] global.KILL_one_arg_one
[ RUN      ] global.KILL_one_arg_six
[       OK ] global.KILL_one_arg_six
[ RUN      ] global.arg_out_of_range
[       OK ] global.arg_out_of_range
[ RUN      ] global.ERRNO_valid
[       OK ] global.ERRNO_valid
[ RUN      ] global.ERRNO_zero
[       OK ] global.ERRNO_zero
[ RUN      ] global.ERRNO_capped
[       OK ] global.ERRNO_capped
[ RUN      ] TRAP.dfl
[       OK ] TRAP.dfl
[ RUN      ] TRAP.ign
[       OK ] TRAP.ign
[ RUN      ] TRAP.handler
[       OK ] TRAP.handler
[ RUN      ] precedence.allow_ok
[       OK ] precedence.allow_ok
[ RUN      ] precedence.kill_is_highest
[       OK ] precedence.kill_is_highest
[ RUN      ] precedence.kill_is_highest_in_any_order
[       OK ] precedence.kill_is_highest_in_any_order
[ RUN      ] precedence.trap_is_second
[       OK ] precedence.trap_is_second
[ RUN      ] precedence.trap_is_second_in_any_order
[       OK ] precedence.trap_is_second_in_any_order
[ RUN      ] precedence.errno_is_third
[       OK ] precedence.errno_is_third
[ RUN      ] precedence.errno_is_third_in_any_order
[       OK ] precedence.errno_is_third_in_any_order
[ RUN      ] precedence.trace_is_fourth
[       OK ] precedence.trace_is_fourth
[ RUN      ] precedence.trace_is_fourth_in_any_order
[       OK ] precedence.trace_is_fourth_in_any_order
[ RUN      ] TRACE_poke.read_has_side_effects
[       OK ] TRACE_poke.read_has_side_effects
[ RUN      ] TRACE_poke.getpid_runs_normally
[       OK ] TRACE_poke.getpid_runs_normally
[ RUN      ] TRACE_syscall.syscall_allowed
[       OK ] TRACE_syscall.syscall_allowed
[ RUN      ] TRACE_syscall.syscall_redirected
[       OK ] TRACE_syscall.syscall_redirected
[ RUN      ] TRACE_syscall.syscall_dropped
[       OK ] TRACE_syscall.syscall_dropped
[ RUN      ] TRACE_syscall.skip_after_RET_TRACE
[       OK ] TRACE_syscall.skip_after_RET_TRACE
[ RUN      ] TRACE_syscall.kill_after_RET_TRACE
[       OK ] TRACE_syscall.kill_after_RET_TRACE
[ RUN      ] TRACE_syscall.skip_after_ptrace
[       OK ] TRACE_syscall.skip_after_ptrace
[ RUN      ] TRACE_syscall.kill_after_ptrace
[       OK ] TRACE_syscall.kill_after_ptrace
[ RUN      ] global.seccomp_syscall
[       OK ] global.seccomp_syscall
[ RUN      ] global.seccomp_syscall_mode_lock
[       OK ] global.seccomp_syscall_mode_lock
[ RUN      ] global.TSYNC_first
[       OK ] global.TSYNC_first
[ RUN      ] TSYNC.siblings_fail_prctl
[       OK ] TSYNC.siblings_fail_prctl
[ RUN      ] TSYNC.two_siblings_with_ancestor
[       OK ] TSYNC.two_siblings_with_ancestor
[ RUN      ] TSYNC.two_sibling_want_nnp
[       OK ] TSYNC.two_sibling_want_nnp
[ RUN      ] TSYNC.two_siblings_with_no_filter
[       OK ] TSYNC.two_siblings_with_no_filter
[ RUN      ] TSYNC.two_siblings_with_one_divergence
[       OK ] TSYNC.two_siblings_with_one_divergence
[ RUN      ] TSYNC.two_siblings_not_under_filter
[       OK ] TSYNC.two_siblings_not_under_filter
[ RUN      ] global.syscall_restart
[       OK ] global.syscall_restart
[==========] 52 / 52 tests passed.
[  PASSED  ]
selftests: seccomp_bpf [PASS]
Running tests in sigaltstack
========================================
[OK]	Initial sigaltstack state was SS_DISABLE
[RUN]	signal USR1
[OK]	sigaltstack is disabled in sighandler
[RUN]	switched to user ctx
[RUN]	signal USR2
[OK]	Stack preserved
[FAIL]	ss_flags=2, should be SS_AUTODISARM
selftests: sas [FAIL]
Running tests in size
========================================
TAP version 13
# Testing system size.
ok 1 get runtime memory use
# System runtime memory report (units in Kilobytes):
 ---
 Total:  1236048
 Free:   1015040
 Buffer: 13048
 In use: 207960
 ...
1..1
selftests: get_size [PASS]
Running tests in splice
========================================
./default_file_splice_read.sh: line 2: ./default_file_splice_read: No such file or directory
selftests: default_file_splice_read.sh [PASS]
Running tests in static_keys
========================================
static_key: ok
selftests: test_static_keys.sh [PASS]
Running tests in sync
========================================
[RUN]	Testing sync framework
[RUN]	Executing test_alloc_timeline
[RUN]	Executing test_alloc_fence
[RUN]	Executing test_alloc_fence_negative
[RUN]	Executing test_fence_one_timeline_wait
[RUN]	Executing test_fence_one_timeline_merge
[RUN]	Executing test_fence_merge_same_fence
[RUN]	Executing test_fence_multi_timeline_wait
[RUN]	Executing test_stress_two_threads_shared_timeline
[RUN]	Executing test_consumer_stress_multi_producer_single_consumer
[RUN]	Executing test_merge_stress_random_merge
[OK]	sync
selftests: sync_test [PASS]
Running tests in sysctl
========================================
./sysctl.sh: You need perl installed
selftests: sysctl.sh [FAIL]
Running tests in timers
========================================
Testing posix timers. False negative may happen on CPU execution
based timers if other threads run on the CPU...
Check itimer prof... [OK]
Check itimer real... [OK]
Check timer_create() per thread... [OK]
Check timer_create() per process... [OK]
1..0
selftests: posix_timers [PASS]
Nanosleep CLOCK_REALTIME                  [OK]
Nanosleep CLOCK_MONOTONIC                 [OK]
Nanosleep CLOCK_MONOTONIC_RAW             [UNSUPPORTED]
Nanosleep CLOCK_REALTIME_COARSE           [UNSUPPORTED]
Nanosleep CLOCK_MONOTONIC_COARSE          [UNSUPPORTED]
Nanosleep CLOCK_BOOTTIME                  [OK]
Nanosleep CLOCK_REALTIME_ALARM            [UNSUPPORTED]
Nanosleep CLOCK_BOOTTIME_ALARM            [UNSUPPORTED]
Nanosleep CLOCK_TAI                       [OK]
1..0
selftests: nanosleep [PASS]
nsleep latency CLOCK_REALTIME             [OK]
nsleep latency CLOCK_MONOTONIC            [OK]
nsleep latency CLOCK_MONOTONIC_RAW        [UNSUPPORTED]
nsleep latency CLOCK_REALTIME_COARSE      [UNSUPPORTED]
nsleep latency CLOCK_MONOTONIC_COARSE     [UNSUPPORTED]
nsleep latency CLOCK_BOOTTIME             [OK]
nsleep latency CLOCK_REALTIME_ALARM       [UNSUPPORTED]
nsleep latency CLOCK_BOOTTIME_ALARM       [UNSUPPORTED]
nsleep latency CLOCK_TAI                  [OK]
1..0
selftests: nsleep-lat [PASS]
Setting timers for every 1 seconds
CLOCK_REALTIME         ABSTIME max latency:     700928 ns : [OK]
CLOCK_REALTIME         RELTIME max latency:    1824256 ns : [OK]
CLOCK_MONOTONIC        ABSTIME max latency:    1324800 ns : [OK]
CLOCK_MONOTONIC        RELTIME max latency:    1265152 ns : [OK]
CLOCK_BOOTTIME         ABSTIME max latency:    1076992 ns : [OK]
CLOCK_BOOTTIME         RELTIME max latency:    1620992 ns : [OK]
CLOCK_REALTIME_ALARM   ABSTIME missing CAP_WAKE_ALARM?    : [UNSUPPORTED]
CLOCK_REALTIME_ALARM   RELTIME missing CAP_WAKE_ALARM?    : [UNSUPPORTED]
CLOCK_BOOTTIME_ALARM   ABSTIME missing CAP_WAKE_ALARM?    : [UNSUPPORTED]
CLOCK_BOOTTIME_ALARM   RELTIME missing CAP_WAKE_ALARM?    : [UNSUPPORTED]
CLOCK_TAI              ABSTIME max latency:     751872 ns : [OK]
CLOCK_TAI              RELTIME max latency:    1671680 ns : [OK]
1..0
selftests: set-timer-lat [PASS]
Mqueue latency :                          [OK]
1..0
selftests: mqueue-lat [PASS]
Consistent CLOCK_REALTIME                 [OK]
Consistent CLOCK_MONOTONIC                [OK]
Consistent CLOCK_PROCESS_CPUTIME_ID       [OK]
Consistent CLOCK_THREAD_CPUTIME_ID        [OK]
Consistent CLOCK_MONOTONIC_RAW            [OK]
Consistent CLOCK_REALTIME_COARSE          [OK]
Consistent CLOCK_MONOTONIC_COARSE         [OK]
Consistent CLOCK_BOOTTIME                 [OK]
Consistent CLOCK_TAI                      [OK]
1..0
selftests: inconsistency-check [PASS]
Estimating clock drift: 0.1(est) 0.0(act)	[OK]
1..0
selftests: raw_skew [PASS]
Thu, 24 Aug 2017 15:34:28 +0000
Testing consistency with 8 threads for 30 seconds: [OK]
1..0
selftests: threadtest [PASS]
/dev/rtc0: No such file or directory
selftests: rtctest [FAIL]
Running tests in user
========================================
user_copy: ok
selftests: test_user_copy.sh [PASS]
Running tests in vm
========================================
no hugetlbfs support in kernel?
selftests: run_vmtests [FAIL]
Running tests in x86
========================================
/opt/run_kselftest.sh: line 204:  3159 Trace/breakpoint trap   ./single_step_syscall_64
selftests: single_step_syscall_64 [FAIL]
[RUN]	Syscalls followed by SS validation
[OK]	We survived
selftests: sysret_ss_attrs_64 [PASS]
/opt/run_kselftest.sh: line 206:  3165 Trace/breakpoint trap   ./syscall_nt_64
selftests: syscall_nt_64 [FAIL]
ptrace_syscall_64: PTRACE_SYSEMU: Input/output error
[RUN]	Check int80 return regs
[FAIL]	getpid() failed to preserve regs
[OK]	kill(getpid(), SIGUSR1) preserves regs
[RUN]	ptrace-induced syscall restart
[RUN]	SYSEMU
selftests: ptrace_syscall_64 [FAIL]
	AT_SYSINFO_EHDR is 0x7fbffff000
[NOTE]	Moving vDSO: [0x7fbffff000, 0x7fc0000000] -> [0x40029000, 0x4002a000]
[OK]
selftests: test_mremap_vdso_64 [PASS]
[OK]	All GPRs except SP are 0
[FAIL]	FLAGS is 0x206, but it should be 0x202
selftests: check_initial_reg_state_64 [FAIL]
/opt/run_kselftest.sh: line 210:  3176 Segmentation fault      ./sigreturn_64
selftests: sigreturn_64 [FAIL]
[NOTE]	set_thread_area is unavailable
[OK]	LDT entry 0 has AR 0x0040FA00 and limit 0x0000000A
[OK]	LDT entry 0 has AR 0x00C0FA00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FA00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FA00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D0FA00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07A00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00907A00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07200 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07000 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07400 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00507600 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507E00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507C00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507A00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507800 and limit 0x0000000A
[RUN]	Test fork
[OK]	LDT entry 2 has AR 0x00507800 and limit 0x0000000A
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 0 has AR 0x0040FA00 and limit 0x0000002A
[NOTE]	set_thread_area is unavailable
[OK]	LDT entry 0 has AR 0x0040FA00 and limit 0x0000000A
[OK]	LDT entry 0 has AR 0x00C0FA00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FA00 and limit 0x0000AFFF
[OK]	LDT entry 1 is invalid
[OK]	LDT entry 2 has AR 0x00C0FA00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D0FA00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07A00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00907A00 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07200 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07000 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00D07400 and limit 0x0000AFFF
[OK]	LDT entry 2 has AR 0x00507600 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507E00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507C00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507A00 and limit 0x0000000A
[OK]	LDT entry 2 has AR 0x00507800 and limit 0x0000000A
[RUN]	Test fork
[OK]	Child succeeded
[RUN]	Test size
[DONE]	Size test
[OK]	modify_ldt failure 22
[OK]	LDT entry 0 has AR 0x0000F200 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007200 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x0000F000 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007200 and limit 0x00000000
[OK]	LDT entry 0 has AR 0x00007000 and limit 0x00000001
[OK]	LDT entry 0 has AR 0x00007000 and limit 0x00000000
[OK]	LDT entry 0 is invalid
[OK]	LDT entry 0 has AR 0x0040F200 and limit 0x00000000
[OK]	LDT entry 0 is invalid
[SKIP]	Cannot set affinity to CPU 1
[RUN]	Test exec
[OK]	LDT entry 0 has AR 0x0040FA00 and limit 0x0000002A
[OK]	Child succeeded
selftests: ldt_gdt_64 [PASS]
[OK]	iopl(3) failed (38) -- try running as root
selftests: iopl_64 [PASS]
processor lacks MPX XSTATE(s), can not run MPX tests
XSAVE is supported by HW & OS
XSAVE processor supported state mask: 0x7
XSAVE OS supported state mask: 0x7
selftests: mpx-mini-test_64 [PASS]
[OK]	outb to 0x80 failed
[OK]	outb to 0xed failed
[RUN]	enable 0x80
[OK]	ioperm(0x80, 1, 1) failed (38) -- try running as root
selftests: ioperm_64 [PASS]
has pku: 0
running PKEY tests for unsupported CPU/OS
selftests: protection_keys_64 [PASS]
[RUN]	Testing getcpu...
[OK]	CPU 0: syscall: cpu 0, node 0 vdso: cpu 0, node 0 vsyscall: cpu 0, node 0
selftests: test_vdso_64 [PASS]
[RUN]	ARCH_SET_GS to 0x0
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x1
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x200000000
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x0
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x200000000
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x1
[OK]	GSBASE was set as expected (selector 0x0)
[OK]	ARCH_GET_GS worked as expected (selector 0x0)
[RUN]	ARCH_SET_GS to 0x0 then mov 0 to %gs
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS to 0x1 then mov 0 to %gs
[FAIL]	GSBASE changed to 0x0 but kernel reports 0x1
[RUN]	ARCH_SET_GS to 0x200000000 then mov 0 to %gs
[FAIL]	GSBASE changed to 0x0 but kernel reports 0x200000000
[RUN]	ARCH_SET_GS to 0x0 then mov 0 to %gs and schedule
[OK]	GSBASE is 0x0
[RUN]	ARCH_SET_GS to 0x1 then mov 0 to %gs and schedule
[FAIL]	GSBASE changed to 0x0 but kernel reports 0x1
[RUN]	ARCH_SET_GS to 0x200000000 then mov 0 to %gs and schedule
[FAIL]	GSBASE changed to 0x0 but kernel reports 0x200000000
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GSBASE remained 0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GSBASE remained 0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GSBASE remained 0x0
[RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GSBASE remained 0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GSBASE remained 0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GSBASE remained 0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GSBASE remained 0x0
[RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GSBASE remained 0x0
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GSBASE remained 0x1
[RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GSBASE remained 0x1
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GSBASE remained 0x1
[RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GSBASE remained 0x1
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
[OK]	GSBASE remained 0x200000000
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
[OK]	GSBASE remained 0x200000000
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
[OK]	GSBASE remained 0x200000000
[RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
[OK]	GSBASE remained 0x200000000
[RUN]	ARCH_SET_GS(0), clear gs, then manipulate GSBASE in a different thread
	other thread: using LDT slot 0
[OK]	GSBASE remained 0
selftests: fsgsbase_64 [FAIL]
sysret_rip_64: mremap to 0x7fffffffd000: Invalid argument
[RUN]	sigreturn to 0x800000000000
[OK]	Got SIGSEGV at RIP=0x800000000000
[RUN]	sigreturn to 0x1000000000000
[OK]	Got SIGSEGV at RIP=0x1000000000000
[RUN]	sigreturn to 0x2000000000000
[OK]	Got SIGSEGV at RIP=0x2000000000000
[RUN]	sigreturn to 0x4000000000000
[OK]	Got SIGSEGV at RIP=0x4000000000000
[RUN]	sigreturn to 0x8000000000000
[OK]	Got SIGSEGV at RIP=0x8000000000000
[RUN]	sigreturn to 0x10000000000000
[OK]	Got SIGSEGV at RIP=0x10000000000000
[RUN]	sigreturn to 0x20000000000000
[OK]	Got SIGSEGV at RIP=0x20000000000000
[RUN]	sigreturn to 0x40000000000000
[OK]	Got SIGSEGV at RIP=0x40000000000000
[RUN]	sigreturn to 0x80000000000000
[OK]	Got SIGSEGV at RIP=0x80000000000000
[RUN]	sigreturn to 0x100000000000000
[OK]	Got SIGSEGV at RIP=0x100000000000000
[RUN]	sigreturn to 0x200000000000000
[OK]	Got SIGSEGV at RIP=0x200000000000000
[RUN]	sigreturn to 0x400000000000000
[OK]	Got SIGSEGV at RIP=0x400000000000000
[RUN]	sigreturn to 0x800000000000000
[OK]	Got SIGSEGV at RIP=0x800000000000000
[RUN]	sigreturn to 0x1000000000000000
[OK]	Got SIGSEGV at RIP=0x1000000000000000
[RUN]	sigreturn to 0x2000000000000000
[OK]	Got SIGSEGV at RIP=0x2000000000000000
[RUN]	sigreturn to 0x4000000000000000
[OK]	Got SIGSEGV at RIP=0x4000000000000000
[RUN]	sigreturn to 0x8000000000000000
[OK]	Got SIGSEGV at RIP=0x8000000000000000
[RUN]	Trying a SYSCALL that falls through to 0x7fffffffe000
selftests: sysret_rip_64 [FAIL]
Running tests in zram
========================================
--------------------
running zram tests
--------------------
create '1' zram device(s)
zram load module successful
set max_comp_streams to zram device(s)
FAIL can't set max_streams '2', get
/sys/block/zram0/max_comp_streams = '1' (1/1)
zram max streams: OK
test that we can set compression algorithm
supported algs: [lzo] lz4 deflate lz4hc 842
/sys/block/zram0/comp_algorithm = 'lzo' (1/1)
zram set compression algorithm: OK
set disk size to zram device(s)
/sys/block/zram0/disksize = '2097152' (1/1)
zram set disksizes: OK
set memory limit to zram device(s)
/sys/block/zram0/mem_limit = '2M' (1/1)
zram set memory limit: OK
make ext4 filesystem on /dev/zram0
zram mkfs.ext4: OK
mount /dev/zram0
zram mount of zram device(s): OK
fill zram0...
zram0 can be filled with '1936' KB
zram used 2M, zram disk sizes 2097152M
./zram01.sh: line 79: bc: command not found
zram compression ratio: :1: OK
zram cleanup
zram rmmod zram
zram01 : [PASS]
create '1' zram device(s)
zram load module successful
set max_comp_streams to zram device(s)
FAIL can't set max_streams '2', get
/sys/block/zram0/max_comp_streams = '1' (1/1)
zram max streams: OK
set disk size to zram device(s)
/sys/block/zram0/disksize = '1048576' (1/1)
zram set disksizes: OK
set memory limit to zram device(s)
/sys/block/zram0/mem_limit = '1M' (1/1)
zram set memory limit: OK
make swap with zram device(s)
done with /dev/zram0
zram making zram mkswap and swapon: OK
zram swapoff: OK
zram cleanup
zram rmmod zram
zram02 : [PASS]
selftests: zram.sh [PASS]

with kind regards
thomas


