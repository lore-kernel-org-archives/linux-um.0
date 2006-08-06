Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G9kq5-0002pJ-HG for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Aug 2006 08:46:53 -0700
Received: from host17-96.pool873.interbusiness.it ([87.3.96.17]
	helo=memento.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1G9kq4-0007Ax-1Z for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Aug 2006 08:46:53 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 06 Aug 2006 17:47:00 +0200
Message-Id: <20060806154700.536.32978.stgit@memento.home.lan>
Subject: [uml-devel] [PATCH 1/3] uml: use -mcmodel=kernel for x86_64
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

We have never used this flag and recently one user experienced a complaining
warning about this (there was a symbol in the positive half of the address space
IIRC). So fix it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile-x86_64 |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index 9558a7c..11154b6 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -4,10 +4,13 @@ # Released under the GPL
 core-y += arch/um/sys-x86_64/
 START := 0x60000000
 
+_extra_flags_ = -fno-builtin -m64 -mcmodel=kernel
+
 #We #undef __x86_64__ for kernelspace, not for userspace where
 #it's needed for headers to work!
-CFLAGS += -U__$(SUBARCH)__ -fno-builtin -m64
-USER_CFLAGS += -fno-builtin -m64
+CFLAGS += -U__$(SUBARCH)__ $(_extra_flags_)
+USER_CFLAGS += $(_extra_flags_)
+
 CHECKFLAGS  += -m64
 AFLAGS += -m64
 LDFLAGS += -m elf_x86_64

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
