Return-Path: <richard.weinberger@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4CB70234.3030308@gmail.com>
References: <20100928225202.GA30352@foursquare.net>
	<4CA275CE.6060401@fusionio.com>
	<20100929012945.GA3324@foursquare.net>
	<4CA2CCC3.8010307@fusionio.com>
	<20100929063452.GA13290@foursquare.net>
	<4CAA02D0.7040901@gmail.com>
	<20101004195152.GA31583@foursquare.net>
	<4CAAE077.9010500@gmail.com>
	<20101005203137.GA594@foursquare.net>
	<4CAD7D98.7080808@fusionio.com>
	<20101007202339.GA8338@foursquare.net>
	<4CB70234.3030308@gmail.com>
Date: Thu, 14 Oct 2010 16:20:10 +0200
Message-ID: <AANLkTi=ni-zEfCMXLR8BJyPQcwzEKAUKYs4uH7ur12Fk@mail.gmail.com>
Subject: Re: [PATCH 1/1] um: ubd: Fix data corruption
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
To: Tejun Heo <htejun@gmail.com>
Cc: Chris Frey <cdfrey@foursquare.net>, Jens Axboe <jaxboe@fusionio.com>, Richard Weinberger <richard@nod.at>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jdike@addtoit.com" <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>, "janjaap@bos.nl" <janjaap@bos.nl>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "syzop@vulnscan.org" <syzop@vulnscan.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Oct 14, 2010 at 3:14 PM, Tejun Heo <htejun@gmail.com> wrote:
> Hello,
>
> Can you please try this one then? =A0It seems to work here but I can't
> reproduce the original problem reliably so I'm not really sure.
>
> Thanks.
>
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 1bcd208..9734994 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -163,6 +163,7 @@ struct ubd {
> =A0 =A0 =A0 =A0struct scatterlist sg[MAX_SG];
> =A0 =A0 =A0 =A0struct request *request;
> =A0 =A0 =A0 =A0int start_sg, end_sg;
> + =A0 =A0 =A0 sector_t rq_pos;
> =A0};
>
> =A0#define DEFAULT_COW { \
> @@ -187,6 +188,7 @@ struct ubd {
> =A0 =A0 =A0 =A0.request =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL, \
> =A0 =A0 =A0 =A0.start_sg =3D =A0 =A0 =A0 =A0 =A0 =A0 0, \
> =A0 =A0 =A0 =A0.end_sg =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, \
> + =A0 =A0 =A0 .rq_pos =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, \
> =A0}
>
> =A0/* Protected by ubd_lock */
> @@ -1228,7 +1230,6 @@ static void do_ubd_request(struct request_queue *q)
> =A0{
> =A0 =A0 =A0 =A0struct io_thread_req *io_req;
> =A0 =A0 =A0 =A0struct request *req;
> - =A0 =A0 =A0 sector_t sector;
> =A0 =A0 =A0 =A0int n;
>
> =A0 =A0 =A0 =A0while(1){
> @@ -1239,12 +1240,12 @@ static void do_ubd_request(struct request_queue *=
q)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->request =3D req;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->rq_pos =3D blk_rq_pos(=
req);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->start_sg =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->end_sg =3D blk_rq_map=
_sg(q, req, dev->sg);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0req =3D dev->request;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sector =3D blk_rq_pos(req);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while(dev->start_sg < dev->end_sg){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct scatterlist *sg =3D=
 &dev->sg[dev->start_sg];
>
> @@ -1256,10 +1257,9 @@ static void do_ubd_request(struct request_queue *q=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prepare_request(req, io_re=
q,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (unsigned long long)sector << 9,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (unsigned long long)dev->rq_pos << 9,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0sg->offset, sg->length, sg_page(sg));
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sector +=3D sg->length >> 9=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n =3D os_write_file(thread=
_fd, &io_req,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0sizeof(struct io_thread_req *));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(n !=3D sizeof(struct io=
_thread_req *)){
> @@ -1272,6 +1272,7 @@ static void do_ubd_request(struct request_queue *q)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->rq_pos +=3D sg->length=
 >> 9;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->start_sg++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->end_sg =3D 0;


It does not work for me.
But the error is a different one. :-)
Without your patch I've never got this kernel trace.

[   59.850000] kworker/0:1: page allocation failure. order:0, mode:0x20
[   59.850000] 0fe22d68:  [<081ca1da>] dump_stack+0x1c/0x20
[   59.850000] 0fe22d80:  [<080a4981>] __alloc_pages_nodemask+0x4a0/0x4cb
[   59.850000] 0fe22e00:  [<080bd2d7>] cache_alloc_refill+0x213/0x3fe
[   59.850000] 0fe22e58:  [<080bd5db>] kmem_cache_alloc+0x62/0x8f
[   59.850000] 0fe22e74:  [<08062a4c>] do_ubd_request+0x91/0x40c
[   59.850000] 0fe22edc:  [<08148f01>] __blk_run_queue+0x40/0x6e
[   59.850000] 0fe22ef0:  [<08151280>] cfq_kick_queue+0x24/0x39
[   59.850000] 0fe22f08:  [<08083c86>] process_one_work+0x1ea/0x2f0
[   59.850000] 0fe22f44:  [<08084202>] worker_thread+0x174/0x2e4
[   59.850000] 0fe22f74:  [<08087e5b>] kthread+0x78/0x7f
[   59.850000] 0fe22fb4:  [<08066117>] run_kernel_thread+0x37/0x3f
[   59.850000] 0fe22fe0:  [<08059bd1>] new_thread_handler+0x60/0x87
[   59.850000] 0fe22ffc:  [<00000000>] 0x0
[   59.850000]
[   59.850000] Mem-Info:
[   59.850000] Normal per-cpu:
[   59.850000] CPU    0: hi:   42, btch:   7 usd:  15
[   59.850000] active_anon:1146 inactive_anon:1194 isolated_anon:0
[   59.850000]  active_file:4314 inactive_file:19869 isolated_file:0
[   59.850000]  unevictable:0 dirty:1327 writeback:1837 unstable:0
[   59.850000]  free:131 slab_reclaimable:3618 slab_unreclaimable:1141
[   59.850000]  mapped:1105 shmem:10 pagetables:82 bounce:0
[   59.850000] Normal free:524kB min:1440kB low:1800kB high:2160kB
active_anon:4584kB inactive_anon:4776kB active_file:17256kB
inactive_file:79476kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:130048kB mlocked:0kB dirty:5308kB
writeback:7348kB mapped:4420kB shmem:40kB slab_reclaimable:14472kB
slab_unreclaimable:4564kB kernel_stack:164kB pagetables:328kB
unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0
all_unreclaimable? no
[   59.850000] lowmem_reserve[]: 0 0
[   59.850000] Normal: 1*4kB 3*8kB 25*16kB 3*32kB 0*64kB 0*128kB
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 524kB
[   59.850000] 24193 total pagecache pages
[   59.850000] 0 pages in swap cache
[   59.850000] Swap cache stats: add 0, delete 0, find 0/0
[   59.850000] Free swap  =3D 0kB
[   59.850000] Total swap =3D 0kB
[   59.850000] 32768 pages RAM
[   59.850000] 1132 pages reserved
[   59.850000] 26071 pages shared
[   59.850000] 8225 pages non-shared
[   94.930000] kworker/0:1: page allocation failure. order:0, mode:0x20
[   94.930000] 0fe22d68:  [<081ca1da>] dump_stack+0x1c/0x20
[   94.930000] 0fe22d80:  [<080a4981>] __alloc_pages_nodemask+0x4a0/0x4cb
[   94.930000] 0fe22e00:  [<080bd2d7>] cache_alloc_refill+0x213/0x3fe
[   94.930000] 0fe22e58:  [<080bd5db>] kmem_cache_alloc+0x62/0x8f
[   94.930000] 0fe22e74:  [<08062a4c>] do_ubd_request+0x91/0x40c
[   94.930000] 0fe22edc:  [<08148f01>] __blk_run_queue+0x40/0x6e
[   94.930000] 0fe22ef0:  [<08151280>] cfq_kick_queue+0x24/0x39
[   94.930000] 0fe22f08:  [<08083c86>] process_one_work+0x1ea/0x2f0
[   94.930000] 0fe22f44:  [<08084202>] worker_thread+0x174/0x2e4
[   94.930000] 0fe22f74:  [<08087e5b>] kthread+0x78/0x7f
[   94.930000] 0fe22fb4:  [<08066117>] run_kernel_thread+0x37/0x3f
[   94.930000] 0fe22fe0:  [<08059bd1>] new_thread_handler+0x60/0x87
[   94.930000] 0fe22ffc:  [<00000000>] 0x0
[   94.930000]
[   94.930000] Mem-Info:
[   94.930000] Normal per-cpu:
[   94.930000] CPU    0: hi:   42, btch:   7 usd:   7
[   94.930000] active_anon:1202 inactive_anon:1274 isolated_anon:0
[   94.930000]  active_file:6904 inactive_file:17913 isolated_file:0
[   94.930000]  unevictable:0 dirty:1341 writeback:2209 unstable:0
[   94.930000]  free:132 slab_reclaimable:2912 slab_unreclaimable:1077
[   94.930000]  mapped:1173 shmem:10 pagetables:86 bounce:0
[   94.930000] Normal free:528kB min:1440kB low:1800kB high:2160kB
active_anon:4808kB inactive_anon:5096kB active_file:27616kB
inactive_file:71652kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:130048kB mlocked:0kB dirty:5364kB
writeback:8836kB mapped:4692kB shmem:40kB slab_reclaimable:11648kB
slab_unreclaimable:4308kB kernel_stack:168kB pagetables:344kB
unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0
all_unreclaimable? no
[   94.930000] lowmem_reserve[]: 0 0
[   94.930000] Normal: 0*4kB 0*8kB 17*16kB 8*32kB 0*64kB 0*128kB
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 528kB
[   94.930000] 24827 total pagecache pages
[   94.930000] 0 pages in swap cache
[   94.930000] Swap cache stats: add 0, delete 0, find 0/0
[   94.930000] Free swap  =3D 0kB
[   94.930000] Total swap =3D 0kB
[   94.930000] 32768 pages RAM
[   94.930000] 1132 pages reserved
[   94.930000] 26123 pages shared
[   94.930000] 8586 pages non-shared
[   94.930000] kworker/0:1: page allocation failure. order:0, mode:0x20
[   94.930000] 0fe22c60:  [<081ca1da>] dump_stack+0x1c/0x20
[   94.930000] 0fe22c78:  [<080a4981>] __alloc_pages_nodemask+0x4a0/0x4cb
[   94.930000] 0fe22cf8:  [<080bd2d7>] cache_alloc_refill+0x213/0x3fe
[   94.930000] 0fe22d50:  [<080bd5db>] kmem_cache_alloc+0x62/0x8f
[   94.930000] 0fe22d6c:  [<08062a4c>] do_ubd_request+0x91/0x40c
[   94.930000] 0fe22dd4:  [<08062e5f>] ubd_intr+0x98/0xbf
[   94.930000] 0fe22df8:  [<0809bed1>] handle_IRQ_event+0x15/0x9b
[   94.930000] 0fe22e14:  [<0809bfbd>] __do_IRQ+0x66/0xb8
[   94.930000] 0fe22e34:  [<08059136>] do_IRQ+0x1f/0x34
[   94.930000] 0fe22e44:  [<080592e6>] sigio_handler+0x46/0x5c
[   94.930000] 0fe22e5c:  [<08066e6e>] sig_handler_common+0x61/0x70
[   94.930000] 0fe22ed4:  [<08066ec3>] unblock_signals+0x46/0x57
[   94.930000] 0fe22ee0:  [<081cc3c7>] _raw_spin_unlock_irq+0x10/0x13
[   94.930000] 0fe22eec:  [<0815128b>] cfq_kick_queue+0x2f/0x39
[   94.930000] 0fe22f08:  [<08083c86>] process_one_work+0x1ea/0x2f0
[   94.930000] 0fe22f44:  [<08084202>] worker_thread+0x174/0x2e4
[   94.930000] 0fe22f74:  [<08087e5b>] kthread+0x78/0x7f
[   94.930000] 0fe22fb4:  [<08066117>] run_kernel_thread+0x37/0x3f
[   94.930000] 0fe22fe0:  [<08059bd1>] new_thread_handler+0x60/0x87
[   94.930000] 0fe22ffc:  [<00000000>] 0x0
[   94.930000]
[   94.930000] Mem-Info:
[   94.930000] Normal per-cpu:
[   94.930000] CPU    0: hi:   42, btch:   7 usd:  18
[   94.930000] active_anon:1202 inactive_anon:1274 isolated_anon:0
[   94.930000]  active_file:6904 inactive_file:17913 isolated_file:0
[   94.930000]  unevictable:0 dirty:1341 writeback:1811 unstable:0
[   94.930000]  free:132 slab_reclaimable:2912 slab_unreclaimable:1066
[   94.930000]  mapped:1173 shmem:10 pagetables:86 bounce:0
[   94.930000] Normal free:528kB min:1440kB low:1800kB high:2160kB
active_anon:4808kB inactive_anon:5096kB active_file:27616kB
inactive_file:71652kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:130048kB mlocked:0kB dirty:5364kB
writeback:7244kB mapped:4692kB shmem:40kB slab_reclaimable:11648kB
slab_unreclaimable:4264kB kernel_stack:168kB pagetables:344kB
unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0
all_unreclaimable? no
[   94.930000] lowmem_reserve[]: 0 0
[   94.930000] Normal: 0*4kB 0*8kB 17*16kB 8*32kB 0*64kB 0*128kB
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 528kB
[   94.930000] 24827 total pagecache pages
[   94.930000] 0 pages in swap cache
[   94.930000] Swap cache stats: add 0, delete 0, find 0/0
[   94.930000] Free swap  =3D 0kB
[   94.930000] Total swap =3D 0kB
[   94.930000] 32768 pages RAM
[   94.930000] 1132 pages reserved
[   94.930000] 26123 pages shared
[   94.930000] 8575 pages non-shared

--=20
Thanks,
//richard

