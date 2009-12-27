Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <antoine@nagafix.co.uk>) id 1NOswV-00024z-Gn
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Dec 2009 13:13:55 +0000
Received: from mamba.nagafix.co.uk ([194.145.196.68] helo=mail.nagafix.co.uk)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NOswM-0001tu-Fn for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Dec 2009 13:13:54 +0000
Received: (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: antoine@nagafix.co.uk)
	by mail.nagafix.co.uk (Postfix) with ESMTPSA id 895336675
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 27 Dec 2009 12:55:59 +0000 (GMT)
Message-ID: <4B37595C.8050002@nagafix.co.uk>
Date: Sun, 27 Dec 2009 19:55:56 +0700
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
Subject: [uml-devel] Fedora 12 can't link with libc.a
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
To: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

Exact same error as this bug:
http://sources.redhat.com/bugzilla/show_bug.cgi?id=10893

  LD      .tmp_vmlinux1
/usr/lib/gcc/x86_64-redhat-linux/4.4.2/../../../../lib64/libc.a(elf-init.o):
In function `__libc_csu_init':
(.text+0x65): undefined reference to `__rela_iplt_end'
/usr/lib/gcc/x86_64-redhat-linux/4.4.2/../../../../lib64/libc.a(elf-init.o):
In function `__libc_csu_init':
(.text+0x6e): undefined reference to `__rela_iplt_start'
/usr/lib/gcc/x86_64-redhat-linux/4.4.2/../../../../lib64/libc.a(elf-init.o):
In function `__libc_csu_init':
(.text+0x8a): undefined reference to `__rela_iplt_start'
/usr/lib/gcc/x86_64-redhat-linux/4.4.2/../../../../lib64/libc.a(elf-init.o):
In function `__libc_csu_init':
(.text+0x98): undefined reference to `__rela_iplt_start'
/usr/lib/gcc/x86_64-redhat-linux/4.4.2/../../../../lib64/libc.a(elf-init.o):
In function `__libc_csu_init':
(.text+0x9e): undefined reference to `__rela_iplt_start'
/usr/lib/gcc/x86_64-redhat-linux/4.4.2/../../../../lib64/libc.a(elf-init.o):
In function `__libc_csu_init':
(.text+0xa3): undefined reference to `__rela_iplt_start'
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file


Anyone from redhat who understands the changes to the linker/static libs
should be able to fix this quickly I would have thought.

Cheers
Antoine

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

