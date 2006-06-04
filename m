Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FnRhH-0006cY-Cv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 19:53:35 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FmiA1-0000zF-12 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jun 2006 19:16:13 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fmi9o-0005Jk-41
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jun 2006 19:16:04 -0700
Message-Id: <200606040216.k542GBfm004822@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Sat, 03 Jun 2006 22:16:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 0/6] UML - small fixes and cleanups for 2.6.17
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The following patches are small changes which either fix important bugs or
which have no functional effect.

The first one, which adds include/asm-um/irqflags.h should go to mainline
when (or if) the lock validator does.

				Jeff



_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
