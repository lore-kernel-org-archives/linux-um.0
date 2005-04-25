Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQ8Ro-0007k8-2x for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 11:36:44 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DQ8RV-0002Xs-3s for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 11:36:43 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050425182805.E9B6F45820@zion>
Subject: [uml-devel] [patch 1/1] uml: fix oops related to exception table [for
	2.6.12, urgent]
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
Date: Mon, 25 Apr 2005 20:28:02 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

In short: avoid that the kernel oopses during the extable sorting, as it can
do now, because the extable is in the readonly section of the binary.

From Jeff: The exception table turned RO in 2.6.11-rc3-mm1 for some reason.
Moving it causes it to land in the writable data section of the binary.

From Paolo: This patch fixes a oops on startup, which can be easily triggered
by compiling with CONFIG_MODE_TT disabled, and STATIC_LINK either disabled or
enabled. The resulting kernel will always Oops on startup, after printing this
simple output:

Checking for /proc/mm...found
Checking for the skas3 patch in the host...found
Checking PROT_EXEC mmap in /tmp...OK

Debugging shows that it's a SIGSEGV during the extable sorting, which is
caused by the fact that the table is in the read-only section of the binary.

The oops is a 2.6.11-bk7 (more or less) regression, which I already reported
on uml-devel. In fact, the original patch had already been totally dropped
because it seemed useless. Also, I don't know why the moved section becomes
writable, actually. And on i386 the current layout is like the one we have
*before* this patch. Still, it does fix the problem for me.

I've verified, by binary search on the BitKeeper repository (synced up as of
2.6.12-rc2), starting from the range 2.6.11-2.6.12-rc1, that this bug shows up
on BitKeeper revisions in the range [@1.1994.11.168,+inf), i.e. starting from
this:

[PATCH] lib/sort: Replace insertion sort in exception tables

Since UML does not use the exception table, it's likely that insertion sort
didn't happen to write anything on the table.

$ bk prs -d':KEY: :MD5KEY:\n' -r@1.1994.11.168 ChangeSet
======== ChangeSet 1.1994.11.168 ========
mpm@selenic.com[torvalds]|ChangeSet|20050308180540|47678
422de974WUZpIt5eM36-PMJe_h6Nfg

(the 2nd thing ought to be the unique hex key for the changeset).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/include/asm-um/common.lds.S |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff -puN include/asm-um/common.lds.S~uml-exception-table-oops-fix include/asm-um/common.lds.S
--- linux-2.6.12/include/asm-um/common.lds.S~uml-exception-table-oops-fix	2005-04-25 20:22:38.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/common.lds.S	2005-04-25 20:22:38.000000000 +0200
@@ -8,11 +8,6 @@
   _sdata = .;
   PROVIDE (sdata = .);
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
   RODATA
 
   .unprotected : { *(.unprotected) }
@@ -20,6 +15,10 @@
   PROVIDE (_unprotected_end = .);
 
   . = ALIGN(4096);
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
   __uml_setup_start = .;
   .uml.setup.init : { *(.uml.setup.init) }
   __uml_setup_end = .;
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
