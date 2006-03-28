Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FON9R-0005bd-1s for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:59:01 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FON9Q-0001bR-NJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:59:01 -0800
Message-Id: <200603282300.k2SN0JaP023007@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 10/10] UML - Fix min usage
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
Date: Tue, 28 Mar 2006 18:00:19 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk

From: Al Viro <viro@zeniv.linux.org.uk>
type-safe min() in arch/um/drivers/mconsole_kern.c

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

 arch/um/drivers/mconsole_kern.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Index: linux-2.6.16-mm/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/mconsole_kern.c	2006-03-28 09:30:36.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/mconsole_kern.c	2006-03-28 09:40:36.000000000 -0500
@@ -616,7 +616,7 @@ static void console_write(struct console
 		return;
 
 	while(1){
-		n = min(len, ARRAY_SIZE(console_buf) - console_index);
+		n = min((size_t)len, ARRAY_SIZE(console_buf) - console_index);
 		strncpy(&console_buf[console_index], string, n);
 		console_index += n;
 		string += n;



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
