Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZyXc-0005yV-8Z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 16:40:12 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GZyXY-0003MD-6R
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 16:40:12 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 18 Oct 2006 01:39:55 +0200
References: <451E9BAB.5030009@linuxbox.cz>
	<20061016150259.GA4381@ccure.user-mode-linux.org>
	<1161116486.2709.15.camel@nik-nb>
In-Reply-To: <1161116486.2709.15.camel@nik-nb>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610180139.55496.blaisorblade@yahoo.it>
Subject: Re: [uml-devel]
	=?iso-8859-1?q?SKAS_mode_not_working=2C_x86=5F64_SMP_?=
	=?iso-8859-1?q?host=2C_x86=5F64=09guest_=2C_problems_with_noprocmm?=
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
To: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 17 October 2006 22:21, Nikola Ciprich wrote:
> Hi guys,
> thanks for suggestions. Now I've been able to track the problem, and it
> seems to be arch/um/sys-x86_64/delay.c, function __const_udelay.
> halt process hangs at drivers/md/md.c, function md_notify_reboot(...):
> it never gets after the mdelay(1000*1) line, however according to my
> printk's I've added it seems that this function is being executed
> periodically, but it's certainly because of some overflow.
> I've noticed that it's being called with usecs value of 4294000, and
> I've also noticed following comment at include/linux/delay.h:
> /*
>  * Using udelay() for intervals greater than a few milliseconds can
>  * risk overflow for high loops_per_jiffy (high bogomips) machines. The
>  * mdelay() provides a wrapper to prevent this.  For delays greater
>  * than MAX_UDELAY_MS milliseconds, the wrapper is used.  Architecture
>  * specific values can be defined in asm-???/delay.h as an override.
>  * The 2nd mdelay() definition ensures GCC will optimize away the
>  * while loop for the common cases where n <= MAX_UDELAY_MS  --  Paul G.
>  */
> So maybe calling __const_udelay with such high value is problem? When I
> print value of n, it's always some big value (like 3419150745), so it
> seems that this variable is overflowing). When I compare um-i386 and
> um-x86_64 implementation of __const_udelay, it turns that difference
> between them is that i386 version uses plain unsigned ints, while x86_64
> version uses unsigned longs. So I've tried to change longs to ints (yup,
> it's certainly brain damaged, but I just wanted to try) and things seem
> to started working.

You really changed long to int? In this case, you may only have introduced a 
bigger overflow.
Jeff, I remember vaguely a recent (>=2.6.17) patch about udelay fixing a 
misbehaviour, would you please complete my recollection and verify the 
interaction with this?

Also, since we take __const_udelay and __udelay() from asm/arch/delay.h:
(for i386):
#define udelay(n) (__builtin_constant_p(n) ? \
        ((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
        __udelay(n))

#define ndelay(n) (__builtin_constant_p(n) ? \
       ((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
       __ndelay(n))

We then do _not_ take these definitions:
arch/i386/lib/delay.c:

void __udelay(unsigned long usecs)
{
        __const_udelay(usecs * 0x000010c7); /* 2**32 / 1000000 (rounded up) */
}

void __ndelay(unsigned long nsecs)
{
        __const_udelay(nsecs * 0x00005); /* 2**32 / 1000000000 (rounded up) */
}

instead for us __udelay and __const_udelay match, which is not likely to help 
at all. Their code is correct because the asm "mull" call divides the 
obtained product by 2^32 by throwing away the 32 low bits (i.e. EAX, since 
the mull result is in EDX:EAX), and the meaning of this is to do the division 
only at the very end (to improve accuracy).

This bug is here at least since 2.6.16.
Suggested solution:
1) have _our own_ delay.h, to avoid depending on subarchs' changes
2) first avoid playing so complex tricks, then maybe copy their implementation 
(note it is slightly different already among x86 and x86_64).

> But I'm sure this is not the right solution, so what 
> do You guys suggest? And also is really i386 variant safely implemented?

> thanks a lot!
> nik.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
