Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOeYh-00017R-Cu for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 13:15:35 -0700
Received: from smtpout3.tre.se ([80.251.192.228])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOeYf-0000jH-Iw
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 13:15:35 -0700
Date: Thu, 31 Jul 2008 22:16:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20080731201602.GC25158@uranus.ravnborg.org>
References: <20080731121028.GA23636@hack.voiplan.pt>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080731121028.GA23636@hack.voiplan.pt>
Subject: Re: [uml-devel] [Patch] UML build: fix missing posix_types.h
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org

On Thu, Jul 31, 2008 at 01:10:28PM +0100, WANG Cong wrote:
> 
> When building UML with 'O=foo' specified, I got:
> 
> CC      kernel/bounds.s
>   In file included from
> /home/wangcong/Projects/linux-2.6/include/linux/types.h:11,
>                  from
> /home/wangcong/Projects/linux-2.6/include/linux/page-flags.h:8,
>                  from
> /home/wangcong/Projects/linux-2.6/kernel/bounds.c:9:
> /home/wangcong/Projects/linux-2.6/include/linux/posix_types.h:47:29:
> error: asm/posix_types.h: No such file or directory
> In file included from
> /home/wangcong/Projects/linux-2.6/include/linux/page-flags.h:8,
>                  from
> /home/wangcong/Projects/linux-2.6/kernel/bounds.c:9:
> /home/wangcong/Projects/linux-2.6/include/linux/types.h:12:23: error:
> asm/types.h: No such file or directory
> In file included from
> /home/wangcong/Projects/linux-2.6/include/linux/page-flags.h:8,
> 
> Below patch fixed it, note, it is only tested for x86 and um.
> 
> Signed-off-by: WANG Cong <wangcong@zeuux.org>
> Cc: sam@ravnborg.org
> Cc: jdike@addtoit.com
> 
> ---
> diff --git a/Makefile b/Makefile
> index aa527a4..39130d1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -930,7 +930,8 @@ ifneq ($(KBUILD_SRC),)
>  		/bin/false; \
>  	fi;
>  	$(Q)if [ ! -d include2 ]; then mkdir -p include2; fi;
> -	$(Q)if [ -e $(srctree)/include/asm-$(SRCARCH)/system.h ]; then  \
> +	$(Q)if [ -e $(srctree)/include/asm-$(SRCARCH)/system.h -o \
> +		 -e $(objtree)/include/asm-$(SRCARCH)/system.h ] ; then \
>  	    ln -fsn $(srctree)/include/asm-$(SRCARCH) include2/asm;     \
>  	    fi
>  endif

I have a similar patch locally. I just check for errno.h so I 
do not have to do the extra check in objtree.
Will push tonight.

	Sam

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
