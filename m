Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGiHW-000157-Sp for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:51:10 -0800
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DGiHV-0000Pg-VV for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:51:10 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050330173403.477AEEFF28@zion>
Subject: [uml-devel] [patch 7/8] uml: correct error message [for 2.6.12]
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
Date: Wed, 30 Mar 2005 19:34:03 +0200
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, Anthony_Brock@ous.edu


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, "Anthony Brock" <Anthony_Brock@ous.edu>

Replace the message with a more meaningful one. Noted by Anthony Brock.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/um_arch.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/um_arch.c~uml-correct-message arch/um/kernel/um_arch.c
--- linux-2.6.11/arch/um/kernel/um_arch.c~uml-correct-message	2005-03-24 03:04:59.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/um_arch.c	2005-03-24 03:05:36.000000000 +0100
@@ -47,7 +47,7 @@ char command_line[COMMAND_LINE_SIZE] = {
 void add_arg(char *arg)
 {
 	if (strlen(command_line) + strlen(arg) + 1 > COMMAND_LINE_SIZE) {
-		printf("add_arg: Too much command line!\n");
+		printf("add_arg: Too many command line arguments!\n");
 		exit(1);
 	}
 	if(strlen(command_line) > 0)
_


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
