Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1300380909.16880.264.camel@gandalf.stny.rr.com>
References: <AANLkTi=e+tM-WTerLmkZfLTQqKCLsJHVBgQ5sj+TMjc4@mail.gmail.com>
	<1300370936.16880.96.camel@gandalf.stny.rr.com>
	<AANLkTi=Z_yYkdwzO7TMs7nSMOXR9wn_7BxtKjOKgS5HL@mail.gmail.com>
	<1300380909.16880.264.camel@gandalf.stny.rr.com>
Date: Thu, 17 Mar 2011 18:18:59 +0100
Message-ID: <AANLkTinOqxRTF0XqZEGxwyojeMhpdFr_yaPEcDtbADTk@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: WARNING: at kernel/futex.c:786 __unqueue_futex
To: Steven Rostedt <rostedt@goodmis.org>
Cc: laijs@cn.fujitsu.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, dvhart@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Mar 17, 2011 at 5:55 PM, Steven Rostedt <rostedt@goodmis.org> w=
rote:
> Here, test this patch. I'm in the process of committing it now.
> It will be two patches, one for the WARN_ON_SMP() change, the other f=
or
> the futex change.
>
> -- Steve
>
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index c2c9ba0..25f1e9e 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -168,7 +168,7 @@ extern void warn_slowpath_null(const char *file, =
const int line);
> =A0#ifdef CONFIG_SMP
> =A0# define WARN_ON_SMP(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0WARN_ON(x)
> =A0#else
> -# define WARN_ON_SMP(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0do { } while (0)
> +# define WARN_ON_SMP(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0({0;})
> =A0#endif
>
> =A0#endif
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 9fe9131..850d00b 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -785,8 +785,8 @@ static void __unqueue_futex(struct futex_q *q)
> =A0{
> =A0 =A0 =A0 =A0struct futex_hash_bucket *hb;
>
> - =A0 =A0 =A0 if (WARN_ON(!q->lock_ptr || !spin_is_locked(q->lock_ptr=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || plist_node_empty(&q-=
>list)))
> + =A0 =A0 =A0 if (WARN_ON_SMP(!q->lock_ptr || !spin_is_locked(q->lock=
_ptr))
> + =A0 =A0 =A0 =A0 =A0 || WARN_ON(plist_node_empty(&q->list)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0hb =3D container_of(q->lock_ptr, struct futex_hash_buc=
ket, lock);
>
>
>

Tested-by: Richard Weinberger <richard@nod.at>

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

