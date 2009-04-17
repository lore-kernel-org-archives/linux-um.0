Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1759763AbZDQJTg@vger.kernel.org>
Date: Fri, 17 Apr 2009 17:20:29 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: [Patch] uml: kill a kconfig warning
Message-ID: <20090417092028.GB31897@hack>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


Got this warning from Kconfig:

   boolean symbol INPUT tested for 'm'? test forced to 'n'

because INPUT is tristate, not bool. The patch below fixes it.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jeff Dike <jdike@addtoit.com>

--
diff --git a/arch/um/Kconfig.rest b/arch/um/Kconfig.rest
index 7b5cea7..0ccad0f 100644
--- a/arch/um/Kconfig.rest
+++ b/arch/um/Kconfig.rest
@@ -36,7 +36,7 @@ source "drivers/leds/Kconfig"
 
 #This is just to shut up some Kconfig warnings, so no prompt.
 config INPUT
-	bool
+	tristate
 	default n
 
 source "arch/um/Kconfig.debug"

