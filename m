Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC44C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 06:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C0k0MVEr+XE77E99y01AzuPfmkQzxHpNDtS6lm5MJtk=; b=JNlcSsYtqxXC3vRF7pMdNYsqVy
	TbbgS5kBCWCY8HaO46wsSlAzTcDxNCKiNQBs+fhHABAkDEje1jVd8eDLu6uugypzf589e75aGfv4w
	4zbQZzROuK5Kbp/NJlUGE7Pd/8Qsjo8gDX/qbot0pHFfYcAu6jvQC9azzMywxK/znpl2PLcVhMn4B
	tOH3BKszUaVoBQy0WRj3An7uK7bQs7W8hrJhVL/Y+5WilGKscLL6HkLoVSmmz8KkbkeG2OAp/2/TC
	Fz5jj0fSIOzupL3r2fEtJkvSWijODJN59HPSUxCcNxJ8Zg2eqtC/iQrHGGopZfOgGKS9Il7KaD3LD
	ojC7v46g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGQn-0000000COwU-3w9P;
	Thu, 04 Jul 2024 06:59:01 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGQk-0000000COw5-3Hk4
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 06:59:00 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPGQj-005c6j-9C; Thu, 04 Jul 2024 06:58:57 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPGQg-0079I9-2H;
	Thu, 04 Jul 2024 07:58:56 +0100
Message-ID: <456e9b12-fd66-4da2-be6c-ad04222da495@kot-begemot.co.uk>
Date: Thu, 4 Jul 2024 07:58:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: register power-off handler
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20240703173839.fcbb538c6686.I3d333f4773cff93c4337c4d128ee0b1b501b3dfa@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20240703173839.fcbb538c6686.I3d333f4773cff93c4337c4d128ee0b1b501b3dfa@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_235858_854832_C16007D2 
X-CRM114-Status: GOOD (  12.34  )
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



On 03/07/2024 16:38, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Otherwise we always get
> 
>   reboot: Power off not available: System halted instead
> 
> which is really quite pointless.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/kernel/reboot.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
> index 25840eee1068..3736bca626ba 100644
> --- a/arch/um/kernel/reboot.c
> +++ b/arch/um/kernel/reboot.c
> @@ -59,3 +59,18 @@ void machine_halt(void)
>   {
>   	machine_power_off();
>   }
> +
> +static int sys_power_off_handler(struct sys_off_data *data)
> +{
> +	machine_power_off();
> +	return 0;
> +}
> +
> +static int register_power_off(void)
> +{
> +	register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> +				 SYS_OFF_PRIO_DEFAULT,
> +				 sys_power_off_handler, NULL);
> +	return 0;
> +}
> +__initcall(register_power_off);

Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

