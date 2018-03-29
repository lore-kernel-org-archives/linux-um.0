MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <6520656.Ns80NH9HyO@blindfold>
References: <CAD=GYpatpGo=6mwhkw+RCQX=TNxX9jyfsq67srFc6+FhYtxaWg@mail.gmail.com>
	<1847021.mDh9H4lbpW@blindfold>
	<CAD=GYpaBOgoWGW3F5kjk_0V8mUw1VeWLm7PnveNGejfehoE1Og@mail.gmail.com>
	<6520656.Ns80NH9HyO@blindfold>
Date: Thu, 29 Mar 2018 08:04:19 +0200
Message-ID: <CAMuHMdUVJtweuB1GVhyaiK2ak3AG+oE5JR-D78xJ75ARpcV=jA@mail.gmail.com>
Subject: Re: [uml-devel] UML hangs with hrtimer test module
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Richard Weinberger <richard@nod.at>
Cc: Joel Fernandes <agnel.joel@gmail.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Mar 29, 2018 at 12:35 AM, Richard Weinberger <richard@nod.at> wrote=
:
> Am Donnerstag, 29. M=C3=A4rz 2018, 00:19:39 CEST schrieb Joel Fernandes:
>> On Wed, Mar 28, 2018 at 6:19 AM, Richard Weinberger <richard@nod.at> wro=
te:
>> > Am Mittwoch, 28. M=C3=A4rz 2018, 15:11:29 CEST schrieb Geert Uytterhoe=
ven:
>> >> On Wed, Mar 28, 2018 at 12:28 PM, Joel Fernandes <agnel.joel@gmail.co=
m>
>> > wrote:
>> >> >         while(release_now =3D=3D 0);
>> >>
>> >> while (release_now =3D=3D 0)
>> >>         cpu_relax();
>> >
>> > Not sure whether a cpu_relax() fixes the problem.
>> > I guess the root of the problem is that UML is UP and non-preemptive.
>> > Therefore the loop is never interrupted.
>> > To verify I asked for the full source.
>> >
>>
>> cpu_relax actually worked!
>
> Interesting.
>
>> Any thoughts on why it helps? Even if its non-preemptive, I did
>> receive the timer interrupt, so I expected the variable to be set.
>
> Timers trigger also with preempt off, I forgot...
> I think the cpu_relax() issues internally a barrier such that the
> release_now variable is read again.
> Can you try barrier() instead of cpu_relax()? I bet it works too.
> Same if you mark release_now as volatile.

Without cpu_relax()/barrier()/volatile, the compiler can assume release_now
never changes, and thus may "optimize" the loop to an infinite loop.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

