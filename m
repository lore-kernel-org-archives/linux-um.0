Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1756580AbZGHQC1@vger.kernel.org>
Subject: [PATCH 17/44] includecheck fix: um, helper.c
From: Jaswinder Singh Rajput <jaswinder@kernel.org>
In-Reply-To: <1247063308.4382.12.camel@ht.satnam>
References: <1247063308.4382.12.camel@ht.satnam>
Content-Type: text/plain
Date: Wed, 08 Jul 2009 20:25:50 +0530
Message-Id: <1247064950.4382.45.camel@ht.satnam>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


fix the following 'make includecheck' warning:

  arch/um/os-Linux/helper.c: linux/limits.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 arch/um/os-Linux/helper.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 30860b8..b6b1096 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -15,7 +15,6 @@
 #include "os.h"
 #include "um_malloc.h"
 #include "user.h"
-#include <linux/limits.h>
 
 struct helper_data {
 	void (*pre_exec)(void*);
-- 
1.6.0.6



