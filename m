Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHALf-0002Hv-0K for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:17:03 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CHALY-0008Gq-Vm for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:17:02 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001624.4DC928686@zion.localdomain>
Subject: [uml-devel] [patch 1/6] uml: fix wrong type for rb_entry call
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
Date: Tue, 12 Oct 2004 02:16:24 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


With the type-safe rb_entry (based on container_of, I sent it) I discovered
this type error, so I've fixed it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/physmem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/um/kernel/physmem.c~uml-fix-wrong-type arch/um/kernel/physmem.c
--- linux-2.6.9-current/arch/um/kernel/physmem.c~uml-fix-wrong-type	2004-10-12 01:05:58.196762360 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/physmem.c	2004-10-12 01:05:58.198762056 +0200
@@ -36,7 +36,7 @@ static struct rb_node **find_rb(void *vi
 	struct phys_desc *d;
 
 	while(*n != NULL){
-		d = rb_entry(n, struct phys_desc, rb);
+		d = rb_entry(*n, struct phys_desc, rb);
 		if(d->virt == virt)
 			return(n);
 
@@ -56,7 +56,7 @@ static struct phys_desc *find_phys_mappi
 	if(*n == NULL)
 		return(NULL);
 
-	return(rb_entry(n, struct phys_desc, rb));
+	return(rb_entry(*n, struct phys_desc, rb));
 }
 
 static void insert_phys_mapping(struct phys_desc *desc)
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
