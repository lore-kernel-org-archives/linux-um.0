Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtcBC-0000sI-NL
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 16:36:38 -0800
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Atbym-0001X7-Gr
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 16:23:48 -0800
Message-ID: <021601c3f680$7d13eb10$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <1bf401c3f3eb$c35704f0$2000000a@schlepptopp> <200402152045.17138.blaisorblade_spam@yahoo.it> <20d501c3f5c1$ef1d3d70$2000000a@schlepptopp> <200402182001.44243.blaisorblade_spam@yahoo.it>
Subject: Re: 2.6.3-rc2 failure - was: Re: [uml-devel] Kernel idles in loop after loading IPv4
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 19 Feb 2004 01:36:59 +0100
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

hi !
>If I guessed right, the attached patch will solve everything.
yep - maybe - but it doesn`t seem to fix the "hang after NET: Registered pr=
otocol family 2" !
i applied the patch and recompiled - same effect.

regards
roland



----- Original Message -----=20
From: "BlaisorBlade" <blaisorblade_spam@yahoo.it>
To: <user-mode-linux-devel@lists.sourceforge.net>
Cc: "Jeff Dike" <jdike@addtoit.com>; "roland" <for_spam@gmx.de>
Sent: Wednesday, February 18, 2004 8:01 PM
Subject: Re: 2.6.3-rc2 failure - was: Re: [uml-devel] Kernel idles in loop =
after loading IPv4


Alle 02:52, mercoled=EC 18 febbraio 2004, roland ha scritto:
> hi !

For Jeff: see at the end why I cc: to you.

>
> the bug ("hang after NET: Registered protocol family 2":) doesn`t seem to
> have a relation to SKAS, because it also happens in TT mode.
> when i run the binary with "./linux mode=3Dtt" the hang occurs, too.
> furthermore - it doesn`t seem to be a compiler issue, because i compiled
> 2.6.3-rc2 on 2 completely different systems (suse9 and rh7.2).
> i also read about guesses, that this could have to do with "newer" hosts
> running NPTL. could someone explain? i thought uml is a static binary

Yes but when it's compiled it's linked against host's libs (mainly glibc and
libpthreads). However, IIRC, the problems with NPTL on the host have been
fixed time ago, and with NPTL in the guest have currently a temporary fix.

>, so
> how can this have a relation to a thread >LIBRARY<?? somewhere i read abo=
ut
> "kernel threads". is ntpl related to the kernel itself? (sorry if this
> sounds stupid - but i remember switching between different thread-librari=
es
> on solaris via envvars. is this just the same with ntpl?)

> after adding a lot if printk`s to the uml-patched 2.6.3-rc2 source, i fou=
nd
> the following(maybe interesting):
>
> in ./kernel/sched.c
> in function wait_for_completion(struct completion *x)
> the call to "schedule()" never returns and this seems to be the reason for
> the hanging ipv4 initialisation. i have no clue about kernel internals and
> i think it`s nonsense, if i dig further into this....
>
> but as i already said:
> 2.6.0-test9 with uml-patch-2.6.0-test9-1  _WORKS_ (at least for me)
> 2.6.0 with uml-patch-2.6.0-1 and following kernel/uml-patch versions seem
> to have the ipv4 hang-at-init bug.
>
> so maybe the bug has been introduced with uml-patch-2.6.0-1 !?

The message about "diagnosed and repeatable kernel panic" is IMHO related to
this: the sigsetjmp change was actually in 2.6.0. And this broke schedule: =
on
my system it happens to broke in one point, on your in another point.

If I guessed right, the attached patch will solve everything.

Jeff, do you think this makes sense?
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=3D1356&alloc_id=3D3438&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
