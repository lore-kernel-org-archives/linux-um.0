Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4B2C4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5CZl9QV4/b2+9vzk2rNaRR4RuuB8R2JAMBCW8lQS+98=; b=Cq/FnKcCuuUzBU
	79wkIWfmkBjuAIj3qb8z70pZmdTH227ZmqwR/FoFLxEWVz+x1EpacPue4FqYuLnFnqX0kKibtUqM6
	4DLqrj6ufgEAWcXjV3wcg+ekRU9Q3LgB1ksGdAgjFLpA5Q76EIiqoHx48YoUN3ly0BxbXNb4QvcZD
	Keab03PqRtwQzx/5M7uzRel+vUzLz4kdP3favKJFgcgG0McQvseO9GScHhYPnkARGGObH5Fs8URbv
	n6fDG60yiIw725fsC6VxhH/DcyF/OPdzuVTHoSuPVK/qet2PSEB3/y4psi22AExC2qXfe2g4oeU6d
	HoQlsFG7J4zm5VVhWEtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1UlP-0096QB-2t;
	Fri, 10 Nov 2023 16:53:47 +0000
Received: from mx2.uni-rostock.de ([139.30.22.72])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1UlM-0096Pb-0B
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 16:53:45 +0000
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 10 Nov 2023 16:53:40 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699635220; bh=iLJIeqR8pd/RG59qLPayhDm3T0SPgeFAbdNBoH8IkA4=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 Sc79Pli5ZJMQuGbyPgmEuAcir5eUVi9ftZTwuL+Jyb5yospOmRZfkwEtz4iVkGsydjRHzeKaocnySpA1LuatCg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699635220; bh=iLJIeqR8pd/RG59qLPayhDm3T0SPgeFAbdNBoH8IkA4=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 ix6WaM+ATXbk4zqAXXohEExhZuG4lXGRp/ylQ3Auiv/6xiU216R88vy6iOrQeDaKIWiAdRFYubJxKXlLEA311FsQPzpaurf59TIF/9oYuGL+HF1hrv/N66wl2HPddl64VlVC/EUygUTjzecqdd1QpcMCYU9Q5PrATu4m0c/1jG0=
Received: from [139.30.201.32] (139.30.201.32) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 17:53:39 +0100
Message-ID: <15d63c81-9e41-4965-b988-c4a934aecc52@uni-rostock.de>
Date: Fri, 10 Nov 2023 17:53:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/11] um: Use a simple time travel handler for line
 interrupts
Content-Language: de-DE
To: Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger
	<richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC: <linux-um@lists.infradead.org>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
 <20231103-bb-timetravel-patches-v1-3-e2c68efcf664@uni-rostock.de>
 <71657ebd4a582b1a3c876de4d778ff67bd29c49d.camel@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
In-Reply-To: <71657ebd4a582b1a3c876de4d778ff67bd29c49d.camel@sipsolutions.net>
X-Originating-IP: [139.30.201.32]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 2DC8D564BAA42FE004C2B2BD53E042ADE0DD923A4CE21B83193C70400D7BA21E2000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_085344_392737_0A97D5CA 
X-CRM114-Status: GOOD (  16.26  )
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

Am 06.11.2023 um 21:26 schrieb Johannes Berg:
> ________________________________
>
> On Fri, 2023-11-03 at 16:41 +0000, Benjamin Beichler wrote:
>> This change permits interrupts on serial lines in time travel mode,
>> especially in external mode. However, these interrupts are processed
>> with the simple handler that does not provide any acknowledgment.
>>
> Yeah... we had this discussion in the other thread.
>
> At least in my mental model this is broken because the sender of the
> event basically has to prepare the calendar for it happening, which
> feels ... odd.
Actually, for me, this would make kind of sense. Why couldn't we be more 
explicit in the time travel protocol to the calendar about interrupts?
We could use the ID from the start-msg to identify um instances and 
tell, in an additional msg, that we are going to trigger an interrupt at 
the current time to that instance from the device simulation.
Another way would be, to serve such information (if the device 
simulation really need it) over the facilities we already established. 
Why not send the ACK as MSG_OOB or ancillary data?
>
> But I can see where you're coming from, and switching to virtio console
> that does it all right might be tricky, so ... perhaps this still makes
> some sense.
>
> I'd still think we should put a warning into the code somewhere when you
> actually use line interrupts though?
>
> johannes
>
Benjamin


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
