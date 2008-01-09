Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCj7W-00055i-TS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 14:09:59 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCj7V-0007x2-Qx
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 14:09:58 -0800
Received: from c2.user-mode-linux.org (littleton.addtoit.com [198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id m09M9stv000408
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 9 Jan 2008 17:09:54 -0500
Received: from c2.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by c2.user-mode-linux.org (8.14.1/8.13.8) with ESMTP id m09M9rkV009324
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 9 Jan 2008 17:09:53 -0500
Date: Wed, 9 Jan 2008 17:09:53 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080109220953.GA9129@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 7/9] SKAS4 - stub management preparation
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
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Tidy the existing stub code so that the skas4 code can be dropped in.

Index: linux-2.6-skas4/arch/um/os-Linux/skas/mem.c
===================================================================
--- linux-2.6-skas4.orig/arch/um/os-Linux/skas/mem.c	2008-01-09 15:10:48.000000000 -0500
+++ linux-2.6-skas4/arch/um/os-Linux/skas/mem.c	2008-01-09 15:57:25.000000000 -0500
@@ -40,35 +40,69 @@ static unsigned long syscall_regs[MAX_RE
 
 static int __init init_syscall_regs(void)
 {
+	unsigned long *stub_entry;
+
 	get_safe_registers(syscall_regs);
+	stub_entry = &batch_syscall_stub;
+
 	syscall_regs[REGS_IP_INDEX] = STUB_CODE +
-		((unsigned long) &batch_syscall_stub -
+		((unsigned long) stub_entry -
 		 (unsigned long) &__syscall_stub_start);
 	return 0;
 }
 
 __initcall(init_syscall_regs);
 
-extern int proc_mm;
+static int syscall_stub_done(unsigned long stack)
+{
+	unsigned long *syscall, *data, offset;
+	int ret, n;
+
+	/*
+	 * When the stub stops, we find the following values on the
+	 * beginning of the stack:
+	 * (long) return_value
+	 * (long) offset to failed sycall data (0 if no error)
+	 */
+	ret = *((unsigned long *) stack);
+	offset = *((unsigned long *) stack + 1);
+	if (offset == 0)
+		return 0;
 
-int single_count = 0;
-int multi_count = 0;
-int multi_op_count = 0;
+	data = (unsigned long *)(stack + offset - STUB_DATA);
+	printk(UM_KERN_ERR "syscall_stub_done : ret = %d, offset = %ld, "
+	       "data = %p\n", ret, offset, data);
+	syscall = (unsigned long *)((unsigned long)data + data[0]);
+	printk(UM_KERN_ERR "syscall_stub_done : syscall %ld failed, "
+	       "return value = 0x%x, expected return value = 0x%lx\n",
+	       syscall[0], ret, syscall[7]);
+	printk(UM_KERN_ERR "    syscall parameters: "
+	       "0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n",
+	       syscall[1], syscall[2], syscall[3],
+	       syscall[4], syscall[5], syscall[6]);
+	for (n = 1; n < data[0]/sizeof(long); n++) {
+		if (n == 1)
+			printk(UM_KERN_ERR "    additional syscall "
+			       "data:");
+		if (n % 4 == 1)
+			printk("\n" UM_KERN_ERR "      ");
+		printk("  0x%lx", data[n]);
+	}
+	if (n > 1)
+		printk("\n");
 
-static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
+	return ret;
+}
+
+static long do_syscall_stub(struct mm_id *mm_idp, void **addr)
 {
-	int n, i;
-	long ret, offset;
-	unsigned long * data;
-	unsigned long * syscall;
-	int err, pid = mm_idp->u.pid;
+	long ret;
+	int n, i, err, pid = mm_idp->u.pid;
 
 	if (proc_mm)
 		/* FIXME: Need to look up userspace_pid by cpu */
 		pid = userspace_pid[0];
 
-	multi_count++;
-
 	n = ptrace_setregs(pid, syscall_regs);
 	if (n < 0) {
 		printk(UM_KERN_ERR "Registers - \n");
@@ -85,52 +119,39 @@ static inline long do_syscall_stub(struc
 
 	wait_stub_done(pid);
 
-	/*
-	 * When the stub stops, we find the following values on the
-	 * beginning of the stack:
-	 * (long )return_value
-	 * (long )offset to failed sycall-data (0, if no error)
-	 */
-	ret = *((unsigned long *) mm_idp->stack);
-	offset = *((unsigned long *) mm_idp->stack + 1);
-	if (offset) {
-		data = (unsigned long *)(mm_idp->stack + offset - STUB_DATA);
-		printk(UM_KERN_ERR "do_syscall_stub : ret = %ld, offset = %ld, "
-		       "data = %p\n", ret, offset, data);
-		syscall = (unsigned long *)((unsigned long)data + data[0]);
-		printk(UM_KERN_ERR "do_syscall_stub: syscall %ld failed, "
-		       "return value = 0x%lx, expected return value = 0x%lx\n",
-		       syscall[0], ret, syscall[7]);
-		printk(UM_KERN_ERR "    syscall parameters: "
-		       "0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n",
-		       syscall[1], syscall[2], syscall[3],
-		       syscall[4], syscall[5], syscall[6]);
-		for (n = 1; n < data[0]/sizeof(long); n++) {
-			if (n == 1)
-				printk(UM_KERN_ERR "    additional syscall "
-				       "data:");
-			if (n % 4 == 1)
-				printk("\n" UM_KERN_ERR "      ");
-			printk("  0x%lx", data[n]);
-		}
-		if (n > 1)
-			printk("\n");
-	}
-	else ret = 0;
+	ret = syscall_stub_done(mm_idp->stack);
 
 	*addr = check_init_stack(mm_idp, NULL);
 
 	return ret;
 }
 
-long run_syscall_stub(struct mm_id * mm_idp, int syscall,
+static int flush_syscalls(struct mm_id *mm_idp, void **addr, int extra)
+{
+	unsigned long *stack = check_init_stack(mm_idp, *addr);
+	int current, end;
+
+	current = ((unsigned long) stack) & ~UM_KERN_PAGE_MASK;
+	end = UM_KERN_PAGE_SIZE;
+
+	if (current + (10 + extra) * sizeof(long) < end)
+		return 0;
+
+	return do_syscall_stub(mm_idp, addr);
+}
+
+long run_syscall_stub(struct mm_id *mm_idp, int syscall,
 		      unsigned long *args, long expected, void **addr,
 		      int done)
 {
-	unsigned long *stack = check_init_stack(mm_idp, *addr);
+	unsigned long *stack;
+	int ret;
 
-	if (done && *addr == NULL)
-		single_count++;
+	ret = flush_syscalls(mm_idp, addr, 0);
+	if (ret)
+		return ret;
+
+	stack = check_init_stack(mm_idp, *addr);
 
 	*stack += sizeof(long);
 	stack += *stack / sizeof(long);
@@ -144,45 +165,32 @@ long run_syscall_stub(struct mm_id * mm_
 	*stack++ = args[5];
 	*stack++ = expected;
 	*stack = 0;
-	multi_op_count++;
 
-	if (!done && ((((unsigned long) stack) & ~UM_KERN_PAGE_MASK) <
-		     UM_KERN_PAGE_SIZE - 10 * sizeof(long))) {
-		*addr = stack;
-		return 0;
-	}
+	if (done)
+		return do_syscall_stub(mm_idp, addr);
 
-	return do_syscall_stub(mm_idp, addr);
+	*addr = stack;
+
+	return 0;
 }
 
-long syscall_stub_data(struct mm_id * mm_idp,
-		       unsigned long *data, int data_count,
-		       void **addr, void **stub_addr)
+long syscall_stub_data(struct mm_id *mm_idp, unsigned long *data,
+		       int data_count, void **addr, void **stub_addr)
 {
 	unsigned long *stack;
-	int ret = 0;
+	int ret;
 
-	/*
-	 * If *addr still is uninitialized, it *must* contain NULL.
-	 * Thus in this case do_syscall_stub correctly won't be called.
-	 */
-	if ((((unsigned long) *addr) & ~UM_KERN_PAGE_MASK) >=
-	   UM_KERN_PAGE_SIZE - (10 + data_count) * sizeof(long)) {
-		ret = do_syscall_stub(mm_idp, addr);
-		/* in case of error, don't overwrite data on stack */
-		if (ret)
-			return ret;
-	}
+	ret = flush_syscalls(mm_idp, addr, data_count);
+	if (ret)
+		return ret;
 
 	stack = check_init_stack(mm_idp, *addr);
-	*addr = stack;
-
-	*stack = data_count * sizeof(long);
+	*stack++ = data_count * sizeof(long);
 
-	memcpy(stack + 1, data, data_count * sizeof(long));
+	memcpy(stack, data, data_count * sizeof(long));
 
-	*stub_addr = (void *)(((unsigned long)(stack + 1) &
-			       ~UM_KERN_PAGE_MASK) + STUB_DATA);
+	*stub_addr = (void *)(((unsigned long) stack & ~UM_KERN_PAGE_MASK) +
+			      STUB_DATA);
 
 	return 0;
 }

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
