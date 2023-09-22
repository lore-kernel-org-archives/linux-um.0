Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E79CD4F49
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 10:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PW5JG1C5tLU46svXFbBsI9Nr1zmklSqjSK7McorDxBE=; b=1e4SgqFf4Mf1Zr
	afumtB3thZsf9/VQ2GLTVS9vhnWSjV8uY/t74yMmJN9rPbtJNa4Qth8DCRk2YKOPMImDH7392KmUQ
	9ZIGI4UAfR4H3G4gagXfYSZMfpYRAHCUe4Yx5AZdbAKzTTvtT85TVO687V0akLg6fHgDOcPKXNErQ
	4aBA9qSf9YlA9qgDuPPLfL440Cihn6WNHLxy5USgQ8STA6vi7UkwENaeJIabAnwlee/eQWWKLTkFT
	CWjR3yWgSfOzFrjcPyGBGXF4ceTeRFqGVQmChLp0iGNxjmCV5DhLg5HxxO1rAVLtAdrH9uK/TOsPe
	g9E6rVV+VoEFupGj1SXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjdpK-008tve-0O;
	Fri, 22 Sep 2023 10:56:02 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjdpG-008tum-2L
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 10:56:00 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjdp9-002bkY-KG; Fri, 22 Sep 2023 10:55:51 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjdp6-002I9f-Uq; Fri, 22 Sep 2023 11:55:51 +0100
Message-ID: <2e7356cb-07c9-bb62-7f4d-b0e4c7af88cf@cambridgegreys.com>
Date: Fri, 22 Sep 2023 11:55:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5] um: Enable preemption in UML
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
 <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
 <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
 <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
 <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
 <210bd25b2dcd9e4424923f55053086f67e219cc4.camel@sipsolutions.net>
 <40babfb4-ed65-dd0e-23aa-abdfaa9c7149@cambridgegreys.com>
 <efaa802bcd0369665b3dbc10030c9ca88aa2cb30.camel@sipsolutions.net>
 <1ce8c412b0d2bdfa176f1f783281e393da94ff6f.camel@sipsolutions.net>
 <b8769840-1e33-f9bf-7a55-6ea805a1639a@cambridgegreys.com>
 <428dc1a37ab12368e09c555e44b767b8aa042cfd.camel@sipsolutions.net>
 <ebed5822cb23b51208afa6c08187b486f8ed05bf.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <ebed5822cb23b51208afa6c08187b486f8ed05bf.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_035558_784260_CDF3CA48 
X-CRM114-Status: GOOD (  10.66  )
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


On 22/09/2023 10:55, Johannes Berg wrote:
> On Fri, 2023-09-22 at 11:51 +0200, Johannes Berg wrote:
>> On Fri, 2023-09-22 at 10:19 +0100, Anton Ivanov wrote:
>>>> So maybe that works - perhaps with a big comment?
>>> Ack. Will add this to the patch and run it through its paces.
>>>
>> We can also just get rid of it entirely:
>>
> And then we can remove all the skas0 stuff, including init_thread_regs
> and all.
>
> Seems the cost would be basically that we now pagefault everything
> that's used between fork() and exec()? But is that so much and so
> important?

Needs testing :)

Let's get the PREEMPT out of the door first.

>
> johannes
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
