Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9pw9-0000y1-S1 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 11:36:41 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D9pw8-0005se-5i for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 11:36:41 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 4/9] UML - Export gcov symbol based on gcc
	version
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
In-Reply-To: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503112035.49163.blaisorblade@yahoo.it>
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
Date: Fri, 11 Mar 2005 20:35:48 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org

On Thursday 10 March 2005 03:16, Jeff Dike wrote:
> The init function called by gcc when gcov is enabled is __gcov_init or
> __bb_init_func, depending on the gcc version.  Anton is using 3.3.4 and
> seeing __gcov_init.  I'm using 3.3.2 and seeing __bb_init_func, so we need
> to close that gap a bit.

I'll have to undo this patch... I said that you must export both symbols when 
GCC version is the right one.

And I can say this version is > 3.3.4, since my good Gentoo's 3.3.4 does not 
include this symbol.

We rediscussed this with Jeff, and I'll post a better patch: 
EXPORT_SYMBOL(__gcov_init), and weakly define it to an empty function. I'll 
do it tomorrow.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>
> Index: linux-2.6.11/arch/um/kernel/gmon_syms.c
> ===================================================================
> --- linux-2.6.11.orig/arch/um/kernel/gmon_syms.c 2005-03-07
> 10:53:03.000000000 -0500 +++
> linux-2.6.11/arch/um/kernel/gmon_syms.c 2005-03-07 16:29:37.000000000 -0500
> @@ -5,8 +5,14 @@
>
>  #include "linux/module.h"
>
> +#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 3) || \
> + (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
> +extern void __gcov_init(void *);
> +EXPORT_SYMBOL(__gcov_init);
> +#else
>  extern void __bb_init_func(void *);
>  EXPORT_SYMBOL(__bb_init_func);
> +#endif
>
>  /*
>   * Overrides for Emacs so that we follow Linus's tabbing style.


-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
