Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4389FCD5BD5
	for <linux-um@archiver.kernel.org>; Thu, 28 May 2026 08:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l5DxUYBizlM/QrV/e8m4rm26bum2vadY2wArofLHKGY=; b=PL+MAcSGJYRDxxDfa3/Tq4u6o4
	kQQoFtPSxF7igjhNRyEisCX1d0Imtxz/bIIkH3KPhVlblM14PSGqQiXj75sF0zNlBQjhKT+coafRI
	hmQAWm1RyZG7WzdBtttskSqMqJMqjWZontSgSvHGke9h0PX+GARdoK7bXUAcqlS/0rNnDzpn/D4sg
	mxsrM9Eco+sLq/H6EzWTyMj5A75puKakMuBfIiyiyzlIxLI3b5lfUHHYo06gwZ7WzSa7XMcAtI847
	lhk7mrx132ROT/IakpjpQrZvLYDyIehqk9gItu3Bm8EF3421gH5I+ibO5YDCCWFCMHwYaHGupo0hK
	/rviZjbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSVgc-00000005Kj4-4907;
	Thu, 28 May 2026 08:01:50 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSVgZ-00000005Kfn-02Jo
	for linux-um@lists.infradead.org;
	Thu, 28 May 2026 08:01:49 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wSVCt-000Q6r-AE; Thu, 28 May 2026 07:31:07 +0000
Received: from [192.168.21.56]
	by jain.kot-begemot.co.uk with esmtp (Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wSTiq-00000001bve-0das;
	Thu, 28 May 2026 08:31:06 +0100
Message-ID: <d19f715e-b8c3-4351-a34b-067a3f591c5a@cambridgegreys.com>
Date: Thu, 28 May 2026 08:31:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: avoid NULL queue dereference in legacy RX
 mode
To: Johannes Berg <johannes@sipsolutions.net>,
 Henry Barreto <contato@henrybarreto.dev>, Richard Weinberger <richard@nod.at>
Cc: Tiwei Bie <tiwei.btw@antgroup.com>, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, Henry Barreto <me@henrybarreto.dev>
References: <20260527213524.45903-1-contato@henrybarreto.dev>
 <b72e33e9d651f67ff2236b21fc13c3c78a99cb97.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <b72e33e9d651f67ff2236b21fc13c3c78a99cb97.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_010147_060838_923F5E09 
X-CRM114-Status: GOOD (  10.65  )
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



On 28/05/2026 08:13, Johannes Berg wrote:
> On Wed, 2026-05-27 at 18:35 -0300, Henry Barreto wrote:
>> From: Henry Barreto <me@henrybarreto.dev>
>>
>> Bringing a UML vector netdev up can panic in vector_net_open() with a
>> fault in _raw_spin_lock().
>>
>> vector_net_open() calls vector_reset_stats(), which takes the RX and TX
>> queue locks. However, queue allocation depends on runtime transport
>> options. With tap transport, vector RX/TX queues are not created and the
>> legacy header buffers are used instead. Taking a queue lock then
>> dereferences a NULL queue pointer.
>>
>> Take the queue locks in vector_reset_stats() only when the corresponding
>> queue exists. Also move the RX queue lock in vector_poll() into the
>> VECTOR_RX path, so legacy RX does not touch rx_queue.
>>
>> Fixes: 612a8c8e0b43 ("um: vector: Replace locks guarding queue depth with atomics")
> 
> So ... you're effectively saying that the tap transport has been broken
> since 6.12, released ~1.5 years ago.
> 
> Maybe we should just remove that entirely since nobody complained?
> 
> johannes
> 
> 

More interesting while it was not observed in testing.

The patch is OK otherwise. I will ack it.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


