Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7e4k-0007Y7-EA for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Mar 2005 10:32:30 -0800
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D7e4i-0001vK-HQ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Mar 2005 10:32:30 -0800
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20050305183134.GH6373@stusta.de>
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	<200502081829.j18ITAs0003968@ccure.user-mode-linux.org>
	<200502081837.22519.blaisorblade@yahoo.it>
	<200502082223.j18MMxs0013724@ccure.user-mode-linux.org>
	<1108380903.22656.9.camel@imp.csi.cam.ac.uk>
	<200503051945.j25JjIB5003539@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503051945.j25JjIB5003539@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: Partial fix! - Was: Re: [BUG report] UML linux-2.6
	latest BK doesn't compile
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
Date: Sat, 5 Mar 2005 19:31:34 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Blaisorblade <blaisorblade@yahoo.it>, lkml <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Mar 05, 2005 at 02:45:18PM -0500, Jeff Dike wrote:
> aia21@cam.ac.uk said:
> > Yes.  I finally found a way to get it to compile.  Compiling without
> > TT mode and WITHOUT static build it still fails with the same problem
> > (__bb_init_func problem I already reported).  But compiling without TT
> > but WITH static build the __bb_init_func problem goes away but instead
> > I get a __gcov_init missing symbol in my modules.
> >
> > Note I have gcc-3.3.4-11 (SuSE 9.2) and it defines __gcov_init.  So I
> > added this as an export symbol and lo and behold the kernel and
> > modules compiled and I am now up an running with UML and NTFS as a
> > module.  (-: 
> 
> Can you try this patch?  It exports either __gcov_init or __bb_init_func
> depending on your gcc version.
> 
> 			Jeff
> 
> Index: linux-2.6.10/arch/um/kernel/gmon_syms.c
> ===================================================================
> --- linux-2.6.10.orig/arch/um/kernel/gmon_syms.c	2005-02-28 17:22:29.000000000 -0500
> +++ linux-2.6.10/arch/um/kernel/gmon_syms.c	2005-03-02 12:19:14.000000000 -0500
> @@ -5,8 +5,14 @@
>  
>  #include "linux/module.h"
>  
> +#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 3) || \
> +	(__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ > 4)

This line has to be something like

( (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4) && \
   HEAVILY_PATCHES_SUSE_GCC ) 


I hope SuSE has added some #define to distinguish what they call 
"gcc 3.3.4" from GNU gcc 3.3.4 ...


> +extern void __gcov_init(void *);
> +EXPORT_SYMBOL(__gcov_init);
> +#else
>  extern void __bb_init_func(void *);
>  EXPORT_SYMBOL(__bb_init_func);
> +#endif
>...

cu
Adrian

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
