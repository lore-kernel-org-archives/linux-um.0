Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMRdB-0005QJ-DT
 for linux-um@lists.infradead.org; Tue, 13 Nov 2018 05:52:59 +0000
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 05/11] um: Give start_idle_thread() a return code
Date: Tue, 13 Nov 2018 00:52:36 -0500
Message-Id: <20181113055242.79261-5-sashal@kernel.org>
In-Reply-To: <20181113055242.79261-1-sashal@kernel.org>
References: <20181113055242.79261-1-sashal@kernel.org>
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
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org

From: Richard Weinberger <richard@nod.at>

[ Upstream commit 7ff1e34bbdc15acab823b1ee4240e94623d50ee8 ]

Fixes:
arch/um/os-Linux/skas/process.c:613:1: warning: control reaches end of
non-void function [-Wreturn-type]

longjmp() never returns but gcc still warns that the end of the function
can be reached.
Add a return code and debug aid to detect this impossible case.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/skas/process.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index b856c66ebd3a..6dbf27ffafc8 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -585,6 +585,11 @@ int start_idle_thread(void *stack, jmp_buf *switch_buf)
 		fatal_sigsegv();
 	}
 	longjmp(*switch_buf, 1);
+
+	/* unreachable */
+	printk(UM_KERN_ERR "impossible long jump!");
+	fatal_sigsegv();
+	return 0;
 }
 
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
-- 
2.17.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

