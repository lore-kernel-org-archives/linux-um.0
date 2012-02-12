Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1RwNpe-0000Pr-63
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Feb 2012 01:02:22 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RwNpc-0004TR-Jy
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Feb 2012 01:02:21 +0000
Date: Sun, 12 Feb 2012 01:02:11 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20120212010211.GN23916@ZenIV.linux.org.uk>
References: <1329006070-4275-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1329006070-4275-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] your mail
To: Richard Weinberger <richard@nod.at>
Cc: alan@lxorguk.ukuu.org.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org

On Sun, Feb 12, 2012 at 01:21:10AM +0100, Richard Weinberger wrote:

Not a full review by any means, but...

> +++ b/arch/um/drivers/line.c
> @@ -19,19 +19,29 @@ static irqreturn_t line_interrupt(int irq, void *data)
>  {
>  	struct chan *chan = data;
>  	struct line *line = chan->line;
> +	struct tty_struct *tty;
> +
> +	if (line) {
> +		tty = tty_port_tty_get(&line->port);
> +		chan_interrupt(&line->chan_list, &line->task, tty, irq);
> +		tty_kref_put(tty);
> +	}
>  
> -	if (line)
> -		chan_interrupt(&line->chan_list, &line->task, line->tty, irq);
>  	return IRQ_HANDLED;
>  }

Is tty_kref_put() safe in interrupt?  Here it seems to be OK, but in other
callers...  More or less at random: drivers/tty/serial/lantiq.c has it
called from lqasc_rx_int().  It seems to be possible to have it end up
calling ->ops->shutdown() and in this case that'd be lqasc_shutdown().
Which does a bunch of free_irq(), including the ->rx_irq, i.e. the one
we have it called from.  Alan?

> @@ -495,13 +413,6 @@ static int setup_one_line(struct line *lines, int n, char *init, int init_prio,
>  	struct line *line = &lines[n];
>  	int err = -EINVAL;
>  
> -	spin_lock(&line->count_lock);
> -
> -	if (line->count) {
> -		*error_out = "Device is already open";
> -		goto out;
> -	}

... and similar in line_open() - just what happens if you try to reconfigure
an opened one?

> @@ -612,13 +523,15 @@ int line_get_config(char *name, struct line *lines, unsigned int num, char *str,
>  
>  	line = &lines[dev];
>  
> -	spin_lock(&line->count_lock);
> +	tty = tty_port_tty_get(&line->port);
> +
>  	if (!line->valid)
>  		CONFIG_CHUNK(str, size, n, "none", 1);
> -	else if (line->tty == NULL)
> +	else if (tty == NULL)
>  		CONFIG_CHUNK(str, size, n, line->init_str, 1);
>  	else n = chan_config_string(&line->chan_list, str, size, error_out);
> -	spin_unlock(&line->count_lock);
> +
> +	tty_kref_put(tty);

again, where's the exclusion with config changes?

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

