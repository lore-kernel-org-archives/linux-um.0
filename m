Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfVGg-0005sX-9t
 for linux-um@lists.infradead.org; Wed, 18 Nov 2020 21:45:35 +0000
Received: by mail-qv1-xf42.google.com with SMTP id z17so1821156qvy.11
 for <linux-um@lists.infradead.org>; Wed, 18 Nov 2020 13:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20201025044139.3019273-1-krisman@collabora.com>
In-Reply-To: <20201025044139.3019273-1-krisman@collabora.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 18 Nov 2020 22:45:19 +0100
Message-ID: <CAFLxGvx41r+DhQnJKtGWuiWq85N8c1tEHuvC-EQn8hzkE8KvWQ@mail.gmail.com>
Subject: Re: [PATCH] um: ubd: Submit all data segments atomically
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: Martyn Welch <martyn@collabora.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Sun, Oct 25, 2020 at 5:42 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Internally, UBD treats each physical IO segment as a separate command to
> be submitted in the execution pipe.  If the pipe returns a transient
> error after a few segments have already been written, UBD will tell the
> block layer to requeue the request, but there is no way to reclaim the
> segments already submitted.  When a new attempt to dispatch the request
> is done, those segments already submitted will get duplicated, causing
> the WARN_ON below in the best case, and potentially data corruption.
>
> In my system, running a UML instance with 2GB of RAM and a 50M UBD disk,
> I can reproduce the WARN_ON by simply running mkfs.fvat against the
> disk on a freshly booted system.
>
> There are a few ways to around this, like reducing the pressure on
> the pipe by reducing the queue depth, which almost eliminates the
> occurrence of the problem, increasing the pipe buffer size on the host
> system, or by limiting the request to one physical segment, which causes
> the block layer to submit way more requests to resolve a single
> operation.
>
> Instead, this patch modifies the format of a UBD command, such that all
> segments are sent through a single element in the communication pipe,
> turning the command submission atomic from the point of view of the
> block layer.  The new format has a variable size, depending on the
> number of elements, and looks like this:
>
> +------------+-----------+-----------+------------
> | cmd_header | segment 0 | segment 1 | segment ...
> +------------+-----------+-----------+------------
>
> With this format, we push a pointer to cmd_header in the submission
> pipe.
>
> This has the advantage of reducing the memory footprint of executing a
> single request, since it allow us to merge some fields in the header.
> It is possible to reduce even further each segment memory footprint, by
> merging bitmap_words and cow_offset, for instance, but this is not the
> focus of this patch and is left as future work.  One issue with the
> patch is that for a big number of segments, we now perform one big
> memory allocation instead of multiple small ones, but I wasn't able to
> trigger any real issues or -ENOMEM because of this change, that wouldn't
> be reproduced otherwise.
>
> This was tested using fio with the verify-crc32 option, and by running
> an ext4 filesystem over this UBD device.
>
> The original WARN_ON was:
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at lib/refcount.c:28 refcount_warn_saturate+0x13f/0x141
> refcount_t: underflow; use-after-free.
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.5.0-rc6-00002-g2a5bb2cf75c8 #346
> Stack:
>  6084eed0 6063dc77 00000009 6084ef60
>  00000000 604b8d9f 6084eee0 6063dcbc
>  6084ef40 6006ab8d e013d780 1c00000000
> Call Trace:
>  [<600a0c1c>] ? printk+0x0/0x94
>  [<6004a888>] show_stack+0x13b/0x155
>  [<6063dc77>] ? dump_stack_print_info+0xdf/0xe8
>  [<604b8d9f>] ? refcount_warn_saturate+0x13f/0x141
>  [<6063dcbc>] dump_stack+0x2a/0x2c
>  [<6006ab8d>] __warn+0x107/0x134
>  [<6008da6c>] ? wake_up_process+0x17/0x19
>  [<60487628>] ? blk_queue_max_discard_sectors+0x0/0xd
>  [<6006b05f>] warn_slowpath_fmt+0xd1/0xdf
>  [<6006af8e>] ? warn_slowpath_fmt+0x0/0xdf
>  [<600acc14>] ? raw_read_seqcount_begin.constprop.0+0x0/0x15
>  [<600619ae>] ? os_nsecs+0x1d/0x2b
>  [<604b8d9f>] refcount_warn_saturate+0x13f/0x141
>  [<6048bc8f>] refcount_sub_and_test.constprop.0+0x2f/0x37
>  [<6048c8de>] blk_mq_free_request+0xf1/0x10d
>  [<6048ca06>] __blk_mq_end_request+0x10c/0x114
>  [<6005ac0f>] ubd_intr+0xb5/0x169
>  [<600a1a37>] __handle_irq_event_percpu+0x6b/0x17e
>  [<600a1b70>] handle_irq_event_percpu+0x26/0x69
>  [<600a1bd9>] handle_irq_event+0x26/0x34
>  [<600a1bb3>] ? handle_irq_event+0x0/0x34
>  [<600a5186>] ? unmask_irq+0x0/0x37
>  [<600a57e6>] handle_edge_irq+0xbc/0xd6
>  [<600a131a>] generic_handle_irq+0x21/0x29
>  [<60048f6e>] do_IRQ+0x39/0x54
>  [...]
> ---[ end trace c6e7444e55386c0f ]---
>
> Cc: Christopher Obbard <chris.obbard@collabora.com>
> Reported-by: Martyn Welch <martyn@collabora.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  arch/um/drivers/ubd_kern.c | 191 ++++++++++++++++++++++---------------
>  1 file changed, 115 insertions(+), 76 deletions(-)
>
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index eae8c83364f7..a97b40432331 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -47,18 +47,25 @@
>  /* Max request size is determined by sector mask - 32K */
>  #define UBD_MAX_REQUEST (8 * sizeof(long))
>
> +struct io_desc {
> +       char *buffer;
> +       unsigned long length;
> +       unsigned long sector_mask;
> +       unsigned long long cow_offset;
> +       unsigned long bitmap_words[2];
> +};
> +
>  struct io_thread_req {
>         struct request *req;
>         int fds[2];
>         unsigned long offsets[2];
>         unsigned long long offset;
> -       unsigned long length;
> -       char *buffer;
>         int sectorsize;
> -       unsigned long sector_mask;
> -       unsigned long long cow_offset;
> -       unsigned long bitmap_words[2];
>         int error;
> +
> +       int desc_cnt;
> +       /* io_desc has to be the last element of the struct */
> +       struct io_desc io_desc[0];

No new zero-sized arrays please, use a flexible array.
struct io_desc io_desc[];

See https://github.com/KSPP/linux/issues/21

--
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

