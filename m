Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtZkn-0000MT-3g
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 14:01:13 -0800
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101] helo=sparrow.stearns.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AtZYW-0001Oj-Gx
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 13:48:32 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] 2.6.3-rc2-uml1 Kernel mode panic
In-Reply-To: <200402171709.44913.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.44.0402181635060.15836-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 18 Feb 2004 16:56:04 -0500 (EST)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, William Stearns <wstearns@pobox.com>

Good afternoon, all,

On Tue, 17 Feb 2004, BlaisorBlade wrote:

> Alle 04:06, domenica 15 febbraio 2004, William Stearns ha scritto:
> > 	I got a Kernel panic from the above kernel; sorry to say my
> > compiler won't let me include all the debugging information that would
> > have made this report useful.  :-(
> >
> > Kernel panic: Kernel mode fault at addr 0x0, ip 0x40101f94
> 
> Could you run with that kernel this loop on a shell:
> 
> while cat /dev/null; do cat /dev/null; done
> 
> This loop deterministically panics 2.6.2 and 2.6.3-rc2 UML kernels I have 
> here(and if the configuration stays the same, even the corrupted values stay 
> the same!). However nobody has yet seen it elsewhere.
> 
> Also this one "works":
> while /bin/true; do /bin/true; done
> (please avoid replacing /bin/true with true, since the second one is a shell 
> builtin while I need a lot of forks to crash UML).

	On a kernel using Jeff's patch from 2/16, which looks absolutely 
identical to yours,  20 of these running in the background * produces:
Kernel panic: Kernel BUG at kernel/exit.c:793
	or
Kernel panic: Kernel BUG at kernel/exit.c:793
Kernel panic: Segfault with no mm
Kernel panic: Segfault with no mm
Kernel panic: Segfault with no mm
	or
Kernel mode fault at addr 0x0, ip 0x401e643e
Kernel mode fault at addr 0x0, ip 0x401e643e
Kernel mode fault at addr 0x0, ip 0x401e643e
Kernel mode fault at addr 0x0, ip 0x401e643e

	For reference, when I revert to the kernel without that patch and
run 20 of those *, I got 8 "Kernel panic: segfault with no mm" within a
few minutes too.
	Both kernels are available from http://www.stearns.org/uml/ ; 
they're the ones eding in -gcc333.
	Cheers,
	- Bill

* Along with a continuous loop from the host of:
while : ; do ssh vmname echo vmname ; done

---------------------------------------------------------------------------
	"I would give up my right arm before I'd give up my netfilter
firewall."
	-- Chris Brenton
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
