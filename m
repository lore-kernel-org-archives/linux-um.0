Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXQAF-0001z1-09
 for linux-um@lists.infradead.org; Wed, 20 Nov 2019 13:37:00 +0000
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] um: Fix Kconfig indentation
Date: Wed, 20 Nov 2019 21:36:54 +0800
Message-Id: <20191120133654.11838-1-krzk@kernel.org>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/um/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index fec6b4ca2b6e..2a6d04fcb3e9 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -153,7 +153,7 @@ config KERNEL_STACK_ORDER
 	  It is possible to reduce the stack to 1 for 64BIT and 0 for 32BIT on
 	  older (pre-2017) CPUs. It is not recommended on newer CPUs due to the
 	  increase in the size of the state which needs to be saved when handling
-          signals.
+	  signals.
 
 config MMAPPER
 	tristate "iomem emulation driver"
-- 
2.17.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

