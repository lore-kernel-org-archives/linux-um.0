Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <553D51F1.9010900@nod.at>
Date: Sun, 26 Apr 2015 23:00:33 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <E1Xg9cr-0007LK-S6@www17.your-server.de> <5444DC3F.20601@nod.at>	 <1429905520.157088.6.camel@m3y3r.de>	 <CAFLxGvxq900TTuJ1jAfNx3xTrUTbE3vZkMZ_H=FvsPg3eck9ww@mail.gmail.com> <1430081853.603436.7.camel@m3y3r.de>
In-Reply-To: <1430081853.603436.7.camel@m3y3r.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] [UM] Long loop in __getnsdayoftime() after resume
 from ram
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi!

Am 26.04.2015 um 22:57 schrieb Thomas Meyer:
> Am Sonntag, den 26.04.2015, 20:32 +0200 schrieb Richard Weinberger:
>> On Fri, Apr 24, 2015 at 9:58 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
>>> Am Montag, den 20.10.2014, 11:56 +0200 schrieb Richard Weinberger:
>>>> Am 20.10.2014 um 11:51 schrieb Thomas Meyer:
>>>>>> Hmm, does this always happen?
>>>>>
>>>>> Yes, my single core system seems to trigger this every time after resume from ram.
>>>>
>>>> What is your host kernel?
>>>>
>>>>>> At least on my notebook it did not happen. I've started an UML yesterday
>>>>>> suspended it and after more than 12h it worked fine today.
>>>>>>
>>>>>> BTW: Do you see the issue also then freezing UML using the freezer cgroup?
>>>>>
>>>>> I'm not sure what do you mean by this. Do I need to enable some special configs for this in the host or uml kernel?
>>>>
>>>> Create on the host side a new freezer cgroup, put UML into it and freeze/thaw it.
>>>> i.e. mkdir /sys/fs/cgroup/freezer/uml ; echo <pid of a shell> >  /sys/fs/cgroup/freezer/uml/tasks.
>>>> In the said shell run UML and then freeze it using echo FROZEN > /sys/fs/cgroup/freezer/uml/freezer.state.
>>>> Later thaw it: echo THAWED > /sys/fs/cgroup/freezer/uml/freezer.state
>>>>
>>>
>>> Sadly, this also happens with a cgroup freezer group :-(
>>>
>>> bt
>>> #0  __iter_div_u64_rem (remainder=<optimized out>, divisor=<optimized out>, dividend=14641577537827850536) at include/linux/math64.h:12
>>> 7
>>> #1  timespec_add_ns (ns=<optimized out>, a=<optimized out>) at include/linux/time.h:235
>>> #2  __getnstimeofday64 (ts=0xffffffffffffffff) at kernel/time/timekeeping.c:658
>>> #3  0x0000000060098a00 in getnstimeofday64 (ts=<optimized out>) at kernel/time/timekeeping.c:678
>>> #4  0x0000000060098a4c in do_gettimeofday (tv=0xab359e50) at kernel/time/timekeeping.c:897
>>> #5  0x0000000060090d66 in SYSC_gettimeofday (tz=<optimized out>, tv=<optimized out>) at kernel/time/time.c:107
>>> #6  SyS_gettimeofday (tv=-1, tz=2097152000) at kernel/time/time.c:102
>>> #7  0x0000000060032cf3 in handle_syscall (r=0xa39db9e8) at arch/um/kernel/skas/syscall.c:35
>>> #8  0x000000006004a247 in handle_trap (local_using_sysemu=<optimized out>, regs=<optimized out>, pid=<optimized out>) at arch/um/os-Lin
>>> ux/skas/process.c:174
>>> #9  userspace (regs=0xa39db9e8) at arch/um/os-Linux/skas/process.c:399
>>> #10 0x000000006002f125 in fork_handler () at arch/um/kernel/process.c:149
>>> #11 0x0000000000000000 in ?? ()
>>>
>>> It seems as only very few people running UML kernels and suspend their host systems...
>>>
>>> Any ideas?
>>
>> Can you give the attached patch a try?
>> Let's see if it proves my theory.
>> Looks like UML's clocksource needs fixing.
> 
> Hi Richard,
> 
> I did run this for an hour and did 4 suspend/resume cycles and it seems
> not to hang any more!

Yay!
BTW: Changing the host's time should also work for testing...

> I'll test your other patch the next week, but AFAIU using clock_gettime
> should solve this hangs in a sane way.

Yep. I have no idea why UML is currently using gettimeofday() as clocksource,
this is completely bogus. ;-\

Thanks,
//richard
