Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <AANLkTim4hY_HJrukNjVe5RDzBj7r547BcxKRozKcQ_uE@mail.gmail.com>
References: <AANLkTi=e+tM-WTerLmkZfLTQqKCLsJHVBgQ5sj+TMjc4@mail.gmail.com>
	 <1300370936.16880.96.camel@gandalf.stny.rr.com>
	 <AANLkTi=Z_yYkdwzO7TMs7nSMOXR9wn_7BxtKjOKgS5HL@mail.gmail.com>
	 <1300380909.16880.264.camel@gandalf.stny.rr.com>
	 <1300381340.6315.323.camel@edumazet-laptop>
	 <1300385802.16880.348.camel@gandalf.stny.rr.com>
	 <AANLkTim4hY_HJrukNjVe5RDzBj7r547BcxKRozKcQ_uE@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Mar 2011 19:38:42 +0100
Message-ID: <1300387122.6315.407.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: WARNING: at kernel/futex.c:786 __unqueue_futex
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, richard -rw- weinberger <richard.weinberger@gmail.com>, laijs@cn.fujitsu.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, dvhart@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Le jeudi 17 mars 2011 =C3=A0 19:25 +0100, Geert Uytterhoeven a =C3=A9cr=
it :
> On Thu, Mar 17, 2011 at 19:16, Steven Rostedt <rostedt@goodmis.org> w=
rote:
> > On Thu, 2011-03-17 at 18:02 +0100, Eric Dumazet wrote:
> >> Le jeudi 17 mars 2011 =C3=A0 12:55 -0400, Steven Rostedt a =C3=A9c=
rit :
> >> > Here, test this patch. I'm in the process of committing it now.
> >> > It will be two patches, one for the WARN_ON_SMP() change, the ot=
her for
> >> > the futex change.
> >> >
> >> > -- Steve
> >> >
> >> > diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug=
=2Eh
> >> > index c2c9ba0..25f1e9e 100644
> >> > --- a/include/asm-generic/bug.h
> >> > +++ b/include/asm-generic/bug.h
> >> > @@ -168,7 +168,7 @@ extern void warn_slowpath_null(const char *f=
ile, const int line);
> >> >  #ifdef CONFIG_SMP
> >> >  # define WARN_ON_SMP(x)                    WARN_ON(x)
> >> >  #else
> >> > -# define WARN_ON_SMP(x)                    do { } while (0)
> >> > +# define WARN_ON_SMP(x)                    ({0;})
> >> >  #endif
> >> >
> >>
> >> You meant :
> >>
> >> # define WARN_ON_SMP(x)                       ({x;})
> >>
> >> or
> >>
> >> # define WARN_ON_SMP(x)         do { } while (x, 0)
> >>
> >> ?
> >>
> >
> > Does if (do { } while (x, 0)) work?
>=20

My point was that WARN_ON(X) always evaluates X once

And apparently, WARN_ON_SMP(X) doesnt evaluates X iF !SMP

This should be documented, or fixed ;)



--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

