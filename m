MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1300381340.6315.323.camel@edumazet-laptop>
References: <AANLkTi=e+tM-WTerLmkZfLTQqKCLsJHVBgQ5sj+TMjc4@mail.gmail.com>
	<1300370936.16880.96.camel@gandalf.stny.rr.com>
	<AANLkTi=Z_yYkdwzO7TMs7nSMOXR9wn_7BxtKjOKgS5HL@mail.gmail.com>
	<1300380909.16880.264.camel@gandalf.stny.rr.com>
	<1300381340.6315.323.camel@edumazet-laptop>
Date: Thu, 17 Mar 2011 18:43:05 +0100
Message-ID: <AANLkTik6oHOOk+1paSmCs=0c03_J10wGBFrRMQw-Jo86@mail.gmail.com>
Subject: Re: um: WARNING: at kernel/futex.c:786 __unqueue_futex
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, richard -rw- weinberger <richard.weinberger@gmail.com>, laijs@cn.fujitsu.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, dvhart@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Mar 17, 2011 at 18:02, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> Le jeudi 17 mars 2011 =C3=A0 12:55 -0400, Steven Rostedt a =C3=A9crit :
>> Here, test this patch. I'm in the process of committing it now.
>> It will be two patches, one for the WARN_ON_SMP() change, the other for
>> the futex change.
>>
>> -- Steve
>>
>> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
>> index c2c9ba0..25f1e9e 100644
>> --- a/include/asm-generic/bug.h
>> +++ b/include/asm-generic/bug.h
>> @@ -168,7 +168,7 @@ extern void warn_slowpath_null(const char *file, con=
st int line);
>> =C2=A0#ifdef CONFIG_SMP
>> =C2=A0# define WARN_ON_SMP(x) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ON(x)
>> =C2=A0#else
>> -# define WARN_ON_SMP(x) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do { } while (0)
>> +# define WARN_ON_SMP(x) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0({0;})
>> =C2=A0#endif
>>
>
> You meant :
>
> # define WARN_ON_SMP(x) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ({x;})
>
> or
>
> # define WARN_ON_SMP(x) =C2=A0 do { } while (x, 0)
>
> ?

I don't know. It's not clear to me if "WARN_ON_SMP(x)" should always return=
 "x",
or only on SMP?

E.g.

    if (WARN_ON_SMP(x)) {
       // Should we get here if "x" is true?
       // Or only if CONFIG_SMP and "x" are both true?
    }

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

