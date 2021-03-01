Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conuserg-08.nifty.com ([210.131.2.75])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGiQX-0008Kk-NU
 for linux-um@lists.infradead.org; Mon, 01 Mar 2021 13:17:37 +0000
From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6/7] x86/syscalls: use __NR_syscalls instead of
 __NR_syscall_max
Date: Mon,  1 Mar 2021 22:15:31 +0900
Message-Id: <20210301131533.64671-7-masahiroy@kernel.org>
In-Reply-To: <20210301131533.64671-1-masahiroy@kernel.org>
References: <20210301131533.64671-1-masahiroy@kernel.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: Johannes Berg <johannes.berg@intel.com>, Brian Gerst <brgerst@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

__NR_syscall_max is only used by x86 and UML in the following two files:

  - arch/um/kernel/skas/syscall.c
  - arch/x86/include/asm/unistd.h

In contrast, __NR_syscalls is widely used by all the architectures.

Let's convert __NR_syscall_max to __NR_syscalls by adding one.

This makes arch/x86/include/asm/unistd.h look cleaner, and also
prepares x86 to switch to the generic scripts/syscallhdr.sh from
arch/x86/entry/syscalls/syscallhdr.sh.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/um/kernel/skas/syscall.c         | 2 +-
 arch/x86/entry/syscalls/syscallhdr.sh | 2 +-
 arch/x86/include/asm/unistd.h         | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 3d91f89fd852..9ee19e566da3 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -41,7 +41,7 @@ void handle_syscall(struct uml_pt_regs *r)
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
-	if (syscall >= 0 && syscall <= __NR_syscall_max)
+	if (syscall >= 0 && syscall < __NR_syscalls)
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
 
diff --git a/arch/x86/entry/syscalls/syscallhdr.sh b/arch/x86/entry/syscalls/syscallhdr.sh
index cc1e63857427..75e66af06773 100644
--- a/arch/x86/entry/syscalls/syscallhdr.sh
+++ b/arch/x86/entry/syscalls/syscallhdr.sh
@@ -28,7 +28,7 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 
     echo ""
     echo "#ifdef __KERNEL__"
-    echo "#define __NR_${prefix}syscall_max $max"
+    echo "#define __NR_${prefix}syscalls $(($max + 1))"
     echo "#endif"
     echo ""
     echo "#endif /* ${fileguard} */"
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 1bc6020bc58d..80e9d5206a71 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -13,7 +13,7 @@
 #  define __ARCH_WANT_SYS_OLD_MMAP
 #  define __ARCH_WANT_SYS_OLD_SELECT
 
-#  define __NR_ia32_syscall_max __NR_syscall_max
+#  define IA32_NR_syscalls (__NR_syscalls)
 
 # else
 
@@ -26,12 +26,12 @@
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
-#  define X32_NR_syscalls (__NR_x32_syscall_max + 1)
+#  define X32_NR_syscalls (__NR_x32_syscalls)
+#  define IA32_NR_syscalls (__NR_ia32_syscalls)
 
 # endif
 
-# define NR_syscalls (__NR_syscall_max + 1)
-# define IA32_NR_syscalls (__NR_ia32_syscall_max + 1)
+# define NR_syscalls (__NR_syscalls)
 
 # define __ARCH_WANT_NEW_STAT
 # define __ARCH_WANT_OLD_READDIR
-- 
2.27.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

