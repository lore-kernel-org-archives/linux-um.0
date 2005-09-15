Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EG14Y-0001vb-2K	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 14:15:10 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EG14X-0000A0-Fo
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 14:15:10 -0700
Subject: Re: [uml-devel] 2.6.14-rc1 x86 on 2.6.13.1 amd64 host: guest
	segfaults
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <20050915190633.GB8106@ccure.user-mode-linux.org>
References: <1126803951.5268.39.camel@localhost.localdomain>
	 <20050915190633.GB8106@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1126820388.1391.4.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Thu, 15 Sep 2005 22:39:48 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, 2005-09-15 at 15:06 -0400, Jeff Dike wrote:
> On Thu, Sep 15, 2005 at 06:05:51PM +0100, Antoine Martin wrote:
> > I tried mode=skas0 but it seems to always default to TT.
> > Or has this not been merged in mainline yet?
> 
> It's in mainline.  What's the guest?
2.6.14-rc1

> > **
> > And here is a amd64 guest:
> > (This trace was much much longer)
> 
> Did this one come up in skas0 or tt mode?
I think it was tt (will check tomorrow on that box)
As I said above, it seems to always use TT, ignoring mode=skas0

> > Another weirdness, this command line works:
> > # ./kernel64 root=/dev/ubda mem=256M ubd0=./root_fs64
> > eth0=tuntap,tap0,FE:F0:00:00:00:01,10.0.0.254 eth1=pcap,eth0
> > console0=fd:0,fd:1 umid=1
> 
> What's with the console* business?  The switch is "con".
DOH Can't trust my memory! That's why I try to use scripts..

> > But this one does not:
> > # ./kernel64 root=/dev/ubda mem=256M ubd0=./root_fs64
> > eth0=tuntap,tap0,FE:F0:00:00:00:01,10.0.0.254 eth1=pcap,eth0
> > console0=fd:0,fd:1 console=pty umid=1 gentoo=nodevfs nodevfs selinux=1
> > enforcing=0
> > With this one it crashes after checking for PROT_EXEC.
> > Is this to do with command line size limitations?
> 
> Maybe, but it probably shouldn't crash.
Yep, it isn't even that big.
> 
> > write(3, "1126803520:  *** terminating.\n", 30) = 30
> 
> This bit seems relevent - were there any syscall failures above that?
What I am looking for?
I could just drop the full log on a public server if that helps.

Antoine



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
