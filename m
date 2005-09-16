Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGM7A-0003kr-3f	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 12:43:16 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EGM77-0007nl-M4
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 12:43:16 -0700
Subject: Re: [uml-devel] testing: 2.6.13 to 2.6.14-rc1 TT boot hangs early
	(sometimes)
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <200509162124.42522.blaisorblade@yahoo.it>
References: <1126653933.3769.45.camel@localhost>
	 <200509162124.42522.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1126901562.17715.9.camel@localhost>
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
Date: Fri, 16 Sep 2005 21:12:42 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>

> > UML running in SKAS3 mode
> > Checking PROT_EXEC mmap in /tmp...OK
> > Kernel virtual memory size shrunk to 28311552 bytes
> This is running in SKAS3 mode - see message. However, the problem may be TT in 
> the meaning you'd better probably disable it.
I enabled both to make it easier to test each mode, oh well... Noted.

> > What's this about shrinking vm size? (reducing the mem gets rid of this
> > warning)
> By how much? If you tried to pass it 1G of mem it's ok it complains (when TT 
> mode is enabled and HIGHMEM disabled it doesn't work - disabling TT should 
> fix this).
HIGHMEM was disabled, but mem=512M so this shouldn't matter, right?
It stopped complaining at about mem=200M (roughly IIRC)

> > # uname -a
> > Linux mamba 2.6.12-skas3-v9-pre4 #2 Thu Jun 23 16:28:29 GMT i686 AMD
> > Athlon(tm) XP 2000+ AuthenticAMD GNU/Linux
> > I tried the same filesystem as ext3 but that made no difference.
> > Guest is 2.6.14-rc1
> 
> > Same kernel in skas3/skas0 works occasionally! But when it does not:
> 
> > [42949374.340000] VFS: Mounted root (ext3 filesystem) readonly.
> > [42949384.250000] BUG: soft lockup detected on CPU#0!
> Does the box locks up thereafter? Jeff has been seeing these for some time, 
> but IIRC the box didn't lock up. (Jeff, what's the actual situation?).
The host is fine... so far.

> > * Good points:
> > pcap works really well.
> > I just wished there was a way to easily figure out which libraries need
> > to be included in the chroot to make it work (beyond lipcap)
> Idea: try using ltrace with focus on dlopen (from libdl).
I'll do that and post the results.

> > * Some other small issues:
> > when building IPv6 & pcap, I get:
> > /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/../../../libc.a(in6_addr.o)(.rodat
> >a+0x10): multiple definition of `in6addr_loopback'
> 
> > (This has been the case with the last few releases)
> It's a name conflict with libc... ugh, means adding another -D like 
> -Derrno=kernel_errno in the same place. It's trivial, but it's getting boring. 
> Attached the fix.
> 
> A question: is it ok to be mentioned in the patch changelog? It was suggested 
> to do so to give a bit of reward to testers - just I don't know if I should 
> or not, and secondly if I should put your email or not.
Anything for credits ;-)
BTW, I can't contribute patches (I can code in C, but not kernel code) -
however I can provide free hosting, disk space, etc to all the uml
hackers that ask.
Feel free include my email, in the worst case it will train my spam
filters!

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
