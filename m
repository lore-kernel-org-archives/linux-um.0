Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F526C4167B
	for <linux-um@archiver.kernel.org>; Wed,  6 Dec 2023 07:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=psj6ZRh34CPn0HndGHLNTXabBh2QAhScgqArPlMX/rU=; b=EIzCEsc67l0aHVqV0hyqxJwE/4
	NmGVC7yDeMOe1+au2ZEihO49ox22y7A+ytX3Nca11bDNY8mKHeBfT8IbZwsDXIMe2yBCzc9NesWeL
	viPwTJClMbDdhBUwWDHH6D8wTuSiaUjEWN9gOWrrxaSQ+gJ3APZDSAOu8RkxAeH/EhKdhlODvJBP+
	D/glWJ6F/uYbz921NCB/YPRM6a81dltR7gOsubjJ8kroXv4cbeZ90t776U27QTKbJYk7HKvQkg4uo
	fznLdFccGGJ6eL7zmtycxN2QJ01JjpZAe2vbw7OzFeWxqFykn4a6LVZEVI0VGzx+pQ5u/nHZM0Z8j
	g6UH/dRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAmCU-009Hdw-0E;
	Wed, 06 Dec 2023 07:20:06 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAmCQ-009Hbk-2K
	for linux-um@lists.infradead.org;
	Wed, 06 Dec 2023 07:20:04 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rAmC4-007Lrx-1N; Wed, 06 Dec 2023 07:19:40 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rAmBz-002Ek0-0k;
	Wed, 06 Dec 2023 07:19:39 +0000
Message-ID: <62f83e94-27fc-1422-3999-1936e6b28625@cambridgegreys.com>
Date: Wed, 6 Dec 2023 07:19:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] um: net: Fix return type of uml_net_start_xmit()
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>, richard@nod.at,
 johannes@sipsolutions.net
Cc: ndesaulniers@google.com, trix@redhat.com, linux-um@lists.infradead.org,
 llvm@lists.linux.dev, patches@lists.linux.dev,
 kernel test robot <lkp@intel.com>
References: <20231003-um-net-wifpts-v1-1-02888c634ee7@kernel.org>
 <20231205175302.GA536347@dev-arch.thelio-3990X>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20231205175302.GA536347@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_232002_781270_D8D733CE 
X-CRM114-Status: GOOD (  19.86  )
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



On 05/12/2023 17:53, Nathan Chancellor wrote:
> Ping? I would like to turn this warning on for W=1 and the kbuild test
> robot flagged this instance. If the UML folks don't want to carry it,
> could I get an ack so that it could go with the warning enablement in
> the kbuild tree?
> 
> https://lore.kernel.org/20231002-enable-wincompatible-function-pointer-types-strict-w-1-v1-1-808ab955d42d@kernel.org/
> 
> On Tue, Oct 03, 2023 at 11:35:53AM -0700, Nathan Chancellor wrote:
>> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
>> indirect call targets are validated against the expected function
>> pointer prototype to make sure the call target is valid to help mitigate
>> ROP attacks. If they are not identical, there is a failure at run time,
>> which manifests as either a kernel panic or thread getting killed. A
>> warning in clang aims to catch these at compile time, which reveals:
>>
>>    arch/um/drivers/net_kern.c:353:21: warning: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Wincompatible-function-pointer-types-strict]
>>      353 |         .ndo_start_xmit         = uml_net_start_xmit,
>>          |                                   ^~~~~~~~~~~~~~~~~~
>>    1 warning generated.
>>
>> ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
>> 'netdev_tx_t', not 'int'. Adjust the return type of uml_net_start_xmit()
>> to match the prototype's to resolve the warning. While UML does not
>> currently implement support for kCFI, it could in the future, which
>> means this warning becomes a fatal CFI failure at run time.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202310031340.v1vPh207-lkp@intel.com/
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>> ---
>>   arch/um/drivers/net_kern.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
>> index 3d7836c46507..cabcc501b448 100644
>> --- a/arch/um/drivers/net_kern.c
>> +++ b/arch/um/drivers/net_kern.c
>> @@ -204,7 +204,7 @@ static int uml_net_close(struct net_device *dev)
>>   	return 0;
>>   }
>>   
>> -static int uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
>> +static netdev_tx_t uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>   {
>>   	struct uml_net_private *lp = netdev_priv(dev);
>>   	unsigned long flags;
>>
>> ---
>> base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
>> change-id: 20231003-um-net-wifpts-14a7429c7524
>>
>> Best regards,
>> -- 
>> Nathan Chancellor <nathan@kernel.org>
>>
> 
> 

Looks ok to me.
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

