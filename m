Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6ZLN-0002BI-OT for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 11:44:57 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C6ZLN-0002YK-0i for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 11:44:57 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040912182626.E030180BF@zion.localdomain>
Subject: [uml-devel] [patch 1/2] uml-correct-tlb-fix-range-skas
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 12 Sep 2004 20:26:25 +0200
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Do not flush the whole kernel page table instead of flushing only a range in SKAS mode:
loop from start to end instead than to start_vm to end_vm. To test a lot, since
it could well be wrong, or some callers could be passing wrong parameters (they
were ignored!). Anyway, it seems that this is safe and that most callers are in
arch-independent code (i.e. correct one). But actually I did not test modules well.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/tlb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/skas/tlb.c~uml-correct-tlb-fix-range-skas arch/um/kernel/skas/tlb.c
--- uml-linux-2.6.8.1/arch/um/kernel/skas/tlb.c~uml-correct-tlb-fix-range-skas	2004-08-29 14:40:53.413091752 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/tlb.c	2004-08-29 14:40:53.415091448 +0200
@@ -77,7 +77,7 @@ void flush_tlb_kernel_range_skas(unsigne
 	int updated = 0, err;
 
 	mm = &init_mm;
-	for(addr = start_vm; addr < end_vm;){
+	for(addr = start; addr < end;){
 		pgd = pgd_offset(mm, addr);
 		pmd = pmd_offset(pgd, addr);
 		if(pmd_present(*pmd)){
_


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
