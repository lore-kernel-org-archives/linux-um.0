Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vitalivanov@gmail.com>) id 1QerX3-0005UA-4z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jul 2011 16:34:29 +0000
Received: from mail-bw0-f46.google.com ([209.85.214.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QerX2-0004r9-Ee
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jul 2011 16:34:29 +0000
Received: by bwd5 with SMTP id 5so1636899bwd.33
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 07 Jul 2011 09:34:22 -0700 (PDT)
From: Vitaliy Ivanov <vitalivanov@gmail.com>
Date: Thu, 07 Jul 2011 19:36:02 +0300
Message-ID: <1310056562.3528.49.camel@vivanov>
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 1/3] uml: drivers/net_user.c memory leak fix
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: vitalivanov@gmail.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

>>From 9b9f36f46aa708c3245f5ded83f96421966b2edf Mon Sep 17 00:00:00 2001
From: Vitaliy Ivanov <vitalivanov@gmail.com>
Date: Thu, 7 Jul 2011 19:23:13 +0300
Subject: [PATCH 1/3] uml: drivers/net_user.c memory leak fix

Perform memory cleanup on exit.
On receiving invalid 'pid' we still should clean 'output' variable.

Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
---
 arch/um/drivers/net_user.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
index 9415dd9..989b653 100644
--- a/arch/um/drivers/net_user.c
+++ b/arch/um/drivers/net_user.c
@@ -228,10 +228,11 @@ static void change(char *dev, char *what, unsigned char *addr,
 		       "buffer\n");
 
 	pid = change_tramp(argv, output, output_len);
-	if (pid < 0) return;
 
 	if (output != NULL) {
-		printk("%s", output);
+		if (pid >= 0) {
+			printk("%s", output);
+		}
 		kfree(output);
 	}
 }
-- 
1.7.0.4




------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

