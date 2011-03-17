Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1300381340.6315.323.camel@edumazet-laptop>
References: <AANLkTi=e+tM-WTerLmkZfLTQqKCLsJHVBgQ5sj+TMjc4@mail.gmail.com>
	 <1300370936.16880.96.camel@gandalf.stny.rr.com>
	 <AANLkTi=Z_yYkdwzO7TMs7nSMOXR9wn_7BxtKjOKgS5HL@mail.gmail.com>
	 <1300380909.16880.264.camel@gandalf.stny.rr.com>
	 <1300381340.6315.323.camel@edumazet-laptop>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 17 Mar 2011 14:16:42 -0400
Message-ID: <1300385802.16880.348.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: WARNING: at kernel/futex.c:786 __unqueue_futex
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, laijs@cn.fujitsu.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, dvhart@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 2011-03-17 at 18:02 +0100, Eric Dumazet wrote:
> Le jeudi 17 mars 2011 =E0 12:55 -0400, Steven Rostedt a =E9crit :
> > Here, test this patch. I'm in the process of committing it now.
> > It will be two patches, one for the WARN_ON_SMP() change, the other=
 for
> > the futex change.
> >=20
> > -- Steve
> >=20
> > diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> > index c2c9ba0..25f1e9e 100644
> > --- a/include/asm-generic/bug.h
> > +++ b/include/asm-generic/bug.h
> > @@ -168,7 +168,7 @@ extern void warn_slowpath_null(const char *file=
, const int line);
> >  #ifdef CONFIG_SMP
> >  # define WARN_ON_SMP(x)			WARN_ON(x)
> >  #else
> > -# define WARN_ON_SMP(x)			do { } while (0)
> > +# define WARN_ON_SMP(x)			({0;})
> >  #endif
> > =20
>=20
> You meant :
>=20
> # define WARN_ON_SMP(x)			({x;})
>=20
> or
>=20
> # define WARN_ON_SMP(x)	  do { } while (x, 0)
>=20
> ?
>=20

Does if (do { } while (x, 0)) work?

And no, on SMP it should always return false. The point is, the warning
is only valid if we are on an SMP box, this is useful for spin_locks()

if (WARN_ON_SMP(!spin_is_locked(lock)))
	fail();

We don't want to fail.

That spin_is_locked(lock) on !SMP returns 0 every time.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

