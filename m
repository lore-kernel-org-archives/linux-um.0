Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtWzQ-00030w-Bs
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 11:04:08 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AtWnK-0006CV-Tz
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 10:51:39 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: 2.6.3-rc2 failure - was: Re: [uml-devel] Kernel idles in loop after loading IPv4
References: <1bf401c3f3eb$c35704f0$2000000a@schlepptopp> <200402152045.17138.blaisorblade_spam@yahoo.it> <20d501c3f5c1$ef1d3d70$2000000a@schlepptopp>
In-Reply-To: <20d501c3f5c1$ef1d3d70$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ya7MAmWa1yGJ6aU"
Message-Id: <200402182001.44243.blaisorblade_spam@yahoo.it>
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
Date: Wed, 18 Feb 2004 20:01:44 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, roland <for_spam@gmx.de>



--Boundary-00=_Ya7MAmWa1yGJ6aU
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 02:52, mercoled=EC 18 febbraio 2004, roland ha scritto:
> hi !

=46or Jeff: see at the end why I cc: to you.

>
> the bug ("hang after NET: Registered protocol family 2":) doesn`t seem to
> have a relation to SKAS, because it also happens in TT mode.
> when i run the binary with "./linux mode=3Dtt" the hang occurs, too.
> furthermore - it doesn`t seem to be a compiler issue, because i compiled
> 2.6.3-rc2 on 2 completely different systems (suse9 and rh7.2).
> i also read about guesses, that this could have to do with "newer" hosts
> running NPTL. could someone explain? i thought uml is a static binary

Yes but when it's compiled it's linked against host's libs (mainly glibc an=
d=20
libpthreads). However, IIRC, the problems with NPTL on the host have been=20
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

The message about "diagnosed and repeatable kernel panic" is IMHO related t=
o=20
this: the sigsetjmp change was actually in 2.6.0. And this broke schedule: =
on=20
my system it happens to broke in one point, on your in another point.

If I guessed right, the attached patch will solve everything.

Jeff, do you think this makes sense?
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_Ya7MAmWa1yGJ6aU
Content-Type: text/x-diff;
  charset="windows-1252";
  name="Panic_schedule_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Panic_schedule_fix.patch"

--- 1.9/arch/um/kernel/skas/process_kern.c	Thu Jan  8 07:43:01 2004
+++ edited/arch/um/kernel/skas/process_kern.c	Sun Feb 15 10:42:31 2004
@@ -76,6 +76,7 @@
 
 void new_thread_proc(void *stack, void (*handler)(int sig))
 {
+       local_irq_disable();
 	init_new_thread_stack(stack, handler);
 	os_usr1_process(os_getpid());
 }

--Boundary-00=_Ya7MAmWa1yGJ6aU--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
