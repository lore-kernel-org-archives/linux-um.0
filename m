Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F771C001DF
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 12:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qPLBVKV5szRZQfblbehkAFWjEEoKGVlNz8cY/Yey2rg=; b=deDTR6eutCuhVy
	2GqnWgCOh5l2vwMm2eQyJQdt1CzX0vg5ueGu1Q8XUdLliGqxe9/HlPp3haR2yQgdMPaxCFKRr9us/
	L77/amhNVKBSbd+7++/qEl4kAFxCXFiOfvkS0t/H+GG9VS/nHCjVR1wvnvAvAY4kLpRi25IYQy+lR
	qSW+UoQkf8y4TZzy5p5/BJ/Zn1JRNsaWYt1y0xkcKJAUK8sXePmB3DojChhteCDzhMyjwgNOZ2Fsp
	kJIInJyONo9lXaY8JfKSzcd0vUtI3+GkaqLZtLDame1qBuf786p1cHwUDQlXCiZj/sLRI/C+ggz8N
	2xQRbcAt/GzgtJbAlwEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtoXP-002EXk-0E;
	Fri, 20 Oct 2023 12:23:35 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtoXL-002EXL-1i
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 12:23:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4Xq2q+3wth9WPPJR0OY9/QpWJfAEjOGEY33Pg0hD4P8=;
	t=1697804611; x=1699014211; b=Sw9C2ClpJoDm/xoQr6jGO9SK1dk2x1mC+bFdmQus4UgCb23
	LgtU0G2XUh9L31BnkJUzLRTE70VjjRl6bJ33xqmzJ3GHnAfMqHBIiLI+PyoLbyfmaPwZeMdRR1528
	TtlGXq5t/KO/wq+/PRFHOI5xkFSTRC5Y8CD7hTQU9xqpRXHjV+Q/SwiMlyI6vSQesDvL7WNoKXgFm
	0OkCoKtm3J6F0Lpm/Ub7vVPtW6KPo7QQMvz8oEZImZzpCOjZXXRYdqQz3NwV0Ve754cODIf4qAdyB
	Xd5ngrh7owjiq5mjm1SaBaHC/NJkUmcrxS1/nOMTlVYeS2e3nvrpmcUqF/OVEK/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qtoXJ-0000000EXan-36KS;
	Fri, 20 Oct 2023 14:23:29 +0200
Message-ID: <76ebb80dd7fca6ef2ed7108a541d3ea3c764a3d5.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, 
	linux-um@lists.infradead.org
Date: Fri, 20 Oct 2023 14:23:28 +0200
In-Reply-To: <10c4e61c2e62ba12cf88ddecd84271c5788c1e6b.camel@sipsolutions.net>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
	 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
	 <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
	 <549de9c0-05f8-437e-8460-5b013b0cd87b@uni-rostock.de>
	 <348de3de5cbd6df96ac51bb07d6e485b2ecc5cc8.camel@sipsolutions.net>
	 <d77b66af-249d-4dd1-b78f-730d252bcf84@uni-rostock.de>
	 <10c4e61c2e62ba12cf88ddecd84271c5788c1e6b.camel@sipsolutions.net>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_052331_597318_302E28C1 
X-CRM114-Status: UNSURE (   8.80  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 2023-10-20 at 14:20 +0200, Johannes Berg wrote:
> 
> Yes but you need to schedule for the interrupt, and you don't
> necessarily know what 'current time' is at interrupt time.
> 
> So let's say you have "something" that's scheduled to run at times
>  - 1000
>  - 2000
>  - 3000
> 
> and free-until is 10000 or something high.
> 

It can also happen without free-until, then it just depends which one of
the two - they're running in parallel now (linux doing time-travel
interrupt handling and adding the event, the other thing continuing to
schedule and doing the next entry)  - asks the controller first.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
