Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ga62r-0005Ub-FH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 00:40:57 -0700
Received: from gwu.lbox.cz ([62.245.111.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ga62q-00068T-Pg
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 00:40:57 -0700
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
In-Reply-To: <200610180139.55496.blaisorblade@yahoo.it>
References: <451E9BAB.5030009@linuxbox.cz>
	<20061016150259.GA4381@ccure.user-mode-linux.org>
	<1161116486.2709.15.camel@nik-nb>
	<200610180139.55496.blaisorblade@yahoo.it>
Date: Wed, 18 Oct 2006 10:40:36 +0300
Message-Id: <1161157236.7397.13.camel@nik-nb>
Mime-Version: 1.0
Subject: Re: [uml-devel]
	=?iso-8859-1?q?SKAS_mode_not_working=2C_x86=5F64_SMP_?=
	=?iso-8859-1?q?host=2C_x86=5F64=09guest_=2C_problems_with_noprocmm?=
Reply-To: nikola.ciprich@linuxbox.cz
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

> You really changed long to int? In this case, you may only have introduced a 
> bigger overflow.

Yes, I'm aware of that, I just wanted to try how i386 variant behaves.
btw I just tried gdb to find out why i386 UML on x86_64 host hangs just
at the beginning, and it turned out to be same problem with
__const_udelay. well, it's not a big surprise now I guess.
So if You need further testing, please feel free to post patches etc ;)
regards
nik.


On Wed, 2006-10-18 at 01:39 +0200, Blaisorblade wrote:
> On Tuesday 17 October 2006 22:21, Nikola Ciprich wrote:

> You really changed long to int? In this case, you may only have introduced a 
> bigger overflow.
> Jeff, I remember vaguely a recent (>=2.6.17) patch about udelay fixing a 
> misbehaviour, would you please complete my recollection and verify the 
> interaction with this?
> 
> Also, since we take __const_udelay and __udelay() from asm/arch/delay.h:
> (for i386):
> #define udelay(n) (__builtin_constant_p(n) ? \
>         ((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
>         __udelay(n))
> 
> #define ndelay(n) (__builtin_constant_p(n) ? \
>        ((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
>        __ndelay(n))
> 
> We then do _not_ take these definitions:
> arch/i386/lib/delay.c:
> 
> void __udelay(unsigned long usecs)
> {
>         __const_udelay(usecs * 0x000010c7); /* 2**32 / 1000000 (rounded up) */
> }
> 
> void __ndelay(unsigned long nsecs)
> {
>         __const_udelay(nsecs * 0x00005); /* 2**32 / 1000000000 (rounded up) */
> }
> 
> instead for us __udelay and __const_udelay match, which is not likely to help 
> at all. Their code is correct because the asm "mull" call divides the 
> obtained product by 2^32 by throwing away the 32 low bits (i.e. EAX, since 
> the mull result is in EDX:EAX), and the meaning of this is to do the division 
> only at the very end (to improve accuracy).
> 
> This bug is here at least since 2.6.16.
> Suggested solution:
> 1) have _our own_ delay.h, to avoid depending on subarchs' changes
> 2) first avoid playing so complex tricks, then maybe copy their implementation 
> (note it is slightly different already among x86 and x86_64).
> 
> > But I'm sure this is not the right solution, so what 
> > do You guys suggest? And also is really i386 variant safely implemented?
> 
> > thanks a lot!
> > nik.
> 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
