Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsRwV-0004NN-17
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 11:28:39 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AsRof-0000eN-AC
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 11:20:33 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel idles in loop after loading IPv4
References: <1075236841.15950.10.camel@rocket.innercite.com> <200401280439.i0S4dUZw005532@ccure.user-mode-linux.org> <1075497812.22009.41.camel@rocket.innercite.com>
In-Reply-To: <1075497812.22009.41.camel@rocket.innercite.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402151801.38113.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset="iso-8859-15"
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
Date: Sun, 15 Feb 2004 18:12:22 +0100
Content-Transfer-Encoding: quoted-printable
To: Phil Nadeau <phil@innercite.com>, roland <for_spam@gmx.de>, UML Dev List <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>

Alle 22:23, venerd=EC 30 gennaio 2004, Phil Nadeau ha scritto:
> On Tue, 2004-01-27 at 20:39, Jeff Dike wrote:

> Here's the last part of a debug session that I ran which produced the
> error. The full transcript is attached. Thanks in advance.

Could you try to reproduce this bug running onto a 2.4 host-skas kernel wit=
h=20
the same guest kernel? Most people have no problem with the code; also, the=
=20
host-skas patch for 2.6 that you used has more than one bug (somebody even =

reported kernel Oopses with that applied). Also, I'd like more info on the =

host configuration: glibc/gcc version and distro used.

> NET: Registered protocol family 2
>
> Breakpoint 1, schedule () at kernel/sched.c:1489
> 1489            if (likely(!(current->state & (TASK_DEAD | TASK_ZOMBIE))))
> { #0  schedule () at kernel/sched.c:1489
> #1  0xa002db4e in wait_for_completion (x=3D0xa1fefb64) at kernel/sched.c:=
1758
> #2  0xa0041104 in synchronize_kernel () at kernel/rcupdate.c:262
> #3  0xa000b5dc in inet_init () at net/ipv4/af_inet.c:1144

An old message, "[uml-devel] wait queues broken?" on 19 November 2003, spok=
e=20
of something that could be related to this. Since everything is about=20
scheduling, this error message I got could be of interest:

Kernel panic: Kernel mode fault at addr 0x1f, ip 0x400d1397
Kernel panic: kernel BUG at kernel/exit.c:793!

The second message is of interest because the BUG line of interest reads as:
  schedule();
  BUG();
and this is fairly interesting.

To get this, I've run this command:

while /bin/true ; do /bin/true ; done

However, the kernel I was running went on after the "NET: Registered protoc=
ol=20
family 2" message.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
