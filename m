Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkYUE-00Cpuv-Gf
 for linux-um@lists.infradead.org; Fri, 29 Apr 2022 21:49:16 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 29 Apr 2022 16:48:31 -0500
Message-Id: <20220429214837.386518-6-ebiederm@xmission.com>
In-Reply-To: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: [PATCH v2 06/12] ptrace: Reimplement PTRACE_KILL by always sending
 SIGKILL
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
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

Call send_sig_info in PTRACE_KILL instead of ptrace_resume.  Calling
ptrace_resume is not safe to call if the task has not been stopped
with ptrace_freeze_traced.

Cc: stable@vger.kernel.org
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index ccc4b465775b..43da5764b6f3 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1238,7 +1238,7 @@ int ptrace_request(struct task_struct *child, long request,
 	case PTRACE_KILL:
 		if (child->exit_state)	/* already dead */
 			return 0;
-		return ptrace_resume(child, request, SIGKILL);
+		return send_sig_info(SIGKILL, SEND_SIG_NOINFO, child);
 
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	case PTRACE_GETREGSET:
-- 
2.35.3


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

