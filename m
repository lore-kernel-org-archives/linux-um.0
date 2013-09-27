Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <artagnon@gmail.com>) id 1VPPYn-00062D-TB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Sep 2013 04:21:45 +0000
Received: from mail-pd0-f173.google.com ([209.85.192.173])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VPPYn-0003IU-8o
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Sep 2013 04:21:45 +0000
Received: by mail-pd0-f173.google.com with SMTP id p10so2062923pdj.32
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 26 Sep 2013 21:21:39 -0700 (PDT)
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Fri, 27 Sep 2013 09:44:45 +0530
Message-Id: <1380255287-5818-1-git-send-email-artagnon@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 0/2] More plesant User-Mode Linux build
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michal Marek <mmarek@suse.cz>, Richard Weinberger <richard@nod.at>, Ingo Molnar <mingo@redhat.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi,

The first patch does the meat of the work of getting rid of the
bloated i386-specific defconfig and replacing it with two tiny ones,
and updating the Makefile/ Kconfig. SUBARCH is now auto-detected
correctly, and can be overridden on the command-line. I've tested both
the x86_64 kernel with an x86_64 userland, as well as the i386 kernel
with an i386 userland.

The second patch is just a related "while we're there".

Thanks.

Ramkumar Ramachandra (2):
  arch/um: make it work with defconfig and x86_64
  um/vdso: add .gitignore for a couple of targets

 arch/um/Kconfig.common           |   5 -
 arch/um/Makefile                 |  11 +
 arch/um/configs/i386_defconfig   |  76 ++++
 arch/um/configs/x86_64_defconfig |  75 ++++
 arch/um/defconfig                | 899 ---------------------------------------
 arch/x86/um/Kconfig              |   5 +
 arch/x86/um/vdso/.gitignore      |   2 +
 7 files changed, 169 insertions(+), 904 deletions(-)
 create mode 100644 arch/um/configs/i386_defconfig
 create mode 100644 arch/um/configs/x86_64_defconfig
 delete mode 100644 arch/um/defconfig
 create mode 100644 arch/x86/um/vdso/.gitignore

-- 
1.8.4.299.gb3e7d24.dirty


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

