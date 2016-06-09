Return-Path: <linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 14/14] um/ptrace: run seccomp after ptrace
Date: Thu,  9 Jun 2016 14:02:04 -0700
Message-Id: <1465506124-21866-15-git-send-email-keescook@chromium.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>, Chris Metcalf <cmetcalf@mellanox.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Hogan <james.hogan@imgtec.com>, Kees Cook <keescook@chromium.org>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, Jeff Dike <jdike@addtoit.com>, Andy Lutomirski <luto@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Maciej W. Rozycki" <macro@imgtec.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
 arch/um/kernel/skas/syscall.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 9c5570f0f397..ef4b8f949b51 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -20,12 +20,12 @@ void handle_syscall(struct uml_pt_regs *r)
 	UPT_SYSCALL_NR(r) = PT_SYSCALL_NR(r->gp);
 	PT_REGS_SET_SYSCALL_RETURN(regs, -ENOSYS);
 
-	/* Do the secure computing check first; failures should be fast. */
-	if (secure_computing(NULL) == -1)
+	if (syscall_trace_enter(regs))
 		return;
 
-	if (syscall_trace_enter(regs))
-		goto out;
+	/* Do the seccomp check after ptrace; failures should be fast. */
+	if (secure_computing(NULL) == -1)
+		return;
 
 	/* Update the syscall number after orig_ax has potentially been updated
 	 * with ptrace.
@@ -37,6 +37,5 @@ void handle_syscall(struct uml_pt_regs *r)
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
 
-out:
 	syscall_trace_leave(regs);
 }
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

