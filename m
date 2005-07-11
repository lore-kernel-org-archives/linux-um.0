Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ds6Hq-00008u-Oa	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 14:58:02 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.44)
	id 1Ds6Hp-0003Ly-EV	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 14:58:03 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 1/1] uml: fix lvalue for gcc4
References: <20050709110143.D59181E9EA4@zion.home.lan>
	<20050709120703.C2175@flint.arm.linux.org.uk>
In-Reply-To: <20050709120703.C2175@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507120005.14985.blaisorblade@yahoo.it>
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
Date: Tue, 12 Jul 2005 00:05:14 +0200
To: Russell King <rmk+lkml@arm.linux.org.uk>, jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On Saturday 09 July 2005 13:07, Russell King wrote:
> On Sat, Jul 09, 2005 at 01:01:33PM +0200, blaisorblade@yahoo.it wrote:
> > diff -puN arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue
> > arch/um/sys-x86_64/signal.c ---
> > linux-2.6.git/arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue	2005-07
> >-09 13:01:03.000000000 +0200 +++
> > linux-2.6.git-paolo/arch/um/sys-x86_64/signal.c	2005-07-09
> > 13:01:03.000000000 +0200 @@ -168,7 +168,7 @@ int
> > setup_signal_stack_si(unsigned long
> >
> >  	frame = (struct rt_sigframe __user *)
> >  		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
> > -	((unsigned char *) frame) -= 128;
> > +	frame -= 128 / sizeof(frame);
>
> Are you sure these two are identical?
SOOOOOOOOORRY, I've become crazy, I meant sizeof(*frame)... thanks for 
noticing.

> The above code fragment looks suspicious anyway, particularly:
>
>  	frame = (struct rt_sigframe __user *)
>  		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
>
> which will put the frame at 8 * sizeof(struct rt_sigframe) below
> the point which round_down() would return (which would be 1 struct
> rt_sigframe below stack_top, rounded down).

You're completely right.

The code is copied from arch/x86_64/kernel/signal.c:setup_rt_frame(), so it 
should make some sense; but in the source, the cast is to (void*).

Surely Jeff, seeing that the result is assigned to a struct rt_sigframe 
__user, "fixed" it. The line I'm patching is new from Jeff, and I don't know 
what's about (I just remember that 

Also, the below access_ok() called on fp (which is still NULL) is surely 
completely wrong, though it won't fail (after all, NULL is under TASK_SIZE. 
right?).

On x86_64 the code is always used from arch/um/kernel/signal_kern.c, since 
CONFIG_whatever is not enabled.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
