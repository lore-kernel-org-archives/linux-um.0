Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyEmp-0005UO-N3 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2006 12:47:39 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EyEmn-0000UX-DJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2006 12:47:39 -0800
Message-Id: <200601152139.k0FLdm0G027742@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 8/11] UML - Eliminate some globals
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
Date: Sun, 15 Jan 2006 16:39:48 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Stop using global variables to hold the file descriptor and offset used to
map the skas0 stubs.  Instead, calculate them using the page physical 
addresses.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/skas/process.c	2006-01-09 11:39:54.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/skas/process.c	2006-01-09 11:40:33.000000000 -0500
@@ -151,8 +151,6 @@ static void handle_trap(int pid, union u
 }
 
 extern int __syscall_stub_start;
-int stub_code_fd = -1;
-__u64 stub_code_offset;
 
 static int userspace_tramp(void *stack)
 {
@@ -167,30 +165,30 @@ static int userspace_tramp(void *stack)
 		/* This has a pte, but it can't be mapped in with the usual
 		 * tlb_flush mechanism because this is part of that mechanism
 		 */
+		int fd;
+		__u64 offset;
+		fd = phys_mapping(to_phys(&__syscall_stub_start), &offset);
 		addr = mmap64((void *) UML_CONFIG_STUB_CODE, page_size(),
-			      PROT_EXEC, MAP_FIXED | MAP_PRIVATE,
-			      stub_code_fd, stub_code_offset);
+			      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
 		if(addr == MAP_FAILED){
-			printk("mapping stub code failed, errno = %d\n",
+			printk("mapping mmap stub failed, errno = %d\n",
 			       errno);
 			exit(1);
 		}
 
 		if(stack != NULL){
-			int fd;
-			__u64 offset;
 			fd = phys_mapping(to_phys(stack), &offset);
 			addr = mmap((void *) UML_CONFIG_STUB_DATA, page_size(),
 				    PROT_READ | PROT_WRITE,
 				    MAP_FIXED | MAP_SHARED, fd, offset);
 			if(addr == MAP_FAILED){
-				printk("mapping stub stack failed, "
+				printk("mapping segfault stack failed, "
 				       "errno = %d\n", errno);
 				exit(1);
 			}
 		}
 	}
-	if(!ptrace_faultinfo){
+	if(!ptrace_faultinfo && (stack != NULL)){
 		unsigned long v = UML_CONFIG_STUB_CODE +
 				  (unsigned long) stub_segv_handler -
 				  (unsigned long) &__syscall_stub_start;
@@ -216,10 +214,6 @@ int start_userspace(unsigned long stub_s
 	unsigned long sp;
 	int pid, status, n, flags;
 
-	if ( stub_code_fd == -1 )
-		stub_code_fd = phys_mapping(to_phys(&__syscall_stub_start),
-					    &stub_code_offset);
-
 	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
 		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if(stack == MAP_FAILED)
@@ -306,7 +300,6 @@ void userspace(union uml_pt_regs *regs)
 			        printk("userspace - child stopped with signal "
 				       "%d\n", WSTOPSIG(status));
 			}
-		    again:
 			pid = userspace_pid[0];
 			interrupt_end();
 
@@ -395,6 +388,9 @@ void map_stub_pages(int fd, unsigned lon
 {
 	struct proc_mm_op mmop;
 	int n;
+	__u64 code_offset;
+	int code_fd = phys_mapping(to_phys((void *) &__syscall_stub_start),
+				   &code_offset);
 
 	mmop = ((struct proc_mm_op) { .op        = MM_MMAP,
 				      .u         =
@@ -403,8 +399,8 @@ void map_stub_pages(int fd, unsigned lon
 					  .len     = PAGE_SIZE,
 					  .prot    = PROT_EXEC,
 					  .flags   = MAP_FIXED | MAP_PRIVATE,
-					  .fd      = stub_code_fd,
-					  .offset  = stub_code_offset
+					  .fd      = code_fd,
+					  .offset  = code_offset
 	} } });
 	n = os_write_file(fd, &mmop, sizeof(mmop));
 	if(n != sizeof(mmop))



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
