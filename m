Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <antoine@nagafix.co.uk>) id 1RNf9Y-0003c7-Lx
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2011 06:27:24 +0000
Received: from mamba.nagafix.co.uk ([194.145.196.68] helo=mail.nagafix.co.uk)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RNf9W-00047t-Hv for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2011 06:27:24 +0000
Message-ID: <4EB8CBB0.8010201@nagafix.co.uk>
Date: Tue, 08 Nov 2011 13:26:56 +0700
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
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
Subject: [uml-devel] 2.6.32.47 breaks UML build (both i386 and amd64)
To: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

(...)
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `sysdev_resume':
/linux-2.6.32.47-amd64/drivers/base/sys.c:478: undefined reference to
`irq_pm_syscore_resume'
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make: *** [.tmp_kallsyms1.S] Error 1

Using this config for a 64-bit build:
http://uml.devloop.org.uk/kernels/kernel64-2.6.32.46.config

Note: I only applied the patch to the existing build tree and did not
make clean or make mrproper.
2.6.33.20 is not affected.

Cheers
Antoine

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

