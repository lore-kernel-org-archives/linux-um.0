MIME-Version: 1.0
Date: Thu, 8 Nov 2018 14:15:36 +0100
References: <20181108130723.12101-1-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20181108130723.12101-1-anton.ivanov@cambridgegreys.com>
Message-ID: <CAMuHMdXYOwiUP9L9WdrFKoiUisowOjwL0jDDZ6o_M-PTzXHjhg@mail.gmail.com>
Subject: Re: [PATCH] Fix breakage from switching to MQ BLK framework
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-um.lists.infradead.org>

Hi Anton,

On Thu, Nov 8, 2018 at 2:08 PM <anton.ivanov@cambridgegreys.com> wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>
> Initial version by Jens Axboe <axboe@kernel.dk>
>
> 1. Fix use of use unititalized req->error for SYNC commands
> 2. Guard the request submission by a spinlock
>
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>  arch/um/drivers/ubd_kern.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 74c002ddc0ce..e3d587d9eff6 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -1305,6 +1305,7 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
>                 io_req->fds[0] = dev->cow.fd;
>         else
>                 io_req->fds[0] = dev->fd;
> +       io_req->error = 0;

Perhaps it's safer to just use kzalloc() instead of kmalloc()?

>
>         if (req_op(req) == REQ_OP_FLUSH) {
>                 io_req->op = UBD_FLUSH;
> @@ -1313,9 +1314,7 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
>                 io_req->cow_offset = -1;
>                 io_req->offset = off;
>                 io_req->length = bvec->bv_len;
> -               io_req->error = 0;
>                 io_req->sector_mask = 0;
> -
>                 io_req->op = rq_data_dir(req) == READ ? UBD_READ : UBD_WRITE;
>                 io_req->offsets[0] = 0;
>                 io_req->offsets[1] = dev->cow.data_offset;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

