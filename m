Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B80CC3ABAA
	for <linux-um@archiver.kernel.org>; Sat,  3 May 2025 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A7Ap2VhX/ucg4SF9W1N+FhUL6KqMbTI9KyMCodLtPiM=; b=iD5AjPwClP2l/8spnJCJeUuWnf
	iXw4bdeA/P5UNvWaQ5ZjqYltUS87yqilm/gile5XjaOzlgCf/eifX6+iWST5H6dKhR0g/kAIwI+3A
	1Csm55DXUlIytPr7ofGkr272SQPMHHXaRR/xfD9gTBTAIufFvh+Mep7I0HM9WGlZeS1qQsiJzutGt
	2CLrXiS7j8PSS0FpivdoGnCyRpZZqrdzFLZRHP8I45L9ozd8jXadJpombhHgkYw9cIr9DrXI7+6tQ
	Q7GtO7oiQIWxa4GSyQ8bImt1D6DOC0RNSouuBoDR3StZz5l4q985fDN+02ckNuCPLBfdyDI+qEUkd
	zfKZhz/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBCso-00000003uxm-3Jqt;
	Sat, 03 May 2025 13:26:22 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBCsl-00000003uwa-3u0M
	for linux-um@lists.infradead.org;
	Sat, 03 May 2025 13:26:21 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1uBCsh-00AMsm-Fz; Sat, 03 May 2025 13:26:15 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1uBCsd-003S6F-1x;
	Sat, 03 May 2025 14:26:15 +0100
Message-ID: <90153f08-e77b-43cb-ac14-9d7877430fb5@cambridgegreys.com>
Date: Sat, 3 May 2025 14:26:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] um: vector: Eliminate the dependency on uml_net
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at,
 johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org
References: <20250503051710.3286595-1-tiwei.btw@antgroup.com>
 <20250503051710.3286595-3-tiwei.btw@antgroup.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20250503051710.3286595-3-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250503_062619_975575_E0E3204A 
X-CRM114-Status: GOOD (  22.30  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 03/05/2025 06:17, Tiwei Bie wrote:
> The only dependency on uml_net (i.e., the legacy network transport
> infrastructure) is the call to uml_net_setup_etheraddr(). Implement
> it inside vector to eliminate the uml_net dependency completely. It
> will allow us to remove uml_net in the next step.
> 
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
>   arch/um/drivers/Kconfig       |  1 -
>   arch/um/drivers/vector_kern.c | 52 +++++++++++++++++++++++++++++++++--
>   2 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 5bf4f0f3fd01..2067e37d6b63 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -145,7 +145,6 @@ config UML_NET
>   
>   config UML_NET_VECTOR
>   	bool "Vector I/O high performance network devices"
> -	depends on UML_NET
>   	select MAY_HAVE_RUNTIME_DEPS
>   	help
>   	  This User-Mode Linux network driver uses multi-message send
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index b97bb52dd562..0d5c96897fa0 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -27,7 +27,6 @@
>   #include <init.h>
>   #include <irq_kern.h>
>   #include <irq_user.h>
> -#include <net_kern.h>
>   #include <os.h>
>   #include "mconsole_kern.h"
>   #include "vector_user.h"
> @@ -1539,7 +1538,56 @@ static void vector_timer_expire(struct timer_list *t)
>   	napi_schedule(&vp->napi);
>   }
>   
> +static void vector_setup_etheraddr(struct net_device *dev, char *str)
> +{
> +	u8 addr[ETH_ALEN];
> +	char *end;
> +	int i;
>   
> +	if (str == NULL)
> +		goto random;
> +
> +	for (i = 0; i < 6; i++) {
> +		addr[i] = simple_strtoul(str, &end, 16);
> +		if ((end == str) ||
> +		   ((*end != ':') && (*end != ',') && (*end != '\0'))) {
> +			printk(KERN_ERR
> +			       "setup_etheraddr: failed to parse '%s' "
> +			       "as an ethernet address\n", str);
> +			goto random;
> +		}
> +		str = end + 1;
> +	}
> +	if (is_multicast_ether_addr(addr)) {
> +		printk(KERN_ERR
> +		       "Attempt to assign a multicast ethernet address to a "
> +		       "device disallowed\n");
> +		goto random;
> +	}
> +	if (!is_valid_ether_addr(addr)) {
> +		printk(KERN_ERR
> +		       "Attempt to assign an invalid ethernet address to a "
> +		       "device disallowed\n");
> +		goto random;
> +	}
> +	if (!is_local_ether_addr(addr)) {
> +		printk(KERN_WARNING
> +		       "Warning: Assigning a globally valid ethernet "
> +		       "address to a device\n");
> +		printk(KERN_WARNING "You should set the 2nd rightmost bit in "
> +		       "the first byte of the MAC,\n");
> +		printk(KERN_WARNING "i.e. %02x:%02x:%02x:%02x:%02x:%02x\n",
> +		       addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4],
> +		       addr[5]);
> +	}
> +	eth_hw_addr_set(dev, addr);
> +	return;
> +
> +random:
> +	printk(KERN_INFO
> +	       "Choosing a random ethernet address for device %s\n", dev->name);
> +	eth_hw_addr_random(dev);
> +}
>   
>   static void vector_eth_configure(
>   		int n,
> @@ -1574,7 +1622,7 @@ static void vector_eth_configure(
>   	 * and fail.
>   	 */
>   	snprintf(dev->name, sizeof(dev->name), "vec%d", n);
> -	uml_net_setup_etheraddr(dev, uml_vector_fetch_arg(def, "mac"));
> +	vector_setup_etheraddr(dev, uml_vector_fetch_arg(def, "mac"));
>   	vp = netdev_priv(dev);
>   
>   	/* sysfs register */


Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

I think it is time - it has been marked obsolete for 5 years.
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

