Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFqWV-0002mv-6M	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 02:59:19 -0700
Received: from gprs189-60.eurotel.cz
	([160.218.189.60] helo=amd.ucw.cz ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFqWD-0000VT-HM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 02:59:19 -0700
From: Pavel Machek <pavel@suse.cz>
Message-ID: <20050915095828.GE7880@elf.ucw.cz>
References: <200509142155.j8ELtm5c012124@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509142155.j8ELtm5c012124@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: [PATCH 1/10] UML - _switch_to code consolidation
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
Date: Thu, 15 Sep 2005 11:58:28 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Allan Graves <allan.graves@gmail.com>

Hi!

> This patch moves code that is in both switch_to_tt and
> switch_to_skas to the top level _switch_to function, keeping us from
> duplicating code.  It is required for the stack trace patch to work
> properly.
> 
> Signed-off-by: Allan Graves <allan.graves@gmail.com>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Index: linux-2.6.13/arch/um/kernel/process_kern.c
> ===================================================================
> --- linux-2.6.13.orig/arch/um/kernel/process_kern.c	2005-09-13 16:04:11.000000000 -0400
> +++ linux-2.6.13/arch/um/kernel/process_kern.c	2005-09-13 16:08:18.000000000 -0400
> @@ -113,8 +113,16 @@
>  
>  void *_switch_to(void *prev, void *next, void *last)
>  {
> -	return(CHOOSE_MODE(switch_to_tt(prev, next), 
> -			   switch_to_skas(prev, next)));
> +        struct task_struct *from = prev;
> +        struct task_struct *to= next;
> +
> +        to->thread.prev_sched = from;
> +        set_current(to);
> +
> +	CHOOSE_MODE_PROC(switch_to_tt, switch_to_skas, prev, next);
> +
> +        return(current->thread.prev_sched); 
> +
>  }

I sense a whitespace damage here.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
