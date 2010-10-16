Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1287128928.29097.1235.camel@twins>
References: <AANLkTinNxzktyttzEjWSUPBiOUwh+4DUL0tmP7p1UiT5@mail.gmail.com>
	<4CB75F05.9070505@linux.intel.com>
	<AANLkTik5_TCXeGzTWBZzE8F0Cb2bQq-D228xDXk87rhP@mail.gmail.com>
	<AANLkTi=vYFv+S=D6O06Nys4cjU7KHWv11d_VdLGmLyf6@mail.gmail.com>
	<1287128928.29097.1235.camel@twins>
Date: Sat, 16 Oct 2010 17:27:36 +0200
Message-ID: <AANLkTimJZXL4gqq5y4eAZMqTEpN8Xy4S2B0cYANyK5qJ@mail.gmail.com>
Subject: Re: [REGRESSION] um: rcu_sched_state detected stall on CPU 0
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Pekka Enberg <penberg@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, penberg@cs.helsinki.fi, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Oct 15, 2010 at 9:48 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
> On Fri, 2010-10-15 at 10:02 +0300, Pekka Enberg wrote:
>> On Fri, Oct 15, 2010 at 2:44 AM, richard -rw- weinberger
>> <richard.weinberger@gmail.com> wrote:
>> > On Thu, Oct 14, 2010 at 9:50 PM, Arjan van de Ven
>> <arjan@linux.intel.com> wrote:
>> >> =EF=BF=BDOn 10/14/2010 11:27 AM, richard -rw- weinberger wrote:
>> >>>
>> >>> Hi Arjan!
>> >>>
>> >>> This commit causes some problems on UML.
>> >>>
>> >> that is extremely weird.
>> >>>
>> >>> The kernel freezes after a few seconds until it gets some input.
>> >>> e.g: When I run top it stops refreshing the process list until i
>> press a
>> >>> button.
>> >>
>> >> a slab timer change (to not be as critical) causing global timer
>> issues....
>> >> that's very obviously not a problem with this patch.
>> >> has this been seem anywhere except UML ?
>> >
>> > A small update:
>> > It seems that CONFIG_NO_HZ is broken on UML. :-(
>> >
>> > CONFIG_NO_HZ + CONFIG_SLAB: works
>> > CONFIG_NO_HZ + CONFIG_SLAB + your patch: broken
>> > CONFIG_NO_HZ + CONFIG_SLUB: broken
>> >
>> > CONFIG_SLAB + your patch: works
>> > CONFIG_SLAB: works
>> > CONFIG_SLUB: works
>>
>> Thanks for testing! Thomas, Ingo, Peter, I'm not sure who maintains
>> CONFIG_NO_HZ so I CC'd you. The problem here is that Arjan's
>> deferrable timers patch in SLAB triggered something that looks like a
>> latent bug with UML and NOHZ.
>
> Thomas does mostly, but if its UML specific, I guess its Jeff Dike
> you'll be wanting to talk to, since he's the arch maintainer.

After reviewing the code for hours I've found the bug.
It's a int/long long issue within arch/um/os-Linux/time.c.
A patch is on the way!

--=20
Thanks,
//richard
