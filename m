Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNGjP-0002hT-MS for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 13:18:47 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CNGjN-00081I-Ev for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 13:18:47 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041028201933.76C984F752@zion.localdomain>
Subject: [uml-devel] [patch 1/1] uml: fix mainline lazyness about TTY layer
	patch
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
Date: Thu, 28 Oct 2004 22:19:33 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


While changing the TTY layer, an API parameter was removed, so it was removed
by almost all calls, changing their prototype. But one use of one such
function was not updated, breaking UML compilation. This is the fix.

Should go in directly - trivial fix.

Thanks for the breakage, too :-).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/drivers/line.c |    2 --
 vanilla-linux-2.6.9-paolo/arch/um/drivers/ssl.c  |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff -puN arch/um/drivers/ssl.c~uml-mainline-is-lazy-fix arch/um/drivers/ssl.c
--- vanilla-linux-2.6.9/arch/um/drivers/ssl.c~uml-mainline-is-lazy-fix	2004-10-27 01:47:58.000000000 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/drivers/ssl.c	2004-10-27 01:48:07.000000000 +0200
@@ -119,7 +119,7 @@ static int ssl_write(struct tty_struct *
 
 static void ssl_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	line_write(serial_lines, tty, 0, &ch, sizeof(ch));
+	line_write(serial_lines, tty, &ch, sizeof(ch));
 }
 
 static void ssl_flush_chars(struct tty_struct *tty)
diff -puN arch/um/drivers/line.c~uml-mainline-is-lazy-fix arch/um/drivers/line.c
--- vanilla-linux-2.6.9/arch/um/drivers/line.c~uml-mainline-is-lazy-fix	2004-10-27 01:49:16.000000000 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/drivers/line.c	2004-10-27 01:49:47.000000000 +0200
@@ -110,7 +110,6 @@ static int flush_buffer(struct line *lin
 int line_write(struct line *lines, struct tty_struct *tty, const char *buf, int len)
 {
 	struct line *line;
-	char *new;
 	unsigned long flags;
 	int n, err, i, ret = 0;
 
@@ -143,7 +142,6 @@ int line_write(struct line *lines, struc
 	}
  out_up:
 	up(&line->sem);
- out_free:
 	return(ret);
 }
 
_


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
