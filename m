MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1285704762.14518.19.camel@voyager>
References: <AANLkTi=PTp7YW_eYxtF-H2QSxgei3whWH59wU0C9oCkz@mail.gmail.com>
	<1285693648.14518.7.camel@voyager>
	<AANLkTi=NiB4hoA5Y8kbR7R8B+J-jJXAHGSu5JdOLSQsj@mail.gmail.com>
	<1285704762.14518.19.camel@voyager>
Date: Tue, 28 Sep 2010 22:37:59 +0200
Message-ID: <AANLkTikquMSnLFW2dcDEWW=Jtez5zzYSuRPFwbyVnk+y@mail.gmail.com>
Subject: Re: [uml-devel] [REGRESSION] um: ubd: block layer issue (Was: ext3
 filesystem corruption in user mode linux)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Janjaap Bos <janjaap@bos.nl>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, tj@kernel.org, axboe@kernel.dk, mike.miller@hp.com, user-mode-linux-devel@lists.sourceforge.net, adrian@mcmen.demon.co.uk, jdike@addtoit.com, LKML <linux-kernel@vger.kernel.org>, grant.likely@secretlab.ca, Geert.Uytterhoeven@sonycom.com, Chris Frey <cdfrey@foursquare.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Sep 28, 2010 at 22:12, Janjaap Bos <janjaap@bos.nl> wrote:
>> On Tue, 2010-09-28 at 21:52 +0200, Geert Uytterhoeven wrote:
>> On Tue, Sep 28, 2010 at 19:07, Janjaap Bos <janjaap@bos.nl> wrote:
>> > See attached patch, and earlier message posted in March 2010 on uml us=
er
>> > list. We are out of maintainer...
>>
>> Thanks for the patch!
>>
>> | --- a/arch/um/drivers/ubd_kern.c
>> | +++ b/arch/um/drivers/ubd_kern.c
>> | @@ -1223,7 +1227,7 @@ static void do_ubd_request(struct request_queue =
*q)
>> | =C2=A0 =C2=A0 =C2=A0 struct io_thread_req *io_req;
>> | =C2=A0 =C2=A0 =C2=A0 struct request *req;
>> | =C2=A0 =C2=A0 =C2=A0 sector_t sector;
>> | - =C2=A0 =C2=A0 int n;
>> | + =C2=A0 =C2=A0 int n, last_sectors;
>> |
>> | =C2=A0 =C2=A0 =C2=A0 while(1){
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ubd *dev =3D q=
->queuedata;
>> | @@ -1239,9 +1243,12 @@ static void do_ubd_request(struct request_queue=
 *q)
>> |
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req =3D dev->request;
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sector =3D blk_rq_pos=
(req);
>> | + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_sectors =3D 0;
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while(dev->start_sg <=
 dev->end_sg){
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct scatterlist *sg =3D &dev->sg[dev->start_sg];
>> |
>> | + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sector +=3D last_sectors;
>> | + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 last_sectors =3D 0;
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 io_req =3D kmalloc(sizeof(struct io_thread_req),
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GFP_AT=
OMIC);
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if(io_req =3D=3D NULL){
>> | @@ -1253,7 +1260,7 @@ static void do_ubd_request(struct request_queue =
*q)
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned lo=
ng long)sector << 9,
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sg->offset, =
sg->length, sg_page(sg));
>> |
>> | - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sector +=3D sg->length >> 9;
>> | + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 last_sectors =3D sg->length >> 9;
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 n =3D os_write_file(thread_fd, &io_req,
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeo=
f(struct io_thread_req *));
>> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if(n !=3D sizeof(struct io_thread_req *)){
>>
>> However, I'm wondering what difference this part makes?
>>
>
>
> It fixes ubd block handling integrity.
> With large block operations errors occurred. Probably due to lost
> request pointers as explained below. Need to keep a local count of
> sectors and delay the update. Done by reverting commit
> f81f2f7c9fee307e371f37424577d46f9eaf8692 using the present
> block api. (At least which is what I intend, but perhaps quite likely I
> am missing the point, also it may not be needed anymore if only single
> 512 byte sector blocks are used per request. Anyway... it solves the
> problem for me ;-)
>
> Regards,
> -Janjaap
>
>
> See:
>
> reverted: commit f81f2f7c9fee307e371f37424577d46f9eaf8692
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Author: Tejun Heo <tj@kernel.org>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Date: =C2=A0 Tue Apr 28 13:06:10 2009 +=
0900
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ubd: drop unnecessary rq->sector manipu=
lation
> =C2=A0 =C2=A0ubd curiously updates rq->sector while issuing the request
> =C2=A0 =C2=A0in multiple pieces. =C2=A0Don't do it and simply use local c=
opy
> =C2=A0 =C2=A0of sector.
>
> See for original reason:
>
> commit 0a6d3a2a3813e7b25267366cfbf9a4a4698dd1c2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Author: Jeff Dike <jdike@addtoit.com>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Date: =C2=A0 Sun Jul 15 23:38:47 2007 -0700
> =C2=A0 =C2=A0 =C2=A0 =C2=A0uml: fix request->sector update
>
> =C2=A0 =C2=A0It is theoretically possible for a request to finish and be =
freed
> between writing it to the I/O thread and updating the sector count. =C2=
=A0In
> this case, the update will dereference a freed pointer.
> =C2=A0 =C2=A0To avoid this, I delay the update until processing the next =
sg
> segment, when the request pointer is known to be good.
>
> =C2=A0 =C2=A0modified: =C2=A0 arch/um/drivers/ubd_kern.c

This changeset from 2007 indeed moved the update of req->sector.

However, in the new code, before or after applying your patch, there's no u=
pdate
of req->sector anymore. Everything is done in local variables.

Is it possible that we only need the hunk below to fix the corruption?

| diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
| index 5ff5546..655ed9e 100644
| --- a/arch/um/drivers/ubd_kern.c
| +++ b/arch/um/drivers/ubd_kern.c
| @@ -746,8 +746,12 @@ static int ubd_open_dev(struct ubd *ubd_dev)
|       }
|       ubd_dev->fd =3D fd;
|
| +     /* A setting higher than 1 sector currently (v2.6.33) generates
| +     data loss, both for raw and cow ubd. */
| +     blk_queue_max_sectors(ubd_dev->queue, 1 * sizeof(long));
| +     blk_queue_max_phys_segments(ubd_dev->queue, 1 * sizeof(long));
| +
|       if(ubd_dev->cow.file !=3D NULL){
| -             blk_queue_max_sectors(ubd_dev->queue, 8 * sizeof(long));
|
|               err =3D -ENOMEM;
|               ubd_dev->cow.bitmap =3D vmalloc(ubd_dev->cow.bitmap_len);

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

