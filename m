Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kbfhz-0003u7-Po for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 11:06:59 -0700
Received: from mail-gx0-f19.google.com ([209.85.217.19])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kbfhz-0006bk-F5
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 11:06:59 -0700
Received: by gxk12 with SMTP id 12so7023347gxk.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 05 Sep 2008 11:06:53 -0700 (PDT)
Message-ID: <ea9232d10809051106h3c678eebq2f9f56dc20823270@mail.gmail.com>
Date: Fri, 5 Sep 2008 20:06:53 +0200
From: "Karol Swietlicki" <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] Removing an unused variable in trap.c
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This patch gets rid of an unused variable in bad_segv.
Compile tested.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
---
diff -rupN linux27r1m1-original/arch/um/kernel/trap.c
linux-2.6.27-rc1-mm1/arch/um/kernel/trap.c
--- linux27r1m1-original/arch/um/kernel/trap.c	2008-09-04
18:32:50.000000000 +0200
+++ linux-2.6.27-rc1-mm1/arch/um/kernel/trap.c	2008-09-05
19:00:45.000000000 +0200
@@ -118,7 +118,7 @@ out_of_memory:
 	goto out;
 }

-static void bad_segv(struct faultinfo fi, unsigned long ip)
+static void bad_segv(struct faultinfo fi)
 {
 	struct siginfo si;

@@ -146,7 +146,7 @@ void segv_handler(int sig, struct uml_pt
 	struct faultinfo * fi = UPT_FAULTINFO(regs);

 	if (UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)) {
-		bad_segv(*fi, UPT_IP(regs));
+		bad_segv(*fi);
 		return;
 	}
 	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
