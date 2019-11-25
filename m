Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZMcR-0002uB-Ms
 for linux-um@lists.infradead.org; Mon, 25 Nov 2019 22:14:09 +0000
Received: by mail-wr1-x443.google.com with SMTP id z3so20064756wru.3
 for <linux-um@lists.infradead.org>; Mon, 25 Nov 2019 14:14:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com>
 <567fd4d5c395e2279e86ca0bfca544ad2773a31d.1573179553.git.thehajime@gmail.com>
In-Reply-To: <567fd4d5c395e2279e86ca0bfca544ad2773a31d.1573179553.git.thehajime@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 25 Nov 2019 23:13:55 +0100
Message-ID: <CAFLxGvxytmS4WSFj2ibyJKCuR5TbspdNf6MvHNvzh9dtKx2rJg@mail.gmail.com>
Subject: Re: [RFC v2 07/37] lkl: interrupt support
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Octavian Purdila <tavi.purdila@gmail.com>, linux-um@lists.infradead.org, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, Michael Zimmermann <sigmaepsilon92@gmail.com>

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> Add APIs that allows the host to reserve and free and interrupt number
> and also to trigger an interrupt.
>
> The trigger operation will simply store the interrupt data in
> queue. The interrupt handler is run later, at the first opportunity it
> has to avoid races with any kernel threads.
>
> Currently, interrupts are run on the first interrupt enable operation
> if interrupts are disabled and if we are not already in interrupt
> context.
>
> When triggering an interrupt, it uses GCC's built-in functions for
> atomic memory access to synchronize and simple boolean flags.
>
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
> ---
>  arch/um/lkl/include/asm/irq.h             |  13 ++
>  arch/um/lkl/include/uapi/asm/irq.h        |  36 ++++
>  arch/um/lkl/include/uapi/asm/sigcontext.h |  16 ++
>  arch/um/lkl/kernel/irq.c                  | 193 ++++++++++++++++++++++

Like I said before, this also something to unify with UML.
I'm aware that this is easily said but we cannot have too much duplication.

Feel free to ask if UML internals give you headache. :-)

--
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

