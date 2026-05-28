Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040BCCD5BD5
	for <linux-um@archiver.kernel.org>; Thu, 28 May 2026 08:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ySzIAVBkrBsUi6rIrqJMmTK9JRbtofloTdSDPZ/eLk=; b=nVrlYmHFzZGgrDlqR3/sF5B+ev
	zZ+SSw4U2VCRDNvZSRWIGe67C7YFkKTaYNwH2D8huU/sYwZaaccSQXjY1Y1migNjjsIAu3arx3BhY
	nlyAFKmq6hMKQI5uQTr7tBwhq3xIqdzq6siPG+rnGl8akPMw4XNny47A3o49/YAeAE6MnvJ8pkDQ1
	17MqwSdJQR163OZmcupsDImS21JOf7oKkckxfgO7aFczJs/B58PyEKaX6NcQ4v3yijWbHB1YPBGvl
	VUKhAT4k3u40reSgSYm02WoM1d5sIQSX5InKFzcvjYAf22T3eoklsdhXU1/OoInIXIGSS7OAP5Tte
	lSZXIJew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSVg5-00000005KN0-2vbx;
	Thu, 28 May 2026 08:01:17 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSVfn-00000005K8J-2Ekx
	for linux-um@lists.infradead.org;
	Thu, 28 May 2026 08:01:01 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wSVff-000QAQ-Q1; Thu, 28 May 2026 08:00:51 +0000
Received: from [192.168.21.56]
	by jain.kot-begemot.co.uk with esmtp (Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wSUBb-00000001dCj-3laD;
	Thu, 28 May 2026 09:00:51 +0100
Message-ID: <a3be3b6c-3347-4b5b-97fa-2431cfb76623@cambridgegreys.com>
Date: Thu, 28 May 2026 09:00:49 +0100
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
X-CRM114-CacheID: sfid-20260528_010059_603014_BD25DCD4 
X-CRM114-Status: GOOD (  13.37  )
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

The one I use is raw :) It is the most useful.

Tap badly needs someone to expose the socket which the kernel uses to implement it. I started writing a kernel helper at some point, but never finished it. It should be able to produce "stupid speeds" with it.

And, yes indeed, this was broken by 612a8c8e0b43ba7e3d0e51f6f76a5fec4912d439 / 2024-07-05 which by the look of it I did not test for tap.

Nice catch.

> 
> Maybe we should just remove that entirely since nobody complained?
> 
> johannes
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


