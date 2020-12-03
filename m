Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkms0-000403-TR
 for linux-um@lists.infradead.org; Thu, 03 Dec 2020 11:33:57 +0000
Subject: Re: [PATCH v7 2/5] um: time: fix read_persistent_clock64() in
 time-travel
References: <20201202195808.244645-1-johannes@sipsolutions.net>
 <20201202205659.03331ec9616f.I3f5effe88fe040ff9262de115dd71bfd65d2b0a2@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <3eb4a611-07ec-d885-2b1e-1547710810cc@kot-begemot.co.uk>
Date: Thu, 3 Dec 2020 11:33:51 +0000
MIME-Version: 1.0
In-Reply-To: <20201202205659.03331ec9616f.I3f5effe88fe040ff9262de115dd71bfd65d2b0a2@changeid>
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



On 02/12/2020 19:58, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> In time-travel mode, we've relied on read_persistent_clock64()
> being called only once at system startup, but this is both the
> right thing to call from the pseudo-RTC, and also gets called
> by the timekeeping core during suspend/resume.
> 
> Thus, fix this to always fall make use of the time_travel_time
> in any time-travel mode, initializing time_travel_start at boot
> to the right value depending on the time-travel mode.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/kernel/time.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
> index 8e8eb8ba04a4..80d33735cfd2 100644
> --- a/arch/um/kernel/time.c
> +++ b/arch/um/kernel/time.c
> @@ -676,10 +676,8 @@ void read_persistent_clock64(struct timespec64 *ts)
>   {
>   	long long nsecs;
>   
> -	if (time_travel_start_set)
> +	if (time_travel_mode != TT_MODE_OFF)
>   		nsecs = time_travel_start + time_travel_time;
> -	else if (time_travel_mode == TT_MODE_EXTERNAL)
> -		nsecs = time_travel_ext_req(UM_TIMETRAVEL_GET_TOD, -1);
>   	else
>   		nsecs = os_persistent_clock_emulation();
>   
> @@ -689,6 +687,25 @@ void read_persistent_clock64(struct timespec64 *ts)
>   
>   void __init time_init(void)
>   {
> +#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
> +	switch (time_travel_mode) {
> +	case TT_MODE_EXTERNAL:
> +		time_travel_start = time_travel_ext_req(UM_TIMETRAVEL_GET_TOD, -1);
> +		/* controller gave us the *current* time, so adjust by that */
> +		time_travel_ext_get_time();
> +		time_travel_start -= time_travel_time;
> +		break;
> +	case TT_MODE_INFCPU:
> +	case TT_MODE_BASIC:
> +		if (!time_travel_start_set)
> +			time_travel_start = os_persistent_clock_emulation();
> +		break;
> +	case TT_MODE_OFF:
> +		/* we just read the host clock with os_persistent_clock_emulation() */
> +		break;
> +	}
> +#endif
> +
>   	timer_set_signal_handler();
>   	late_time_init = um_timer_setup;
>   }
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

