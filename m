Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYOHt-00DoWe-6y
	for linux-um@lists.infradead.org; Wed, 14 Sep 2022 09:02:31 +0000
Message-ID: <b203541c-680e-7ec8-b718-fed01911dee0@cambridgegreys.com>
Date: Wed, 14 Sep 2022 09:38:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] um: remove unused reactivate_chan() declaration
Content-Language: en-US
References: <20220914073027.1340509-1-cuigaosheng1@huawei.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20220914073027.1340509-1-cuigaosheng1@huawei.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Gaosheng Cui <cuigaosheng1@huawei.com>, richard@nod.at, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org



On 14/09/2022 08:30, Gaosheng Cui wrote:
> All uses of reactivate_chan() were removed by
> commit 940b241d9050 ("um: Remove obsolete reenable_XX
> calls"), so remove the declaration, too.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>   arch/um/drivers/chan.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/um/drivers/chan.h b/arch/um/drivers/chan.h
> index c37cc4f26f91..3fec3b8406e9 100644
> --- a/arch/um/drivers/chan.h
> +++ b/arch/um/drivers/chan.h
> @@ -36,7 +36,6 @@ extern int console_write_chan(struct chan *chan, const char *buf,
>   			      int len);
>   extern int console_open_chan(struct line *line, struct console *co);
>   extern void deactivate_chan(struct chan *chan, int irq);
> -extern void reactivate_chan(struct chan *chan, int irq);
>   extern void chan_enable_winch(struct chan *chan, struct tty_port *port);
>   extern int enable_chan(struct line *line);
>   extern void close_chan(struct line *line);

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

