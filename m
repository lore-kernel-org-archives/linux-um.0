Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrSZH-004C0s-Kg
 for linux-um@lists.infradead.org; Wed, 18 May 2022 22:55:00 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 18 May 2022 17:53:48 -0500
Message-Id: <20220518225355.784371-9-ebiederm@xmission.com>
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: [PATCH 09/16] ptrace: In ptrace_setsiginfo deal with invalid si_signo
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
Cc: rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org, Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Douglas Miller <dougmill@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Eric W. Biederman" <ebiederm@xmission.com>

If the tracer calls PTRACE_SETSIGINFO it only has an effect if the
tracee is stopped in ptrace_signal.

When one of PTRACE_DETACH, PTRACE_SINGLESTEP, PTRACE_SINGLEBLOCK,
PTRACE_SYSEMU, PTRACE_SYSEMU_SINGLESTEP, PTRACE_SYSCALL, or
PTRACE_CONT pass in a signel number to continue with the kernel
validates that signal number and the ptrace_signal verifies the signal
number matches the si_signo, before the siginfo is used.

As the signal number to continue with is verified to be a valid signal
number the signal number in si_signo must be a valid signal number.

Make this obvious and avoid needing checks later by immediately
clearing siginfo if si_signo is not valid.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index a24eed725cec..a0a07d140751 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -716,7 +716,9 @@ static int ptrace_setsiginfo(struct task_struct *child, const kernel_siginfo_t *
 	if (unlikely(!child->last_siginfo))
 		return -EINVAL;
 
-	copy_siginfo(child->last_siginfo, info);
+	clear_siginfo(child->last_siginfo);
+	if (valid_signal(info->si_signo))
+		copy_siginfo(child->last_siginfo, info);
 	return 0;
 }
 
-- 
2.35.3


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

