Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <heiko.carstens@de.ibm.com>) id 1LVls7-0007o7-HJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 12:01:19 +0000
Received: from mtagate7.de.ibm.com ([195.212.29.156])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LVls2-0000c2-EJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 12:01:19 +0000
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id n17BxxIU615550
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 7 Feb 2009 11:59:59 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id n17BxxdS671942
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 7 Feb 2009 12:59:59 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n17BxwW7008761 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 7 Feb 2009 12:59:59 +0100
Date: Sat, 7 Feb 2009 12:59:56 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20090207125956.110591c9@osiris.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0902042150550.25136@anakin>
References: <20090115194033.GA10926@hack.private>
	<20090116124158.4364e269.akpm@linux-foundation.org>
	<200901170328.15178.rob@landley.net>
	<dc84318c0901172223p57872a8cr227d940b1c0a908a@mail.gmail.com>
	<20090119152104.GC6432@c2.user-mode-linux.org>
	<dc84318c0901191746g31d51c23g65da89190dc8bfd2@mail.gmail.com>
	<49753063.8040007@hathawaymix.org>
	<alpine.LRH.2.00.0902041803360.7690@vixen.sonytel.be>
	<Pine.LNX.4.64.0902042115530.25136@anakin>
	<20090204204009.GA10680@suse.de>
	<Pine.LNX.4.64.0902042150550.25136@anakin>
Mime-Version: 1.0
Subject: Re: [uml-devel] [Patch] uml: fix a link error
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Greg KH <gregkh@suse.de>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Rob Landley <rob@landley.net>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Am?rico Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Shane Hathaway <shane@hathawaymix.org>, Daolong Wang <ahlongxp@gmail.com>, stable@kernel.org

On Wed, 4 Feb 2009 21:54:12 +0100 (CET)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> I verified that Shane's solution:
> 
> #define sys_sigprocmask sys_kernel_sigprocmask
> 
> works for me, but that's definitely not the cleanest way.
> 
> Al Viro also had a suggestion to rework the SYSCALL_DEFINE* macros, but I
> haven't tried it yet.


Patch below should fix it.


Subject: [PATCH] syscall define: fix uml compile bug

From: Heiko Carstens <heiko.carstens@de.ibm.com>

With the new system call defines we get this on uml:

arch/um/sys-i386/built-in.o: In function `sys_call_table':
(.rodata+0x308): undefined reference to `sys_sigprocmask'

Reason for this is that uml passes the preprocessor option
-Dsigprocmask=kernel_sigprocmask to gcc when compiling the kernel.
This causes SYSCALL_DEFINE3(sigprocmask, ...) to be expanded to
SYSCALL_DEFINEx(3, kernel_sigprocmask, ...) and finally to a system call
named sys_kernel_sigprocmask. However sys_sigprocmask is missing because
of this.
To avoid macro expansion for the system call name just concatenate the
name at first define instead of carrying it through severel levels.
This was pointed out by Al Viro.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/linux/syscalls.h |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

Index: linux-2.6/include/linux/syscalls.h
===================================================================
--- linux-2.6.orig/include/linux/syscalls.h
+++ linux-2.6/include/linux/syscalls.h
@@ -95,13 +95,13 @@ struct old_linux_dirent;
 #define __SC_TEST5(t5, a5, ...)	__SC_TEST(t5); __SC_TEST4(__VA_ARGS__)
 #define __SC_TEST6(t6, a6, ...)	__SC_TEST(t6); __SC_TEST5(__VA_ARGS__)
 
-#define SYSCALL_DEFINE0(name)   asmlinkage long sys_##name(void)
-#define SYSCALL_DEFINE1(...)    SYSCALL_DEFINEx(1, __VA_ARGS__)
-#define SYSCALL_DEFINE2(...)    SYSCALL_DEFINEx(2, __VA_ARGS__)
-#define SYSCALL_DEFINE3(...)    SYSCALL_DEFINEx(3, __VA_ARGS__)
-#define SYSCALL_DEFINE4(...)    SYSCALL_DEFINEx(4, __VA_ARGS__)
-#define SYSCALL_DEFINE5(...)    SYSCALL_DEFINEx(5, __VA_ARGS__)
-#define SYSCALL_DEFINE6(...)    SYSCALL_DEFINEx(6, __VA_ARGS__)
+#define SYSCALL_DEFINE0(name)	   asmlinkage long sys_##name(void)
+#define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
+#define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
+#define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
+#define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
+#define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
+#define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
 
 #ifdef CONFIG_PPC64
 #define SYSCALL_ALIAS(alias, name)					\
@@ -121,21 +121,21 @@ struct old_linux_dirent;
 
 #define SYSCALL_DEFINE(name) static inline long SYSC_##name
 #define SYSCALL_DEFINEx(x, name, ...)					\
-	asmlinkage long sys_##name(__SC_DECL##x(__VA_ARGS__));		\
-	static inline long SYSC_##name(__SC_DECL##x(__VA_ARGS__));	\
-	asmlinkage long SyS_##name(__SC_LONG##x(__VA_ARGS__))		\
+	asmlinkage long sys##name(__SC_DECL##x(__VA_ARGS__));		\
+	static inline long SYSC##name(__SC_DECL##x(__VA_ARGS__));	\
+	asmlinkage long SyS##name(__SC_LONG##x(__VA_ARGS__))		\
 	{								\
 		__SC_TEST##x(__VA_ARGS__);				\
-		return (long) SYSC_##name(__SC_CAST##x(__VA_ARGS__));	\
+		return (long) SYSC##name(__SC_CAST##x(__VA_ARGS__));	\
 	}								\
-	SYSCALL_ALIAS(sys_##name, SyS_##name);				\
-	static inline long SYSC_##name(__SC_DECL##x(__VA_ARGS__))
+	SYSCALL_ALIAS(sys##name, SyS##name);				\
+	static inline long SYSC##name(__SC_DECL##x(__VA_ARGS__))
 
 #else /* CONFIG_HAVE_SYSCALL_WRAPPERS */
 
 #define SYSCALL_DEFINE(name) asmlinkage long sys_##name
 #define SYSCALL_DEFINEx(x, name, ...)					\
-	asmlinkage long sys_##name(__SC_DECL##x(__VA_ARGS__))
+	asmlinkage long sys##name(__SC_DECL##x(__VA_ARGS__))
 
 #endif /* CONFIG_HAVE_SYSCALL_WRAPPERS */
 

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
