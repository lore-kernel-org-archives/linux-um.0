Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJmzw-0007rg-AU for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 23:29:44 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DJmzu-0000Iy-PG
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 23:29:44 -0700
From: Rob Landley <rob@landley.net>
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504072022.47474.blaisorblade@yahoo.it>
	<cbec11ac0504071621298678da@mail.gmail.com>
In-Reply-To: <cbec11ac0504071621298678da@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504080126.49602.rob@landley.net>
Subject: [uml-devel] [patch] Fix broken compiling under 2.6.12-rc2 with sed
	3.02
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
Date: Fri, 8 Apr 2005 01:26:49 -0400
To: Ian McDonald <imcdnzl@gmail.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

Old versions of sed from 1998 (predating the first release of gcc 2.95, but 
still in use by debian stable) don't understand the single-line version of 
the sed append command.  Since newer versions of sed still understand the... 
ahem, "vintage" form of the command, change it to use that.

Signed-off-by: Rob Landley <rob@landley.net>
Acked-by: Ian McDonald <imcdnzl@gmail.com>

--- linux-2.6.11.old/arch/um/kernel/Makefile	2005-04-08 01:06:15.000000000 
-0400
+++ linux-2.6.11/arch/um/kernel/Makefile	2005-04-08 01:08:44.000000000 -0400
@@ -53,6 +53,7 @@
       cmd_quote2 = sed -e '/CONFIG/{'          \
 		  -e 's/"CONFIG"\;/""/'        \
 		  -e 'r $(obj)/config.tmp'     \
-		  -e 'a""\;'                   \
+		  -e 'a \'                     \
+		  -e '""\;'                    \
 		  -e '}'                       \
 		  $< > $@


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
