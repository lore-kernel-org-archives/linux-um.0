Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EL49D-0008GP-Gg	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:32:51 -0700
Received: from ppp-62-11-74-97.dialup.tiscali.it ([62.11.74.97]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EL49A-0002kB-Lq	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:32:51 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050929193044.14528.13150.stgit@zion.home.lan>
In-Reply-To: <200509292102.44942.blaisorblade@yahoo.it>
References: <200509292102.44942.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 3/5] uml: clear SKAS0/3 flags when running in TT
	mode
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
Date: Thu, 29 Sep 2005 21:30:44 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

SEGV_MAYBE_FIXABLE tests ptrace_faultinfo, and depends on it being 1 only in
SKAS3 mode, while currently when running with mode=tt it will be 1 anyway. Fix
this, and do the same for proc_mm.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/os.h     |    4 ++++
 arch/um/kernel/um_arch.c |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -157,6 +157,10 @@ extern int os_lock_file(int fd, int excl
 extern void os_early_checks(void);
 extern int can_do_skas(void);
 
+/* Make sure they are clear when running in TT mode. Required by
+ * SEGV_MAYBE_FIXABLE */
+#define clear_can_do_skas() do { ptrace_faultinfo = proc_mm = 0; } while (0)
+
 /* mem.c */
 extern int create_mem_file(unsigned long len);
 
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -334,6 +334,8 @@ int linux_main(int argc, char **argv)
 		add_arg(DEFAULT_COMMAND_LINE);
 
 	os_early_checks();
+	if (force_tt)
+		clear_can_do_skas();
 	mode_tt = force_tt ? 1 : !can_do_skas();
 #ifndef CONFIG_MODE_TT
 	if (mode_tt) {



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
