Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWQcz-0007Td-0i	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 19:46:33 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EWQcy-0007Ed-HQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 19:46:33 -0800
Message-Id: <200510310439.j9V4dMZO000839@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/10] UML - Fix syscall stubs
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
Date: Sun, 30 Oct 2005 23:39:22 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Jeff Dike noted that the assembly code for syscall stubs is misassembled with
GCC 3.2.3: the values copied in registers weren't preserved between one asm()
and the following one.

So I fixed the thing by rewriting the __asm__ constraints more
like unistd.h ones.

Note: in syscall6 case I had to add one more instruction (i.e. moving arg6 in
eax and shuffling things around) - it's needed for the function to be valid in
general (we can't load the value from the stack, relative to ebp, because we
change it), but could be avoided since we actually use a constant as param 6.

The only fix would be to turn stub_syscall6 to a macro and use a "i" constraint
for arg6 (i.e., specify it's a constant value).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>
---

 arch/um/include/sysdep-i386/stub.h   |   64 +++++++++++++++++++++++-----------
 arch/um/include/sysdep-x86_64/stub.h |   61 ++++++++++++++++++++++++++------
 2 files changed, 92 insertions(+), 33 deletions(-)

diff --git a/arch/um/include/sysdep-i386/stub.h b/arch/um/include/sysdep-i386/stub.h
--- a/arch/um/include/sysdep-i386/stub.h
+++ b/arch/um/include/sysdep-i386/stub.h
@@ -16,45 +16,69 @@ extern void stub_clone_handler(void);
 #define STUB_MMAP_NR __NR_mmap2
 #define MMAP_OFFSET(o) ((o) >> PAGE_SHIFT)
 
+static inline long stub_syscall1(long syscall, long arg1)
+{
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1));
+
+	return ret;
+}
+
 static inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
 
-	__asm__("movl %0, %%ecx; " : : "g" (arg2) : "%ecx");
-	__asm__("movl %0, %%ebx; " : : "g" (arg1) : "%ebx");
-	__asm__("movl %0, %%eax; " : : "g" (syscall) : "%eax");
-	__asm__("int $0x80;" : : : "%eax");
-	__asm__ __volatile__("movl %%eax, %0; " : "=g" (ret) :);
-	return(ret);
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
+			"c" (arg2));
+
+	return ret;
 }
 
 static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
 {
-	__asm__("movl %0, %%edx; " : : "g" (arg3) : "%edx");
-	return(stub_syscall2(syscall, arg1, arg2));
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
+			"c" (arg2), "d" (arg3));
+
+	return ret;
 }
 
 static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
 				 long arg4)
 {
-	__asm__("movl %0, %%esi; " : : "g" (arg4) : "%esi");
-	return(stub_syscall3(syscall, arg1, arg2, arg3));
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
+			"c" (arg2), "d" (arg3), "S" (arg4));
+
+	return ret;
+}
+
+static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
+				 long arg4, long arg5)
+{
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
+			"c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5));
+
+	return ret;
 }
 
 static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
 				 long arg4, long arg5, long arg6)
 {
 	long ret;
-	__asm__("movl %0, %%eax; " : : "g" (syscall) : "%eax");
-	__asm__("movl %0, %%ebx; " : : "g" (arg1) : "%ebx");
-	__asm__("movl %0, %%ecx; " : : "g" (arg2) : "%ecx");
-	__asm__("movl %0, %%edx; " : : "g" (arg3) : "%edx");
-	__asm__("movl %0, %%esi; " : : "g" (arg4) : "%esi");
-	__asm__("movl %0, %%edi; " : : "g" (arg5) : "%edi");
-	__asm__ __volatile__("pushl %%ebp ; movl %1, %%ebp; "
-		"int $0x80; popl %%ebp ; "
-		"movl %%eax, %0; " : "=g" (ret) : "g" (arg6) : "%eax");
-	return(ret);
+
+	__asm__ volatile ("push %%ebp ; movl %%eax,%%ebp ; movl %1,%%eax ; "
+			"int $0x80 ; pop %%ebp"
+			: "=a" (ret)
+			: "g" (syscall), "b" (arg1), "c" (arg2), "d" (arg3),
+			  "S" (arg4), "D" (arg5), "0" (arg6));
+
+	return ret;
 }
 
 static inline void trap_myself(void)
diff --git a/arch/um/include/sysdep-x86_64/stub.h b/arch/um/include/sysdep-x86_64/stub.h
--- a/arch/um/include/sysdep-x86_64/stub.h
+++ b/arch/um/include/sysdep-x86_64/stub.h
@@ -17,37 +17,72 @@ extern void stub_clone_handler(void);
 #define STUB_MMAP_NR __NR_mmap
 #define MMAP_OFFSET(o) (o)
 
+#define __syscall_clobber "r11","rcx","memory"
+#define __syscall "syscall"
+
 static inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
 
-	__asm__("movq %0, %%rsi; " : : "g" (arg2) : "%rsi");
-	__asm__("movq %0, %%rdi; " : : "g" (arg1) : "%rdi");
-	__asm__("movq %0, %%rax; " : : "g" (syscall) : "%rax");
-	__asm__("syscall;" : : : "%rax", "%r11", "%rcx");
-	__asm__ __volatile__("movq %%rax, %0; " : "=g" (ret) :);
-	return(ret);
+	__asm__ volatile (__syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2) : __syscall_clobber );
+
+	return ret;
 }
 
 static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
 {
-	__asm__("movq %0, %%rdx; " : : "g" (arg3) : "%rdx");
-	return(stub_syscall2(syscall, arg1, arg2));
+	long ret;
+
+	__asm__ volatile (__syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3)
+		: __syscall_clobber );
+
+	return ret;
 }
 
 static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
 				 long arg4)
 {
-	__asm__("movq %0, %%r10; " : : "g" (arg4) : "%r10");
-	return(stub_syscall3(syscall, arg1, arg2, arg3));
+	long ret;
+
+	__asm__ volatile ("movq %5,%%r10 ; " __syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3),
+		  "g" (arg4)
+		: __syscall_clobber, "r10" );
+
+	return ret;
+}
+
+static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
+				 long arg4, long arg5)
+{
+	long ret;
+
+	__asm__ volatile ("movq %5,%%r10 ; movq %6,%%r8 ; " __syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3),
+		  "g" (arg4), "g" (arg5)
+		: __syscall_clobber, "r10", "r8" );
+
+	return ret;
 }
 
 static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
 				 long arg4, long arg5, long arg6)
 {
-	__asm__("movq %0, %%r9; " : : "g" (arg6) : "%r9");
-	__asm__("movq %0, %%r8; " : : "g" (arg5) : "%r8");
-	return(stub_syscall4(syscall, arg1, arg2, arg3, arg4));
+	long ret;
+
+	__asm__ volatile ("movq %5,%%r10 ; movq %6,%%r8 ; "
+		"movq %7, %%r9; " __syscall : "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3),
+		  "g" (arg4), "g" (arg5), "g" (arg6)
+		: __syscall_clobber, "r10", "r8", "r9" );
+
+	return ret;
 }
 
 static inline void trap_myself(void)




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
