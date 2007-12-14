Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J3EoX-0003TZ-TF for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Dec 2007 09:59:09 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J3EoW-0005Ui-Jh
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Dec 2007 09:59:09 -0800
Date: Fri, 14 Dec 2007 09:58:40 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20071214095840.28736204.akpm@linux-foundation.org>
In-Reply-To: <20071214161647.GA5802@c2.user-mode-linux.org>
References: <20071214161647.GA5802@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] UML - Add asm/fixmap.h include
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
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 14 Dec 2007 11:16:47 -0500 Jeff Dike <jdike@addtoit.com> wrote:

> [ This needs to go into 2.6.24, as it fixes a build breakage seen on x86_64 ]
> 
> um_uaccess.h refers to FIXADDR_USER_*, so it should include fixmap.h.
> 
> I also changed the non-UML includes to use <> instead of "".
> 
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> ---
>  arch/um/include/um_uaccess.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.22/arch/um/include/um_uaccess.h
> ===================================================================
> --- linux-2.6.22.orig/arch/um/include/um_uaccess.h	2007-12-13 10:09:22.000000000 -0500
> +++ linux-2.6.22/arch/um/include/um_uaccess.h	2007-12-13 15:11:42.000000000 -0500
> @@ -6,7 +6,8 @@
>  #ifndef __ARCH_UM_UACCESS_H
>  #define __ARCH_UM_UACCESS_H
>  
> -#include "asm/elf.h"
> +#include <asm/elf.h>
> +#include <asm/fixmap.h>
>  #include "sysdep/archsetjmp.h"
>  
>  #define __under_task_size(addr, size) \

arch/um/include/um_uaccess.h already includes fixmap.h.  Is this a -mm-only
fix?


-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
