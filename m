Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 143/219] um: Include sys/uio.h to have writev()
Date: Fri, 22 Nov 2019 00:47:55 -0500
Message-Id: <20191122054911.1750-136-sashal@kernel.org>
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

From: Richard Weinberger <richard@nod.at>

[ Upstream commit 0053102a869f1b909904b1b85ac282e2744deaab ]

sys/uio.h gives us writev(), otherwise the build might fail on
some systems.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/vector_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 4d6a78e31089f..00c4c2735a5f7 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -30,6 +30,7 @@
 #include <stdlib.h>
 #include <os.h>
 #include <um_malloc.h>
+#include <sys/uio.h>
 #include "vector_user.h"
 
 #define ID_GRE 0
-- 
2.20.1


