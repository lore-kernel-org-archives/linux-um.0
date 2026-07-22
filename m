Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526C0C44536
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 21:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gb0X60QU/3MzBnrwoGeITHH0+n+drjfPHbQr9tGlPAI=; b=mHhwki/499op+fE/OJkHbzR0OP
	NvcWSv/hDdlpSQPW6zn9jgElaYuqbvUoO1WuyYIdS47hLVAoSYjATFQaT4cnCz+DLONhSupj7RVC7
	zhxj+LHSNjigjpXVrF5s9sFyIeBMOJVtb5i1mCPowoGrsHZNsCudf5oqtKNposRa3LKxpM63zxTJh
	hnZ/OzPseWeKWFQtIlldU3aUM5/7HMTgUqfPvlpCbuz9EddOyjOhtHcWnA4xQU3hi8oX+SfaYsWVJ
	c7xD/4E3iHwIpGvBxTLHWYZ3LRlKIy3TGRCbNM4oFI8/OIiXfZVXnfEAk1iQ5xm/xEP+PWfisYcbn
	tSZCJP5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeX7-0000000Cofo-1SF2;
	Wed, 22 Jul 2026 21:31:17 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeX3-0000000CofI-3ga3
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 21:31:15 +0000
Received: from 90-154-203-91.ip.btc-net.bg ([90.154.203.91] helo=[192.168.14.189])
	by www.kot-begemot.co.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wmeWr-003CCq-Lu; Wed, 22 Jul 2026 21:31:02 +0000
Message-ID: <7aea68a6-a393-417f-9f99-f915a6ccf2d4@cambridgegreys.com>
Date: Wed, 22 Jul 2026 22:30:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: fix use-after-free in vector_mmsg_rx()
To: Richard Weinberger <richard.weinberger@gmail.com>,
 Michael Bommarito <michael.bommarito@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260622124722.1694157-1-michael.bommarito@gmail.com>
 <CAFLxGvzLku3V1v1aEZU0v6ZhRE0UcUUbkfj1H3vzgtE9LEQZVQ@mail.gmail.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <CAFLxGvzLku3V1v1aEZU0v6ZhRE0UcUUbkfj1H3vzgtE9LEQZVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_143113_916242_262FAB3C 
X-CRM114-Status: GOOD (  19.93  )
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



On 22/07/2026 22:13, Richard Weinberger wrote:
> On Mon, Jun 22, 2026 at 2:47 PM Michael Bommarito
> <michael.bommarito@gmail.com> wrote:
>>
>> When vector_mmsg_rx() discards a packet whose overlay header fails
>> verify_header(), it frees the skb and continues the loop:
>>
>>          if (header_check < 0) {
>>                  dev_kfree_skb_irq(skb);
>>                  vp->estats.rx_encaps_errors++;
>>                  continue;
>>          }
>>
>> The normal and short-packet paths fall through to the bottom of the
>> loop body, which clears the consumed slot and advances the cursors:
>>
>>          (*skbuff_vector) = NULL;
>>          mmsg_vector++;
>>          skbuff_vector++;
>>
>> The verify_header() < 0 path skips that via continue, so the freed skb
>> is left in skbuff_vector[] and the cursors do not advance. The next
>> iteration reads the same slot, gets the freed skb, and frees it again,
>> producing a refcount underflow / use-after-free in the RX path.
>>
>> Discard the slot the same way the other paths do before continuing.
>>
>> Only transports whose verify_header() can return negative are affected:
>> GRE and L2TPv3 do so on a cookie/session-id mismatch (raw/tap do not),
>> so any peer on such a transport can trigger it without authentication.
>>
>> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
>> ---
>> Reproduced on a KASAN + refcount-full UML build: bring up a vec0
>> l2tpv3 device and send frames from the host with the right cookie but a
>> wrong session id. Stock kernel logs repeated "uml_l2tpv3: session
>> mismatch" then a refcount_t underflow / use-after-free in
>> dev_kfree_skb_irq_reason() <- vector_poll() <- vector_mmsg_rx(); with
>> this patch the mismatch is logged and the splat is gone (0 underflow, 0
>> use-after-free). Full dmesg and reproducer available on request.
>>
>>   arch/um/drivers/vector_kern.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
>> index 2cc90055499a5..8a70b3a625537 100644
>> --- a/arch/um/drivers/vector_kern.c
>> +++ b/arch/um/drivers/vector_kern.c
>> @@ -995,6 +995,9 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
>>                                   */
>>                                          dev_kfree_skb_irq(skb);
>>                                          vp->estats.rx_encaps_errors++;
>> +                                       (*skbuff_vector) = NULL;
>> +                                       mmsg_vector++;
>> +                                       skbuff_vector++;
> 
> Anton, please have a look.
> 

I already did with Johannes a while back. Valid bug and can be triggered 
remotely.

I think I acked the patch at the time.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


