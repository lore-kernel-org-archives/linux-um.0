Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyL1J-002ycG-RM
	for linux-um@lists.infradead.org; Mon, 06 Jun 2022 22:16:23 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
	<20220518225355.784371-8-ebiederm@xmission.com>
	<20220524152725.GE14347@redhat.com>
Date: Mon, 06 Jun 2022 17:16:01 -0500
In-Reply-To: <20220524152725.GE14347@redhat.com> (Oleg Nesterov's message of
	"Tue, 24 May 2022 17:27:25 +0200")
Message-ID: <87pmjl1lr2.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 08/16] ptrace: Only populate last_siginfo from ptrace
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
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org, Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Douglas Miller <dougmill@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/18, Eric W. Biederman wrote:
>>
>> The code in ptrace_signal to populate siginfo if the signal number
>> changed is buggy.  If the tracer contined the tracee using
>> ptrace_detach it is guaranteed to use the real_parent (or possibly a
>> new tracer) but definitely not the origional tracer to populate si_pid
>> and si_uid.
>
> I guess nobody cares. As the comment says
>
> 	 If the debugger wanted something
> 	 specific in the siginfo structure then it should
> 	 have updated *info via PTRACE_SETSIGINFO.
>
> otherwise I don't think si_pid/si_uid have any value.

No one has complained so it is clearly no one cares.  So it is
definitely not a regression.  Or even anything that needs to be
backported.

However si_pid and si_uid are defined with SI_USER are defined
to be whomever sent the signal.  So I would argue by definition
those values are wrong.

> However the patch looks fine to me, just the word "buggy" looks a bit
> too strong imo.

I guess I am in general agreement.  Perhaps I can just say they values
are wrong by definition?

Eric



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

