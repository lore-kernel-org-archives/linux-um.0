Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AttpC-0003bz-BW
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 11:27:06 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Attbe-0002pR-UN
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 11:13:07 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] 2.6.3-rc2-uml1 Kernel mode panic
References: <Pine.LNX.4.44.0402181635060.15836-100000@sparrow> <200402191914.01209.blaisorblade_spam@yahoo.it> <20040219193529.GA3644@ccure.user-mode-linux.org>
In-Reply-To: <20040219193529.GA3644@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402192024.10858.blaisorblade_spam@yahoo.it>
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
Date: Thu, 19 Feb 2004 20:24:10 +0100
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Alle 20:35, gioved=EC 19 febbraio 2004, Jeff Dike ha scritto:

> I can reproduce it fine.  The recipe that Bill provided works like a charm
> - hit it from the outside with 'ssh uml some command'
> 	run 'while true; do cat /dev/null; done' inside
>
> and it will panic in 5-10 minutes in one of several ways.  The exit.c BUG
> is the process returning from the schedule at the end of exit().

Exactly the same here.

> The
> kernel mode fault is the scheduler seeing that the runqueue bitmap says
> there's a process to be scheduled waiting on a particular queue, but that
> queue is empty.

On my system the queue is not simply empty (i.e. queue[index] =3D=3D=20
queue[index]->next =3D=3D queue[index]->prev) but has wrong next and prev v=
alues=20
(one is 0x78 and one 0x0 last time, IIRC; however values <0x100). For the=20
rest, it's the same as I get.

Now you can reproduce it, we'll soon see it fixed!

Bye
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
