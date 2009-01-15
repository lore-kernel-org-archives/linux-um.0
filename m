Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1LNS1q-0006PU-1T
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Jan 2009 13:12:58 +0000
Received: from ti-out-0910.google.com ([209.85.142.185])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LNS1k-0007U5-O8 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Jan 2009 13:12:58 +0000
Received: by ti-out-0910.google.com with SMTP id y6so770836tia.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Jan 2009 05:12:50 -0800 (PST)
Date: Thu, 15 Jan 2009 19:40:33 +0000
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20090115194033.GA10926@hack.private>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [Patch] uml: fix a link error
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net


This patch fixes the following link error:

  LD      .tmp_vmlinux1                                             
  arch/um/sys-i386/built-in.o: In function sys_call_table':          
  (.rodata+0x308): undefined reference to sys_sigprocmask'           
  collect2: ld returned 1 exit status                                 
   KSYM    .tmp_kallsyms1.S                                          
   nm: '.tmp_vmlinux1': No such file                                   
   AS      .tmp_kallsyms1.o                                          
   LD      .tmp_vmlinux2 
   arch/um/sys-i386/built-in.o: In function sys_call_table':  
  (.rodata+0x308): undefined reference to sys_sigprocmask'  
  collect2: ld returned 1 exit status   
  make[1]: *** [.tmp_vmlinux2] Error 1   
  make: *** [sub-make] Error 2                               


Signed-off-by: WANG Cong <wangcong@zeuux.org>
Cc: Jeff Dike <jdike@addtoit.com>

---
diff --git a/arch/um/sys-i386/sys_call_table.S b/arch/um/sys-i386/sys_call_table.S
index 00e5f52..04147dc 100644
--- a/arch/um/sys-i386/sys_call_table.S
+++ b/arch/um/sys-i386/sys_call_table.S
@@ -6,6 +6,7 @@
 
 #define sys_vm86old sys_ni_syscall
 #define sys_vm86 sys_ni_syscall
+#define sys_sigprocmask sigprocmask
 
 #define old_mmap old_mmap_i386
 







------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
