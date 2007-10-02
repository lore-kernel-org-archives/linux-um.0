Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IcbTK-0007IY-3h for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 23:43:10 -0700
Received: from astra.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IcbTJ-0005vc-FB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 23:43:10 -0700
Date: Tue, 2 Oct 2007 08:43:00 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <20071001212306.GA10113@c2.user-mode-linux.org>
Message-ID: <Pine.LNX.4.64.0710020841411.28398@anakin>
References: <20071001212306.GA10113@c2.user-mode-linux.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/3] UML - Fix stub address calculations
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
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Magotari@gail.com

On Mon, 1 Oct 2007, Jeff Dike wrote:
> The Kconfig language seems not to allow calculation of hex constants,
> so I moved this to as-layout.h.  CONFIG_STUB_CODE, CONFIG_STUB_DATA,
> and CONFIG_STUB_START are now gone.  In their place are STUB_CODE,
> STUB_DATA, and STUB_START in as-layout.h.

Hmm, perhaps you can use _AC() (from <linux/const.h>) to defined the original
constants instead, so you don't need the #ifdefs?

> --- linux-2.6.22.orig/arch/um/include/as-layout.h	2007-09-27 11:47:22.000000000 -0400
> +++ linux-2.6.22/arch/um/include/as-layout.h	2007-10-01 16:41:26.000000000 -0400
> @@ -6,6 +6,28 @@
>  #ifndef __START_H__
>  #define __START_H__
>  
> +#include "uml-config.h"
> +#include "kern_constants.h"
> +
> +/*
> + * Assembly doesn't want any casting, but C does, so define these
> + * without casts here, and define new symbols with casts inside the C
> + * section.
> + */
> +#define ASM_STUB_CODE (UML_CONFIG_TOP_ADDR - 2 * UM_KERN_PAGE_SIZE)
> +#define ASM_STUB_DATA (UML_CONFIG_TOP_ADDR - UM_KERN_PAGE_SIZE)
> +#define ASM_STUB_START ASM_STUB_CODE
> +
> +/*
> + * This file is included by the assembly stubs, which just want the
> + * definitions above.
> + */
> +#ifndef __ASSEMBLY__
> +
> +#define STUB_CODE ((unsigned long) ASM_STUB_CODE)
> +#define STUB_DATA ((unsigned long) ASM_STUB_DATA)
> +#define STUB_START ((unsigned long) ASM_STUB_START)
> +
>  #include "sysdep/ptrace.h"
>  
>  struct cpu_task {
> @@ -32,3 +54,5 @@ extern int linux_main(int argc, char **a
>  extern void (*sig_info[])(int, struct uml_pt_regs *);
>  
>  #endif
> +
> +#endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
