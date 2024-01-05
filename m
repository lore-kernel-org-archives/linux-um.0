Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E251EC3DA6E
	for <linux-um@archiver.kernel.org>; Fri,  5 Jan 2024 11:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H1Kp4VIgTLQ/oxQc8cpwzAuuciZMbjy+saWp57HYYSY=; b=hx9r0r4EPXF5Ctaf/Q15besW8L
	BmxRLzwldxX4cmetE4kljgMJMuI0lAffdWCrOxyUFSH6k86nbvIGDDlmoZhcRzKkE3QOznwE6hveY
	IgLHtzf5yTjr9GFkjJcVkPQSNfCyDYuhignF8aAnDBJxv3iSy27m44Inypt7+YZtd3SAab4AgGOEU
	MaET62KcuHOpZki727hxdCuJXiG1qXS1T3zRMQj9tLeynVN2iArJ5KQIqVwV1SZWk9aJ4PoTSvC75
	bR87i99NJkiO0ZMS2bMdk+XUND1vwwJXynhsfdMvTh6Fs0IfhujFRyjVQviwAqmj7+bKtxSAPeH8m
	Pnxr+eaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLiix-00Gji3-0u;
	Fri, 05 Jan 2024 11:50:51 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLiiu-00GjdE-08
	for linux-um@lists.infradead.org;
	Fri, 05 Jan 2024 11:50:49 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rLiIU-009MXW-Dv; Fri, 05 Jan 2024 11:23:31 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rLiIN-0024Bu-2P;
	Fri, 05 Jan 2024 11:23:30 +0000
Message-ID: <d5859c6e-e924-4413-bff5-7009acd8718f@cambridgegreys.com>
Date: Fri, 5 Jan 2024 11:23:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: fix return value check in vector_legacy_rx
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Ma Ke <make_ruc2021@163.com>
Cc: richard@nod.at, xiangyang3@huawei.com, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231006122717.3984017-1-make_ruc2021@163.com>
 <CAFLxGvytpwjXM0bdLrxt0itfEBPqJSmuM6otB7dTBmsTaAAPgw@mail.gmail.com>
 <1c098c26132b60ebebc46a39e8b7827a29e3a166.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <1c098c26132b60ebebc46a39e8b7827a29e3a166.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_035048_079186_6AE40FFE 
X-CRM114-Status: GOOD (  15.58  )
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

On 05/01/2024 08:42, Johannes Berg wrote:
> On Thu, 2024-01-04 at 22:05 +0100, Richard Weinberger wrote:
>> On Fri, Oct 6, 2023 at 2:28 PM Ma Ke <make_ruc2021@163.com> wrote:
>>>
>>> In vector_legacy_rx, to avoid an unexpected result returned by
>>> pskb_trim, we should check the return value of pskb_trim().
>>>
>>> Signed-off-by: Ma Ke <make_ruc2021@163.com>
>>> ---
>>>   arch/um/drivers/vector_kern.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
>>> index 131b7cb29576..822a8c0cdcc1 100644
>>> --- a/arch/um/drivers/vector_kern.c
>>> +++ b/arch/um/drivers/vector_kern.c
>>> @@ -890,7 +890,8 @@ static int vector_legacy_rx(struct vector_private *vp)
>>>                                          skb->ip_summed = CHECKSUM_UNNECESSARY;
>>>                                  }
>>>                          }
>>> -                       pskb_trim(skb, pkt_len - vp->rx_header_size);
>>> +                       if (pskb_trim(skb, pkt_len - vp->rx_header_size))
>>> +                               return 0;
>>
>> I think this adds a memory leak. Also, can pskb_trim() really fail in
>> this scenario?
>> The function controls skb creation and knows all lengths.
>>
> We had pretty much the exact same discussion in the other patch ...
> 
> https://patchwork.ozlabs.org/project/linux-um/patch/20231007005104.3994678-1-make_ruc2021@163.com/
> 
> 
> No point arguing with people who care about static checkers only, I
> guess. This person here never even came back to respond to the comments,
> my take is they're throwing patches over the wall they didn't think
> about, just to see what sticks.

CV padding, the 2024 way. Accomplishments: submitted 231 patches to the 
linux kernel.

> 
> johannes
> 
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


