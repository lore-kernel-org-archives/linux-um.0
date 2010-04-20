Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 20 Apr 2010 16:31:53 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/5] uml: Remove unused variable from line driver
In-Reply-To: <f430193946dbd11791e8fb5bef2e4a8e68393828.1271713955.git.jan.kiszka@web.de>
Message-ID: <alpine.LNX.2.00.1004201631440.7579@pobox.suse.cz>
References: <cover.1271713955.git.jan.kiszka@web.de> <f430193946dbd11791e8fb5bef2e4a8e68393828.1271713955.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, 19 Apr 2010, Jan Kiszka wrote:

> Signed-off-by: Jan Kiszka <jan.kiszka@web.de>
> ---
>  arch/um/drivers/line.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
> index 7a656bd..7f7338c 100644
> --- a/arch/um/drivers/line.c
> +++ b/arch/um/drivers/line.c
> @@ -19,7 +19,6 @@ static irqreturn_t line_interrupt(int irq, void *data)
>  {
>  	struct chan *chan = data;
>  	struct line *line = chan->line;
> -	struct tty_struct *tty;
>  
>  	if (line)
>  		chan_interrupt(&line->chan_list, &line->task, line->tty, irq);

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
