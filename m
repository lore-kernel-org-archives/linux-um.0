Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.58.0312181209230.1327@earth>
Message-ID: <Pine.LNX.4.58.0312181253460.2378@earth>
References: <Pine.LNX.4.58.0312171735540.8123@earth>
 <20031217174901.GA6709@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312171924290.12482@earth>
  <Pine.LNX.4.58.0312172249020.19508@earth>  <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org>
 <Pine.LNX.4.58.0312181036220.31295@earth> <Pine.LNX.4.58.0312181122070.32554@earth>
 <Pine.LNX.4.58.0312181209230.1327@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: [patch] host-skas support for 2.6.0, other UML fixes
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 18 Dec 2003 12:56:36 +0100 (CET)
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net


the attached patch is necessary in addition to the previous ones, to get a
unified 2.6.0 UML tree: both UML and the host-kernel can be compiled
cleanly from the same tree.

To 'replicate' an existing tree, i use the following method:

	cd linux-host
	make mrproper
	cd ..
	cp -rl linux-host linux-UML

this creates a hard-linked clone of the kernel tree. Now the linux-host
kernel and the linux-UML kernels can be configured & compiled
independently. Any change to an existing source file in one tree will
affect the other tree too.

	Ingo

--- linux/arch/um/kernel/ptrace.c.orig	
+++ linux/arch/um/kernel/ptrace.c	
@@ -24,11 +24,6 @@ void ptrace_disable(struct task_struct *
 { 
 }
 
-extern long do_mmap2(struct task_struct *task, unsigned long addr, 
-		     unsigned long len, unsigned long prot, 
-		     unsigned long flags, unsigned long fd,
-		     unsigned long pgoff);
-
 int sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
--- linux/arch/um/include/skas_ptrace.h.orig	
+++ linux/arch/um/include/skas_ptrace.h	
@@ -6,6 +6,10 @@
 #ifndef __SKAS_PTRACE_H
 #define __SKAS_PTRACE_H
 
+
+#ifndef _LINUX_PTRACE_STRUCT_DEF
+#define _LINUX_PTRACE_STRUCT_DEF
+
 struct ptrace_faultinfo {
 	int is_write;
 	unsigned long addr;
@@ -17,6 +21,8 @@ struct ptrace_ldt {
 	unsigned long bytecount;
 };
 
+#endif
+
 #define PTRACE_FAULTINFO 52
 #define PTRACE_SIGPENDING 53
 #define PTRACE_LDT 54
--- linux/include/linux/ptrace.h.orig	
+++ linux/include/linux/ptrace.h	
@@ -26,6 +26,10 @@
 #define PTRACE_LDT		  54
 #define PTRACE_SWITCH_MM 	  55
 
+
+#ifndef _LINUX_PTRACE_STRUCT_DEF
+#define _LINUX_PTRACE_STRUCT_DEF
+
 struct ptrace_faultinfo {
 	int is_write;
 	unsigned long addr;
@@ -37,6 +41,8 @@ struct ptrace_ldt {
 	unsigned long bytecount;
 };
 
+#endif
+
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
 #define PTRACE_GETEVENTMSG	0x4201


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
