Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9she-0002j7-TZ
 for linux-um@lists.infradead.org; Mon, 16 Sep 2019 15:14:12 +0000
Subject: Re: [PATCH] um: export uml_reserved
References: <1568639174-I89491153563c5836b17475c319aeeb3582a7b5e3@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <30ad0c09-3f44-9eff-3517-e55adab9ceb9@kot-begemot.co.uk>
Date: Mon, 16 Sep 2019 16:14:03 +0100
MIME-Version: 1.0
In-Reply-To: <1568639174-I89491153563c5836b17475c319aeeb3582a7b5e3@changeid>
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



On 16/09/2019 14:06, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> We need this symbol now, in case the virtio_uml driver
> is a module, as it needs to know how much memory was
> reserved to not advertise that to the device.
> 
> Fixes: 5d38f324993f ("um: drivers: Add virtio vhost-user driver")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/kernel/um_arch.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index 0f40eccbd759..474790b146c3 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -102,6 +102,7 @@ unsigned long uml_physmem;
>   EXPORT_SYMBOL(uml_physmem);
>   
>   unsigned long uml_reserved; /* Also modified in mem_init */
> +EXPORT_SYMBOL(uml_reserved);
>   unsigned long start_vm;
>   unsigned long end_vm;
>   
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.co.uk>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

