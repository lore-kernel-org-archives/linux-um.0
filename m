Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njbpj-000Bur-Iw
 for linux-um@lists.infradead.org; Wed, 27 Apr 2022 07:11:36 +0000
Message-ID: <f6d31801de631dfe6e1a2da25370cddf2aca32ad.camel@sipsolutions.net>
Subject: Re: [PATCH 3/9] ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 27 Apr 2022 09:10:47 +0200
In-Reply-To: <20220426225211.308418-3-ebiederm@xmission.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-3-ebiederm@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

On Tue, 2022-04-26 at 17:52 -0500, Eric W. Biederman wrote:
> User mode linux is the last user of the PT_DTRACE flag.  Using the flag to indicate
> single stepping is a little confusing and worse changing tsk->ptrace without locking
> could potentionally cause problems.
> 
> So use a thread info flag with a better name instead of flag in tsk->ptrace.
> 
> Remove the definition PT_DTRACE as uml is the last user.


Looks fine to me.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

Looking at pending patches, I don't see any conflicts from this. I'm
guessing anyway you'll want/need to take these through some tree all
together.

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

