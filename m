Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9WY9-0001uZ-1C for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 14:54:37 -0800
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D9WY7-0004wE-A9 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 14:54:36 -0800
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20050310225340.GD3205@stusta.de>
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: [PATCH 4/9] UML - Export gcov symbol based on gcc
	version
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
Date: Thu, 10 Mar 2005 23:53:40 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Mar 09, 2005 at 09:16:02PM -0500, Jeff Dike wrote:
> The init function called by gcc when gcov is enabled is __gcov_init or
> __bb_init_func, depending on the gcc version.  Anton is using 3.3.4 and 
> seeing __gcov_init.  I'm using 3.3.2 and seeing __bb_init_func, so we need
> to close that gap a bit.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Index: linux-2.6.11/arch/um/kernel/gmon_syms.c
> ===================================================================
> --- linux-2.6.11.orig/arch/um/kernel/gmon_syms.c	2005-03-07 10:53:03.000000000 -0500
> +++ linux-2.6.11/arch/um/kernel/gmon_syms.c	2005-03-07 16:29:37.000000000 -0500
> @@ -5,8 +5,14 @@
>  
>  #include "linux/module.h"
>  
> +#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 3) || \
> +	(__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
>...

This patch is still wrong.

It seems my comment on this [1] was lost:

<--  snip  -->

This line has to be something like

( (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4) && \
   HEAVILY_PATCHED_SUSE_GCC ) 

I hope SuSE has added some #define to distinguish what they call 
"gcc 3.3.4" from GNU gcc 3.3.4

<--  snip  -->


cu
Adrian

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0503.0/1876.html

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
