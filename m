Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOh47-0003WC-Ml	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 12:42:35 -0700
Received: from ppp-62-11-74-46.dialup.tiscali.it ([62.11.74.46]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EOh44-0006AQ-NQ	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 12:42:35 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051009193718.26019.60494.stgit@zion.home.lan>
In-Reply-To: <200510092118.21032.blaisorblade@yahoo.it>
References: <200510092118.21032.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 2/6] uml: add mode=skas0 as a synonym of skas0
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
Date: Sun, 09 Oct 2005 21:37:18 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Too many people were confused by skas0 and tried using "mode=skas0". And after
all, they are right - accept this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/start_up.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -143,11 +143,22 @@ static int __init skas0_cmd_param(char *
 	return 0;
 }
 
+/* The two __uml_setup would conflict, without this stupid alias. */
+
+static int __init mode_skas0_cmd_param(char *str, int* add)
+	__attribute__((alias("skas0_cmd_param")));
+
 __uml_setup("skas0", skas0_cmd_param,
 		"skas0\n"
 		"    Disables SKAS3 usage, so that SKAS0 is used, unless \n"
 	        "    you specify mode=tt.\n\n");
 
+__uml_setup("mode=skas0", mode_skas0_cmd_param,
+		"mode=skas0\n"
+		"    Disables SKAS3 usage, so that SKAS0 is used, unless you \n"
+		"    specify mode=tt. Note that this was recently added - on \n"
+		"    older kernels you must use simply \"skas0\".\n\n");
+
 static int force_sysemu_disabled = 0;
 
 static int __init nosysemu_cmd_param(char *str, int* add)



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
