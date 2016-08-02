Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0030/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:35:42 +0800
Message-Id: <20160802103542.15773-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 arch/um/drivers/hostaudio_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index 3a4b587..3fc34a0 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -40,9 +40,9 @@ static char *mixer = HOSTAUDIO_DEV_MIXER;
 "    This is used to specify the host mixer device to the hostaudio driver.\n"\
 "    The default is \"" HOSTAUDIO_DEV_MIXER "\".\n\n"
 
-module_param(dsp, charp, 0644);
+module_param(dsp, charp, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dsp, DSP_HELP);
-module_param(mixer, charp, 0644);
+module_param(mixer, charp, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mixer, MIXER_HELP);
 
 #ifndef MODULE
-- 
2.9.2


