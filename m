Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2Q8n-0003zV-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 00:02:17 -0700
Received: from mx13.sac.fedex.com ([199.81.197.53])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A2Q8m-0006ae-JY
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 25 Sep 2003 00:02:16 -0700
Received: from mail-e1000-1.prod.fedex.com (inet03.prod.fedex.com [199.81.10.43])
	by mx13.sac.fedex.com (8.12.6p2/8.12.3) with SMTP id h8P71h4R063737
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 02:01:43 -0500 (CDT)
	(envelope-from jeff98@silk.corp.fedex.com)
Received: from entpm11.apac.fedex.com (entpm11.apac.fedex.com [155.161.92.11])
	by inet03.prod.fedex.com (8.12.10/8.12.10) with ESMTP id h8P71e0Z013608
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 02:01:41 -0500 (CDT)
Received: from boston.corp.fedex.com ([155.161.156.88])
	by silk.corp.fedex.com (8.11.4/8.11.4) with ESMTP id h8P6xsP02674
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 14:59:54 +0800
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Message-ID: <Pine.LNX.4.58.0309251449260.20970@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] (no subject)
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 25 Sep 2003 14:59:30 +0800 (SGT)
To: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>


Please apply the patch below to host-skas3.patch so that it does not need
to be undone when compiling uml.

Currently, I need to apply host-skas3.patch to /usr/src/linux to compile
the host's vmlinux, and reverse it in order to compile uml linux. With the
patch below, this will prevent gcc from redefining the struct twice.

Thanks,
Jeff


--- linux/include/asm-i386/ptrace.h.org	Thu Sep 25 14:32:18 2003
+++ linux/include/asm-i386/ptrace.h	Thu Sep 25 14:34:49 2003
@@ -51,6 +51,7 @@

 #define PTRACE_SETOPTIONS         21

+#ifndef __arch_um__
 struct ptrace_faultinfo {
 	int is_write;
 	unsigned long addr;
@@ -61,6 +62,7 @@
   	void *ptr;
 	unsigned long bytecount;
 };
+#endif

 #define PTRACE_FAULTINFO 52
 #define PTRACE_SIGPENDING 53



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
