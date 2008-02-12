Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JP2eR-0002rF-Ua for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 13:26:53 -0800
Received: from fg-out-1718.google.com ([72.14.220.157])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JP2eQ-0000ur-Hp
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 13:26:51 -0800
Received: by fg-out-1718.google.com with SMTP id d23so4187370fga.32
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Feb 2008 13:26:49 -0800 (PST)
Message-ID: <47B20F17.3050308@gmail.com>
Date: Tue, 12 Feb 2008 22:26:47 +0100
From: Jiri Olsa <olsajiri@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] uml: adding include/asm generate rule
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

Hi,

I noticed UML does not create include/asm symlink automatically.
I found this during solving another issue, so I dont know if this
really helps or it is useless..

Signed-off-by: Jiri Olsa <olsajiri@gmail.com>
---
 arch/um/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index dbeab15..8708a56 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -29,7 +29,7 @@ SYMLINK_HEADERS := $(foreach header,$(SYMLINK_HEADERS),include/asm-um/$(header))
 # These are cleaned up during mrproper. Please DO NOT fix it again, this is
 # the Correct Thing(tm) to do!
 ARCH_SYMLINKS = include/asm-um/arch $(ARCH_DIR)/include/sysdep $(ARCH_DIR)/os \
-	$(SYMLINK_HEADERS) $(ARCH_DIR)/include/uml-config.h
+	$(SYMLINK_HEADERS) $(ARCH_DIR)/include/uml-config.h include/asm
 
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/skas
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
