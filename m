Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVsJt-005K9r-DU
	for linux-um@lists.infradead.org; Wed, 07 Sep 2022 10:30:10 +0000
Received: by mail-lf1-x12c.google.com with SMTP id u18so9414879lfo.8
        for <linux-um@lists.infradead.org>; Wed, 07 Sep 2022 03:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220907100533.1719128-1-vincent.whitchurch@axis.com>
In-Reply-To: <20220907100533.1719128-1-vincent.whitchurch@axis.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 7 Sep 2022 12:29:55 +0200
Message-ID: <CACT4Y+aBpkfgEvM6rE9Kg5U0MwcHnUA+Fm_2F4g9A4QQ3hav4g@mail.gmail.com>
Subject: Re: [PATCH] um: Prevent KASAN splats in dump_stack()
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
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, kernel@axis.com, Patricia Alfonso <trishalfonso@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, 7 Sept 2022 at 12:05, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Use READ_ONCE_NOCHECK() when reading the stack to prevent KASAN splats
> when dump_stack() is used.
>
> Fixes: 5b301409e8bc5d7fad ("UML: add support for KASAN under x86_64")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  arch/um/kernel/sysrq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
> index 7452f70d50d0..746715379f12 100644
> --- a/arch/um/kernel/sysrq.c
> +++ b/arch/um/kernel/sysrq.c
> @@ -48,7 +48,8 @@ void show_stack(struct task_struct *task, unsigned long *stack,
>                         break;
>                 if (i && ((i % STACKSLOTS_PER_LINE) == 0))
>                         pr_cont("\n");
> -               pr_cont(" %08lx", *stack++);
> +               pr_cont(" %08lx", READ_ONCE_NOCHECK(*stack));
> +               stack++;
>         }
>
>         printk("%sCall Trace:\n", loglvl);
> --
> 2.34.1
>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

