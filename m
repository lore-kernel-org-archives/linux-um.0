Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUxHF-0008Pf-Ih for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 17:09:29 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CUxHD-00026r-D4 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 17:09:28 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041119011024.703A47B9AA@zion.localdomain>
Subject: [uml-devel] [patch 1/1] skas-v7: update the 2.6.9 version for
	2.6.10-rc*
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
Date: Fri, 19 Nov 2004 02:10:23 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net, blaisorblade_spam@yahoo.it


This is simply a resync with this change:

http://linux.bkbits.net:8080/linux-2.5/cset@4176817885Kn6zGc09K1fOrpbsJJQA

Since we create an mm and added it to the list, the patch must be updated now,
otherwise it does not even build.

Please, test the resulting kernel and post result with it (I've not yet done
this, in fact you cannot find it on my site).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/mm/proc_mm.c |    5 -----
 1 files changed, 5 deletions(-)

diff -puN mm/proc_mm.c~skas-update-2.6.10 mm/proc_mm.c
--- linux-2.6.10-rc/mm/proc_mm.c~skas-update-2.6.10	2004-11-19 02:03:04.000000000 +0100
+++ linux-2.6.10-rc-paolo/mm/proc_mm.c	2004-11-19 02:07:09.000000000 +0100
@@ -127,11 +127,6 @@ static int open_proc_mm(struct inode *in
 	init_new_empty_context(mm);
 	arch_pick_mmap_layout(mm);
 
-	spin_lock(&mmlist_lock);
-	list_add(&mm->mmlist, &current->mm->mmlist);
-	mmlist_nr++;
-	spin_unlock(&mmlist_lock);
-
 	file->private_data = mm;
 
 	return(0);
_


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
