Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IaGUB-0008Hx-US for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Sep 2007 12:54:29 -0700
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IaGU9-00066w-Ng
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Sep 2007 12:54:23 -0700
From: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20070925173713.GA8262@c2.user-mode-linux.org>
References: <20070925173713.GA8262@c2.user-mode-linux.org>
Date: Tue, 25 Sep 2007 21:54:15 +0200
Message-Id: <1190750055.17409.38.camel@chaos>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] UML - time build fix
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>


On Tue, 2007-09-25 at 13:37 -0400, Jeff Dike wrote:
> Put back an implementation of timeval_to_ns in
> arch/um/os-Linux/time.c.  tglx pointed out in his review of tickless
> support that there was a perfectly good implementation of it in
> linux/time.h.  The problem is that this is userspace code which can't
> pull in kernel headers and there doesn't seem to be a libc version.

Oops. Did not notice. Can't we move it into some header file which is
accessible from everywhere ?

	tglx

> So, I'm copying the version from linux/time.h rather than resurrecting
> my version.  This causes some declaration changes as it now returns a
> signed value rather than an unsigned value.
> 
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> ---
>  arch/um/include/os.h    |    4 ++--
>  arch/um/os-Linux/time.c |   22 +++++++++++++++++++---
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6.22/arch/um/include/os.h
> ===================================================================
> --- linux-2.6.22.orig/arch/um/include/os.h	2007-09-25 09:26:42.000000000 -0400
> +++ linux-2.6.22/arch/um/include/os.h	2007-09-25 09:28:42.000000000 -0400
> @@ -252,9 +252,9 @@ extern void os_dump_core(void);
>  extern void idle_sleep(unsigned long long nsecs);
>  extern int set_interval(void);
>  extern int timer_one_shot(int ticks);
> -extern unsigned long long disable_timer(void);
> +extern long long disable_timer(void);
>  extern void uml_idle_timer(void);
> -extern unsigned long long os_nsecs(void);
> +extern long long os_nsecs(void);
>  
>  /* skas/mem.c */
>  extern long run_syscall_stub(struct mm_id * mm_idp,
> Index: linux-2.6.22/arch/um/os-Linux/time.c
> ===================================================================
> --- linux-2.6.22.orig/arch/um/os-Linux/time.c	2007-09-25 09:26:42.000000000 -0400
> +++ linux-2.6.22/arch/um/os-Linux/time.c	2007-09-25 09:28:42.000000000 -0400
> @@ -39,7 +39,23 @@ int timer_one_shot(int ticks)
>  	return 0;
>  }
>  
> -unsigned long long disable_timer(void)
> +/**
> + * timeval_to_ns - Convert timeval to nanoseconds
> + * @ts:		pointer to the timeval variable to be converted
> + *
> + * Returns the scalar nanosecond representation of the timeval
> + * parameter.
> + *
> + * Ripped from linux/time.h because it's a kernel header, and thus
> + * unusable from here.
> + */
> +static inline long long timeval_to_ns(const struct timeval *tv)
> +{
> +	return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
> +		tv->tv_usec * UM_NSEC_PER_USEC;
> +}
> +
> +long long disable_timer(void)
>  {
>  	struct itimerval time = ((struct itimerval) { { 0, 0 }, { 0, 0 } });
>  
> @@ -47,10 +63,10 @@ unsigned long long disable_timer(void)
>  		printk(UM_KERN_ERR "disable_timer - setitimer failed, "
>  		       "errno = %d\n", errno);
>  
> -	return tv_to_nsec(&time.it_value);
> +	return timeval_to_ns(&time.it_value);
>  }
>  
> -unsigned long long os_nsecs(void)
> +long long os_nsecs(void)
>  {
>  	struct timeval tv;
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
