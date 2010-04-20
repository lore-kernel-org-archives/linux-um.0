Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 20 Apr 2010 16:32:36 +0800
From: Amerigo Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 1/5] uml: Remove unused variable from line driver
Message-ID: <20100420083236.GC4356@cr0.nay.redhat.com>
References: <cover.1271713955.git.jan.kiszka@web.de>
 <f430193946dbd11791e8fb5bef2e4a8e68393828.1271713955.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f430193946dbd11791e8fb5bef2e4a8e68393828.1271713955.git.jan.kiszka@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Apr 19, 2010 at 11:53:04PM +0200, Jan Kiszka wrote:
>Signed-off-by: Jan Kiszka <jan.kiszka@web.de>


Acked-by: WANG Cong <xiyou.wangcong@gmail.com>


>---
> arch/um/drivers/line.c |    1 -
> 1 files changed, 0 insertions(+), 1 deletions(-)
>
>diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
>index 7a656bd..7f7338c 100644
>--- a/arch/um/drivers/line.c
>+++ b/arch/um/drivers/line.c
>@@ -19,7 +19,6 @@ static irqreturn_t line_interrupt(int irq, void *data)
> {
> 	struct chan *chan = data;
> 	struct line *line = chan->line;
>-	struct tty_struct *tty;
> 
> 	if (line)
> 		chan_interrupt(&line->chan_list, &line->task, line->tty, irq);
>-- 
>1.6.0.2
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
