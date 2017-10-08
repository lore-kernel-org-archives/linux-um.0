Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] um: Fix kcov crash before kernel is started.
Date: Sun,  8 Oct 2017 12:31:58 +0200
Message-Id: <20171008103158.14107-1-thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, richard@nod.at
Cc: Thomas Meyer <thomas@m3y3r.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

UMLs current_thread_info() unconditionally assumes that the top of the stack
contains the thread_info structure. But on UML the __sanitizer_cov_trace_pc
function is called for *all* functions! This results in an early crash:

Prevent kcov from using invalid curent_thread_info() data by checking
the system_state.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 kernel/kcov.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 3f693a0f6f3e..d601c0e956f6 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -56,6 +56,12 @@ void notrace __sanitizer_cov_trace_pc(void)
 	struct task_struct *t;
 	enum kcov_mode mode;
 
+#ifdef CONFIG_UML
+	if(!(system_state == SYSTEM_SCHEDULING ||
+	     system_state == SYSTEM_RUNNING))
+		return;
+#endif
+
 	t = current;
 	/*
 	 * We are interested in code coverage as a function of a syscall inputs,
-- 
2.11.0


