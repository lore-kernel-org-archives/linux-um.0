Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5km6-00006H-10 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:58:46 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I5km4-00015F-Mw
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:58:46 -0700
Date: Tue, 3 Jul 2007 08:58:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070703085830.9b0520a1.akpm@linux-foundation.org>
In-Reply-To: <200707031728.36472.blaisorblade@yahoo.it>
References: <20070614202655.GA9647@c2.user-mode-linux.org>
	<20070627233701.8e53f3cb.akpm@linux-foundation.org>
	<200707031728.36472.blaisorblade@yahoo.it>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 4/5] UML - Simplify helper stack handling
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Tue, 3 Jul 2007 17:28:30 +0200 Blaisorblade <blaisorblade@yahoo.it> wrot=
e:

> On gioved=EC 28 giugno 2007, Andrew Morton wrote:
> > So I'm running the generic version of this on i386 with 8k stacks (belo=
w),
> > with a quick LTP run.
> >
> > Holy cow, either we use a _lot_ of stack or these numbers are off:
> >
> > vmm:/home/akpm> dmesg -s 1000000|grep 'bytes left'
> > khelper used greatest stack depth: 7176 bytes left
> > khelper used greatest stack depth: 7064 bytes left
> > khelper used greatest stack depth: 6840 bytes left
> > khelper used greatest stack depth: 6812 bytes left
> > hostname used greatest stack depth: 6636 bytes left
> > uname used greatest stack depth: 6592 bytes left
> > uname used greatest stack depth: 6284 bytes left
> > hotplug used greatest stack depth: 5568 bytes left
> > rpc.nfsd used greatest stack depth: 5136 bytes left
> > chown02 used greatest stack depth: 4956 bytes left
> > fchown01 used greatest stack depth: 4892 bytes left
> =

> > That's the sum of process stack and interrupt stack, but I doubt if this
> > little box is using much interrupt stack space.
> >
> > No wonder people are still getting stack overflows with 4k stacks...
> =

> First, those numbers pretend to be _unused_ stack space.

Yep.  So fchown01 used ~3200 bytes of stack.  Problem.

> Well, UML tends to use more stack space than the rest of kernel.

That was a plain old i386 kernel.


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
