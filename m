Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEZak-0001D3-Ls
 for linux-um@lists.infradead.org; Tue, 23 Feb 2021 15:27:16 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 3/7] um: remove unused smp_sigio_handler() declaration
Date: Tue, 23 Feb 2021 16:27:03 +0100
Message-Id: <20210223161449.bef71f0bbee7.I479aba3ebfb7a6418255b7a51c5c2cfe3796e9a2@changeid>
In-Reply-To: <20210223152707.408995-1-johannes@sipsolutions.net>
References: <20210223152707.408995-1-johannes@sipsolutions.net>
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
To: linux-um@lists.infradead.org
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

This function doesn't exist, remove its declaration.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/kern_util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 2888ec812f6e..a2cfd42608a0 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -33,7 +33,6 @@ extern int handle_page_fault(unsigned long address, unsigned long ip,
 			     int is_write, int is_user, int *code_out);
 
 extern unsigned int do_IRQ(int irq, struct uml_pt_regs *regs);
-extern int smp_sigio_handler(void);
 extern void initial_thread_cb(void (*proc)(void *), void *arg);
 extern int is_syscall(unsigned long addr);
 
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

