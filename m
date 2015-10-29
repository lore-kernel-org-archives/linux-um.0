Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1446130255.2757.168.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Thu, 29 Oct 2015 07:50:55 -0700
In-Reply-To: <1446110203-21968-1-git-send-email-saurabh.truth@gmail.com>
References: <saurabh.truth@gmail.com>
	 <1446110203-21968-1-git-send-email-saurabh.truth@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3] um: net: replace GFP_KERNEL with GFP_ATOMIC when
 spinlock is held
To: Saurabh Sengar <saurabh.truth@gmail.com>
Cc: jdike@addtoit.com, richard@nod.at, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 2015-10-29 at 14:46 +0530, Saurabh Sengar wrote:
> replace GFP_KERNEL with GFP_ATOMIC while spinlock is held,
> as code while holding a spinlock should be atomic.
> GFP_KERNEL may sleep and can cause deadlock,
> where as GFP_ATOMIC may fail but certainly avoids deadlock
> 
> Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
> ---
> v3: removed the atomic variable, as per Richard comment

Trivia: You could remove the gfp_mask variables too
	and just use GFP_KERNEL and GFP_ATOMIC directly.

> diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
[]
> @@ -600,20 +600,22 @@ void register_transport(struct transport *new)
>  	void *init;
>  	char *mac = NULL;
>  	int match;
> +	int gfp_mask;
>  
>  	spin_lock(&transports_lock);
>  	BUG_ON(!list_empty(&new->list));
>  	list_add(&new->list, &transports);
>  	spin_unlock(&transports_lock);
>  
> +	gfp_mask = GFP_KERNEL;
>  	list_for_each_safe(ele, next, &eth_cmd_line) {
>  		eth = list_entry(ele, struct eth_init, list);
>  		match = check_transport(new, eth->init, eth->index, &init,
> -					&mac);
> +					&mac, gfp_mask);
>  		if (!match)
>  			continue;
>  		else if (init != NULL) {
> -			eth_configure(eth->index, init, mac, new);
> +			eth_configure(eth->index, init, mac, new, gfp_mask);
>  			kfree(init);
>  		}
>  		list_del(&eth->list);
> @@ -627,14 +629,17 @@ static int eth_setup_common(char *str, int index)
>  	void *init;
>  	char *mac = NULL;
>  	int found = 0;
> +	int gfp_mask;
>  
>  	spin_lock(&transports_lock);
> +	gfp_mask = GFP_ATOMIC;
>  	list_for_each(ele, &transports) {
>  		transport = list_entry(ele, struct transport, list);
> -	        if (!check_transport(transport, str, index, &init, &mac))
> +		if (!check_transport(transport, str, index, &init,
> +							&mac, gfp_mask))
>  			continue;
>  		if (init != NULL) {
> -			eth_configure(index, init, mac, transport);
> +			eth_configure(index, init, mac, transport, gfp_mask);
>  			kfree(init);
>  		}
>  		found = 1;



