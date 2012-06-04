Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4FCD1EF9.6000001@suse.cz>
Date: Mon, 04 Jun 2012 22:47:53 +0200
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
References: <1338841657-30358-1-git-send-email-richard@nod.at> <1338841657-30358-6-git-send-email-richard@nod.at>
In-Reply-To: <1338841657-30358-6-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 5/6] um: fully use tty_port
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, alan@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/04/2012 10:27 PM, Richard Weinberger wrote:
> +void line_cleanup(struct tty_struct *tty)
> +{
> +	struct line *line = tty->driver_data;
>  
>  	if (line->sigio) {
>  		unregister_winch(tty);
>  		line->sigio = 0;

r u sure you want to to do this asynchronously? This should be
tty_port_operations->shutdown I suppose...

>  	}
> +}

Anyway, please split the patch into 2 pieces at least:
1) introducing ->install and moving the setup there.
2) switching to tty port helpers
Otherwise it's a hard-to-review mess.

thanks,
-- 
js
suse labs


