Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FEFCDB47E
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wC8S6Z7ACku2Dxspa/rktrGB0PDewjM18c1nzPZ6Gkg=; b=vQk2IO8GgmiPj2yNr6f1gvC8Kv
	UhCrte+RuxIriiTKCPvhK+ib3Xiaa2i5oF1AfRuMl940u3rdTTEjiJyX2EDYCmqquxRWpv+MSAckn
	lCXuRB5u8hcqaONJQdxYaztRRMcoPbAniItlhotWwsboEV70cH2lj9SkJNUHKgkbW5idDzdb8YRKQ
	utDTo/Twsmp5OLzj8i7bucNCLdE8r4pRCoEYkigunpgO1EdSxEWFSv2o22Hs5l+8YE0n4Pe9QqzEA
	0jrEsnXyYgCsIZtiZC5MVv+3YbXLNeWR7lGVugx6NdEyZtegWNUdJT66JJsGbuWJJZHnKuxIapu7G
	PkfiR9DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtlmC-001gEM-0K;
	Fri, 20 Oct 2023 09:26:40 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtlm8-001gCh-1S
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 09:26:38 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qtllz-004OnU-23; Fri, 20 Oct 2023 09:26:27 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qtllt-0005AQ-2F;
	Fri, 20 Oct 2023 10:26:26 +0100
Message-ID: <7f172f42-38bf-c2be-15b4-0710f50b372e@kot-begemot.co.uk>
Date: Fri, 20 Oct 2023 10:26:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>,
 linux-um@lists.infradead.org
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_022636_494542_0E5A4D64 
X-CRM114-Status: GOOD (  20.75  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 20/10/2023 10:15, Benjamin Beichler wrote:
> Am 18.10.2023 um 14:36 schrieb benjamin@sipsolutions.net:
>> From: Benjamin Berg <benjamin.berg@intel.com>
>>
>> When in time-travel mode, the eventfd events are read even when signals
>> are blocked as SIGIO still needs to be processed. In this case, the
>> event is cleared on the eventfd but the IRQ still needs to be fired
>> later.
>>
>> We did already ensure that the SIGIO handler is run again. However, the
>> FDs are configured to be level triggered, so that eventfd will not
>> notify again. As such, add some logic to mark the IRQ as pending and
>> process it at the next opportunity.
>>
>> To avoid duplication, reuse the logic used for the suspend/resume case.
>> This does not really change anything except for delaying running the
>> IRQs with timetravel_handler at a slightly later point in time (and
>> possibly running non-timetravel IRQs that shouldn't happen earlier).
>> While at it, move marking as pending into irq_event_handler as that is
>> the more logical place for it to happen.
>>
>> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> 
> I also noticed this problem, but after a discussion with Johannes Berg about this, we come to the conclusion, that all drivers with interrupts need to deal with time travel mode via their own time travel handler. What I actually did, was to write a trivial handler for e.g., the serial line, which simply only call time_travel_add_irq_event(ev).
> 
> I'm not entirely sure, what the right way to do it, although the outcome seems to be the same, as with no time advance the actual simulation time, when the interrupt is handled is the same.

Add an extra registration flag for um_register_irq?


enum um_irq_type {
	IRQ_READ,
	IRQ_WRITE,
	IRQ_HAVE_TT_HANDLER,
	NUM_IRQ_TYPES,
};

Ones that do not register get the default one which advances the time. Ones that do - have it left to them and do with time whatever they need.

> 
> I actually also have some other significant bug fixes on time travel in my tree, but I was too lazy to send them here, are you interested in taking a look at them?
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
