Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klErJ-0003j0-N2
 for linux-um@lists.infradead.org; Fri, 04 Dec 2020 17:27:06 +0000
Subject: Re: [PATCH] um: line: don't free winch (with IRQ) under spinlock
References: <20201204162243.779ca2ed9a30.I11ed45127847cd6c160f561a3508ba111be82b2d@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <2b196bee-9ac6-6f47-298a-d29d721b04d0@kot-begemot.co.uk>
Date: Fri, 4 Dec 2020 17:26:55 +0000
MIME-Version: 1.0
In-Reply-To: <20201204162243.779ca2ed9a30.I11ed45127847cd6c160f561a3508ba111be82b2d@changeid>
Content-Language: en-US
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>



On 04/12/2020 15:22, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Lockdep correctly complains that one shouldn't call um_free_irq()
> with free_irq() inside under a spinlock since that will attempt
> to acquire a mutex.
> 
> Rearrange the code to keep the list manipulations under the lock
> while moving the actual freeing outside of it, to avoid this.
> 
> In particular, this removes the lockdep complaint at shutdown that
> I was seeing with lockdep enabled.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/drivers/line.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
> index 2d68f58ac54b..1c70a31e7c5b 100644
> --- a/arch/um/drivers/line.c
> +++ b/arch/um/drivers/line.c
> @@ -614,7 +614,6 @@ static void free_winch(struct winch *winch)
>   	winch->fd = -1;
>   	if (fd != -1)
>   		os_close_file(fd);
> -	list_del(&winch->list);
>   	__free_winch(&winch->work);
>   }
>   
> @@ -715,6 +714,8 @@ static void unregister_winch(struct tty_struct *tty)
>   		winch = list_entry(ele, struct winch, list);
>   		wtty = tty_port_tty_get(winch->port);
>   		if (wtty == tty) {
> +			list_del(&winch->list);
> +			spin_unlock(&winch_handler_lock);
>   			free_winch(winch);
>   			break;
>   		}
> @@ -725,14 +726,17 @@ static void unregister_winch(struct tty_struct *tty)
>   
>   static void winch_cleanup(void)
>   {
> -	struct list_head *ele, *next;
>   	struct winch *winch;
>   
>   	spin_lock(&winch_handler_lock);
> +	while ((winch = list_first_entry_or_null(&winch_handlers,
> +						 struct winch, list))) {
> +		list_del(&winch->list);
> +		spin_unlock(&winch_handler_lock);
>   
> -	list_for_each_safe(ele, next, &winch_handlers) {
> -		winch = list_entry(ele, struct winch, list);
>   		free_winch(winch);
> +
> +		spin_lock(&winch_handler_lock);
>   	}
>   
>   	spin_unlock(&winch_handler_lock);
> 

Acked-By: anton.ivanov@cambridgegreys.com

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

