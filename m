Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtYtx-0001Gd-Ae for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 14:11:09 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CtYtv-00070x-Jh for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 14:11:09 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501252310.22421.blaisorblade@yahoo.it>
Subject: [uml-devel] Error in current vsyscall patch
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
Date: Tue, 25 Jan 2005 23:10:22 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

About 
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.11-rc1-mm1/patches/vsyscall

this hunk is not enough:

@@ -152,6 +152,7 @@
 static void init_highmem(void)
 {
 pgd_t *pgd;
+pud_t *pud;
 pmd_t *pmd;
 pte_t *pte;
 unsigned long vaddr;
@@ -163,6 +164,7 @@
 fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, swapper_pg_dir);
 
 pgd = swapper_pg_dir + pgd_index(vaddr);
+pud = pud_offset(pgd, vaddr);
 pmd = pmd_offset(pgd, vaddr);
 pte = pte_offset_kernel(pmd, vaddr);
 pkmap_page_table = pte;

You forgot this obvious change:

-pmd = pmd_offset(pgd, vaddr);
+pmd = pmd_offset(pud, vaddr);

Please correct... and always try to proof-read each patch you write...
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
