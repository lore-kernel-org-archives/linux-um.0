Return-Path: <agnel.joel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUVJtweuB1GVhyaiK2ak3AG+oE5JR-D78xJ75ARpcV=jA@mail.gmail.com>
References: <CAD=GYpatpGo=6mwhkw+RCQX=TNxX9jyfsq67srFc6+FhYtxaWg@mail.gmail.com>
 <1847021.mDh9H4lbpW@blindfold> <CAD=GYpaBOgoWGW3F5kjk_0V8mUw1VeWLm7PnveNGejfehoE1Og@mail.gmail.com>
 <6520656.Ns80NH9HyO@blindfold> <CAMuHMdUVJtweuB1GVhyaiK2ak3AG+oE5JR-D78xJ75ARpcV=jA@mail.gmail.com>
From: Joel Fernandes <agnel.joel@gmail.com>
Date: Thu, 29 Mar 2018 13:20:47 -0700
Message-ID: <CAD=GYpbAfqdEquXWdvHwrxaPQwi8Dyh=j9+6=SpwZ3zqnKSq0Q@mail.gmail.com>
Subject: Re: [uml-devel] UML hangs with hrtimer test module
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Mar 28, 2018 at 11:04 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Mar 29, 2018 at 12:35 AM, Richard Weinberger <richard@nod.at> wro=
te:
>> Am Donnerstag, 29. M=C3=A4rz 2018, 00:19:39 CEST schrieb Joel Fernandes:
>>> On Wed, Mar 28, 2018 at 6:19 AM, Richard Weinberger <richard@nod.at> wr=
ote:
>>> > Am Mittwoch, 28. M=C3=A4rz 2018, 15:11:29 CEST schrieb Geert Uytterho=
even:
>>> >> On Wed, Mar 28, 2018 at 12:28 PM, Joel Fernandes <agnel.joel@gmail.c=
om>
>>> > wrote:
>>> >> >         while(release_now =3D=3D 0);
>>> >>
>>> >> while (release_now =3D=3D 0)
>>> >>         cpu_relax();
>>> >
>>> > Not sure whether a cpu_relax() fixes the problem.
>>> > I guess the root of the problem is that UML is UP and non-preemptive.
>>> > Therefore the loop is never interrupted.
>>> > To verify I asked for the full source.
>>> >
>>>
>>> cpu_relax actually worked!
>>
>> Interesting.
>>
>>> Any thoughts on why it helps? Even if its non-preemptive, I did
>>> receive the timer interrupt, so I expected the variable to be set.
>>
>> Timers trigger also with preempt off, I forgot...
>> I think the cpu_relax() issues internally a barrier such that the
>> release_now variable is read again.
>> Can you try barrier() instead of cpu_relax()? I bet it works too.
>> Same if you mark release_now as volatile.
>
> Without cpu_relax()/barrier()/volatile, the compiler can assume release_n=
ow
> never changes, and thus may "optimize" the loop to an infinite loop.
>

Thanks a lot! I am wondering why the same compiler works when running
the test for a regular image. Maybe different compiler flags. Anyway
good to learn this.

Also one more slightly OT question, why is UML only doing UP ? Is it
extremely hard to do SMP for UML?

I also happen to notice Qemu has one thread per emulated core...

thanks,

- Joel

