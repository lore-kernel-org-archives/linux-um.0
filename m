Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DaFQO-0000Yd-7l	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2005 09:05:04 -0700
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DaFQJ-0000mE-Li	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2005 09:05:04 -0700
Received: from NHROCAVG2.ets.enterasys.com ([134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id j4NG4pZC008009
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 23 May 2005 12:04:51 -0400 (EDT)
Message-ID: <4291FF1D.70505@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBE51F13953E2948FD50D3870"
Subject: [uml-devel] panic on shutdown bt for 2.4.26+ UML
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
Date: Mon, 23 May 2005 12:04:45 -0400
To: uml devel <user-mode-linux-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBE51F13953E2948FD50D3870
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

any hints for where to look for a fix for this odd crash on shutdown?

i must admit, lately, i've been rather frustrated with the lack of
either maintainance or backporting in the 2.4 UML series.  of course
this frustration is mostly because of my lack of ability to move forward
past issues such as these. but also the UML web-site + blaise's + other
patches out there along with all kinds of instructions on combinations
on what to use....

the mechanisims UML uses, jmps ptrace and the like, are not terribly
familar to generic programmers. Is there a UML: How it Works for
Developers - document somewhere? or must we be so dedicated that we
browse the mailing list archives and look for explainations piecemeal as
responses to queries (as we've seen recently on the list)?

appoligies for any toes i'm stepping on here - i want to help - i just
need help to get there...

(gdb) bt
#0  0x08161351 in kill ()
#1  0x0817d662 in raise ()
#2  0x0816163d in abort ()
#3  0x080dac3e in panic_coreonpanic (self=0x81fec3c, unused1=0,
unused2=0x8216d60) at um_arch.c:425
#4  0x0805e46a in notifier_call_chain (n=0x0, val=0, v=0x8216d60) at
sys.c:148
#5  0x080533d9 in panic (fmt=0x81d1780 "switch_mm_skas -
PTRACE_SWITCH_MM failed, errno = %d\n") at panic.c:77
#6  0x080dbf5a in switch_mm_skas (mm_fd=107) at process.c:353
#7  0x08050b17 in schedule () at mmu_context.h:29
#8  0x080d6d6e in cpu_idle () at process_kern.c:206
#9  0x0805047a in rest_init () at init/main.c:353
#10 0x080494e6 in start_kernel () at init/main.c:447
#11 0x080dc437 in start_kernel_proc (unused=0x0) at process_kern.c:179
#12 0x080d6979 in run_kernel_thread (fn=0x80dc410 <start_kernel_proc>,
arg=0x0, jmp_ptr=0x81fec3c) at process.c:231
#13 0x080dc162 in new_thread_handler (sig=10) at process_kern.c:72
#14 <signal handler called>
#15 0x08161351 in kill ()
#16 0x08160fe5 in siglongjmp ()
#17 0x080dbdc1 in start_idle_thread (stack=0x81f0000,
switch_buf_ptr=0x81f0578, fork_buf_ptr=0x0) at process.c:303
#18 0x080dc48a in start_uml_skas () at process_kern.c:193
#19 0x080daae3 in linux_main (argc=19, argv=0x30000000) at um_arch.c:393
#20 0x08050286 in main (argc=19, argv=0xbfffd0b4, envp=0xbfffd104) at
arch/um/main.c:149
#21 0x08160d13 in __libc_start_main ()

--
db


--------------enigBE51F13953E2948FD50D3870
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCkf8d3XQ4zakZ3z4RAiXSAJ0WRecSqFTlI6ybZIOt4ll7/8U8MACfREGz
8NC1eR7LcYsOa6no+lko4uA=
=n3Yl
-----END PGP SIGNATURE-----

--------------enigBE51F13953E2948FD50D3870--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
