Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e3k-0004fi-BG	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:12 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e3j-00007v-N5
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:12 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182102.867BF24E0AC@zion.home.lan>
Subject: [uml-devel] [patch 03/39] add swap cache mapping comment
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
Date: Fri, 12 Aug 2005 20:21:02 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add some more comments about page->mapping and swapper_space, explaining their
(historical and current) relationship. Such material can be extracted from the
old GIT history (which I used for reference), but having it in the source is
more useful.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/./mm/swap_state.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN ./mm/swap_state.c~swap-cache-mapping-comment ./mm/swap_state.c
--- linux-2.6.git/./mm/swap_state.c~swap-cache-mapping-comment	2005-08-11 11:12:57.000000000 +0200
+++ linux-2.6.git-paolo/./mm/swap_state.c	2005-08-11 11:12:57.000000000 +0200
@@ -21,6 +21,11 @@
  * swapper_space is a fiction, retained to simplify the path through
  * vmscan's shrink_list, to make sync_page look nicer, and to allow
  * future use of radix_tree tags in the swap cache.
+ *
+ * In 2.4 and until 2.6.6 pages in the swap cache also had page->mapping ==
+ * &swapper_space (this was the definition of PageSwapCache), but this is no
+ * more true. Instead, we use page->flags for that, and page->mapping is
+ * *ignored* here. However, also take a look at page_mapping().
  */
 static struct address_space_operations swap_aops = {
 	.writepage	= swap_writepage,
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
