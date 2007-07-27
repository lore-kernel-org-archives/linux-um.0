Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IEUHW-0007qt-MM for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jul 2007 11:11:18 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IEUHU-0005td-7B
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jul 2007 11:11:18 -0700
Received: from [192.168.0.6] (80-195-236-49.cable.ubr02.camd.blueyonder.co.uk
	[80.195.236.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: antoine@nagafix.co.uk)
	by mail.nagafix.co.uk (Postfix) with ESMTP id 776AF43B47
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 27 Jul 2007 19:11:07 +0100 (BST)
Message-ID: <46AA353B.9090907@nagafix.co.uk>
Date: Fri, 27 Jul 2007 19:11:07 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
Subject: [uml-devel] aio vs gentoo headers
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
To: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

I needed the tiny change below to be able to build on amd64 with gentoo 
kernel headers. posted here just in case it's useful, I can compile both 
x86 and amd64 kernels using these headers but not cross compile (make 
ARCH=um SUBARCH=i386)
That still fails with:
arch/um/sys-i386/user-offsets.c: In function 'foo':
arch/um/sys-i386/user-offsets.c:52: error: invalid application of 
'sizeof' to incomplete type 'struct user_fxsr_struct'
make[1]: *** [arch/um/sys-i386/user-offsets.s] Error 1
make: *** [arch/um/sys-i386/user-offsets.s] Error 2



--- 2.6.22.1-old/arch/um/os-Linux/aio    2007-07-27 18:14:43.000000000 +0100
+++ new/arch/um/os-Linux/aio.c    2007-07-27 18:14:24.000000000 +0100
@@ -76,7 +76,8 @@
                                 .aio_nbytes     = len,
                                 .aio_offset     = offset,
                                 .aio_reserved1  = 0,
-                               .aio_reserved2  = 0 });
+                               .aio_reserved2  = 0,
+                               .aio_reserved3  = 0 });

         switch(type){
         case AIO_READ:

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
