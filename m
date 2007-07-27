Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IEMbl-00033O-BO for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jul 2007 02:59:41 -0700
Received: from sicnat3.emn.fr ([193.54.76.194] helo=ron.emn.fr)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IEMT0-0000PK-7q
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jul 2007 02:50:40 -0700
Date: Fri, 27 Jul 2007 11:45:56 +0200 (MEST)
Message-Id: <200707270945.LAA17372@ifs.emn.fr>
From: Yoann Padioleau <padator@wanadoo.fr>
Subject: [uml-devel] [PATCH 18/68] 0 -> NULL, for arch/um
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: kernel-janitors@vger.kernel.org
Cc: jdike@karaya.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


When comparing a pointer, it's clearer to compare it to NULL than to 0.

Here is an excerpt of the semantic patch: 

@@
expression *E;
@@

  E ==
- 0
+ NULL

@@
expression *E;
@@

  E !=
- 0
+ NULL

Signed-off-by: Yoann Padioleau <padator@wanadoo.fr>
Cc: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org
---

 sys-i386/fault.c   |    2 +-
 sys-x86_64/fault.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/sys-i386/fault.c b/arch/um/sys-i386/fault.c
index 745b4fd..8004023 100644
--- a/arch/um/sys-i386/fault.c
+++ b/arch/um/sys-i386/fault.c
@@ -20,7 +20,7 @@ int arch_fixup(unsigned long address, un
 	const struct exception_table_entry *fixup;
 
 	fixup = search_exception_tables(address);
-	if(fixup != 0){
+	if(fixup != NULL){
 		UPT_IP(regs) = fixup->fixup;
 		return(1);
 	}
diff --git a/arch/um/sys-x86_64/fault.c b/arch/um/sys-x86_64/fault.c
index 4636b14..67d4a19 100644
--- a/arch/um/sys-x86_64/fault.c
+++ b/arch/um/sys-x86_64/fault.c
@@ -19,7 +19,7 @@ int arch_fixup(unsigned long address, un
 	const struct exception_table_entry *fixup;
 
 	fixup = search_exception_tables(address);
-	if(fixup != 0){
+	if(fixup != NULL){
 		UPT_IP(regs) = fixup->fixup;
 		return(1);
 	}


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
