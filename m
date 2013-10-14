Return-Path: <jack@suse.cz>
Date: Mon, 14 Oct 2013 14:34:26 +0200
From: Jan Kara <jack@suse.cz>
Message-ID: <20131014123426.GG19604@quack.suse.cz>
References: <525591AD.4060401@gmx.de>
 <5255A3E6.6020100@nod.at>
 <20131009214733.GB25608@quack.suse.cz>
 <5255D9A6.3010208@nod.at>
 <5256DA9A.5060904@gmx.de>
 <20131011011649.GA11191@localhost>
 <5257B9EB.7080503@gmx.de>
 <20131011085701.GA27382@localhost>
 <52580767.6090604@gmx.de>
 <20131012044517.GA32048@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20131012044517.GA32048@localhost>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] writeback: fix negative bdi max pause
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, UML devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, hannes@cmpxchg.org, darrick.wong@oracle.com, Michal Hocko <mhocko@suse.cz>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat 12-10-13 12:45:17, Wu Fengguang wrote:
> Toralf runs trinity on UML/i386.
> After some time it hangs and the last message line is
>=20
> 	BUG: soft lockup - CPU#0 stuck for 22s! [trinity-child0:1521]
>=20
> It's found that pages_dirtied becomes very large.
> More than 1000000000 pages in this case:
>=20
> 	period =3D HZ * pages_dirtied / task_ratelimit;
> 	BUG_ON(pages_dirtied > 2000000000);
> 	BUG_ON(pages_dirtied > 1000000000);      <---------
>=20
> UML debug printf shows that we got negative pause here:
>=20
> 	ick: pause : -984
> 	ick: pages_dirtied : 0
> 	ick: task_ratelimit: 0
>=20
> 	 pause:
> 	+       if (pause < 0)  {
> 	+               extern int printf(char *, ...);
> 	+               printf("ick : pause : %li\n", pause);
> 	+               printf("ick: pages_dirtied : %lu\n", pages_dirtied);
> 	+               printf("ick: task_ratelimit: %lu\n", task_ratelimit);
> 	+               BUG_ON(1);
> 	+       }
> 	        trace_balance_dirty_pages(bdi,
>=20
> Since pause is bounded by [min_pause, max_pause] where min_pause is als=
o
> bounded by max_pause. It's suspected and demonstrated that the max_paus=
e
> calculation goes wrong:
>=20
> 	ick: pause : -717
> 	ick: min_pause : -177
> 	ick: max_pause : -717
> 	ick: pages_dirtied : 14
> 	ick: task_ratelimit: 0
>=20
> The problem lies in the two "long =3D unsigned long" assignments in
> bdi_max_pause() which might go negative if the highest bit is 1, and
> the min_t(long, ...) check failed to protect it falling under 0. Fix
> all of them by using "unsigned long" throughout the function.
>=20
> Reported-by: Toralf F=F6rster <toralf.foerster@gmx.de>
> Tested-by: Toralf F=F6rster <toralf.foerster@gmx.de>
> Cc: <stable@vger.kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
  The patch looks good. You can add:
Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c |   10 +++++-----
>  mm/readahead.c      |    2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
>  Changes since v1: Add CC list.
>=20
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 3f0c895..241a746 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1104,11 +1104,11 @@ static unsigned long dirty_poll_interval(unsign=
ed long dirty,
>  	return 1;
>  }
> =20
> -static long bdi_max_pause(struct backing_dev_info *bdi,
> -			  unsigned long bdi_dirty)
> +static unsigned long bdi_max_pause(struct backing_dev_info *bdi,
> +				   unsigned long bdi_dirty)
>  {
> -	long bw =3D bdi->avg_write_bandwidth;
> -	long t;
> +	unsigned long bw =3D bdi->avg_write_bandwidth;
> +	unsigned long t;
> =20
>  	/*
>  	 * Limit pause time for small memory systems. If sleeping for too lon=
g
> @@ -1120,7 +1120,7 @@ static long bdi_max_pause(struct backing_dev_info=
 *bdi,
>  	t =3D bdi_dirty / (1 + bw / roundup_pow_of_two(1 + HZ / 8));
>  	t++;
> =20
> -	return min_t(long, t, MAX_PAUSE);
> +	return min_t(unsigned long, t, MAX_PAUSE);
>  }
> =20
>  static long bdi_min_pause(struct backing_dev_info *bdi,
--=20
Jan Kara <jack@suse.cz>
SUSE Labs, CR

