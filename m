Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <410FCC70.1050902@enterasys.com>
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
In-Reply-To: <200408031750.i73HoMvv002966@ccure.user-mode-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC3F6B94943C88C358EF22F33"
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
Date: Tue, 03 Aug 2004 13:33:36 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: Nicholas Nethercote <njn25@cam.ac.uk>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC3F6B94943C88C358EF22F33
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

fantastic! patch applied. results below.

note that valgrind almost _requires_ dynamic
linking - so I'll keep mem= below 750M, right?

ugh, so close - it bails - stopped by clone() !?!!?? :

[u2](dbahi)276$  ~/valgrind-2.1.2/bin/valgrind -v --tool=memcheck 
./linux umid=kickme 
ubd0=/local/cow/kickmoo,/local/dbahi/root_fs.rh-9-full 
ubd1=/local/cow/kickmoo2,/local/dbahi/swap_fs.256 hostfs=/local/hostfs
==2951== Memcheck, a memory error detector for x86-linux.
==2951== Copyright (C) 2002-2004, and GNU GPL'd, by Julian Seward et al.
==2951== Using valgrind-2.1.2, a program supervision framework for 
x86-linux.
==2951== Copyright (C) 2000-2004, and GNU GPL'd, by Julian Seward et al.
==2951== Valgrind library directory: 
/home/rtrsvcs/dbahi/valgrind-2.1.2/lib/valgrind
==2951== Command line
==2951==    ./linux
==2951==    umid=kickme
==2951==    ubd0=/local/cow/kickmoo,/local/dbahi/root_fs.rh-9-full
==2951==    ubd1=/local/cow/kickmoo2,/local/dbahi/swap_fs.256
==2951==    hostfs=/local/hostfs
==2951== Startup, with flags:
==2951==    -v
==2951==    --tool=memcheck
==2951== Contents of /proc/version:
==2951==   Linux version 2.4.20-28.9.ets.1.autofs41.skas3 
(dbahi@etrs-pc02) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) 
#1 Thu Feb 12 21:32:45 EST 2004
==2951== Reading syms from 
/local/dbahi/kernels/linux-2.4.26_uml-patch-2.4.26-2um/linux (0x8048000)
==2951== Reading syms from /lib/ld-2.3.2.so (0x1B8E4000)
==2951==    object doesn't have any debug info
==2951== Reading syms from 
/home/rtrsvcs/dbahi/valgrind-2.1.2/lib/valgrind/stage2 (0xB0000000)
==2951== Reading syms from /lib/ld-2.3.2.so (0xB1000000)
==2951==    object doesn't have any debug info
==2951== Reading syms from /lib/libdl-2.3.2.so (0xB1031000)
==2951==    object doesn't have any debug info
==2951== Reading syms from /lib/i686/libc-2.3.2.so (0xB1036000)
==2951==    object doesn't have any debug info
==2951== Reading syms from 
/home/rtrsvcs/dbahi/valgrind-2.1.2/lib/valgrind/vgskin_memcheck.so 
(0xB126F000)
==2951== Reading suppressions file: 
/home/rtrsvcs/dbahi/valgrind-2.1.2/lib/valgrind/default.supp
==2951== REDIRECT soname:libc.so.6(__GI___errno_location) to 
soname:libpthread.so.0(__errno_location)
==2951== REDIRECT soname:libc.so.6(__errno_location) to 
soname:libpthread.so.0(__errno_location)
==2951== REDIRECT soname:libc.so.6(__GI___h_errno_location) to 
soname:libpthread.so.0(__h_errno_location)
==2951== REDIRECT soname:libc.so.6(__h_errno_location) to 
soname:libpthread.so.0(__h_errno_location)
==2951== REDIRECT soname:libc.so.6(__GI___res_state) to 
soname:libpthread.so.0(__res_state)
==2951== REDIRECT soname:libc.so.6(__res_state) to 
soname:libpthread.so.0(__res_state)
==2951== REDIRECT soname:libc.so.6(stpcpy) to 
*vgpreload_memcheck.so*(stpcpy)
==2951== REDIRECT soname:libc.so.6(strnlen) to 
*vgpreload_memcheck.so*(strnlen)
==2951== REDIRECT soname:ld-linux.so.2(stpcpy) to 
*vgpreload_memcheck.so*(stpcpy)
==2951== REDIRECT soname:ld-linux.so.2(strchr) to 
*vgpreload_memcheck.so*(strchr)
==2951==
==2951== Reading syms from 
/home/rtrsvcs/dbahi/valgrind-2.1.2/lib/valgrind/vg_inject.so (0x1B8FB000)
==2951== Reading syms from 
/home/rtrsvcs/dbahi/valgrind-2.1.2/lib/valgrind/vgpreload_memcheck.so 
(0x1B900000)
==2951== TRANSLATE: 0x1B8F5BB0 redirected to 0x1B903498
==2951== Reading syms from /lib/libutil-2.3.2.so (0x1B907000)
==2951==    object doesn't have any debug info
==2951== Reading syms from /lib/tls/libc-2.3.2.so (0x42000000)
==2951==    object doesn't have any debug info
==2951== TRANSLATE: 0x1B8E4C00 redirected to 0x52BFF040
==2951== TRANSLATE: 0x42073700 redirected to 0x1B903C90
==2951==
==2951== Valgrind detected that your program requires
==2951== the following unimplemented functionality:
==2951==    clone(): not supported by Valgrind.
    We do now support programs linked against
    libpthread.so, though.  Re-run with -v and ensure that
    you are picking up Valgrind's implementation of libpthread.so.
==2951== This may be because the functionality is hard to implement,
==2951== or because no reasonable program would behave this way,
==2951== or because nobody has yet needed it.  In any case, let us know at
==2951== valgrind.kde.org and/or try to work around the problem, if you can.
==2951==
==2951== Valgrind has to exit now.  Sorry.  Bye!
==2951==

sched status:

Thread 1: status = Runnable, associated_mx = 0x0, associated_cv = 0x0
==2951==    at 0x420DF139: clone (in /lib/tls/libc-2.3.2.so)
==2951==    by 0x80DA3A4: can_do_skas (process.c:239)
==2951==    by 0x80DE595: linux_main (um_arch.c:332)
==2951==    by 0x80532AF: main (main.c:148)



Jeff Dike wrote:

> njn25@cam.ac.uk said:
> 
>>What address was UML trying to load something at?  Is that adjustable?
> 
> 
> It is now.  Get the load-low patch from 
> 	http://user-mode-linux.sourceforge.net/patches.html
> 
> It will make UML load where every normal process loads when CONFIG_MODE_SKAS
> is on and CONFIG_MODE_TT is off.  This should get you past valgrind's address
> space assumptions.
> 
> As a side-benefit, this will allow UML to have much greater physical memory
> without needing to go to highmem.  If you take advantage of this, either enable 
> CONFIG_STATIC_LINK or keep the physical memory size below about 750M.  The
> reason is you don't want to push UML physical memory into the 0x40000000 area
> occupied by shared libraries.  With CONFIG_STATIC_LINK, this problem goes away
> and you can have physical memory up to about 2.75G.
> 
> Let me know if there are any problems.  It's not well tested - I ran it enough
> to see it panic because it had no root filesystem.  My current work box doesn't
> have skas on it yet, so I can't boot this one up totally.
> 
> 				Jeff
> 

-- 
There are two kinds of people in this world: Those that enter a room and 
turn the television set on, and those that enter a room and turn the 
television set off. -- Raymond Shaw, The Manchurian Candidate (1962).

--------------enigC3F6B94943C88C358EF22F33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBD8x13XQ4zakZ3z4RAkr/AJ9yFlme6kd1QXpe2p5Cs/D41mTZmgCff/ys
uZK4cMh68UkuRn6kmdNDqFs=
=fEm7
-----END PGP SIGNATURE-----

--------------enigC3F6B94943C88C358EF22F33--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
