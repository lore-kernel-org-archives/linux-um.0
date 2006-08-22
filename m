Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GFYnH-0003Vt-7z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Aug 2006 09:07:59 -0700
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GFYnE-0008IQ-Hq
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Aug 2006 09:07:59 -0700
Date: Tue, 22 Aug 2006 18:07:41 +0200
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20060822160741.GB11651@stusta.de>
References: <20060821215641.GQ11651@stusta.de>
	<20060822022012.GA7070@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060822022012.GA7070@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] arch/um/sys-i386/setjmp.S: useless #ifdef _REGPARM's?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Aug 21, 2006 at 10:20:12PM -0400, Jeff Dike wrote:
> On Mon, Aug 21, 2006 at 11:56:41PM +0200, Adrian Bunk wrote:
> > arch/um/sys-i386/setjmp.S contains two #ifdef _REGPARM's.
> > 
> > Even if regparm was used in i386 uml (which isn't currently done (why?)),
> > I don't see _REGPARM being defined anywhere.
> 
> setjmp.S was stolen from klibc, and I'd just as soon leave it alone and
> not try to customize it for UML.  That file will disappear if/when klibc 
> is in mainline, and I can just pull it in from usr.

Ah, klibc defines _REGPARM if required.

> In general, there's no reason that regparam can't be used for UML.  However,
> in the past (I don't know if it's still a problem) gcc miscompiled regparam
> code in the presence of -pg.

I didn't find a corresponding open bug in the gcc Bugzilla.

Can someone verify whether it's still present, and if yes, open a gcc 
bug?

> As for why it's not, I don't see any occurences of regparam in include/linux
> or include/asm-i386 either.

It's set globally in arch/i386/Makefile:
  cflags-$(CONFIG_REGPARM) += -mregparm=3

That's not pulled by UML, but if there are no outstanding problems with 
regparm, we could both enable it uncomditionally on i386 and enable it
on UML/i386.

> > Is this a bug waiting for happening when regparm will be used on uml or 
> > do I miss anything?
> 
> Probably not.
> 
> 				Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
