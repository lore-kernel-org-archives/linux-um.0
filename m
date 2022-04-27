Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njhqQ-001ane-PS
 for linux-um@lists.infradead.org; Wed, 27 Apr 2022 13:36:40 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-5-ebiederm@xmission.com>
 <YmjlScztfmfWBfGi@linutronix.de>
Date: Wed, 27 Apr 2022 08:35:47 -0500
In-Reply-To: <YmjlScztfmfWBfGi@linutronix.de> (Sebastian Andrzej Siewior's
 message of "Wed, 27 Apr 2022 08:40:09 +0200")
Message-ID: <87tuaebqdo.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5/9] signal: Protect parent child relationships by
 childs siglock
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
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2022-04-26 17:52:07 [-0500], Eric W. Biederman wrote:
>> The functions ptrace_stop and do_signal_stop have to drop siglock
>> and grab tasklist_lock because the parent/child relation ship
>> is guarded by siglock and not siglock.
>
>  "is guarded by tasklist_lock and not siglock." ?

Yes.   Thank you.  I will fix that.

>> Simplify things by guarding the parent/child relationship
>> with siglock.  For the most part this just requires a little bit
>> of code motion.  In a couple of places more locking was needed.
>> 
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Sebastian

Eric

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

