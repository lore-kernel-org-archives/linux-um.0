Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbkoD-0003v8-Al for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 12:20:09 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EbkoA-0006Ow-BT
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 12:20:09 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <1131140395.27405.6.camel@localhost.localdomain>
	<200511111848.01764.blaisorblade@yahoo.it>
	<1131742176.23542.17.camel@localhost.localdomain>
In-Reply-To: <1131742176.23542.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511142127.29052.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: 2.6.14-bs1
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
Date: Mon, 14 Nov 2005 21:27:28 +0100
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 11 November 2005 21:49, Antoine Martin wrote:
> > However, I just remembered I have an Ubuntu with GCC 4.0... so I could
> > test the thing.

> Or you could use a gentoo chroot. (if you leave it to build overnight..)
I have Gentoo installed, no problem... it's that actually they don't support 
4.0 yet and I agree with them.

However, I _did_ test with that GCC and things work ok. So it's definitely the 
hardening patches.

However, I _can_ test them:

gentoo # gcc-config -l
 [1] x86_64-pc-linux-gnu-3.4.4 *
 [2] x86_64-pc-linux-gnu-3.4.4-hardened
 [3] x86_64-pc-linux-gnu-3.4.4-hardenednopie
 [4] x86_64-pc-linux-gnu-3.4.4-hardenednopiessp
 [5] x86_64-pc-linux-gnu-3.4.4-hardenednossp

I will test the whole thing tomorrow.

> > > I've had quite a few problems with 2.6.14 not booting on 2.6.13 and
> > > 2.6.14 hosts. (errors have been reported by other users - unfortunately
> > > the strace isn't very useful)
> >
> > I've not looked deeply at the strace, but I don't see anything much
> > clear.
> >
> > Also, I suppose the problem is with SKAS0 and no regression is seen in
> > other modes.
> >
> > However, given that you're having this compilation problem (caused by
> > uml-fix-misassembling-skas0-stub-segv, which you can unapply for
> > testing),
>
> I tried removing this patch (and its sibling ^segv^) but patch -R moaned
> at me, 

Strange - the proper order is remove "-segv" and then (if needed but it 
shouldn't) remove the other - the proper patch order is documented in the 
"series" file.

Indeed, I missed that you should also remove (first)
patches/uml-fix-64compile-misassembling-skas0-stub-segv

Using quilt makes that fast, however:

*) untar the broken-out tarball

*) mv the directory to "patches

*) $ quilt pop patches/uml-fix-misassembling-skas0-stub-segv

*) (comment the patch out in patches/series)

*) $ quilt push bs-extraversion-bs1 (or quilt push -a, should be the same).

> and after unmerging it by hand I still got the same error so I 
> gave up (for now anyway)

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
