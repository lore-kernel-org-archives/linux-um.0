Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk1dd-00Fyvf-LE
 for linux-um@lists.infradead.org; Mon, 08 Nov 2021 10:12:31 +0000
From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH v0 25/42] arch/um: Check notifier registration return value
Date: Mon,  8 Nov 2021 11:11:40 +0100
Message-Id: <20211108101157.15189-26-bp@alien8.de>
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-um@lists.infradead.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-um@lists.infradead.org
---
 arch/um/drivers/mconsole_kern.c | 6 ++++--
 arch/um/kernel/um_arch.c        | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 6ead1e240457..ceea940c0aa0 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -856,8 +856,10 @@ static struct notifier_block panic_exit_notifier = {
 
 static int add_notifier(void)
 {
-	atomic_notifier_chain_register(&panic_notifier_list,
-			&panic_exit_notifier);
+	if (atomic_notifier_chain_register(&panic_notifier_list,
+					   &panic_exit_notifier))
+		pr_warn("UM console panic notifier already registered\n");
+
 	return 0;
 }
 
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 54447690de11..6c0e562ff0b7 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -255,8 +255,9 @@ static struct notifier_block panic_exit_notifier = {
 
 void uml_finishsetup(void)
 {
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &panic_exit_notifier);
+	if (atomic_notifier_chain_register(&panic_notifier_list,
+					   &panic_exit_notifier))
+		pr_warn("UM panic notifier already registered\n");
 
 	uml_postsetup();
 
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

