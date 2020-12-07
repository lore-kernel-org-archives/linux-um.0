Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmKQk-0003Fw-7u
 for linux-um@lists.infradead.org; Mon, 07 Dec 2020 17:36:12 +0000
Message-ID: <3904ecc6b329edc1af908f7701bc08fb18316fff.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] um: Monitor error events in IRQ controller
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 07 Dec 2020 18:35:51 +0100
In-Reply-To: <20201207171940.25240-1-anton.ivanov@cambridgegreys.com>
References: <20201207171940.25240-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
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
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at

On Mon, 2020-12-07 at 17:19 +0000, anton.ivanov@cambridgegreys.com
wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Ensure that file closes, connection closes, etc are propagated
> as interrupts in the interrupt controller.
> 
> Fixes: ff6a17989c08 ("Epoll based IRQ controller")
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>  arch/um/os-Linux/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/os-Linux/irq.c b/arch/um/os-Linux/irq.c
> index d508310ee5e1..f1732c308c61 100644
> --- a/arch/um/os-Linux/irq.c
> +++ b/arch/um/os-Linux/irq.c
> @@ -48,7 +48,7 @@ int os_epoll_triggered(int index, int events)
>  int os_event_mask(int irq_type)
>  {
>  	if (irq_type == IRQ_READ)
> -		return EPOLLIN | EPOLLPRI;
> +		return EPOLLIN | EPOLLPRI | EPOLLERR | EPOLLHUP | EPOLLRDHUP;
>  	if (irq_type == IRQ_WRITE)
>  		return EPOLLOUT;

Why not monitor it also for write?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

