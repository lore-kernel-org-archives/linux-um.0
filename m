Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4Ak0-0004hx-NE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Feb 2005 20:36:44 -0800
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D4Ajw-0002WY-U7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Feb 2005 20:36:44 -0800
Received: from NHROCAVG2.ets.enterasys.com ([134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id j1O4aUZC000305
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 23 Feb 2005 23:36:30 -0500 (EST)
Message-ID: <421D59C5.9020003@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig44A6FFA21F29787726BDFD63"
Subject: [uml-devel] UML startup -- segfault with no mm
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 23 Feb 2005 23:36:21 -0500
To: uml devel <user-mode-linux-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig44A6FFA21F29787726BDFD63
Content-Type: multipart/mixed; boundary="------------060308010306000207040806"

This is a multi-part message in MIME format.
--------------060308010306000207040806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hello wonderful umlers,

here's a wonderfully infrequent but nagging startup
failure that usually has a useless (no stack depth,
or just corrupt) backtrace...

Here's all the user sees:

Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Enterasys Node Driver v0.1 (4, 15, 0)
Kernel panic: Segfault with no mm
In idle task - not syncing

and then it dumps core - that, this once, had a
(possibly informative) backtrace (attached).

host is 2.4.20-31 redhat9 + skas - nptl
guest is 2.4.26-3um + core_on_panic and other
local mods that are *not* in this trace.

thank you for any insight.

(please, no suggestions to update :-)


--
db


--------------060308010306000207040806
Content-Type: text/plain;
 name="segfault_with_nomm_bt.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="segfault_with_nomm_bt.txt"

(gdb) bt
#0  0x0815dfc1 in kill ()
#1  0x0817a2d2 in raise ()
#2  0x0815e2ad in abort ()
#3  0x080dac3e in panic_coreonpanic (self=0x81f6c3c, unused1=0, unused2=0x820ed60) at um_arch.c:425
#4  0x0805e46a in notifier_call_chain (n=0x0, val=0, v=0x820ed60) at sys.c:148
#5  0x080533d9 in panic (fmt=0x81ba50f "Segfault with no mm") at panic.c:77
#6  0x080da339 in segv (address=3221194032, ip=0, is_write=0, is_user=0, sc=0xbfff8270) at trap_kern.c:149
#7  0x080da67d in segv_handler (sig=11, regs=0xbfff8270) at trap_user.c:74
#8  0x080dcad1 in sig_handler_common_skas (sig=11, sc_ptr=0x58) at trap_user.c:35
#9  0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221197508, esp = 3221197484, ebx = 3221197552, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221197484, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#10 <signal handler called>
#11 sig_handler_common_skas (sig=11, sc_ptr=0xbfff92f0) at trap_user.c:25
#12 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221198300, esp = 3221198276, ebx = 3221198344, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221198276, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#13 <signal handler called>
#14 sig_handler_common_skas (sig=11, sc_ptr=0xbfff9608) at trap_user.c:25
#15 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221199092, esp = 3221199068, ebx = 3221199136, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221199068, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#16 <signal handler called>
#17 sig_handler_common_skas (sig=11, sc_ptr=0xbfff9920) at trap_user.c:25
#18 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221199884, esp = 3221199860, ebx = 3221199928, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221199860, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#19 <signal handler called>
#20 sig_handler_common_skas (sig=11, sc_ptr=0xbfff9c38) at trap_user.c:25
#21 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221200676, esp = 3221200652, ebx = 3221200720, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221200652, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#22 <signal handler called>
#23 sig_handler_common_skas (sig=11, sc_ptr=0xbfff9f50) at trap_user.c:25
#24 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221201468, esp = 3221201444, ebx = 3221201512, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221201444, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#25 <signal handler called>
#26 sig_handler_common_skas (sig=11, sc_ptr=0xbfffa268) at trap_user.c:25
#27 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221202260, esp = 3221202236, ebx = 3221202304, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221202236, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#28 <signal handler called>
#29 sig_handler_common_skas (sig=11, sc_ptr=0xbfffa580) at trap_user.c:25
#30 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221203052, esp = 3221203028, ebx = 3221203096, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221203028, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#31 <signal handler called>
#32 sig_handler_common_skas (sig=11, sc_ptr=0xbfffa898) at trap_user.c:25
#33 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221203844, esp = 3221203820, ebx = 3221203888, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221203820, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#34 <signal handler called>
#35 sig_handler_common_skas (sig=11, sc_ptr=0xbfffabb0) at trap_user.c:25
#36 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221204636, esp = 3221204612, ebx = 3221204680, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221204612, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#37 <signal handler called>
#38 sig_handler_common_skas (sig=11, sc_ptr=0xbfffaec8) at trap_user.c:25
#39 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221205428, esp = 3221205404, ebx = 3221205472, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221205404, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#40 <signal handler called>
#41 sig_handler_common_skas (sig=11, sc_ptr=0xbfffb1e0) at trap_user.c:25
#42 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221206220, esp = 3221206196, ebx = 3221206264, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221206196, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#43 <signal handler called>
#44 sig_handler_common_skas (sig=11, sc_ptr=0xbfffb4f8) at trap_user.c:25
#45 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221207012, esp = 3221206988, ebx = 3221207056, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221206988, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#46 <signal handler called>
#47 sig_handler_common_skas (sig=11, sc_ptr=0xbfffb810) at trap_user.c:25
#48 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136676108, esi = 3221193328, ebp = 3221207804, esp = 3221207780, ebx = 3221207848, edx = 1, ecx = 2147767344, eax = 3221192704, trapno = 14, err = 4, eip = 135121527, cs = 35, __csh = 0, eflags = 66182, esp_at_signal = 3221207780, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 = 3221194032}) at trap_user.c:109
#49 <signal handler called>
#50 sig_handler_common_skas (sig=11, sc_ptr=0xbfffbb28) at trap_user.c:25
#51 0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 0, esi = 3221192704, ebp = 3221208596, esp = 3221208572, ebx = 0, edx = 1, ecx = 2147767344, eax = 0, trapno = 14, err = 6, eip = 134594293, cs = 35, __csh = 0, eflags = 66198, esp_at_signal = 3221208572, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436207616, cr2 = 3221192972}) at trap_user.c:109
#52 <signal handler called>
#53 update_one_process (p=0xbfff8000, user=0, system=136277052, cpu=0) at timer.c:585
#54 0x0805bff0 in update_process_times (user_tick=0) at timer.c:600
#55 0x0805c1b2 in do_timer (regs=0x0) at timer.c:705
#56 0x080d9ce4 in boot_timer_handler (sig=26) at time_kern.c:92
#57 <signal handler called>
#58 0x0816d224 in ioctl ()
#59 0x0825830c in buf.2 ()
#60 0x0816e383 in pts_name ()
#61 0x0816dff9 in grantpt ()
#62 0x0815ce92 in openpty ()
#63 0x080d7631 in openpty_cb (arg=0x81efa64) at sigio_user.c:47
#64 0x080dbde1 in start_idle_thread (stack=0x81e8000, switch_buf_ptr=0x81e8578, fork_buf_ptr=0x0) at process.c:292
#65 0x080dc48a in start_uml_skas () at process_kern.c:193
#66 0x080daae3 in linux_main (argc=19, argv=0x30000000) at um_arch.c:393
#67 0x08050286 in main (argc=19, argv=0xbfffe994, envp=0xbfffe9e4) at arch/um/main.c:149
#68 0x0815d97b in __libc_start_main ()

--------------060308010306000207040806--

--------------enig44A6FFA21F29787726BDFD63
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCHVnL3XQ4zakZ3z4RAkZ7AJ4s5Y6u3fdtX95mCqnMiVakWv0eWACeLdcG
GbUtoj+WKJ3sUxcdywUJXl8=
=0k1P
-----END PGP SIGNATURE-----

--------------enig44A6FFA21F29787726BDFD63--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
