Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgpRm-0007Xp-2i for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jul 2004 11:41:10 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BgpRl-0005Ar-HL for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jul 2004 11:41:10 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407032055.35871.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Could you explain this strange fix?
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
Date: Sat, 3 Jul 2004 20:55:35 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This hunk comes straight from 2.4.24-3um. Could you explain it? Are you sure 
it's safe? Several people complain about patches later than 2.4.24-1 (even 
for stability), so I have doubts about it. Also, could you say me which is 
the fix for the "tracing myself" bug of 2.4? The patch is in 2.4.24-2, but 
since I've split it out, I cannot find which is the needed fix.

diff -puN arch/um/kernel/skas/tlb.c~optimization-unstable 
arch/um/kernel/skas/tlb.c
--- UmWorklinux-2.4.24/arch/um/kernel/skas/tlb.c~optimization-unstable  
2004-07-02 13:45:07.057643968 +0200
+++ UmWorklinux-2.4.24-paolo/arch/um/kernel/skas/tlb.c  2004-07-02 
13:45:14.098573584 +0200
@@ -132,7 +132,9 @@ void flush_tlb_range_skas(struct mm_stru

 void flush_tlb_mm_skas(struct mm_struct *mm)
 {
+#if 0
        flush_tlb_kernel_vm_skas();
+#endif
        fix_range(mm, 0, host_task_size, 0);
 }


-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
