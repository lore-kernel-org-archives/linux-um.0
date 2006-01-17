Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez0FG-0005E4-KG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 15:28:10 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ez0FC-0006SW-2N
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 15:28:10 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060117232626.11417.66832.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH] uml: remove leftover from patch revertal
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
Date: Wed, 18 Jan 2006 00:26:27 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I added this line to share this file with UML, but now it's no longer shared so
remove this useless leftover.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-i386/futex.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-i386/futex.h b/include/asm-i386/futex.h
index e7a271d..44b9db8 100644
--- a/include/asm-i386/futex.h
+++ b/include/asm-i386/futex.h
@@ -61,7 +61,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	if (op == FUTEX_OP_SET)
 		__futex_atomic_op1("xchgl %0, %2", ret, oldval, uaddr, oparg);
 	else {
-#if !defined(CONFIG_X86_BSWAP) && !defined(CONFIG_UML)
+#ifndef CONFIG_X86_BSWAP
 		if (boot_cpu_data.x86 == 3)
 			ret = -ENOSYS;
 		else



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
