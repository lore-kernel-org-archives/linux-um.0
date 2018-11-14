MIME-Version: 1.0
Date: Wed, 14 Nov 2018 10:35:04 +0100
References: <20181114081017.10508-1-anton.ivanov@cambridgegreys.com>
	<20181114081017.10508-3-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20181114081017.10508-3-anton.ivanov@cambridgegreys.com>
Message-ID: <CAMuHMdVOD2SpJeq-Choegn4+ODODo+o25fRR3BU60agF27Nf9A@mail.gmail.com>
Subject: Re: [PATCH 3/4] um: Remove unsafe printks from the io thread
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-um.lists.infradead.org>

Hi Anton,

On Wed, Nov 14, 2018 at 9:11 AM <anton.ivanov@cambridgegreys.com> wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>
> Printk out of the io thread has been proven to be unsafe. This
> is not surprising as the thread is part of the UML hypervisor
> code. It is not supposed to invoke any kernel code/resources.

Thanks for your patch!

Perhaps this can be made safer, so people don't shoot themselves in the foot?
I was thinking about e.g. redefining printk() in kern.h to something
that doesn't
exist, to cause a link error, and preincluding kern.h in all *_kern.c files,
like is currently done with user.h in arch/um/scripts/Makefile.rules.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

