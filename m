Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C39C6FD1F
	for <linux-um@archiver.kernel.org>; Wed, 20 Mar 2024 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kbWc+d8bmMqVXKu84RWVnSC0b9y0V4x6pf6NpmVNWjo=; b=wLWdixmcvc12xD9udqsICH715f
	0smrNKpclMIyXM6vKhLlbbmvk3XiDpzaa1wmvD301+2C8j5KGu6mbAXRoevdvrmE+rVeWHsi5Qryt
	R4jz6PcQauIGtDH4/k9Lb0z9ALAO9bzs1cONf/YeHMtifFVU7PAiHtxH6kEPa5s/dfOs2oxWh4m8Y
	cuOAJ06NA0qi1v8LEnandsoK84EE+yPjmfbI7BSQzvqh6bVigvu3A2PeJOShhL6LO+5TLKzZVSCVY
	vomNkpdhQM97RwkmA7vogb4i/rd1FWBlvOLc8uu/OZmFLuriQPpdk3J0egISK1VOfHqNqLeSvJs2+
	txF0XjXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmyDF-00000000ACz-1h3z;
	Wed, 20 Mar 2024 15:50:45 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmyDB-00000000ABx-29KZ
	for linux-um@lists.infradead.org;
	Wed, 20 Mar 2024 15:50:43 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rmxe4-00Etue-PG; Wed, 20 Mar 2024 15:14:25 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rmxe0-005Z95-2L;
	Wed, 20 Mar 2024 15:14:24 +0000
Message-ID: <ecfc31c9-e45a-4e5c-8662-add496246678@cambridgegreys.com>
Date: Wed, 20 Mar 2024 15:14:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>,
 Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-um <linux-um@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, petr <petr@tesarici.cz>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
 <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com>
 <8d45f94c-bce1-4327-9573-cec254a4e9c3@huaweicloud.com>
 <1418379493.78340.1710886685735.JavaMail.zimbra@nod.at>
 <6a62f534-463f-45c4-a5ea-2c1021cf45d4@huaweicloud.com>
 <156343757.79841.1710943777684.JavaMail.zimbra@nod.at>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <156343757.79841.1710943777684.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_085041_580834_EB5B6561 
X-CRM114-Status: UNSURE (   9.66  )
X-CRM114-Notice: Please train this message.
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



On 20/03/2024 14:09, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Petr Tesarik" <petrtesarik@huaweicloud.com>
>>> Yes. I'm just way behind my maintainer schedule. :-/
>>
>> Understood. Thank you for your reply.
>>
>> By the way, are you looking for more people to help with the amount of work?
> 
> Yes, help is always welcome!
> Johannes and Anton do already a great job but more maintenance power is always good.
> You could help with reviewing patches, testing stuff, etc. :-)
> It's not that UML itself is a lot of work, it's just that $dayjob is not UML related at all...

Same here.

> 
> Thanks,
> //richard
> 
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

