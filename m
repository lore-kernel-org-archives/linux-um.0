Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgoNC-00024r-FP for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jul 2004 10:32:22 -0700
Received: from ppp-62-11-78-69.dialup.tiscali.it ([62.11.78.69]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BgoN5-0003O4-D3 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jul 2004 10:32:22 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040703173237.1E39DEF1@zion.localdomain>
Subject: [uml-devel] [patch 1/1] Do not flush the whole kernel page table
	instead of flushing one tlb.
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
Date: Sat, 03 Jul 2004 19:32:36 +0200
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Do not flush the whole kernel page table instead of flushing only a range in SKAS mode:
loop from start to end instead than to start_vm to end_vm. To test a lot, since
it could well be wrong, or some callers could be passing wrong parameters (they
were ignored!).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.7-paolo/arch/um/kernel/skas/tlb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/skas/tlb.c~correct-tlb-fix-range-skas arch/um/kernel/skas/tlb.c
--- uml-linux-2.6.7/arch/um/kernel/skas/tlb.c~correct-tlb-fix-range-skas	2004-07-03 18:10:10.061305552 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/skas/tlb.c	2004-07-03 18:10:10.064305096 +0200
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
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
