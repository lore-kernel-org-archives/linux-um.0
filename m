Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI7kM-0001E8-7F	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:47:02 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EI7kK-0003vX-QN
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:47:02 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050921163913.30500.72827.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 05/10] uml: fix uname output on 32-bit binary on
	64-bit host
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
Date: Wed, 21 Sep 2005 18:39:14 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Translate uname output taken from the host if needed.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/user_util.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/um/kernel/user_util.c b/arch/um/kernel/user_util.c
--- a/arch/um/kernel/user_util.c
+++ b/arch/um/kernel/user_util.c
@@ -128,6 +128,12 @@ void setup_machinename(char *machine_out
 	struct utsname host;
 
 	uname(&host);
+#if defined(UML_CONFIG_UML_X86) && !defined(UML_CONFIG_64BIT)
+	if (!strcmp(host.machine, "x86_64")) {
+		strcpy(machine_out, "i686");
+		return;
+	}
+#endif
 	strcpy(machine_out, host.machine);
 }
 



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
