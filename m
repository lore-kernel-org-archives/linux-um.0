Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nsBdC-00EqmW-G0
 for linux-um@lists.infradead.org; Fri, 20 May 2022 23:02:03 +0000
Received: by mail-ej1-x636.google.com with SMTP id y13so17355429eje.2
 for <linux-um@lists.infradead.org>; Fri, 20 May 2022 16:01:59 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47]) by smtp.gmail.com with ESMTPSA id
 cy23-20020a0564021c9700b0042617ba63c8sm4948228edb.82.2022.05.20.16.01.56
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 May 2022 16:01:57 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id r23so13299469wrr.2
 for <linux-um@lists.infradead.org>; Fri, 20 May 2022 16:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <20220518225355.784371-3-ebiederm@xmission.com>
 <CAD=FV=UFK7h0oHGJ23y37ShO+z4vt9ubGE9E4m=jMECgNAAHgA@mail.gmail.com>
 <8735h52ief.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <8735h52ief.fsf@email.froward.int.ebiederm.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 20 May 2022 16:01:43 -0700
Message-ID: <CAD=FV=UxzB=jZuNtg--BFfKm_=7_Bex7G5fbjkV6Vf_tJQ+dTw@mail.gmail.com>
Subject: Re: [PATCH 03/16] kdb: Use real_parent when displaying a list of
 processes
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org, Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Miller <dougmill@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

Hi,

On Thu, May 19, 2022 at 4:49 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Doug Anderson <dianders@chromium.org> writes:
>
> > Hi,
> >
> > On Wed, May 18, 2022 at 3:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> kdb has a bug that when using the ps command to display a list of
> >> processes, if a process is being debugged the debugger as the parent
> >> process.
> >>
> >> This is silly, and I expect it never comes up in ptractice.  As there
> >> is very little point in using gdb and kdb simultaneously.  Update the
> >> code to use real_parent so that it is clear kdb does not want to
> >> display a debugger as the parent of a process.
> >
> > So I would tend to defer to Daniel, but I'm not convinced that the
> > behavior you describe for kdb today _is_ actually silly.
> >
> > If I was in kdb and I was listing processes, I might actually want to
> > see that a process's parent was set to gdb. Presumably that would tell
> > me extra information that might be relevant to my debug session.
> >
> > Personally, I'd rather add an extra piece of information into the list
> > showing the real parent if it's not the same as the parent. Then
> > you're not throwing away information.
>
> The name of the field is confusing for anyone who isn't intimate with
> the implementation details.  The function getppid returns
> tsk->real_parent->tgid.
>
> If kdb wants information of what the tracer is that is fine, but I
> recommend putting that information in another field.
>
> Given that the original description says give the information that ps
> gives my sense is that kdb is currently wrong.  Especially as it does
> not give you the actual parentage anywhere.
>
> I can certainly be convinced, but I do want some clarity.  It looks very
> attractive to rename task->parent to task->ptracer and leave the field
> NULL when there is no tracer.

Fair enough. You can consider my objection rescinded.

Presumably, though, you're hoping for an Ack for your patch and you
plan to take it with the rest of the series. That's going to need to
come from Daniel anyway as he is the actual maintainer. I'm just the
peanut gallery. ;-)

-Doug

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

