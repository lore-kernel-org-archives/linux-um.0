Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8]
	helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BrpLL-0001iZ-SC for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Aug 2004 19:47:59 -0700
Message-ID: <410EFCDB.8080404@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
In-Reply-To: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD89771905BF2F67F54F36FE4"
Subject: [uml-devel] Re: UML and valgrind
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
Date: Mon, 02 Aug 2004 22:47:55 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: valgrind-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD89771905BF2F67F54F36FE4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

cc'ing valgrind users to solicit support!

as of valgrind 2.1.2 is happy as can be within a User Mode
Linux hosted session. This was tested with 2.4.24-1um and
2.4.26-2um + incrementals on a RedHat 9 (non-nptl, skas)
host - and using RH9 UML filesystems.

still trouble with launching a UML itself under valgrind
(even with MODE_SKAS, ! MODE_TT, and KERNEL_STACK_ORDER=3)

for starters we have:

[u2](dbahi)443$ ~/valgrind-2.1.2/bin/valgrind --tool=memcheck 
/local/dbahi/kernels/linux-2.4.26_uml-patch-2.4.26-2um/linux umid=kickme 
ubd0=/local/cow/kickmoo,/local/dbahi/root_fs.rh-9-full 
ubd1=/local/cow/kickmoo2,/local/dbahi/swap_fs.256 
hostfs=/local/hostfs/kickdir/

Executable is mapped outside of range (nil)-0x52c00000
valgrind: 
do_exec(/local/dbahi/kernels/linux-2.4.26_uml-patch-2.4.26-2um/linux) 
failed: Cannot allocate memory

How does one get around this sudden valgrind exit?

Bahi, David wrote:

> back some time ago it seems like someone had more than a clue as to what
> was requried to get valgrind working under UML... well as of 2.1.1 it
> still ain't working.
> 
> http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=107066894230633&
> w=2
> 
> I was wondering if a patch was available for our 'community' to make use
> of this tool... for both running the UML as an application and for
> running
> applications within the UML.
> 
> It seems that for running valgrind within the UML there is a signal
> handling
> problem where 'restorer' is NULL and causes a panic in
> setup_signal_stack_si
> 
> signal_kernel.c
>   handle_signal()
> 
> 	if (ka->sa.sa_flags & SA_RESTORER) restorer =
> ka->sa.sa_restorer;
> 	else restorer = NULL;
> 
> 	if(ka->sa.sa_flags & SA_SIGINFO)
> 		err = setup_signal_stack_si(sp, signr, (unsigned long)
> handler,
> 					    restorer, regs, info,
> &save);
> 
> thanks for any insight.
> 
> db
> 
> "The kernel is the only UNIX code that cannot be substituted by a user
> to his own liking. For this reason, the kernel should make as few real
> decisions as possible." -- K. Thompson

-- 
There are two kinds of people in this world: Those that enter a room and 
turn the television set on, and those that enter a room and turn the 
television set off. -- Raymond Shaw, The Manchurian Candidate (1962).

--------------enigD89771905BF2F67F54F36FE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBDvzb3XQ4zakZ3z4RAq7DAJ46qhI/Kmj1WTNhIWvDtP+keuslgwCfbNP6
Q6FrudbHy8vNF3pLEQp3zUc=
=iAym
-----END PGP SIGNATURE-----

--------------enigD89771905BF2F67F54F36FE4--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
