Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 552/671] um: Fix off by one error in IRQ enumeration
Date: Thu, 16 Jan 2020 12:03:10 -0500
Message-Id: <20200116170509.12787-289-sashal@kernel.org>
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>, Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

[ Upstream commit 09ccf0364ca3e94aba4093707ef433ea8014e2a4 ]

Fix an off-by-one in IRQ enumeration

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Reported by: Dana Johnson <djohns042@gmail.com>
Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/include/asm/irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
index 49ed3e35b35a..ce7a78c3bcf2 100644
--- a/arch/um/include/asm/irq.h
+++ b/arch/um/include/asm/irq.h
@@ -23,7 +23,7 @@
 #define VECTOR_BASE_IRQ		15
 #define VECTOR_IRQ_SPACE	8
 
-#define LAST_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ)
+#define LAST_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ - 1)
 
 #else
 
-- 
2.20.1


