Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <enjoymindful@gmail.com>) id 1WrhJl-0004aP-4Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2014 05:31:25 +0000
Received: from mail-pa0-f41.google.com ([209.85.220.41])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WrhJk-0005lp-8z
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2014 05:31:25 +0000
Received: by mail-pa0-f41.google.com with SMTP id kx10so5033121pab.28
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 02 Jun 2014 22:31:18 -0700 (PDT)
From: Real Name <enjoymindful@gmail.com>
Date: Tue,  3 Jun 2014 13:30:44 +0800
Message-Id: <1401773445-25256-1-git-send-email-enjoymindful@gmail.com>
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
Subject: [uml-devel] [PATCH v2] delete unnecessary bootmem struct page array
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at, linux-kernel@vger.kernel.org

From: Honggang Li <enjoymindful@gmail.com>

The patch based on linux-next-2014-06-02.

The old init_maps function does two things:
1) allocates and initializes one struct page array for bootmem
2) count the number of total pages

After removed the source code related to the unnecessary array, the name 
'init_maps' is some kind of improper named, as it just count the number of
total page numbers. So, I renamed the function as 'mem_total_pages'.

I tested the patch through repeat reboot the uml kernel many times.
[real@name linux-next]$ make ARCH=um defconfig
[real@name linux-next]$ make ARCH=um linux
[real@name linux-next]$ file linux
linux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, not stripped
[real@name linux-next]$ ./linux ubda=/home/real/linux-next/Fedora20-AMD64-root_fs mem=256m && sync && echo 1
[real@name linux-next]$ ./linux ubda=/home/real/linux-next/Fedora20-AMD64-root_fs mem=256m && sync && echo 2
(repeat reboot the uml kernel many times..)

Honggang Li (1):
  delete unnecessary bootmem struct page array

 arch/um/include/shared/mem_user.h |  2 +-
 arch/um/kernel/physmem.c          | 32 ++++++--------------------------
 arch/um/kernel/um_arch.c          |  7 +------
 3 files changed, 8 insertions(+), 33 deletions(-)

-- 
1.8.3.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

