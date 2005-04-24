Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPliP-0004st-Py for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:20:21 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DPliN-0006Ve-28 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:20:21 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050424180955.0C70C33AED@zion>
Subject: [uml-devel] [patch 1/6] uml: workaround old problematic sed behaviour
	[compile-fix, for 2.6.12]
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
Date: Sun, 24 Apr 2005 20:09:53 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, rob@landley.net, imcdnzl@gmail.com


From: Rob Landley <rob@landley.net>

Old versions of sed from 1998 (predating the first release of gcc 2.95, but 
still in use by debian stable) don't understand the single-line version of 
the sed append command.  Since newer versions of sed still understand the... 
ahem, "vintage" form of the command, change our code to use that.

Signed-off-by: Rob Landley <rob@landley.net>
Acked-by: Ian McDonald <imcdnzl@gmail.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/kernel/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/Makefile~uml-workaround-sed-behaviour arch/um/kernel/Makefile
--- linux-2.6.12/arch/um/kernel/Makefile~uml-workaround-sed-behaviour	2005-04-24 19:32:15.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/Makefile	2005-04-24 19:32:15.000000000 +0200
@@ -53,6 +53,7 @@ quiet_cmd_quote2 = QUOTE   $@
       cmd_quote2 = sed -e '/CONFIG/{'          \
 		  -e 's/"CONFIG"\;/""/'        \
 		  -e 'r $(obj)/config.tmp'     \
-		  -e 'a""\;'                   \
+		  -e 'a \'                     \
+		  -e '""\;'                    \
 		  -e '}'                       \
 		  $< > $@
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
