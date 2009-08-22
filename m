Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1Meqco-0000fu-GC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Aug 2009 13:27:18 +0000
Received: from mail-ew0-f225.google.com ([209.85.219.225])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Meqcf-0000Dh-HZ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Aug 2009 13:27:18 +0000
Received: by ewy25 with SMTP id 25so1268777ewy.33
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 22 Aug 2009 06:27:02 -0700 (PDT)
Message-ID: <4A8FF347.30309@gmail.com>
Date: Sat, 22 Aug 2009 15:31:51 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] uml: Fix order of pud and pmd_free()
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
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

If pmd_alloc() fails we should only free the prior allocated pud,
if pte_alloc_map() fails, we should free pmd as well.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 0cd9a7a..8bfd1e9 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -38,10 +38,10 @@ static int init_stub_pte(struct mm_struct *mm, unsigned long proc,
 	*pte = pte_mkread(*pte);
 	return 0;
 
- out_pmd:
-	pud_free(mm, pud);
  out_pte:
 	pmd_free(mm, pmd);
+ out_pmd:
+	pud_free(mm, pud);
  out:
 	return -ENOMEM;
 }

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

