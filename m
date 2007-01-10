Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H4Zm0-0004jz-N0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jan 2007 01:29:32 -0800
Received: from p15198372.pureserver.info ([212.227.95.191])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H4Zlz-0007Bc-3K
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jan 2007 01:29:32 -0800
Message-ID: <20070110102857.9bzdrhzh8g0s04og@webmail.flonatel.org>
Date: Wed, 10 Jan 2007 10:28:57 +0100
From: uml@flonatel.org
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] Configuration problem with UML in kernel 2.6.19.1
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
To: user-mode-linux-devel@lists.sourceforge.net

Hello!

I had some problems running linux 2.6.19.1 as client UML.  When  
starting 'mapping mmap stub failed, errno = -12' is printed - with an  
additional Kernel panic. In the file arch/um/Kconfig.i386 the  
definition of STUB_CODE and STUB_DATA depend on the configuration  
symbol HOST_2G_2G which has gone sometimes in between 2.6.18.6 and  
2.6.19.1.

The applied patch solves the problem for me.

Kind regards

Andreas Florath


diff -u linux-2.6.19.1_orig/arch/um/Kconfig.i386  
linux-2.6.19.1/arch/um/Kconfig.i386
--- linux-2.6.19.1_orig/arch/um/Kconfig.i386    2006-12-11  
20:32:53.000000000 +0100
+++ linux-2.6.19.1/arch/um/Kconfig.i386 2007-01-10 09:32:01.000000000 +0100
@@ -67,13 +67,13 @@

  config STUB_CODE
         hex
-       default 0xbfffe000 if !HOST_2G_2G
-       default 0x7fffe000 if HOST_2G_2G
+       default 0xbfffe000 if !HOST_VMSPLIT_2G
+       default 0x7fffe000 if HOST_VMSPLIT_2G

  config STUB_DATA
         hex
-       default 0xbffff000 if !HOST_2G_2G
-       default 0x7ffff000 if HOST_2G_2G
+       default 0xbffff000 if !HOST_VMSPLIT_2G
+       default 0x7ffff000 if HOST_VMSPLIT_2G

  config STUB_START
         hex



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
