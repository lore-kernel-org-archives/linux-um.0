MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1285693648.14518.7.camel@voyager>
References: <AANLkTi=PTp7YW_eYxtF-H2QSxgei3whWH59wU0C9oCkz@mail.gmail.com>
	<1285693648.14518.7.camel@voyager>
Date: Tue, 28 Sep 2010 21:52:01 +0200
Message-ID: <AANLkTi=NiB4hoA5Y8kbR7R8B+J-jJXAHGSu5JdOLSQsj@mail.gmail.com>
Subject: Re: [uml-devel] [REGRESSION] um: ubd: block layer issue (Was: ext3
 filesystem corruption in user mode linux)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Janjaap Bos <janjaap@bos.nl>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, tj@kernel.org, axboe@kernel.dk, mike.miller@hp.com, user-mode-linux-devel@lists.sourceforge.net, adrian@mcmen.demon.co.uk, jdike@addtoit.com, LKML <linux-kernel@vger.kernel.org>, grant.likely@secretlab.ca, Geert.Uytterhoeven@sonycom.com, Chris Frey <cdfrey@foursquare.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Sep 28, 2010 at 19:07, Janjaap Bos <janjaap@bos.nl> wrote:
> See attached patch, and earlier message posted in March 2010 on uml user
> list. We are out of maintainer...

Thanks for the patch!

| --- a/arch/um/drivers/ubd_kern.c
| +++ b/arch/um/drivers/ubd_kern.c
| @@ -1223,7 +1227,7 @@ static void do_ubd_request(struct request_queue *q)
|       struct io_thread_req *io_req;
|       struct request *req;
|       sector_t sector;
| -     int n;
| +     int n, last_sectors;
|
|       while(1){
|               struct ubd *dev =3D q->queuedata;
| @@ -1239,9 +1243,12 @@ static void do_ubd_request(struct request_queue *q=
)
|
|               req =3D dev->request;
|               sector =3D blk_rq_pos(req);
| +             last_sectors =3D 0;
|               while(dev->start_sg < dev->end_sg){
|                       struct scatterlist *sg =3D &dev->sg[dev->start_sg];
|
| +                     sector +=3D last_sectors;
| +                     last_sectors =3D 0;
|                       io_req =3D kmalloc(sizeof(struct io_thread_req),
|                                        GFP_ATOMIC);
|                       if(io_req =3D=3D NULL){
| @@ -1253,7 +1260,7 @@ static void do_ubd_request(struct request_queue *q)
|                                       (unsigned long long)sector << 9,
|                                       sg->offset, sg->length, sg_page(sg)=
);
|
| -                     sector +=3D sg->length >> 9;
| +                     last_sectors =3D sg->length >> 9;
|                       n =3D os_write_file(thread_fd, &io_req,
|                                         sizeof(struct io_thread_req *));
|                       if(n !=3D sizeof(struct io_thread_req *)){

However, I'm wondering what difference this part makes?

> On Tue, 2010-09-28 at 18:16 +0200, richard -rw- weinberger wrote:
>> Hi Tejun!
>>
>> Chris Frey ran into some problems with ext3 on UML.
>> See: http://marc.info/?i=3D20100924041410.GA18040%20()%20foursquare%20!%=
20net
>>
>> I can reproduce this issue with any file system on Linux >=3D 2.6.31.
>> There seems to be a serious problem with the block layer on UML.
>> Under high load any file system gets corrupted.
>>
>> The regression was most likely introduced with this three changes:
>> 83096ebf1263b2c1ee5e653ba37d993d02e3eb7b (block: convert to pos and
>> nr_sectors accessors)
>> f81f2f7c9fee307e371f37424577d46f9eaf8692 (ubd: drop unnecessary
>> rq->sector manipulation)
>> 4d6c84d91d1a539ebc47d1a36a35e9390ba11fdc (ubd: cleanup completion path)
>>
>> Maybe only f81f2f7 is the bad one. They depend on each and I don't
>> know all the internals...

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

