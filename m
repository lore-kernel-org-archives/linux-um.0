Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 18 Jan 2017 19:03:30 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 1/5] um: port: Move an assignment for the variable "fd"
 in port_wait()
Message-ID: <20170119000330.GA12052@parts.user-mode-linux.org>
References: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
 <4940ae24-c7ae-66ce-4c2a-5283607a5549@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4940ae24-c7ae-66ce-4c2a-5283607a5549@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Anton Ivanov <aivanov@kot-begemot.co.uk>, Dan Williams <dan.j.williams@intel.com>, Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>, Richard Weinberger <richard@nod.at>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Jan 18, 2017 at 10:56:17PM +0100, SF Markus Elfring wrote:
> diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
> index 40ca5cc275e9..b2bbda21c5f3 100644
> --- a/arch/um/drivers/port_kern.c
> +++ b/arch/um/drivers/port_kern.c
> @@ -230,10 +230,10 @@ int port_wait(void *data)
>  
>  	atomic_inc(&port->wait_count);
>  	while (1) {
> -		fd = -ERESTARTSYS;
> -		if (wait_for_completion_interruptible(&port->done))
> +		if (wait_for_completion_interruptible(&port->done)) {
> +			fd = -ERESTARTSYS;
>  			goto out;
> -
> +		}
>  		spin_lock(&port->lock);
>  
>  		conn = list_entry(port->connections.next, struct connection,
> -- 
> 2.11.0
>

The current code is pretty standard kernel coding style.  The inline
    fd = -ERESTARTSYS;
is likely free, or close to it, and I believe that having anything
besides a goto inside the if could make it significantly more
expensive.

				Jeff

-- 
Jeff Dike
AddToIt
978-254-0789 (o)
978-394-8986 (c)

