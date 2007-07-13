Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9IyM-0008Ku-4m for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 04:06:14 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9IyK-0006Hm-Ua
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 04:06:05 -0700
Received: from [192.168.1.132] (AMarseille-252-1-56-155.w86-193.abo.wanadoo.fr
	[86.193.151.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: antoine@nagafix.co.uk)
	by mail.nagafix.co.uk (Postfix) with ESMTP id AF44243BC9
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 13 Jul 2007 12:05:43 +0100 (BST)
Message-ID: <46975C78.5010903@nagafix.co.uk>
Date: Fri, 13 Jul 2007 12:05:28 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
Subject: [uml-devel] link failure, multiple definition of 'in6addr_any'
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
To: user-mode-linux-devel@lists.sourceforge.net


  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/um/drivers/built-in.o: In function `pcap_nametoaddrinfo':
(.text+0x1143f): warning: Using 'getaddrinfo' in statically linked 
applications requires at runtime the shared libraries from the glibc 
version used for linking
arch/um/drivers/built-in.o: In function `pcap_nametoaddr':
(.text+0x11465): warning: Using 'gethostbyname' in statically linked 
applications requires at runtime the shared libraries from the glibc 
version used for linking
arch/um/drivers/built-in.o: In function `pcap_nametonetaddr':
(.text+0x113e5): warning: Using 'getnetbyname' in statically linked 
applications requires at runtime the shared libraries from the glibc 
version used for linking
arch/um/drivers/built-in.o: In function `pcap_nametoproto':
(.text+0x111f5): warning: Using 'getprotobyname' in statically linked 
applications requires at runtime the shared libraries from the glibc 
version used for linking
arch/um/drivers/built-in.o: In function `pcap_nametoport':
(.text+0x11239): warning: Using 'getservbyname' in statically linked 
applications requires at runtime the shared libraries from the glibc 
version used for linking
/usr/lib/gcc/x86_64-pc-linux-gnu/4.1.2/../../../../lib64/libc.a(in6_addr.o):(.rodata+0x0): 
multiple definition of `in6addr_any'
net/built-in.o:(.rodata+0x5380): first defined here
collect2: ld returned 1 exit status

This is from a known "good" config upgraded to 2.6.22 with oldconfig.
I removed IPv6 support and all is well.

Antoine

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
