Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B0nD8-0007i5-1b for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Mar 2004 11:48:18 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B0mYP-0000Ud-46 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Mar 2004 11:06:13 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] fix writing into /dev/kmem
References: <20040229023636.GB8272@ccure.user-mode-linux.org>
	<200403021941.52257.blaisorblade_spam@yahoo.it>
	<200403040202.i2422GWo008953@ccure.user-mode-linux.org>
In-Reply-To: <200403040202.i2422GWo008953@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403081250.11095.blaisorblade_spam@yahoo.it>
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
Date: Mon, 8 Mar 2004 12:50:11 +0100
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 03:02, gioved=EC 4 marzo 2004, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:
> > Well, on *i386* that is 0xc0000001; since klogd is built with i386
> > kernel  headers, it will use those.
>
> This was the stupidity that I was refusing to believe in.  This means that
> if you take a normal klogd and move it to a 2G/2G system, where the kernel
> starts at 0x80000000, it won't work.

Well, that can be stupid (and is), but needing to recompile iptables when=20
upgrading kernel from 2.4.21-Mandrake (i.e. 2.4.21-rc#) to 2.4.21 is even=20
more stupid, right? However that was real.

> > Anyway, here comes that copy_{to,from}_user are buggy. Since fixing
> > those  would have a good performance hit (to test, but that will
> > probably be  sensitive
>
> In skas mode, I wasn't expecting any legitimate unfixable kernel mode
> access faults, so I wasn't setting up the fault_catcher.  So, what I did
> was add a wrapper around the guts of copy_user which does a setjmp, and
> returns whether it got longjmp-ed back to.

Yes, fault_catcher (i.e. memory exceptions) works for kernel addresses at v=
ery=20
little cost. Not for userspace addresses, sadly.

> Reading /dev/kmem now produces -EFAULT.

Well, if you only changed copy_user, there should be some working addresses=
 to=20
read there, right? Even if klogd would need recompilation to handle it righ=
t.

In the case /dev/kmem does not work at all we could live with it, but it is=
 a=20
bit unclean.

> Writing to it still causes a hang
> because write_kmem doesn't check the return value of do_write_mem.  With
> that fixed, everything produces -EFAULT.

I'm sending the return check fix to LKML+ Andrew Morton, together with some=
=20
cleanup for the unused params of do_write_mem.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
