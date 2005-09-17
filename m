Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGeqp-0005ns-4r	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 08:43:39 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EGeql-0007lD-LN
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 08:43:39 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] testing: 2.6.13 to 2.6.14-rc1 TT boot hangs early
	(sometimes)
References: <1126653933.3769.45.camel@localhost>
	<200509162124.42522.blaisorblade@yahoo.it>
	<1126901562.17715.9.camel@localhost>
In-Reply-To: <1126901562.17715.9.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509171741.30694.blaisorblade@yahoo.it>
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
Date: Sat, 17 Sep 2005 17:41:30 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: antoine <antoine@nagafix.co.uk>, Jeff Dike <jdike@addtoit.com>

On Friday 16 September 2005 22:12, antoine wrote:
> > > UML running in SKAS3 mode
> > > Checking PROT_EXEC mmap in /tmp...OK
> > > Kernel virtual memory size shrunk to 28311552 bytes
> >
> > This is running in SKAS3 mode - see message. However, the problem may be
> > TT in the meaning you'd better probably disable it.

> I enabled both to make it easier to test each mode, oh well... Noted.

> > > What's this about shrinking vm size? (reducing the mem gets rid of this
> > > warning)

> > By how much? If you tried to pass it 1G of mem it's ok it complains (when
> > TT mode is enabled and HIGHMEM disabled it doesn't work - disabling TT
> > should fix this).
>
> HIGHMEM was disabled, but mem=512M so this shouldn't matter, right?
I've read from Jeff that the actual limit is 480M (some space must be saved 
for vmalloc(), i.e. kernel pageable memory).
> It stopped complaining at about mem=200M (roughly IIRC)
Well, that's too low, so yes, there's some problem. Especially because memory 
is shrunk down to 28M...

Which is the host distro? Having a RH/Fc could be a cause (I don't know the 
current situation with these).
> > > # uname -a

> >
> > Does the box locks up thereafter? Jeff has been seeing these for some
> > time, but IIRC the box didn't lock up. (Jeff, what's the actual
> > situation?).

> The host is fine... so far.
Sorry, was talking about UML. But I assume it locks up. Was SMP enabled? In 
that case, there's a couple of things in -bs1 (just published) which may help 
it.
> > > * Good points:
> > > pcap works really well.
> > > I just wished there was a way to easily figure out which libraries need
> > > to be included in the chroot to make it work (beyond lipcap)

> > Idea: try using ltrace with focus on dlopen (from libdl).

> I'll do that and post the results.

> > > * Some other small issues:
> > > when building IPv6 & pcap, I get:
> > > /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/../../../libc.a(in6_addr.o)(.r
> > >odat a+0x10): multiple definition of `in6addr_loopback'
> > >
> > > (This has been the case with the last few releases)
> >

> Anything for credits ;-)
> BTW, I can't contribute patches (I can code in C, but not kernel code) -
> however I can provide free hosting, disk space, etc to all the uml
> hackers that ask.
> Feel free include my email, in the worst case it will train my spam
> filters!

> Antoine

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
