Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <1300380909.16880.264.camel@gandalf.stny.rr.com>
References: <AANLkTi=e+tM-WTerLmkZfLTQqKCLsJHVBgQ5sj+TMjc4@mail.gmail.com>
	 <1300370936.16880.96.camel@gandalf.stny.rr.com>
	 <AANLkTi=Z_yYkdwzO7TMs7nSMOXR9wn_7BxtKjOKgS5HL@mail.gmail.com>
	 <1300380909.16880.264.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Mar 2011 18:02:20 +0100
Message-ID: <1300381340.6315.323.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: WARNING: at kernel/futex.c:786 __unqueue_futex
To: Steven Rostedt <rostedt@goodmis.org>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, laijs@cn.fujitsu.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, dvhart@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Le jeudi 17 mars 2011 =C3=A0 12:55 -0400, Steven Rostedt a =C3=A9crit :
> Here, test this patch. I'm in the process of committing it now.
> It will be two patches, one for the WARN_ON_SMP() change, the other f=
or
> the futex change.
>=20
> -- Steve
>=20
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index c2c9ba0..25f1e9e 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -168,7 +168,7 @@ extern void warn_slowpath_null(const char *file, =
const int line);
>  #ifdef CONFIG_SMP
>  # define WARN_ON_SMP(x)			WARN_ON(x)
>  #else
> -# define WARN_ON_SMP(x)			do { } while (0)
> +# define WARN_ON_SMP(x)			({0;})
>  #endif
> =20

You meant :

# define WARN_ON_SMP(x)			({x;})

or

# define WARN_ON_SMP(x)	  do { } while (x, 0)

?


--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

