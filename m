Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUcC2-0006u5-Lt
 for linux-um@lists.infradead.org; Mon, 19 Oct 2020 20:55:49 +0000
Received: by mail-qt1-x841.google.com with SMTP id e6so820760qtw.10
 for <linux-um@lists.infradead.org>; Mon, 19 Oct 2020 13:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLxGvxsHD6zvTJSHeo2gaoRQfjUPZ6M=5BirOObHFjGqnzfew@mail.gmail.com>
 <7307c1ca-696f-060d-78a2-d4bf05221e71@cambridgegreys.com>
 <69a216ca-6e93-a615-eb98-bdc73859d604@cambridgegreys.com>
In-Reply-To: <69a216ca-6e93-a615-eb98-bdc73859d604@cambridgegreys.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 19 Oct 2020 22:55:33 +0200
Message-ID: <CAFLxGvzS5KmWk6Wi5uun8q6Nbe493YtO5tWJARLUSAaCa3ubgA@mail.gmail.com>
Subject: Re: Fwd: [PATCH] arch: um: convert tasklets to use new
 tasklet_setup() API
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
Cc: linux-um <linux-um@lists.infradead.org>, willy@infradead.org

[CC'ing willy]

On Mon, Oct 19, 2020 at 10:26 AM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
>
>
> On 19/10/2020 08:43, Anton Ivanov wrote:
> > Hi all,
> >
> > When checking the tasklet patch I noticed that the mm is throwing page in invalid state warnings. This is not related to the tasklet and it something which appeared recently. I think it was not there in 5.9.
> >
> > [  721.930000] BUG: Bad page state in process sshd  pfn:031f9
> > [  721.930000] page:0000000054519316 refcount:0 mapcount:-1024 mapping:0000000000000000 index:0x0 pfn:0x31f9
> > [  721.930000] flags: 0x0()
> > [  721.930000] raw: 0000000000000000 0000000000000100 0000000000000122 0000000000000000
> > [  721.930000] raw: 0000000000000000 0000000000000000 00000000fffffbff
> > [  721.930000] page dumped because: nonzero mapcount
> > [  721.930000] Modules linked in:
> > [  721.930000] CPU: 0 PID: 201 Comm: sshd Tainted: G    B W         5.9.0-11954-gc370f4218465 #66
> > [  721.930000] Stack:
> > [  721.930000]  60307b89 604feb38 65b4f900 dfde3e78
> > [  721.930000]  6039cd29 604feb38 dfd29000 65b4f9a0
> > [  721.930000]  65b4f910 60308de6 65b4f950 600cd6ed
> > [  721.930000] Call Trace:
> > [  721.930000]  [<60307b89>] ? printk+0x0/0x94
> > [  721.930000]  [<6001f382>] show_stack+0x13e/0x14d
> > [  721.930000]  [<60307b89>] ? printk+0x0/0x94
> > [  721.930000]  [<60308de6>] dump_stack+0x34/0x36
> > [  721.930000]  [<600cd6ed>] bad_page+0x13a/0x162
> > [  721.930000]  [<600cde98>] ? __free_one_page+0x97/0x19d
> > [  721.930000]  [<600cd750>] check_free_page+0x3b/0x44
> > [  721.930000]  [<600ce274>] free_pcppages_bulk+0xb9/0x1c1
> > [  721.930000]  [<600cd7f5>] ? arch_local_irq_save+0x0/0x29
> > [  721.930000]  [<600ce44b>] ? free_unref_page_commit.isra.133+0x0/0x91
> > [  721.930000]  [<600cf3a4>] free_unref_page_list+0xeb/0x133
> > [  721.930000]  [<600a77fa>] ? compound_head+0x0/0x11
> > [  721.930000]  [<600a7849>] ? test_bit+0x0/0xd
> > [  721.930000]  [<60035459>] ? set_signals+0x0/0x36
> > [  721.930000]  [<600a85bc>] release_pages+0x227/0x236
> > [  721.930000]  [<600d4035>] ? free_swap_cache+0x0/0x66
> > [  721.930000]  [<60035367>] ? block_signals+0x0/0x11
> > [  721.930000]  [<600d47e6>] free_pages_and_swap_cache+0x4c/0x55
> > [  721.930000]  [<600d479a>] ? free_pages_and_swap_cache+0x0/0x55
> > [  721.930000]  [<600c5681>] tlb_flush_mmu+0x54/0x6e
> > [  721.930000]  [<600cf089>] ? free_pages+0x0/0x3a
> > [  721.930000]  [<600c1957>] ? remove_vma+0x0/0x54
> > [  721.930000]  [<600c5738>] tlb_finish_mmu+0x47/0x76
> > [  721.930000]  [<600c1957>] ? remove_vma+0x0/0x54
> > [  721.930000]  [<600c334f>] exit_mmap+0x101/0x186
> > [  721.930000]  [<6003b765>] __mmput+0x24/0xa7
> > [  721.930000]  [<6003b7fd>] mmput+0x15/0x17
> > [  721.930000]  [<600e7acb>] begin_new_exec+0x76c/0xa41
> > [  721.930000]  [<60035378>] ? unblock_signals+0x0/0xd7
> > [  721.930000]  [<60137627>] load_elf_binary+0x294/0xcb3
> > [  721.930000]  [<600ddfb5>] ? set_fs+0x0/0x14
> > [  721.930000]  [<600de5ae>] ? fsnotify_parent.constprop.52+0x43/0x64
> > [  721.930000]  [<601357cc>] ? load_elf_phdrs+0x0/0x85
> > [  721.930000]  [<6021ed63>] ? memcmp+0x0/0x1d
> > [  721.930000]  [<60087b84>] ? try_module_get+0x0/0x36
> > [  721.930000]  [<600e6044>] exec_binprm+0xef/0x30a
> > [  721.930000]  [<600e5618>] ? test_bit+0x0/0xd
> > [  721.930000]  [<600e6f2f>] bprm_execve+0x1ee/0x2de
> > [  721.930000]  [<600e5c5b>] ? copy_strings+0x0/0x26f
> > [  721.930000]  [<600e7184>] do_execveat_common+0x165/0x19e
> > [  721.930000]  [<600e7dd6>] sys_execve+0x36/0x3d
> > [  721.930000]  [<60021365>] handle_syscall+0x79/0xa7
> > [  721.930000]  [<60037ff3>] userspace+0x483/0x510
> > [  721.930000]  [<6001e1ab>] fork_handler+0x94/0x96
> >
> > I will try to have a go at that and figure out where it came from.
>
> This happens as a result of:
>
>
> commit b2b29d6d01194404dfef4eafa026959be301705b (HEAD)
> Author: Matthew Wilcox <willy@infradead.org>
> Date:   Tue Oct 13 16:53:22 2020 -0700
>
>      mm: account PMD tables like PTE tables
>
> There is however, another bug too.
>
> At some point between 5.9 and this commit slab starts throwing a warning that a page is not a slab page.
>
> I will try to narrow that one down too and send it to the list.
>
>
> >
> > A.
> >
> >
> >
> > -------- Forwarded Message --------
> > Subject:      Re: [PATCH] arch: um: convert tasklets to use new tasklet_setup() API
> > Date:         Sun, 18 Oct 2020 23:50:00 +0200
> > From:         Richard Weinberger <richard.weinberger@gmail.com>
> > To:   Allen Pais <allen.cryptic@gmail.com>
> > CC:   Ulf Hansson <ulf.hansson@linaro.org>, linux-atm-general@lists.sourceforge.net, manohar.vanga@gmail.com, Dave Airlie <airlied@linux.ie>, Allen Pais <allen.lkml@gmail.com>, linux-hyperv@vger.kernel.org, DRI mailing list <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, K. Y. Srinivasan <kys@microsoft.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Maxim Levitsky <maximlevitsky@gmail.com>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, jassisinghbrar@gmail.com, 3chas3@gmail.com, intel-gfx@lists.freedesktop.org, kuba@kernel.org, mporter@kernel.crashing.org, Jeff Dike <jdike@addtoit.com>, Kees Cook <keescook@chromium.org>, Alex Dubov <oakad@yahoo.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-input@vger.kernel.org, linux-um <linux-um@lists.infradead.org>,
> > linux-block@vger.kernel.org, Mark Brown <broonie@kernel.org>, openipmi-developer@lists.sourceforge.net, mitch@sfgoth.com, linux-arm-kernel@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, linux-parisc@vger.kernel.org, netdev@vger.kernel.org, martyn@welchs.me.uk, dmitry.torokhov@gmail.com, linux-mmc@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, open list:SPI SUBSYSTEM <linux-spi@vger.kernel.org>, alex.bou9@gmail.com, stefanr@s5r6.in-berlin.de, Daniel Vetter <daniel@ffwll.ch>, linux-ntb@googlegroups.com, Romain Perier <romain.perier@gmail.com>, Shawn Guo <shawnguo@kernel.org>, David S. Miller <davem@davemloft.net>
> >
> >
> >
> > On Mon, Aug 17, 2020 at 11:17 AM Allen Pais <allen.cryptic@gmail.com> wrote:
> >> From: Allen Pais<allen.lkml@gmail.com>
> >>
> >> In preparation for unconditionally passing the
> >> struct tasklet_struct pointer to all tasklet
> >> callbacks, switch to using the new tasklet_setup()
> >> and from_tasklet() to pass the tasklet pointer explicitly.
> >>
> >> Signed-off-by: Romain Perier<romain.perier@gmail.com>
> >> Signed-off-by: Allen Pais<allen.lkml@gmail.com>
> >> ---
> >>   arch/um/drivers/vector_kern.c | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > Anton, can you please review this patch?
> >
> > --
> > Thanks,
> > //richard
> >
> > _______________________________________________
> > linux-um mailing list
> > linux-um@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-um
> >
>
> --
> Anton R. Ivanov
> Cambridgegreys Limited. Registered in England. Company Number 10273661
> https://www.cambridgegreys.com/



-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

