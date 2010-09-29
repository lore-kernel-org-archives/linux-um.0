MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <AANLkTi=s4HJepGa32mKfCYn2sHWems09mH0DRKXqAt9R@mail.gmail.com>
References: <AANLkTi=PTp7YW_eYxtF-H2QSxgei3whWH59wU0C9oCkz@mail.gmail.com>
	<1285693648.14518.7.camel@voyager>
	<AANLkTi=NiB4hoA5Y8kbR7R8B+J-jJXAHGSu5JdOLSQsj@mail.gmail.com>
	<1285704762.14518.19.camel@voyager>
	<AANLkTikquMSnLFW2dcDEWW=Jtez5zzYSuRPFwbyVnk+y@mail.gmail.com>
	<AANLkTi=s4HJepGa32mKfCYn2sHWems09mH0DRKXqAt9R@mail.gmail.com>
Date: Wed, 29 Sep 2010 11:19:18 +0200
Message-ID: <AANLkTi=U+Am_nWkXrKrxXkFjhGGpxyUA_KRZB=-m+UU8@mail.gmail.com>
Subject: Re: [uml-devel] [REGRESSION] um: ubd: block layer issue (Was: ext3
 filesystem corruption in user mode linux)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Janjaap Bos <janjaap@bos.nl>, tj@kernel.org, axboe@kernel.dk, mike.miller@hp.com, user-mode-linux-devel@lists.sourceforge.net, adrian@mcmen.demon.co.uk, jdike@addtoit.com, LKML <linux-kernel@vger.kernel.org>, grant.likely@secretlab.ca, Geert.Uytterhoeven@sonycom.com, Chris Frey <cdfrey@foursquare.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Sep 28, 2010 at 23:19, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> On Tue, Sep 28, 2010 at 10:37 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>>
>> This changeset from 2007 indeed moved the update of req->sector.
>>
>> However, in the new code, before or after applying your patch, there's n=
o update
>> of req->sector anymore. Everything is done in local variables.
>>
>> Is it possible that we only need the hunk below to fix the corruption?
>
> Yes, it seems so. So far all my test cases work fine.
> I'll submit a patch in a few minutes.

Thanks, good to know!

>> | diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
>> | index 5ff5546..655ed9e 100644
>> | --- a/arch/um/drivers/ubd_kern.c
>> | +++ b/arch/um/drivers/ubd_kern.c
>> | @@ -746,8 +746,12 @@ static int ubd_open_dev(struct ubd *ubd_dev)
>> | =C2=A0 =C2=A0 =C2=A0 }
>> | =C2=A0 =C2=A0 =C2=A0 ubd_dev->fd =3D fd;
>> |
>> | + =C2=A0 =C2=A0 /* A setting higher than 1 sector currently (v2.6.33) =
generates
>> | + =C2=A0 =C2=A0 data loss, both for raw and cow ubd. */
>> | + =C2=A0 =C2=A0 blk_queue_max_sectors(ubd_dev->queue, 1 * sizeof(long)=
);
>> | + =C2=A0 =C2=A0 blk_queue_max_phys_segments(ubd_dev->queue, 1 * sizeof=
(long));
>> | +
>> | =C2=A0 =C2=A0 =C2=A0 if(ubd_dev->cow.file !=3D NULL){
>> | - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_queue_max_sectors(ubd_=
dev->queue, 8 * sizeof(long));
>> |
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENOMEM;
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ubd_dev->cow.bitmap =
=3D vmalloc(ubd_dev->cow.bitmap_len);

So we can no longer process more than one sector? Why?

Could it be 4d6c84d91d1a539ebc47d1a36a35e9390ba11fdc (ubd: cleanup
completion path),
which is one of the three commits you pointed out?

Before 4d6c84d91d1a539ebc47d1a36a35e9390ba11fdc, blk_end_request() was
only called when
rq->nr_sectors reached zero.
Now it's called for each part.

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

