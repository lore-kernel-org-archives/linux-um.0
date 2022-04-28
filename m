Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk8nF-0089W9-76
 for linux-um@lists.infradead.org; Thu, 28 Apr 2022 18:23:11 +0000
Date: Thu, 28 Apr 2022 20:22:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
Message-ID: <20220428182257.GE15485@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-6-ebiederm@xmission.com>
 <20220427141018.GA17421@redhat.com>
 <874k2ea9q4.fsf@email.froward.int.ebiederm.org>
 <87zgk67fdd.fsf@email.froward.int.ebiederm.org>
 <YmrSijTc6HIv4sAG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YmrSijTc6HIv4sAG@hirez.programming.kicks-ass.net>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

On 04/28, Peter Zijlstra wrote:
>
> I've not had time to fully appreciate the nested locking here, but if it
> is possible to rework things to always take both locks at the same time,
> then it would be possible to impose an arbitrary lock order on things
> and break the cycle that way.

This is clear, but this is not that simple.

For example (with this series at least), ptrace_stop() already holds
current->sighand->siglock which (in particular) we need to protect
current->parent, but then we need current->parent->sighand->siglock
in do_notify_parent_cldstop().

Oleg.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

