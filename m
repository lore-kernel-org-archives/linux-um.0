Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTik5_TCXeGzTWBZzE8F0Cb2bQq-D228xDXk87rhP@mail.gmail.com>
References: <AANLkTinNxzktyttzEjWSUPBiOUwh+4DUL0tmP7p1UiT5@mail.gmail.com>
	<4CB75F05.9070505@linux.intel.com>
	<AANLkTik5_TCXeGzTWBZzE8F0Cb2bQq-D228xDXk87rhP@mail.gmail.com>
Date: Fri, 15 Oct 2010 10:02:56 +0300
Message-ID: <AANLkTi=vYFv+S=D6O06Nys4cjU7KHWv11d_VdLGmLyf6@mail.gmail.com>
Subject: Re: [REGRESSION] um: rcu_sched_state detected stall on CPU 0
From: Pekka Enberg <penberg@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, penberg@cs.helsinki.fi, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Oct 15, 2010 at 2:44 AM, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> On Thu, Oct 14, 2010 at 9:50 PM, Arjan van de Ven <arjan@linux.intel.com>=
 wrote:
>> =EF=BF=BDOn 10/14/2010 11:27 AM, richard -rw- weinberger wrote:
>>>
>>> Hi Arjan!
>>>
>>> This commit causes some problems on UML.
>>>
>> that is extremely weird.
>>>
>>> The kernel freezes after a few seconds until it gets some input.
>>> e.g: When I run top it stops refreshing the process list until i press a
>>> button.
>>
>> a slab timer change (to not be as critical) causing global timer issues.=
...
>> that's very obviously not a problem with this patch.
>> has this been seem anywhere except UML ?
>
> A small update:
> It seems that CONFIG_NO_HZ is broken on UML. :-(
>
> CONFIG_NO_HZ + CONFIG_SLAB: works
> CONFIG_NO_HZ + CONFIG_SLAB + your patch: broken
> CONFIG_NO_HZ + CONFIG_SLUB: broken
>
> CONFIG_SLAB + your patch: works
> CONFIG_SLAB: works
> CONFIG_SLUB: works

Thanks for testing! Thomas, Ingo, Peter, I'm not sure who maintains
CONFIG_NO_HZ so I CC'd you. The problem here is that Arjan's
deferrable timers patch in SLAB triggered something that looks like a
latent bug with UML and NOHZ.

                        Pekka

>>> Messages like this appear:
>>> INFO: rcu_sched_state detected stall on CPU 0 (t=3D7348 jiffies)
>>>
>>> After reverting UML works fine again.
>>>
>>> commit 78b435368fcd615e695a06012cd963a556284e00
>>> Author: Arjan van de Ven<arjan@linux.intel.com>
>>> Date: =EF=BF=BD Mon Jul 19 10:59:42 2010 -0700
>>>
>>> =EF=BF=BD =EF=BF=BD slab: use deferable timers for its periodic houseke=
eping
>>>
>>> =EF=BF=BD =EF=BF=BD slab has a "once every 2 second" timer for its hous=
ekeeping.
>>> =EF=BF=BD =EF=BF=BD As the number of logical processors is growing, its=
 more and more
>>> =EF=BF=BD =EF=BF=BD common that this 2 second timer becomes the primary=
 wakeup source.
>>>
>>> =EF=BF=BD =EF=BF=BD This patch turns this housekeeping timer into a def=
erable timer,
>>> =EF=BF=BD =EF=BF=BD which means that the timer does not interrupt idle,=
 but just runs
>>> =EF=BF=BD =EF=BF=BD at the next event that wakes the cpu up.
>>>
>>> =EF=BF=BD =EF=BF=BD The impact is that the timer likely runs a bit late=
r, but during the
>>> =EF=BF=BD =EF=BF=BD delay no code is running so there's not all that mu=
ch reason for
>>> =EF=BF=BD =EF=BF=BD a difference in housekeeping to occur because of th=
is delay.
>>>
>>> =EF=BF=BD =EF=BF=BD Signed-off-by: Arjan van de Ven<arjan@linux.intel.c=
om>
>>> =EF=BF=BD =EF=BF=BD Signed-off-by: Pekka Enberg<penberg@cs.helsinki.fi>
>>>
>>> diff --git a/mm/slab.c b/mm/slab.c
>>> index e49f8f4..29aad44 100644
>>> --- a/mm/slab.c
>>> +++ b/mm/slab.c
>>> @@ -861,7 +861,7 @@ static void __cpuinit start_cpu_timer(int cpu)
>>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD*/
>>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD if (keventd_up()&& =EF=BF=BDrea=
p_work->work.func =3D=3D NULL) {
>>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD init_reap_node(cpu);
>>> - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 INIT_DELAYED_WORK(reap_work, cache_reap);
>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 INIT_DELAYED_WORK_DEFERRABLE(reap_work, cache_reap);
>>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD schedule_delayed_work_on(cpu, reap_work,
>>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD __round_jiffies_re=
lative(HZ,
>>> cpu));
>>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD }
>>>
>>>
>>
>>
>
>
>
> --
> Thanks,
> //richard
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =EF=BF=BDhttp://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =EF=BF=BDhttp://www.tux.org/lkml/
>
