Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D47C25B41
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 15:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XtvZqlIXFejj2ndHelf+pV8scyjQPeGhwSIccXAQiRg=; b=2catgXIAbHchbF
	Obh329JJYDb/cFrpUfGoXBw9fqvov7RUkecarTgMhypGHpIJf1Qwqd3Y+bmAkA18JpmMPbHooS0Tn
	ErORQiPvzmE0jJsTBkBqS3TGr8qTTD4qHiC6Xm0PQRB0q+d4naAEQxrSSurKMBlM3Xzs7Qfpgnmiu
	+F6uwx/mmeujqOYbty0Gh+5hoGFb2MdhcPyUsHvpzPoTtslZvGgXXbQ9rRhCITPdtUIRNgEjBtGV6
	3HVhM0q/JnjedKYGvRHj/eFygZNrEfTStL06TbZpf+FjkdfTXBIMUif716rl+Csgsww2na1+wf+ap
	iBr56aVmnp1AyTlEHfnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrmw-002e4a-0w;
	Fri, 20 Oct 2023 15:51:50 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrmt-002e47-1f
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 15:51:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rJbtokV/wQqbzA0Ioab2X1QBzJNYhrSRrDYx6HRvFuk=;
	t=1697817106; x=1699026706; b=Q0GxtvM1ENvdUEV4pfBrV0ljPyWtn3f5TStflUXxNMGJrUk
	jAvFd+FDyqo+H4WWQRU/jFjFUWgMxn07vOZrp4nZrm9rVJDOUd1toCbJaD3XmCmsBPzlUj3NL9rRz
	TYLeNFS6RbW7CRBdm3eKbs9/L/PsxIfh58S7h88zz1f+XzQZ9vqiUfmrM7Z6kZrYL9O73xfe6v2R0
	KxmYBOkA9uqSwq6ZEl2FeGBdTtwA85OvJIyBp2vGBN2aJrVKYYzuDfjpqo/Nzqxe08tVLGdR6Uwte
	dOptr4+HSIy18JYTNNMC5OAwhbejQet5mD6IArEabjpe/ny1p7sOhuWQIg9guDqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qtrmq-0000000EcYp-0sem;
	Fri, 20 Oct 2023 17:51:44 +0200
Message-ID: <6622572d97b970bc83ac628a8b6c93f91f0bdf2e.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, 
	linux-um@lists.infradead.org
Date: Fri, 20 Oct 2023 17:51:43 +0200
In-Reply-To: <fe6dc227-44f4-466e-a99b-e5e9e6afe7aa@uni-rostock.de>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
	 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
	 <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
	 <549de9c0-05f8-437e-8460-5b013b0cd87b@uni-rostock.de>
	 <348de3de5cbd6df96ac51bb07d6e485b2ecc5cc8.camel@sipsolutions.net>
	 <d77b66af-249d-4dd1-b78f-730d252bcf84@uni-rostock.de>
	 <10c4e61c2e62ba12cf88ddecd84271c5788c1e6b.camel@sipsolutions.net>
	 <93c958e1-a0ed-4787-adad-12c6f96c9999@uni-rostock.de>
	 <2315dd8321a86c52e2c7226889568068ffafe9a7.camel@sipsolutions.net>
	 <fe6dc227-44f4-466e-a99b-e5e9e6afe7aa@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_085147_846987_334A69F1 
X-CRM114-Status: GOOD (  15.39  )
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

On Fri, 2023-10-20 at 17:47 +0200, Benjamin Beichler wrote:
> 
> I think, I get now, why I don't have this Problem: My virtio simulation 
> and my controller/simulation-master are tightly coupled and indeed the 
> same process. When I create a new event for the UML-instance, it is 
> anticipated in the simulation master.
> 
> So my sequence is more like:
> B sends message to A's stdin (say at 1000)
> B tells the controller, that it activated A, and time should not advance 
> until A has sent a request for processing an interrupt and has gone back 
> to waiting state
> B requests to run at 2000 from controller
> B releases time to controller
> ...

Ahh, OK. I thought you were probably using our controller from the
usfstl, but of course you don't have to. I think I did push the shared
memory optimisation there though, but I suspect I haven't posted the
Linux client version.

> I see that without further information from the device simulation to the 
> controller, it is quite harder.

Right, I wanted to handle that in the other side (hence the ACK) since
you might not always know _when_ the interrupt is scheduled there, even
if it's currently always "immediately".

> Nonetheless, I'm not totally sure, how this interacts with the timing 
> semantics of the interrupts here. Either the solution of Benjamin Berg 
> or mine (with the trivial tt-handler have the same problem).

Oh, yeah, his changes do have the same problem. He's just fixing that
interrupts got lost completely in some already _otherwise_ broken cases,
to make it work better without hanging, not to make it work correctly.

To make it work correctly you shouldn't use stdio at all, or I guess
have some external helper thing like you do :)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
