Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHALk-0002IB-N3 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:17:08 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CHALh-0007Dk-AN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:17:08 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001633.B94388691@zion.localdomain>
Subject: [uml-devel] [patch 5/6] uml: fix an "unused" warnings
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
Date: Tue, 12 Oct 2004 02:16:33 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Fixes some random warnings. To avoid "defined but not used" for
not_configged_ops, make it be defined only if at least one channel is not defined.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Kconfig_char        |    4 ++++
 linux-2.6.9-current-paolo/arch/um/drivers/chan_kern.c |    2 ++
 2 files changed, 6 insertions(+)

diff -puN arch/um/drivers/chan_kern.c~uml-fix-some-warnings arch/um/drivers/chan_kern.c
--- linux-2.6.9-current/arch/um/drivers/chan_kern.c~uml-fix-some-warnings	2004-09-19 18:27:33.885887560 +0200
+++ linux-2.6.9-current-paolo/arch/um/drivers/chan_kern.c	2004-09-19 18:27:33.888887104 +0200
@@ -19,6 +19,7 @@
 #include "line.h"
 #include "os.h"
 
+#ifdef CONFIG_NOCONFIG_CHAN
 static void *not_configged_init(char *str, int device, struct chan_opts *opts)
 {
 	printk(KERN_ERR "Using a channel type which is configured out of "
@@ -87,6 +88,7 @@ static struct chan_ops not_configged_ops
 	.free		= not_configged_free,
 	.winch		= 0,
 };
+#endif /* CONFIG_NOCONFIG_CHAN */
 
 void generic_close(int fd, void *unused)
 {
diff -puN arch/um/Kconfig_char~uml-fix-some-warnings arch/um/Kconfig_char
--- linux-2.6.9-current/arch/um/Kconfig_char~uml-fix-some-warnings	2004-09-19 18:27:33.886887408 +0200
+++ linux-2.6.9-current-paolo/arch/um/Kconfig_char	2004-09-19 18:27:33.888887104 +0200
@@ -72,6 +72,10 @@ config XTERM_CHAN
         well, since UML's gdb currently requires an xterm.
         It is safe to say 'Y' here.
 
+config NOCONFIG_CHAN
+	bool
+	default !(XTERM_CHAN && TTY_CHAN && PTY_CHAN && PORT_CHAN && FD_CHAN && NULL_CHAN)
+
 config CON_ZERO_CHAN
 	string "Default main console channel initialization"
 	default "fd:0,fd:1"
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
