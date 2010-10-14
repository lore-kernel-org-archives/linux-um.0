Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4CB75F05.9070505@linux.intel.com>
References: <AANLkTinNxzktyttzEjWSUPBiOUwh+4DUL0tmP7p1UiT5@mail.gmail.com>
	<4CB75F05.9070505@linux.intel.com>
Date: Fri, 15 Oct 2010 01:44:08 +0200
Message-ID: <AANLkTik5_TCXeGzTWBZzE8F0Cb2bQq-D228xDXk87rhP@mail.gmail.com>
Subject: Re: [REGRESSION] um: rcu_sched_state detected stall on CPU 0
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: penberg@cs.helsinki.fi, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Oct 14, 2010 at 9:50 PM, Arjan van de Ven <arjan@linux.intel.com> w=
rote:
> =EF=BF=BDOn 10/14/2010 11:27 AM, richard -rw- weinberger wrote:
>>
>> Hi Arjan!
>>
>> This commit causes some problems on UML.
>>
> that is extremely weird.
>>
>> The kernel freezes after a few seconds until it gets some input.
>> e.g: When I run top it stops refreshing the process list until i press a
>> button.
>
> a slab timer change (to not be as critical) causing global timer issues..=
..
> that's very obviously not a problem with this patch.
> has this been seem anywhere except UML ?

A small update:
It seems that CONFIG_NO_HZ is broken on UML. :-(

CONFIG_NO_HZ + CONFIG_SLAB: works
CONFIG_NO_HZ + CONFIG_SLAB + your patch: broken
CONFIG_NO_HZ + CONFIG_SLUB: broken

CONFIG_SLAB + your patch: works
CONFIG_SLAB: works
CONFIG_SLUB: works

>> Messages like this appear:
>> INFO: rcu_sched_state detected stall on CPU 0 (t=3D7348 jiffies)
>>
>> After reverting UML works fine again.
>>
>> commit 78b435368fcd615e695a06012cd963a556284e00
>> Author: Arjan van de Ven<arjan@linux.intel.com>
>> Date: =EF=BF=BD Mon Jul 19 10:59:42 2010 -0700
>>
>> =EF=BF=BD =EF=BF=BD slab: use deferable timers for its periodic housekee=
ping
>>
>> =EF=BF=BD =EF=BF=BD slab has a "once every 2 second" timer for its house=
keeping.
>> =EF=BF=BD =EF=BF=BD As the number of logical processors is growing, its =
more and more
>> =EF=BF=BD =EF=BF=BD common that this 2 second timer becomes the primary =
wakeup source.
>>
>> =EF=BF=BD =EF=BF=BD This patch turns this housekeeping timer into a defe=
rable timer,
>> =EF=BF=BD =EF=BF=BD which means that the timer does not interrupt idle, =
but just runs
>> =EF=BF=BD =EF=BF=BD at the next event that wakes the cpu up.
>>
>> =EF=BF=BD =EF=BF=BD The impact is that the timer likely runs a bit later=
, but during the
>> =EF=BF=BD =EF=BF=BD delay no code is running so there's not all that muc=
h reason for
>> =EF=BF=BD =EF=BF=BD a difference in housekeeping to occur because of thi=
s delay.
>>
>> =EF=BF=BD =EF=BF=BD Signed-off-by: Arjan van de Ven<arjan@linux.intel.co=
m>
>> =EF=BF=BD =EF=BF=BD Signed-off-by: Pekka Enberg<penberg@cs.helsinki.fi>
>>
>> diff --git a/mm/slab.c b/mm/slab.c
>> index e49f8f4..29aad44 100644
>> --- a/mm/slab.c
>> +++ b/mm/slab.c
>> @@ -861,7 +861,7 @@ static void __cpuinit start_cpu_timer(int cpu)
>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD*/
>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD if (keventd_up()&& =EF=BF=BDreap=
_work->work.func =3D=3D NULL) {
>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD init_reap_node(cpu);
>> - =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
INIT_DELAYED_WORK(reap_work, cache_reap);
>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
INIT_DELAYED_WORK_DEFERRABLE(reap_work, cache_reap);
>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD schedule_delayed_work_on(cpu, reap_work,
>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD __round_jiffies_re=
lative(HZ,
>> cpu));
>> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD }
>>
>>
>
>



--=20
Thanks,
//richard
