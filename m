Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxCpL-0004TU-Bs for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Aug 2004 15:53:11 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BxCpH-000403-VJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Aug 2004 15:53:11 -0700
Received: from ctron-dnm.enterasys.com ([12.25.1.120] ident=firewall-user)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1Bx6A6-0001L3-Ho for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Aug 2004 08:46:12 -0700
Received: (from uucp@localhost)
	by ctron-dnm.enterasys.com (8.8.7/8.8.7) id LAA16359
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 Aug 2004 11:48:40 -0400 (EDT)
Message-ID: <412227A4.6060005@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig82CEDD06FD78D4849E822D56"
Subject: [uml-devel] Expected SIGSTOP persists in 2.4.26-3um
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
Date: Tue, 17 Aug 2004 11:43:32 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig82CEDD06FD78D4849E822D56
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

launching UMLs with nice seems to aggravate this problem --
but it also has been seen w/o adding that irritant.

status is 0x1c7f - which maps to 0x1c (SIGWINCH	28 right?)

here it is trying to panic and generates a segfault

#4  0x08051270 in main (argc=11, argv=0xbfffd3e4, envp=0xbfffd414) at 
arch/um/main.c:148
#3  0x080dd2f4 in linux_main (argc=11, argv=0xbfffd3e4) at um_arch.c:332
#2  0x080d9154 in can_do_skas () at process.c:255
#1  0x080d9058 in stop_ptraced_child (pid=21301, stack=0x40001000, 
exitcode=1) at process.c:182
#0  0x0805628c in panic (fmt=0x81c8080 "check_ptrace : child exited with 
status 0x%x") at panic.c:67

values for locals and parameters in stop_ptraced_child are:

(gdb) print errno
$1 = 0
(gdb) print n
$2 = -1073774592
(gdb) print pid
$3 = 21301
(gdb) print status
$4 = 7295
(gdb) print exitcode
$5 = 1
(gdb) set radix 16
(gdb) print status
$6 = 0x1c7f
(gdb) print n
$7 = 0xbfff8000

also have seen:

2.4.24-1um + reboot-signals

   Checking for the skas3 patch in the host...found
   Checking for /proc/mm...found
   CONFIG_HIGHMEM not enabled - physical memory shrunk to 499122176 bytes
   Kernel virtual memory size shrunk to 32505856 bytes
   capture_stack : Expected SIGSTOP, got status = 0x1c7f


2.4.26-3um

   Checking for the skas3 patch in the host...found
   Checking for /proc/mm...found
   capture_stack : Expected SIGSTOP, got status = 0x1c7f



--------------enig82CEDD06FD78D4849E822D56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBIiek3XQ4zakZ3z4RAlByAJ9SX1X0GD1rzl1h1MFj5PvCUTDkHwCeLao2
60fejW74C4V/EmLdSvUzAY8=
=B5za
-----END PGP SIGNATURE-----

--------------enig82CEDD06FD78D4849E822D56--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
