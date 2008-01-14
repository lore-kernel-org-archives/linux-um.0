Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JEWz1-0000ea-6s for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jan 2008 13:36:39 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JEWyw-00085o-IS
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jan 2008 13:36:36 -0800
Received: from c2.user-mode-linux.org (littleton.addtoit.com [198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id m0ELaSCf021912
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 14 Jan 2008 16:36:29 -0500
Received: from c2.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by c2.user-mode-linux.org (8.14.1/8.13.8) with ESMTP id m0ELaSoZ002587
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 14 Jan 2008 16:36:28 -0500
Date: Mon, 14 Jan 2008 16:36:28 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080114213628.GA2480@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 1/10] SKAS4 - Fix x86_64 arch_copy_thread
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
To: UML-user <user-mode-linux-devel@lists.sourceforge.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

    Fix a bug which will be important later.  x86_64 copy_thread needs to
    copy %fs from parent to child.

diff --git a/include/asm-um/processor-x86_64.h b/include/asm-um/processor-x86_64.h
index d946bf2..0528d9e 100644
--- a/include/asm-um/processor-x86_64.h
+++ b/include/asm-um/processor-x86_64.h
@@ -37,6 +37,7 @@ static inline void arch_flush_thread(struct arch_thread *thread)
 static inline void arch_copy_thread(struct arch_thread *from,
                                     struct arch_thread *to)
 {
+	to->fs = from->fs;
 }
 
 #include "asm/arch/user.h"

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
