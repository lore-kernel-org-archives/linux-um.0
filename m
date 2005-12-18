Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eo1lZ-0003qt-O1 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Dec 2005 08:52:09 -0800
Received: from host229-46.pool8259.interbusiness.it ([82.59.46.229]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eo1lZ-00047g-DV for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Dec 2005 08:52:09 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051218165031.441.4674.stgit@zion.home.lan>
In-Reply-To: <20051218164916.441.69564.stgit@zion.home.lan>
References: <20051218164916.441.69564.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 1/4] uml: arch/um/scripts/Makefile.rules - remove
	duplicated code
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
Date: Sun, 18 Dec 2005 17:50:32 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Duplicated code - the patch adding it was probably applied twice without enough
care.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/scripts/Makefile.rules |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index b3fbf12..2e41cab 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -21,11 +21,6 @@ define unprofile
 endef
 
 
-# The stubs and unmap.o can't try to call mcount or update basic block data
-define unprofile
-	$(patsubst -pg,,$(patsubst -fprofile-arcs -ftest-coverage,,$(1)))
-endef
-
 # cmd_make_link checks to see if the $(foo-dir) variable starts with a /.  If
 # so, it's considered to be a path relative to $(srcdir) rather than
 # $(srcdir)/arch/$(SUBARCH).  This is because x86_64 wants to get ldt.c from



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
