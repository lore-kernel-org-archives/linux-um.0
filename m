Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 20 Apr 2010 18:10:56 +0800
From: Amerigo Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 4/5] uml: i386: Avoid redefinition of NR_syscalls
Message-ID: <20100420101056.GC5317@cr0.nay.redhat.com>
References: <cover.1271713955.git.jan.kiszka@web.de>
 <3e07ad1a38e88a22d7298deb88a8f3962b101998.1271713955.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e07ad1a38e88a22d7298deb88a8f3962b101998.1271713955.git.jan.kiszka@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Apr 19, 2010 at 11:53:07PM +0200, Jan Kiszka wrote:
>The i386 subarch happens to pull in original NR_syscalls. Maybe we can
>make that work for all host arch, but for now just avoid the clash by
>using an all-upper-case name.
>

Where?


>Signed-off-by: Jan Kiszka <jan.kiszka@web.de>
>---
> arch/um/kernel/skas/syscall.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
>index 4e3b820..f5173e1 100644
>--- a/arch/um/kernel/skas/syscall.c
>+++ b/arch/um/kernel/skas/syscall.c
>@@ -10,7 +10,7 @@
> #include "sysdep/syscalls.h"
> 
> extern int syscall_table_size;
>-#define NR_syscalls (syscall_table_size / sizeof(void *))
>+#define NR_SYSCALLS (syscall_table_size / sizeof(void *))
> 
> void handle_syscall(struct uml_pt_regs *r)
> {
>@@ -30,7 +30,7 @@ void handle_syscall(struct uml_pt_regs *r)
> 	 * in case it's a compiler bug.
> 	 */
> 	syscall = UPT_SYSCALL_NR(r);
>-	if ((syscall >= NR_syscalls) || (syscall < 0))
>+	if ((syscall >= NR_SYSCALLS) || (syscall < 0))
> 		result = -ENOSYS;
> 	else result = EXECUTE_SYSCALL(syscall, regs);
> 
>-- 
>1.6.0.2
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
