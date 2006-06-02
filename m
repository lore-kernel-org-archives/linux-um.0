Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FmHIK-00021D-6m for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 14:35:00 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FmHIJ-0002AP-UY for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 14:34:59 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FmHIH-0000Dt-Gy
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 14:35:00 -0700
Date: Fri, 2 Jun 2006 17:34:55 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060602213455.GA5889@ccure.user-mode-linux.org>
References: <20060602030825.GA8006@ccure.user-mode-linux.org>
	<1149231262.20582.119.camel@localhost.localdomain>
	<20060602151916.GC4708@ccure.user-mode-linux.org>
	<200606022028.38510.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200606022028.38510.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] non-scalar ktime addition and subtraction broken
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
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, "Christopher S. Aker" <caker@theshore.net>

On Fri, Jun 02, 2006 at 08:28:37PM +0200, Blaisorblade wrote:
> Ok, since I now I'll never finish it:
> $ ll old-patch-scripts/patches/uml-fix-timers.patch
> -rw-r--r-- 1 paolo paolo 6763 2005-07-24 06:41 
> old-patch-scripts/patches/uml-fix-timers.patch
> 
> I'm attaching this incomplete patch. It won't apply (it was written likely 
> before 2.6.13 but surely after git was born), it likely introduces bugs and I

> *) Rename timer() since it's a global and such a name is a "shooting 
> offense".  Also, it's difficult to find the def with ctags
> currently, because people miss fantasy.

This is now gone, replaced by get_time.  I can rename that if you feel
it's objectionable.

> *) do_timer must be called with xtime_lock held. I'm not sure
> boot_timer_handler needs this, however I don't think it hurts: it simply
> disables irq and takes a spinlock.

Fixed.

> *) wall_to_monotonic must be normalized and have a posititive ts_nsec part,
> see wall_to_monotonic definition and i386 usage in arch/i386/kernel/time.c.
> Otherwise you can get negative tv_nsec results with
> do_posix_clock_monotonic_gettime and its callers, including
> sys_timer_gettime.

Bah, you almost completely diagnosed the bug.  Fixed now.

> *) Remove um_time() and um_stime() syscalls since they are identical to
> system-wide ones.

Fixed.  sys_time64 seems to be gone on x86_64, so I deleted it from
here as well.

> *) Move clock_was_set() from do_gettimeofday to do_settimeofday. Not
> only from the name you guess this is needed, but I indeed verified
> that for i386 it's in arch/i386/kernel/time.c:do_settimeofday().

I had already fixed this.

> *) XXX: Probably do_settimeofday should be copied from i386 to
> replace the current version.
>
> *) XXX: do_[gs]ettimeofday() should use seqlocks like in i386,
> instead of timer_lock() like they do. They also don't synchronize
> with the rest, beyond the performance problems!

You're probably right.  These two are related, and I'm not sure what
to do with them offhand.

				Jeff


_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
