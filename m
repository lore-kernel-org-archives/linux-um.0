Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuzAA-00071q-D7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jun 2006 15:02:34 -0700
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FuzA8-0004Rv-Ta
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jun 2006 15:02:34 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5QM2RVP006948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 26 Jun 2006 18:02:27 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5QM2f6U143974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 26 Jun 2006 16:02:41 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5QM2Qhl023765 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 26 Jun 2006 16:02:26 -0600
Date: Mon, 26 Jun 2006 15:02:34 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
Message-ID: <20060626220234.GG4223@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] Fix UML build on i386 Ubuntu Dapper
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
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi Jeff,

I run an x86_64 kernel with i386 userspace (Ubuntu Dapper) and decided
to try out UML today. I found that UML wasn't quite aware of biarch
compilers (which Ubuntu i386 ships). A fix similar to what was done for
x86_64 should probably be committed (see
http://marc.theaimsgroup.com/?l=linux-kernel&m=113425940204010&w=2).
Without the FLAGS changes, the build will fail at a number of places and
without the LINK change, the final link will fail.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff -urpN 2.6.17/arch/um/kernel/vmlinux.lds.S 2.6.17-dev/arch/um/kernel/vmlinux.lds.S
--- 2.6.17/arch/um/kernel/vmlinux.lds.S	2006-06-17 18:49:35.000000000 -0700
+++ 2.6.17-dev/arch/um/kernel/vmlinux.lds.S	2006-06-26 14:55:45.000000000 -0700
@@ -1,4 +1,5 @@
 #include <linux/config.h>
+#undef i386
 #ifdef CONFIG_LD_SCRIPT_STATIC
 #include "uml.lds.S"
 #else
diff -urpN 2.6.17/arch/um/Makefile-x86_64 2.6.17-dev/arch/um/Makefile-x86_64
--- 2.6.17/arch/um/Makefile-x86_64	2006-06-17 18:49:35.000000000 -0700
+++ 2.6.17-dev/arch/um/Makefile-x86_64	2006-06-26 14:49:01.000000000 -0700
@@ -6,9 +6,11 @@ START := 0x60000000
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
 #it's needed for headers to work!
-CFLAGS += -U__$(SUBARCH)__ -fno-builtin
-USER_CFLAGS += -fno-builtin
+CFLAGS += -U__$(SUBARCH)__ -fno-builtin -m64
+USER_CFLAGS += -fno-builtin -m64
 CHECKFLAGS  += -m64
+AFLAGS += -m64
+LDFLAGS += -m elf_x86_64
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
@@ -16,3 +18,4 @@ ELF_FORMAT := elf64-x86-64
 # Not on all 64-bit distros /lib is a symlink to /lib64. PLD is an example.
 
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
+LINK-y += -m64

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
