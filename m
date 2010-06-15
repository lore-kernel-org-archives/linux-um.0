Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Jun 2010 16:06:16 +0800
Message-ID: <AANLkTikziSEDW07YiiJs6ny6JLhSQ-TGvdw_kTroIIx5@mail.gmail.com>
Subject: [PATCH] um: Include missing header file in os-linux/mem.c
From: Liu Aleaxander <aleaxander@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The os-linux/mem.c file calls fchmod function, which is declared in sys/stat.h
header file, so include it.

Signed-off-by: Liu Aleaxander <Aleaxander@gmail.com>
---
 arch/um/os-Linux/mem.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 93a11d7..e696144 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <string.h>
+#include <sys/stat.h>
 #include <sys/mman.h>
 #include <sys/param.h>
 #include "init.h"


-- 
Thanks & regards
Liu Aleaxander
