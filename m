Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAo6Q-0004Bh-Ry for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 03:51:18 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DAo6O-0004ck-1p for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 03:51:18 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050311193327.E6D166477@zion>
Subject: [uml-devel] [patch 1/2] uml: export getgid for hostfs
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
Date: Fri, 11 Mar 2005 20:33:27 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Export this symbol which is now needed for a typo fix (getuid() -> getgid()).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/os-Linux/user_syms.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN arch/um/os-Linux/user_syms.c~uml-export-getgid-for-hostfs arch/um/os-Linux/user_syms.c
--- linux-2.6.11/arch/um/os-Linux/user_syms.c~uml-export-getgid-for-hostfs	2005-03-11 20:16:17.061368376 +0100
+++ linux-2.6.11-paolo/arch/um/os-Linux/user_syms.c	2005-03-11 20:16:17.065367768 +0100
@@ -82,6 +82,7 @@ EXPORT_SYMBOL_PROTO(statfs);
 EXPORT_SYMBOL_PROTO(statfs64);
 
 EXPORT_SYMBOL_PROTO(getuid);
+EXPORT_SYMBOL_PROTO(getgid);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
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
