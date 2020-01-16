Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 175/205] um: Don't trace irqflags during shutdown
Date: Thu, 16 Jan 2020 11:42:30 -0500
Message-Id: <20200116164300.6705-175-sashal@kernel.org>
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>, Richard Weinberger <richard@nod.at>, Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 5c1f33e2a03c0b8710b5d910a46f1e1fb0607679 ]

In the main() code, we eventually enable signals just before
exec() or exit(), in order to to not have signals pending and
delivered *after* the exec().

I've observed SIGSEGV loops at this point, and the reason seems
to be the irqflags tracing; this makes sense as the kernel is
no longer really functional at this point. Since there's really
no reason to use unblock_signals_trace() here (I had just done
a global search & replace), use the plain unblock_signals() in
this case to avoid going into the no longer functional kernel.

Fixes: 0dafcbe128d2 ("um: Implement TRACE_IRQFLAGS_SUPPORT")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 8014dfac644d..c8a42ecbd7a2 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -170,7 +170,7 @@ int __init main(int argc, char **argv, char **envp)
 	 * that they won't be delivered after the exec, when
 	 * they are definitely not expected.
 	 */
-	unblock_signals_trace();
+	unblock_signals();
 
 	os_info("\n");
 	/* Reboot */
-- 
2.20.1


