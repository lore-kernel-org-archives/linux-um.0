Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8]
	helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BsBp4-0007DN-8S for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Aug 2004 19:48:10 -0700
Message-ID: <41104E5C.1010803@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [Valgrind-users] Re: [uml-devel] Re: UML and valgrind
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com>
	<200408030517.i735HZUE026250@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031028541.22157@hermes-1.csi.cam.ac.uk>
	<200408031450.i73EoEvv002040@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031527320.22157@hermes-1.csi.cam.ac.uk>
	<200408031750.i73HoMvv002966@ccure.user-mode-linux.org>
	<410FCC70.1050902@enterasys.com> <4110373D.5010706@vgertech.com>
In-Reply-To: <4110373D.5010706@vgertech.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCB0E9FCED185DF62595F3AD6"
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
Date: Tue, 03 Aug 2004 22:47:56 -0400
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Jeff Dike <jdike@addtoit.com>, Nicholas Nethercote <njn25@cam.ac.uk>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB0E9FCED185DF62595F3AD6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

thanks for the idea, but, nope. i'm sorry to report same results.

to clarify, the toolchain supports NTPL but the kernel is not built
with this feature as the UML 2.4 series didn't have an skas patch
that supported this...

oh well. here's the log so you can see the invocation/results:

[u2](dbahi)307$ ~/valgrind-2.1.2/bin/valgrind -v --tool=memcheck 
/local/dbahi/kernels/linux-2.4.26_uml-patch-2.4.26-2um/linux umid=kickme 
ubd0=/local/cow/kickmoo,/local/dbahi/root_fs.rh-9-full 
ubd1=/local/cow/kickmoo2,/local/dbahi/swap_fs.256  hostfs=/local/hostfs&
[2] 18281
[u2](dbahi)308$ ==18281== Memcheck, a memory error detector for x86-linux.
==18281== Copyright (C) 2002-2004, and GNU GPL'd, by Julian Seward et al.
==18281== Using valgrind-2.1.2, a program supervision framework for 
x86-linux.
==18281== Copyright (C) 2000-2004, and GNU GPL'd, by Julian Seward et al.
==18281== Valgrind library directory: 
/home/rtrsvcs/dbahi/valgrind-2.1.2/lib/valgrind
==18281== Command line
==18281==    /local/dbahi/kernels/linux-2.4.26_uml-patch-2.4.26-2um/linux
==18281==    umid=kickme
==18281== 
ubd0=/local/target0/s1/cow/kickmoo,/local/dbahi/root_fs.rh-9-full
==18281==    ubd1=/local/target0/s1/cow/kickmoo2,/local/dbahi/swap_fs.256
==18281==    hostfs=/local/target0/s1/hostfs/chassis[box].cm[cm1]/
==18281== Startup, with flags:
==18281==    -v
==18281==    --tool=memcheck
==18281== Contents of /proc/version:
==18281==   Linux version 2.4.20-28.9.ets.1.autofs41.skas3 
(dbahi@etrs-pc02) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) 
#1 Thu Feb 12 21:32:45 EST 2004
==18281== Reading syms from 
/local/dbahi/kernels/linux-2.4.26_uml-patch-2.4.26-2um/linux (0x8048000)
==18281== Reading syms from /lib/ld-2.3.2.so (0x1B8E4000)
==18281==    object doesn't have any debug info
==18281== Reading syms from 
/home/rtrsvcs/dbahi/valgrind-2.1.2/lib/valgrind/stage2 (0xB0000000)
==18281== Reading syms from /lib/ld-2.3.2.so (0xB1000000)
==18281==    object doesn't have any debug info
==18281== Reading syms from /lib/libdl-2.3.2.so (0xB1031000)
==18281==    object doesn't have any debug info
==18281== Reading syms from /lib/i686/libc-2.3.2.so (0xB1036000)
==18281==    object doesn't have any debug info
==18281== Reading syms from 
/home/rtrsvcs/dbahi/valgrind-2.1.2/lib/valgrind/vgskin_memcheck.so 
(0xB126F000)
==18281== Reading suppressions file: 
/home/rtrsvcs/dbahi/valgrind-2.1.2/lib/valgrind/default.supp
==18281== REDIRECT soname:libc.so.6(__GI___errno_location) to 
soname:libpthread.so.0(__errno_location)
==18281== REDIRECT soname:libc.so.6(__errno_location) to 
soname:libpthread.so.0(__errno_location)
==18281== REDIRECT soname:libc.so.6(__GI___h_errno_location) to 
soname:libpthread.so.0(__h_errno_location)
==18281== REDIRECT soname:libc.so.6(__h_errno_location) to 
soname:libpthread.so.0(__h_errno_location)
==18281== REDIRECT soname:libc.so.6(__GI___res_state) to 
soname:libpthread.so.0(__res_state)
==18281== REDIRECT soname:libc.so.6(__res_state) to 
soname:libpthread.so.0(__res_state)
==18281== REDIRECT soname:libc.so.6(stpcpy) to 
*vgpreload_memcheck.so*(stpcpy)
==18281== REDIRECT soname:libc.so.6(strnlen) to 
*vgpreload_memcheck.so*(strnlen)
==18281== REDIRECT soname:ld-linux.so.2(stpcpy) to 
*vgpreload_memcheck.so*(stpcpy)
==18281== REDIRECT soname:ld-linux.so.2(strchr) to 
*vgpreload_memcheck.so*(strchr)
==18281==
==18281== Reading syms from 
/home/rtrsvcs/dbahi/valgrind-2.1.2/lib/valgrind/vg_inject.so (0x1B8FB000)
==18281== Reading syms from 
/home/rtrsvcs/dbahi/valgrind-2.1.2/lib/valgrind/vgpreload_memcheck.so 
(0x1B900000)
==18281== TRANSLATE: 0x1B8F5BB0 redirected to 0x1B903498
==18281== Reading syms from /lib/libutil-2.3.2.so (0x1B907000)
==18281==    object doesn't have any debug info
==18281== Reading syms from /lib/libc-2.3.2.so (0x1B90B000)
==18281==    object doesn't have any debug info
==18281== TRANSLATE: 0x1B97E1C0 redirected to 0x1B903C90
==18281==
==18281== Valgrind detected that your program requires
==18281== the following unimplemented functionality:
==18281==    clone(): not supported by Valgrind.
    We do now support programs linked against
    libpthread.so, though.  Re-run with -v and ensure that
    you are picking up Valgrind's implementation of libpthread.so.
==18281== This may be because the functionality is hard to implement,
==18281== or because no reasonable program would behave this way,
==18281== or because nobody has yet needed it.  In any case, let us know at
==18281== valgrind.kde.org and/or try to work around the problem, if you 
can.
==18281==
==18281== Valgrind has to exit now.  Sorry.  Bye!
==18281==

sched status:

Thread 1: status = Runnable, associated_mx = 0x0, associated_cv = 0x0
==18281==    at 0x1B9EE4C9: clone (in /lib/libc-2.3.2.so)
==18281==    by 0x80DA3A4: can_do_skas (process.c:239)
==18281==    by 0x80DE595: linux_main (um_arch.c:332)
==18281==    by 0x80532AF: main (main.c:148)


Nuno Silva wrote:
> Hi!
> 
> D. Bahi wrote:
> | fantastic! patch applied. results below.
> |
> | note that valgrind almost _requires_ dynamic
> | linking - so I'll keep mem= below 750M, right?
> |
> | ugh, so close - it bails - stopped by clone() !?!!?? :
> 
> [..]
> 
> |
> | ==2951== Reading syms from /lib/tls/libc-2.3.2.so (0x42000000)
> | ==2951==    object doesn't have any debug info
> | ==2951== TRANSLATE: 0x1B8E4C00 redirected to 0x52BFF040
> | ==2951== TRANSLATE: 0x42073700 redirected to 0x1B903C90
> | ==2951==
> | ==2951== Valgrind detected that your program requires
> | ==2951== the following unimplemented functionality:
> | ==2951==    clone(): not supported by Valgrind.
> 
> [..]
> 
> You have a NPTL/TLS system. Maybe that's the problem. You could try to:
> 
> # mv /lib/tls /lib/tls.off
> 
> ...and rerun that. Maybe it works better. :-)
> Remember to move tls.off again to revert to tls-enabled glibc ;)
> 
> HTH,
> Nuno Silva

-- 
There are two kinds of people in this world: Those that enter a room and
turn the television set on, and those that enter a room and turn the
television set off. -- Raymond Shaw, The Manchurian Candidate (1962).

--------------enigCB0E9FCED185DF62595F3AD6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBEE5h3XQ4zakZ3z4RAuuLAJ9QsniPcoidmStnT5wn1YJlsWIyAQCfU+VP
G9eb6ezeNnOawx5srbXpAVs=
=NnH2
-----END PGP SIGNATURE-----

--------------enigCB0E9FCED185DF62595F3AD6--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
