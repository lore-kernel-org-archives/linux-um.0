Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1May9K-0003rU-KS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Aug 2009 20:40:50 +0000
Received: from mail-ew0-f210.google.com ([209.85.219.210])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1May9E-0000ST-BF for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Aug 2009 20:40:50 +0000
Received: by ewy6 with SMTP id 6so2230456ewy.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 11 Aug 2009 13:40:37 -0700 (PDT)
Message-ID: <4A81D831.5090808@gmail.com>
Date: Tue, 11 Aug 2009 22:44:33 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] uml: Read buffer overflow
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
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

Prevent write to write init->argw.argv[SLIRP_MAX_ARGS]

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
If i becomes SLIRP_MAX_ARGS - 1 and `*str != ','` evaluates to
true, then we write init->argw.argv[SLIRP_MAX_ARGS].

Can this occur?

diff --git a/arch/um/drivers/slirp_kern.c b/arch/um/drivers/slirp_kern.c
index e376284..39bc9a7 100644
--- a/arch/um/drivers/slirp_kern.c
+++ b/arch/um/drivers/slirp_kern.c
@@ -97,6 +97,9 @@ static int slirp_setup(char *str, char **mac_out, void *data)
 		*str++ = '\0';
 	} while (1);
 
+	if (i == SLIRP_MAX_ARGS)
+		i--;
+
 	init->argw.argv[i] = NULL;
 	return 1;
 }

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

