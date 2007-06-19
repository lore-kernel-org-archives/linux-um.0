Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I0jol-00055k-Fu for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Jun 2007 12:56:47 -0700
Received: from rgminet01.oracle.com ([148.87.113.118])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I0jok-0002rf-1P
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Jun 2007 12:56:47 -0700
Date: Tue, 19 Jun 2007 12:57:07 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Message-Id: <20070619125707.84cf73fd.randy.dunlap@oracle.com>
In-Reply-To: <20070619195003.GA11718@c2.user-mode-linux.org>
References: <20070619184245.GA10567@c2.user-mode-linux.org>
	<20070619115422.de61abd5.akpm@linux-foundation.org>
	<20070619195003.GA11718@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 2/2] UML - Add stack usage monitoring
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
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, 19 Jun 2007 15:50:03 -0400 Jeff Dike wrote:

> Add a machanism to see how much of a kernel stack is used.  This
> allocates zeroed stacks and sees where the lowest non-zero byte is on
> process exit.  It keeps track of the lowest value and logs values as
> they get lower.
> 
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> --
>  arch/um/Kconfig.debug        |    9 +++++++++
>  arch/um/defconfig            |    1 +
>  arch/um/kernel/process.c     |   29 +++++++++++++++++++++++++++++
>  include/asm-um/thread_info.h |   16 ++++++++++++++++
>  4 files changed, 55 insertions(+)
> 
> Index: linux-2.6.21-mm/arch/um/Kconfig.debug
> ===================================================================
> --- linux-2.6.21-mm.orig/arch/um/Kconfig.debug	2007-06-19 14:06:36.000000000 -0400
> +++ linux-2.6.21-mm/arch/um/Kconfig.debug	2007-06-19 14:06:44.000000000 -0400
> @@ -47,4 +47,13 @@ config GCOV
>          If you're involved in UML kernel development and want to use gcov,
>          say Y.  If you're unsure, say N.
>  
> +config DEBUG_STACK_USAGE
> +	bool "Stack utilization instrumentation"
> +	default N
> +	help
> +	Track the maximum kernel stack usage - this will look at each
> +	kernel stack at process exit and log it if it's the deepest
> +	stack seen so far.

Kconfig help text is indented 2 more spaces (by convention or
CodingStyle).

> +
> +	This option will slow down process creation and destruction somewhat.
>  endmenu
> Index: linux-2.6.21-mm/arch/um/kernel/process.c
> ===================================================================
> --- linux-2.6.21-mm.orig/arch/um/kernel/process.c	2007-06-19 14:06:36.000000000 -0400
> +++ linux-2.6.21-mm/arch/um/kernel/process.c	2007-06-19 15:48:20.000000000 -0400
> @@ -411,3 +411,32 @@ unsigned long arch_align_stack(unsigned 
>  	return sp & ~0xf;
>  }
>  #endif
> +
> +#ifdef CONFIG_DEBUG_STACK_USAGE
> +
> +static DEFINE_SPINLOCK(low_water_lock);
> +static int lowest_to_date = THREAD_SIZE;
> +
> +void check_stack_usage(struct thread_info *s)
> +{
> +	unsigned int *stack, *p, *end;
> +	int left;
> +
> +	stack = (unsigned int *) (s + 1);
> +	end = (unsigned int *) ((unsigned long) s + THREAD_SIZE);
> +	for (p = stack; p < end; p++) {
> +		if(*p != 0)

		if (*p != NULL)
or
		if (*p)

> +			break;
> +	}
> +
> +	left = (p - stack) * sizeof(*p);
> +
> +	spin_lock(&low_water_lock);
> +	if (left < lowest_to_date) {
> +		printk("Greatest stack depth - %d bytes left\n", left);

Does UML need/use KERN_* facility levels in printk() calls?

> +		lowest_to_date = left;
> +	}
> +	spin_unlock(&low_water_lock);
> +}
> +
> +#endif

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
