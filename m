Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AbO94-00034f-Jl
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 09:59:06 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AbO94-0006Tw-1K
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 09:59:06 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Message-Id: <200312301748.41073.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2xa8/CFeqBufJGV"
Subject: [uml-devel] Debian "modify_ldt_ldt_s undeclared" problem fix
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
Date: Tue, 30 Dec 2003 17:48:54 +0100
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_2xa8/CFeqBufJGV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Debian (IIRC, the unstable one) has started putting 2.6 headers in 
/usr/include/asm, and this has given a compilation error with UML. Attached 
there is a fix for 2.6, which makes the source detect and use the correct 
structure name. So this patch doesn't hurt who hasn't that problem.

For 2.4 I'm not attaching a fix since the code has been commented out in 
2.4.23-1um (the comment says this doesn't work in TT mode, but making the 
code a no-op for TT mode is easy). The idea comes from the hostfs Makefile.

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



--Boundary-00=_2xa8/CFeqBufJGV
Content-Type: text/x-diff;
  charset="us-ascii";
  name="D-04-Debian_workaround.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="D-04-Debian_workaround.patch"

--- ./arch/um/sys-i386/Makefile.Debian	2003-12-30 16:44:42.000000000 +0100
+++ ./arch/um/sys-i386/Makefile	2003-12-30 17:31:22.000000000 +0100
@@ -1,6 +1,10 @@
 obj-y = bugs.o checksum.o extable.o fault.o ksyms.o ldt.o ptrace.o \
 	ptrace_user.o semaphore.o sigcontext.o syscalls.o sysrq.o
 
+# The kernel 2.6 renamed struct modify_ldt_ldt_s (its name in 2.4) as
+# struct user_desc. I hope that glibc will fix this, but for now this workaround is included.
+CFLAGS_bugs.o = -DLDT_STRUCT_NAME=$(shell if grep -q user_desc /usr/include/asm/ldt.h ; then echo user_desc; else echo modify_ldt_ldt_s; fi)
+
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
 
--- ./arch/um/sys-i386/bugs.c.Debian	2003-12-28 12:51:48.000000000 +0100
+++ ./arch/um/sys-i386/bugs.c	2003-12-30 17:31:22.000000000 +0100
@@ -105,9 +105,12 @@
 	return(1);
 }
 
+extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
+
 static void disable_lcall(void)
 {
-	struct modify_ldt_ldt_s ldt;
+	/*See Makefile comments for why we use LDT_STRUCT_NAME*/
+	struct LDT_STRUCT_NAME ldt;
 	int err;
 
 	bzero(&ldt, sizeof(ldt));

--Boundary-00=_2xa8/CFeqBufJGV--




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
