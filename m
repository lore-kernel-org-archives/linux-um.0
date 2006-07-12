Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0hka-0000WR-6r for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 09:39:48 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G0hkY-0005p3-Lz
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 09:39:48 -0700
Message-Id: <200607121639.k6CGdrL4021226@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 12 Jul 2006 12:39:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/5] UML - tidy longjmp macro
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The UML_SETJMP macro was requiring its users to pass in a argument
which it could supply itself, since it wasn't used outside that
invocation of the macro.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/longjmp.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/longjmp.h	2006-07-12 11:29:00.000000000 -0400
+++ linux-2.6.17/arch/um/include/longjmp.h	2006-07-12 12:04:43.000000000 -0400
@@ -8,8 +8,8 @@
 	longjmp(*buf, val);	\
 } while(0)
 
-#define UML_SETJMP(buf, enable) ({ \
-	int n; \
+#define UML_SETJMP(buf) ({ \
+	int n, enable;	   \
 	enable = get_signals(); \
 	n = setjmp(*buf); \
 	if(n != 0) \
Index: linux-2.6.17/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/process.c	2006-07-12 11:29:00.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/process.c	2006-07-12 12:04:43.000000000 -0400
@@ -273,12 +273,12 @@ void init_new_thread_signals(void)
 int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr)
 {
 	jmp_buf buf;
-	int n, enable;
+	int n;
 
 	*jmp_ptr = &buf;
-	n = UML_SETJMP(&buf, enable);
+	n = UML_SETJMP(&buf);
 	if(n != 0)
-		return(n);
+		return n;
 	(*fn)(arg);
-	return(0);
+	return 0;
 }
Index: linux-2.6.17/arch/um/os-Linux/uaccess.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/uaccess.c	2006-07-12 11:29:00.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/uaccess.c	2006-07-12 12:04:43.000000000 -0400
@@ -14,11 +14,10 @@ unsigned long __do_user_copy(void *to, c
 					int n), int *faulted_out)
 {
 	unsigned long *faddrp = (unsigned long *) fault_addr, ret;
-	int enable;
 
 	jmp_buf jbuf;
 	*fault_catcher = &jbuf;
-	if(UML_SETJMP(&jbuf, enable) == 0){
+	if(UML_SETJMP(&jbuf) == 0){
 		(*op)(to, from, n);
 		ret = 0;
 		*faulted_out = 0;
Index: linux-2.6.17/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/skas/process.c	2006-07-12 11:29:00.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/skas/process.c	2006-07-12 12:04:43.000000000 -0400
@@ -435,7 +435,6 @@ void new_thread(void *stack, void **swit
 {
 	unsigned long flags;
 	jmp_buf switch_buf, fork_buf;
-	int enable;
 
 	*switch_buf_ptr = &switch_buf;
 	*fork_buf_ptr = &fork_buf;
@@ -450,7 +449,7 @@ void new_thread(void *stack, void **swit
 	 */
 	flags = get_signals();
 	block_signals();
-	if(UML_SETJMP(&fork_buf, enable) == 0)
+	if(UML_SETJMP(&fork_buf) == 0)
 		new_thread_proc(stack, handler);
 
 	remove_sigstack();
@@ -467,21 +466,19 @@ void new_thread(void *stack, void **swit
 void thread_wait(void *sw, void *fb)
 {
 	jmp_buf buf, **switch_buf = sw, *fork_buf;
-	int enable;
 
 	*switch_buf = &buf;
 	fork_buf = fb;
-	if(UML_SETJMP(&buf, enable) == 0)
+	if(UML_SETJMP(&buf) == 0)
 		siglongjmp(*fork_buf, INIT_JMP_REMOVE_SIGSTACK);
 }
 
 void switch_threads(void *me, void *next)
 {
 	jmp_buf my_buf, **me_ptr = me, *next_buf = next;
-	int enable;
 
 	*me_ptr = &my_buf;
-	if(UML_SETJMP(&my_buf, enable) == 0)
+	if(UML_SETJMP(&my_buf) == 0)
 		UML_LONGJMP(next_buf, 1);
 }
 
@@ -495,14 +492,14 @@ static jmp_buf *cb_back;
 int start_idle_thread(void *stack, void *switch_buf_ptr, void **fork_buf_ptr)
 {
 	jmp_buf **switch_buf = switch_buf_ptr;
-	int n, enable;
+	int n;
 
 	set_handler(SIGWINCH, (__sighandler_t) sig_handler,
 		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGALRM,
 		    SIGVTALRM, -1);
 
 	*fork_buf_ptr = &initial_jmpbuf;
-	n = UML_SETJMP(&initial_jmpbuf, enable);
+	n = UML_SETJMP(&initial_jmpbuf);
 	switch(n){
 	case INIT_JMP_NEW_THREAD:
 		new_thread_proc((void *) stack, new_thread_handler);
@@ -529,14 +526,13 @@ int start_idle_thread(void *stack, void 
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
 {
 	jmp_buf here;
-	int enable;
 
 	cb_proc = proc;
 	cb_arg = arg;
 	cb_back = &here;
 
 	block_signals();
-	if(UML_SETJMP(&here, enable) == 0)
+	if(UML_SETJMP(&here) == 0)
 		UML_LONGJMP(&initial_jmpbuf, INIT_JMP_CALLBACK);
 	unblock_signals();
 



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
