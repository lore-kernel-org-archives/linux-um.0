Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD202C3064D
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 10:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ejnqKEj1NIrA62XRnFFu0iVVLC/5aj+CwJoPEYJFZV8=; b=dgs88IuPulZ0JJFVd/7x9Vk7um
	r8zntQ/PeZk5siKRCz6h7immPzHM+Pw4erREsc7sK6Ayw3LCRyn7Y/4FTe9vVa7zupFuLVrYJ3Ntb
	efjr0APSWaOf8hmcLkoCRDgYEA4cd6DULG3KIBE7D922Lpn0e8rAwfRQrka8GEvrW0DyTFgZ+sS87
	UfdmWLTA4MvLXb4g0JS3ntXulw4yu/pfeIzaMTBQ7JZq5xfw7pHR8s3rBCb+WHI8bZJYe2/iH9yuq
	wfXTDwZAu8KyLy0EiJxZXycWwNGWACqX19HqExEDCCxyRDGXjd2FYZBGNL/fponWrzxxq/qBx1Pps
	h62//VcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOadn-00000006KqL-0CKQ;
	Tue, 02 Jul 2024 10:21:39 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOadi-00000006Kpk-1b7t
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 10:21:37 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sOadf-005UNu-GF
	for linux-um@lists.infradead.org; Tue, 02 Jul 2024 10:21:31 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sOadc-001fiA-2W
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 11:21:31 +0100
Message-ID: <6878d6fb-9d8f-45ce-86c5-95cb291ecc2b@kot-begemot.co.uk>
Date: Tue, 2 Jul 2024 11:21:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] um: Enable preemption in UML
Content-Language: en-US
To: linux-um@lists.infradead.org
References: <20240702102549.d2fcea450854.I12f5a53d80ec1e425e66ef272b1e95cb523b608e@changeid>
 <2c584137-211b-4746-bb6b-ebdec4c486af@cambridgegreys.com>
 <6d4c32b6237f02b6f53ed91bbc7fdfc0b293874a.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <6d4c32b6237f02b6f53ed91bbc7fdfc0b293874a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_032135_857703_403DB0EC 
X-CRM114-Status: GOOD (  12.63  )
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



On 02/07/2024 11:18, Johannes Berg wrote:
> On Tue, 2024-07-02 at 11:07 +0100, Anton Ivanov wrote:
>>
>>
>> Is that all we have left?
> 
> I think so, yes.
> 
>> I lost track of your mm patches and they do not apply cleanly to master at present.
> 
> Mine actually mostly went away, in favour of Benjamin's, but his also
> didn't apply cleanly due to the compiler warning cleanups.

Ack.

> 
>> Otherwise, the fpu-less on top of the older mm works fine for me. Testing it at the moment.
> 
> :-)
> 
> We have 40 patches in patchwork now, including the 7 64-bit address
> space ones from Benjamin where I think some rework is needed. I've
> rebased/applied the other 33, I've just pushed that to the 'pending'
> branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git/log/?h=pending

Cool. It will be nice to see all of it in the tree at last.

> 
> johannes
> 
> 
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

