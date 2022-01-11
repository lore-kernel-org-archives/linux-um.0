Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx1.uni-rostock.de ([139.30.22.71])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7PYs-000Lmg-FX
 for linux-um@lists.infradead.org; Tue, 11 Jan 2022 22:24:16 +0000
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Subject: [PATCH] um: add generated capflags.c to gitignore
Date: Tue, 11 Jan 2022 22:23:53 +0000
Message-ID: <20220111222353.1501350-1-benjamin.beichler@uni-rostock.de>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/.gitignore b/arch/um/.gitignore
index 6323e5571887..8168b3bc08b8 100644
--- a/arch/um/.gitignore
+++ b/arch/um/.gitignore
@@ -2,3 +2,4 @@
 kernel/config.c
 kernel/config.tmp
 kernel/vmlinux.lds
+capflags.c
\ No newline at end of file
-- 
2.25.1

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

