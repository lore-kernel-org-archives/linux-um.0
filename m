Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8JRS-0007JE-Sq for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 07:10:26 -0700
Received: from ctron-dnm.enterasys.com ([12.25.1.120] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C8JRS-0006gi-5m for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 07:10:26 -0700
Received: (from uucp@localhost)
	by ctron-dnm.enterasys.com (8.8.7/8.8.7) id KAA07674
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 17 Sep 2004 10:14:42 -0400 (EDT)
Message-ID: <414AF00B.1090607@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2EB7E4352945FCE47593B50D"
Subject: [uml-devel] REBOOT fails 2.4.26-3um
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
Date: Fri, 17 Sep 2004 10:09:15 -0400
To: uml devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: "Tsillas, Demetrios J" <jtsillas@enterasys.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2EB7E4352945FCE47593B50D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

any one else seeing trouble with uml_mconsole <umid> reboot ?

1) currently when machine_restart is called it dies in the 
do_uml_exitcalls on
a call to open on the umid dir (but setting kmalloc_ok = 0 allows us to get
past this and on to the next - via reboot_skas)

2) This occurs right after the reboot when signals are unmasked temporarily.

 

#0  panic (fmt=0x81b3652 "Segfault with no mm") at panic.c:60

#1  0x080da339 in segv (address=3221194032, ip=0, is_write=0, is_user=0, 
sc=0xbfff8270) at trap_kern.c:149

#2  0x080da67d in segv_handler (sig=11, regs=0xbfff8270) at trap_user.c:74

#3  0x080dcab5 in sig_handler_common_skas (sig=11, sc_ptr=0x58) at 
trap_user.c:35

#4  0x080da69e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, 
__fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 136625644, esi 
= 3221193328, ebp = 3221213548, esp = 3221213524, ebx = 3221213592, edx 
= 0, ecx = 3221214352, eax = 3221192704, trapno = 14, err = 4, eip = 
135121499, cs = 35, __csh = 0, eflags = 66438, esp_at_signal = 
3221213524, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436216320, cr2 
= 3221194032}) at trap_user.c:109

#5  <signal handler called>

#6  sig_handler_common_skas (sig=29, sc_ptr=0xbfffd198) at trap_user.c:25

#7  0x080da69e in sig_handler (sig=29, sc={gs = 0, __gsh = 0, fs = 0, 
__fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 1, esi = 8, ebp 
= 3221214328, esp = 3221214316, ebx = 1, edx = 0, ecx = 3221214352, eax 
= 0, trapno = 1, err = 0, eip = 135624481, cs = 35, __csh = 0, eflags = 
642, esp_at_signal = 3221214316, ss = 43, __ssh = 0, fpstate = 0x0, 
oldmask = 134217728, cr2 = 679845888}) at trap_user.c:109

#8  <signal handler called>

#9  0x08157721 in sigprocmask ()

#10 0x080d8948 in change_signals (type=1) at signal_user.c:69

#11 0x080d898d in unblock_signals () at signal_user.c:80

#12 0x080502b3 in main (argc=14, argv=0xbfffd824, envp=0xbfffd860) at 
arch/um/main.c:161

#13 0x0815711b in __libc_start_main ()

-- 
db


--------------enig2EB7E4352945FCE47593B50D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBSvAL3XQ4zakZ3z4RAgKmAJ4gjiYejpwChOpqa1jIM95cq37YgQCbB0xW
nssBFipWAZpVQZ4M+FDnwQY=
=5n8s
-----END PGP SIGNATURE-----

--------------enig2EB7E4352945FCE47593B50D--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
