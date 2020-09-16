Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIRtk-0008GI-Cl
 for linux-um@lists.infradead.org; Wed, 16 Sep 2020 07:30:37 +0000
Subject: Re: [PATCH v2 1/2] um: time-travel: fix IRQ handling in
 time_travel_handle_message()
References: <20200910093113.90307-1-johannes@sipsolutions.net>
 <20200910113049.6de850314f17.Ic74385f3d36466cc01cc8487fc54affe0fdf7f26@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <3e6aa1d9-4c36-f034-51ec-75b1bf715c0d@kot-begemot.co.uk>
Date: Wed, 16 Sep 2020 08:30:33 +0100
MIME-Version: 1.0
In-Reply-To: <20200910113049.6de850314f17.Ic74385f3d36466cc01cc8487fc54affe0fdf7f26@changeid>
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



On 10/09/2020 10:31, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> As the comment here indicates, we need to do the polling in the
> idle loop without blocking interrupts, since interrupts can be
> vhost-user messages that we must process even while in our idle
> loop.
> 
> I don't know why I explained one thing and implemented another,
> but we have indeed observed random hangs due to this, depending
> on the timing of the messages.
> 
> Fixes: 88ce64249233 ("um: Implement time-travel=ext")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/kernel/time.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
> index 25eaa6a0c658..c07436e89e59 100644
> --- a/arch/um/kernel/time.c
> +++ b/arch/um/kernel/time.c
> @@ -70,13 +70,17 @@ static void time_travel_handle_message(struct um_timetravel_msg *msg,
>   	 * read of the message and write of the ACK.
>   	 */
>   	if (mode != TTMH_READ) {
> +		bool disabled = irqs_disabled();
> +
> +		BUG_ON(mode == TTMH_IDLE && !disabled);
> +
> +		if (disabled)
> +			local_irq_enable();
>   		while (os_poll(1, &time_travel_ext_fd) != 0) {
> -			if (mode == TTMH_IDLE) {
> -				BUG_ON(!irqs_disabled());
> -				local_irq_enable();
> -				local_irq_disable();
> -			}
> +			/* nothing */
>   		}
> +		if (disabled)
> +			local_irq_disable();
>   	}
>   
>   	ret = os_read_file(time_travel_ext_fd, msg, sizeof(*msg));
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

