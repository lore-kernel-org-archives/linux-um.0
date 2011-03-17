MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1300385802.16880.348.camel@gandalf.stny.rr.com>
References: <AANLkTi=e+tM-WTerLmkZfLTQqKCLsJHVBgQ5sj+TMjc4@mail.gmail.com>
	<1300370936.16880.96.camel@gandalf.stny.rr.com>
	<AANLkTi=Z_yYkdwzO7TMs7nSMOXR9wn_7BxtKjOKgS5HL@mail.gmail.com>
	<1300380909.16880.264.camel@gandalf.stny.rr.com>
	<1300381340.6315.323.camel@edumazet-laptop>
	<1300385802.16880.348.camel@gandalf.stny.rr.com>
Date: Thu, 17 Mar 2011 19:25:36 +0100
Message-ID: <AANLkTim4hY_HJrukNjVe5RDzBj7r547BcxKRozKcQ_uE@mail.gmail.com>
Subject: Re: um: WARNING: at kernel/futex.c:786 __unqueue_futex
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, richard -rw- weinberger <richard.weinberger@gmail.com>, laijs@cn.fujitsu.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, dvhart@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Mar 17, 2011 at 19:16, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 2011-03-17 at 18:02 +0100, Eric Dumazet wrote:
>> Le jeudi 17 mars 2011 =C3=A0 12:55 -0400, Steven Rostedt a =C3=A9crit :
>> > Here, test this patch. I'm in the process of committing it now.
>> > It will be two patches, one for the WARN_ON_SMP() change, the other fo=
r
>> > the futex change.
>> >
>> > -- Steve
>> >
>> > diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
>> > index c2c9ba0..25f1e9e 100644
>> > --- a/include/asm-generic/bug.h
>> > +++ b/include/asm-generic/bug.h
>> > @@ -168,7 +168,7 @@ extern void warn_slowpath_null(const char *file, c=
onst int line);
>> > =C2=A0#ifdef CONFIG_SMP
>> > =C2=A0# define WARN_ON_SMP(x) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ON(x)
>> > =C2=A0#else
>> > -# define WARN_ON_SMP(x) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0do { } while (0)
>> > +# define WARN_ON_SMP(x) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0({0;})
>> > =C2=A0#endif
>> >
>>
>> You meant :
>>
>> # define WARN_ON_SMP(x) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ({x;})
>>
>> or
>>
>> # define WARN_ON_SMP(x) =C2=A0 =C2=A0 =C2=A0 =C2=A0 do { } while (x, 0)
>>
>> ?
>>
>
> Does if (do { } while (x, 0)) work?

No.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds

