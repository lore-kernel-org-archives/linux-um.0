Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
Date: Sun, 31 Jul 2011 00:01:23 +0100
In-Reply-To: <1312066693.22074.50.camel@i7.infradead.org>
References: <1312066693.22074.50.camel@i7.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1312066917.22074.52.camel@i7.infradead.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 2/5] um: Remove gratuitous use of $(SUBARCH) in Makefile-i386
To: Arnaud Lacombe <lacombar@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

If we're in Makefile-i386, we know what the target architecture is.
Don't try to be cute.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 arch/um/Makefile-i386 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
index 302cbe5..75b3309 100644
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -5,8 +5,8 @@ TOP_ADDR := $(CONFIG_TOP_ADDR)
 START := 0x8048000
 
 LDFLAGS			+= -m elf_i386
-ELF_ARCH		:= $(SUBARCH)
-ELF_FORMAT 		:= elf32-$(SUBARCH)
+ELF_ARCH		:= i386
+ELF_FORMAT 		:= elf32-i386
 OBJCOPYFLAGS  		:= -O binary -R .note -R .comment -S
 HEADER_ARCH		:= x86
 CHECKFLAGS	+= -D__i386__
-- 
1.7.6



