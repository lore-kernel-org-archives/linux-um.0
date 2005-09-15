Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EG0Gv-0007zv-0J	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 13:23:53 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EG0Gt-00059T-Jb
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 13:23:53 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] 2.6.14-rc1 x86 on 2.6.13.1 amd64 host: guest
	segfaults
Message-ID: <20050915190633.GB8106@ccure.user-mode-linux.org>
References: <1126803951.5268.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126803951.5268.39.camel@localhost.localdomain>
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
Date: Thu, 15 Sep 2005 15:06:33 -0400
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Sep 15, 2005 at 06:05:51PM +0100, Antoine Martin wrote:
> I tried mode=skas0 but it seems to always default to TT.
> Or has this not been merged in mainline yet?

It's in mainline.  What's the guest?

> **
> And here is a amd64 guest:
> (This trace was much much longer)

Did this one come up in skas0 or tt mode?

> Another weirdness, this command line works:
> # ./kernel64 root=/dev/ubda mem=256M ubd0=./root_fs64
> eth0=tuntap,tap0,FE:F0:00:00:00:01,10.0.0.254 eth1=pcap,eth0
> console0=fd:0,fd:1 umid=1

What's with the console* business?  The switch is "con".

> But this one does not:
> # ./kernel64 root=/dev/ubda mem=256M ubd0=./root_fs64
> eth0=tuntap,tap0,FE:F0:00:00:00:01,10.0.0.254 eth1=pcap,eth0
> console0=fd:0,fd:1 console=pty umid=1 gentoo=nodevfs nodevfs selinux=1
> enforcing=0
> With this one it crashes after checking for PROT_EXEC.
> Is this to do with command line size limitations?

Maybe, but it probably shouldn't crash.

> write(3, "1126803520:  *** terminating.\n", 30) = 30

This bit seems relevent - were there any syscall failures above that?

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
