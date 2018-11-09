Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gLDxI-0000Uz-72
 for linux-um@lists.infradead.org; Fri, 09 Nov 2018 21:04:41 +0000
Received: by mail-wr1-x442.google.com with SMTP id z16-v6so3273429wrv.2
 for <linux-um@lists.infradead.org>; Fri, 09 Nov 2018 13:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20181109091937.25470-1-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20181109091937.25470-1-anton.ivanov@cambridgegreys.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 9 Nov 2018 22:04:16 +0100
Message-ID: <CAFLxGvxy7d_9--b_SPcPQ_e=Er0aJds5TBqfd5Q-OANCj6DOaQ@mail.gmail.com>
Subject: Re: [PATCH] Add DISCARD support to UML udb driver
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-um@lists.infradead.org, Christoph Hellwig <hch@lst.de>

On Fri, Nov 9, 2018 at 10:20 AM <anton.ivanov@cambridgegreys.com> wrote:
>
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>
> 1. Remove UBD specific opcode definitions and reuse the block-mq
> ones
> 2. Add DISCARD and ZERO fill support (tested with ext4).
> 3. Further cleanup on the request forming, request checking and
> handling of unexpected command codes.

As Jens already asked, please one patch per logical change.
Also make sure to use a proper subject line.
Either prefix with "um: ..."  or "ubd: ...".
If prefer "um", but if it really affects only the ubd driver, "ubd:"
is fine too.

> +int os_falloc_punch(int fd, unsigned long long offset, int len)
> +{
> +       int n = fallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, offset, len);
> +
> +       if (n < 0)
> +               return -errno;
> +       return n;
> +}

What shall happen if the host filesystem does not support these
fallocate() operations?
I guess we need to probe for them first and decide whether to
accept/offer the discard command
at run time.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

