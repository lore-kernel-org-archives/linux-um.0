Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976A8CDB474
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CL8PAGLih1fC3vzCdD/EXxOLMqnvxf0bJlMNkZ5627w=; b=2m6S9+XOi1vZFwKbpGURVh/t9B
	+KKACboF0CqSCrmPfPkm6Z8/KzmVeIZg/U8dbB6hxKj7J6zDL2pIKjejK48aYf0sJKTe6KfP4iIJR
	WHwRgjZowfqxHKOOyKQGrU9JXc8S5wvmcM0ALmADGsDNJoznw9y1jL0AYDp1CY7FZTSeo+ayW8KNt
	2CjLIFUEyVCkplhKp7g9voLetnk7ZMOLLksSJASIvJKFg9yvmsA469N7eUbhAV13PqtNX6/l8sJpn
	E5t3VV6iNMK6EDIHKcs1qTzax+unFBdzZ60gIVwveCTRWrGybGLWAkMqFQl4aHhL7ZIBpT2PTWgak
	HqMknGjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrjT-002djz-1L;
	Fri, 20 Oct 2023 15:48:15 +0000
Received: from mx2.uni-rostock.de ([139.30.22.72])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrjN-002diA-1V
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 15:48:14 +0000
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 20 Oct 2023 15:48:00 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1697816880; bh=eGT9HMdgZvXhFsUZJnPqRlmN1CBn1feZxM2qRbv2mC8=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 N6mD8xONRYGnnnIMSztPAIWsQcf/sP5RdgkKrkJIV5Cp+UuiVtNNRAEQtVfMwYb64opUGeHMNX+BN8RMd6xNBA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1697816880; bh=eGT9HMdgZvXhFsUZJnPqRlmN1CBn1feZxM2qRbv2mC8=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 B2v8jGbYz89tatnXEkwonU48Tm6nxTNXZz+FNF5t5QLXuGwc3C8oWUp3iYFNQp1ikghITi8WVvH+1NFr7H5+wQAYU+LF/izcCXluQxBcZQhw4onTKh8RofKS4OsofWJsohcgY1wov4xrPKEOw8MAOp2semKumSgNj2AkySJ/ocg=
Received: from [139.30.201.32] (139.30.201.32) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 20 Oct
 2023 17:47:59 +0200
Message-ID: <fe6dc227-44f4-466e-a99b-e5e9e6afe7aa@uni-rostock.de>
Date: Fri, 20 Oct 2023 17:47:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
Content-Language: de-DE
To: Johannes Berg <johannes@sipsolutions.net>, <linux-um@lists.infradead.org>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
 <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
 <549de9c0-05f8-437e-8460-5b013b0cd87b@uni-rostock.de>
 <348de3de5cbd6df96ac51bb07d6e485b2ecc5cc8.camel@sipsolutions.net>
 <d77b66af-249d-4dd1-b78f-730d252bcf84@uni-rostock.de>
 <10c4e61c2e62ba12cf88ddecd84271c5788c1e6b.camel@sipsolutions.net>
 <93c958e1-a0ed-4787-adad-12c6f96c9999@uni-rostock.de>
 <2315dd8321a86c52e2c7226889568068ffafe9a7.camel@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
In-Reply-To: <2315dd8321a86c52e2c7226889568068ffafe9a7.camel@sipsolutions.net>
X-Originating-IP: [139.30.201.32]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: ACEA82D81815E27523106E33BF8FBAF81C7035D9FBC88024E1D58EED7244C53F2000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_084810_472526_705FFE6E 
X-CRM114-Status: GOOD (  16.06  )
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



>> My mind model is, that simulation time advances in the controller are 
>> only done, If all parts of the simulation reached the current 
>> simulation time and are at the event processed/idle/wait state. 
> Yeah that's a simpler model, and in what we implemented it's true if 
> you do have the ACK messages. If don't have free-until, that's also 
> possibly true, although we might have implementation bugs in a sense 
> with time_travel_add_irq_event() since that looks at the current time. 
> And also, if you request something the controller thinks is already in 
> the past because the other side updated the controller due to 
> free-until, the simulation just crashes. It's also possible that B (in 
> the situation above) actually *does* ask the controller who should run 
> next, and the controller simply doesn't yet know: B sends message to 
> A's stdin (say at 1000) B requests to run at 2000 from controller B 
> releases time to controller controller sets time to 2000 and tells B 
> to run A requests scheduling at 1000 controller *crashes* 

I think, I get now, why I don't have this Problem: My virtio simulation 
and my controller/simulation-master are tightly coupled and indeed the 
same process. When I create a new event for the UML-instance, it is 
anticipated in the simulation master.

So my sequence is more like:
B sends message to A's stdin (say at 1000)
B tells the controller, that it activated A, and time should not advance 
until A has sent a request for processing an interrupt and has gone back 
to waiting state
B requests to run at 2000 from controller
B releases time to controller
...

I see that without further information from the device simulation to the 
controller, it is quite harder.

Nonetheless, I'm not totally sure, how this interacts with the timing 
semantics of the interrupts here. Either the solution of Benjamin Berg 
or mine (with the trivial tt-handler have the same problem).

I will post my patches the next days, you may have a look on them, maybe 
you also experienced some of my problems :-)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
