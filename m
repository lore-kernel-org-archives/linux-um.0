Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GU2fn-0005DR-BW for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 07:52:07 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GU2fk-0005Hb-AB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 07:52:07 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 1 Oct 2006 16:49:07 +0200
References: <200609251834.k8PIYWLu005031@ccure.user-mode-linux.org>
In-Reply-To: <200609251834.k8PIYWLu005031@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610011649.08382.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 3/8] UML - Fix missing x86_64 register
	definitions
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Monday 25 September 2006 20:34, Jeff Dike wrote:
> The UML/x86_64 headers were missing ptrace support for some segment
> registers. The underlying problem was that the x86_64 kernel uses
> user_regs_struct rather than the ptrace register definitions in ptrace. 
> This patch switches UML/x86_64 to using user_regs_struct for its
> definitions of the host's registers.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  arch/um/include/sysdep-x86_64/ptrace.h |   43 +++++++++++++++++++++--
>  arch/um/include/sysdep-x86_64/sc.h     |    2 -
>  include/asm-um/ptrace-x86_64.h         |    3 +
>  3 files changed, 44 insertions(+), 4 deletions(-)
>
> diff -puN
> arch/um/include/sysdep-x86_64/ptrace.h~uml-fix-missing-x86_64-register-defi
>nitions arch/um/include/sysdep-x86_64/ptrace.h ---
> a/arch/um/include/sysdep-x86_64/ptrace.h~uml-fix-missing-x86_64-register-de
>finitions +++ a/arch/um/include/sysdep-x86_64/ptrace.h
> @@ -50,6 +50,21 @@
>  #define HOST_FS 25
>  #define HOST_GS 26
>
> +/* Also defined in asm/ptrace-x86_64.h, but not in libc headers.  So,
> these + * are already defined for kernel code, but not for userspace code.
> + */
> +#ifndef FS_BASE
> +/* These aren't defined in ptrace.h, but exist in struct user_regs_struct,
> + * which is what x86_64 ptrace actually uses.
> + */
> +#define FS_BASE (HOST_FS_BASE * sizeof(long))
> +#define GS_BASE (HOST_GS_BASE * sizeof(long))
> +#define DS (HOST_DS * sizeof(long))
> +#define ES (HOST_ES * sizeof(long))
> +#define FS (HOST_FS * sizeof(long))
> +#define GS (HOST_GS * sizeof(long))
> +#endif
> +
>  #define REGS_FS_BASE(r) ((r)[HOST_FS_BASE])
>  #define REGS_GS_BASE(r) ((r)[HOST_GS_BASE])
>  #define REGS_DS(r) ((r)[HOST_DS])

> diff -puN
> include/asm-um/ptrace-x86_64.h~uml-fix-missing-x86_64-register-definitions
> include/asm-um/ptrace-x86_64.h ---
> a/include/asm-um/ptrace-x86_64.h~uml-fix-missing-x86_64-register-definition
>s +++ a/include/asm-um/ptrace-x86_64.h
> @@ -16,12 +16,15 @@
>
>  #define HOST_AUDIT_ARCH AUDIT_ARCH_X86_64
>
> +/* Also defined in sysdep/ptrace.h, so may already be defined. */
> +#ifndef FS_BASE
>  #define FS_BASE (21 * sizeof(unsigned long))
>  #define GS_BASE (22 * sizeof(unsigned long))
>  #define DS (23 * sizeof(unsigned long))
>  #define ES (24 * sizeof(unsigned long))
>  #define FS (25 * sizeof(unsigned long))
>  #define GS (26 * sizeof(unsigned long))
> +#endif
>
>  #define PT_REGS_RBX(r) UPT_RBX(&(r)->regs)
>  #define PT_REGS_RCX(r) UPT_RCX(&(r)->regs)

The patch is ok for me, but frankly, this hunk could be further cleaned up - 
there is an awful hardcoded duplication of code which could be removed (the 
definition could be split away from <sysdep/ptrace.h> if inclusion order hell 
starts).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
