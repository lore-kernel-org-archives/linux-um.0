Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KLkUz-000426-FI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Jul 2008 12:59:45 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KLkUz-0002jy-7Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Jul 2008 12:59:45 -0700
Date: Wed, 23 Jul 2008 12:59:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20080723125925.6ac68198.akpm@linux-foundation.org>
In-Reply-To: <20080723154650.GA15682@c2.user-mode-linux.org>
References: <20080723154650.GA15682@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] UML - Fix boot crash
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
Cc: akpm@linuxfoundation.org, torvalds@linux-foundation.org, stable@kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, 23 Jul 2008 11:46:50 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> My copying of linux/init.h didn't go far enough.  The definition of
> __used singled out gcc minor version 3, but didn't care what the major
> version was.  This broke when unit-at-a-time was added and gcc started
> throwing out initcalls.
> 
> This results in an early boot crash when ptrace tries to initialize a
> process with an empty, uninitialized register set.
> 
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> ---
>  arch/um/include/init.h |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> Index: linux-2.6.22/arch/um/include/init.h
> ===================================================================
> --- linux-2.6.22.orig/arch/um/include/init.h	2008-02-18 11:53:50.000000000 -0500
> +++ linux-2.6.22/arch/um/include/init.h	2008-07-20 18:06:35.000000000 -0400
> @@ -45,6 +45,8 @@ typedef void (*exitcall_t)(void);
>  # define __section(S) __attribute__ ((__section__(#S)))
>  #endif
>  
> +#if __GNUC__ == 3
> +
>  #if __GNUC_MINOR__ >= 3
>  # define __used			__attribute__((__used__))
>  #else
> @@ -52,6 +54,12 @@ typedef void (*exitcall_t)(void);
>  #endif
>  
>  #else
> +#if __GNUC__ == 4
> +# define __used			__attribute__((__used__))
> +#endif
> +#endif
> +
> +#else
>  #include <linux/compiler.h>
>  #endif
>  /* These are for everybody (although not all archs will actually

Needed in 2.6.26.x, but also applies to 2.6.25.  Is it also needed in
2.6.25.x?


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
