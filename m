Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4fgE-00ArAI-23
 for linux-um@lists.infradead.org; Tue, 04 Jan 2022 09:00:31 +0000
Message-ID: <5fdb10e93535d83d208682e2eb5514fa1d5b6240.camel@sipsolutions.net>
Subject: Re: [PATCH 2/4] um: os_set_fd_block: Return old blocking mode
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 04 Jan 2022 10:00:25 +0100
In-Reply-To: <20220101215810.13260-3-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
 <20220101215810.13260-3-richard@nod.at>
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
To: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, anton.ivanov@cambridgegreys.com

On Sat, 2022-01-01 at 22:58 +0100, Richard Weinberger wrote:
> This will be needed when we restore the old mode upon exit.
> The function now returns < 0 in case of an error, 1 if O_NONBLOCK
> was set, 0 otherwise.
> 
> +++ b/arch/um/drivers/chan_user.c
> @@ -257,7 +257,7 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
>  	}
>  
>  	err = os_set_fd_block(*fd_out, 0);
> -	if (err) {
> +	if (err < 0) {
>  		printk(UM_KERN_ERR "winch_tramp: failed to set thread_fd "
>  		       "non-blocking.\n");
>  		goto out_close;

This does 'return err' afterwards, which then changes the logic from 0
to 1, which seems wrong - especially given that it gets passed further
elsewhere as a pid, which seems very questionable in the first place,
but at least 1 would be valid pid unlike 0?

IOW, I think you need

-	return err;
+	return 0;

a couple of lines later.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

