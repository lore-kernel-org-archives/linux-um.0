Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7wb-0008GF-Bk
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:07:57 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7wa-0003vN-LP
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:07:57 +0000
Date: Thu, 18 Aug 2011 20:07:49 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7wT-0007oo-Nc@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 53/91] um: make
 flush_tlb_kernel_range_common() static
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/tlb.h |    2 --
 arch/um/kernel/tlb.c         |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/shared/tlb.h b/arch/um/include/shared/tlb.h
index ecd2265..8a50ce1 100644
--- a/arch/um/include/shared/tlb.h
+++ b/arch/um/include/shared/tlb.h
@@ -9,7 +9,5 @@
 #include "um_mmu.h"
 
 extern void force_flush_all(void);
-extern int flush_tlb_kernel_range_common(unsigned long start,
-					 unsigned long end);
 
 #endif
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index d175d05..d1da8ac 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -287,7 +287,7 @@ void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 	}
 }
 
-int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
+static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 {
 	struct mm_struct *mm;
 	pgd_t *pgd;
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

