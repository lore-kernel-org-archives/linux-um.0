Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABF5CDB474
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 10:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2vGjo3JoLhw6y7BsuQFMhIdG2SlInPKX1G/Jl5WcylY=; b=HMpWqrxZVTMrY4
	0xrZVD/ujh/VPyZbKHm9/JDEk/Dkl+68Pu4nZFhTSeyaVSJrolf4AtYQX6eChHFAsk91KkdvGxn9b
	zIjNTCOjLaXJ/tNDOVCzFlP6/vyQSni2z4tmA7eFxiVlHZ9ws5PFPPrzjj9EUmbqCmQ35Srt9NtkT
	DIHLL2R1xZtehx2PjWhP58vWz5/VAlNbbKi9mPPvtIJgfQ96t424VxKwERXd9IWi9cbKwp/lKP6gM
	kEKyYTUxNGnfSb9VUquLWQ7jA3hLrGRJVoTvM/ymIgKu0LsiGOWUrUEHsYoCJHJH+TpV/6eGHX3uv
	+UdvAmnvXEVDRP3BOL6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtmIU-001j8W-0s;
	Fri, 20 Oct 2023 10:00:02 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtmIQ-001j2z-0o
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 10:00:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2BzWkQf0vpcswzuu7O/1RXEpOPFOgYt+GfCXjeoib74=;
	t=1697795995; x=1699005595; b=dGfCba1eo/DPS7HuQ+ee/Zcl+GKfchKjyhGDfXKLbkuttsQ
	b4MHcSP3p7qTc2ASBrqMi2B5PeVWeO+6ftXm0SZsQFJlNym/uWs6TVceThESjpYGCT7mvNqptNiH5
	vVvn/uxuM3Ih9bhOeuwfO0YJiyaK8DdtrNXHy5M2FpfJo3oNNBNe6KCsQw1AKNmwH1yAYnu6mRwf3
	vP/rg2s8MZ7KETEQS6B14j1pcfPQfCzo02uF3DQyo5UTqsTyDlZXS1xMqBVYuhLT0Pvw+0uGoE0hP
	S31jRAHfEaEQ0vYFx9RNOhYbZqG7ubE3OvvURhuV0ips2qJ5lmeQItGKiILWpTEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1qtmIK-0000000EToU-1K5E;
	Fri, 20 Oct 2023 11:59:52 +0200
Message-ID: <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, 
	linux-um@lists.infradead.org
Date: Fri, 20 Oct 2023 11:59:51 +0200
In-Reply-To: <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
	 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_025958_289495_95E95D1E 
X-CRM114-Status: GOOD (  28.42  )
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

On Fri, 2023-10-20 at 11:15 +0200, Benjamin Beichler wrote:
> Am 18.10.2023 um 14:36 schrieb benjamin@sipsolutions.net:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> > 
> > When in time-travel mode, the eventfd events are read even when signals
> > are blocked as SIGIO still needs to be processed. In this case, the
> > event is cleared on the eventfd but the IRQ still needs to be fired
> > later.
> > 
> > We did already ensure that the SIGIO handler is run again. However, the
> > FDs are configured to be level triggered, so that eventfd will not
> > notify again. As such, add some logic to mark the IRQ as pending and
> > process it at the next opportunity.
> > 
> > To avoid duplication, reuse the logic used for the suspend/resume case.
> > This does not really change anything except for delaying running the
> > IRQs with timetravel_handler at a slightly later point in time (and
> > possibly running non-timetravel IRQs that shouldn't happen earlier).
> > While at it, move marking as pending into irq_event_handler as that is
> > the more logical place for it to happen.
> > 
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> 
> I also noticed this problem, but after a discussion with Johannes Berg 
> about this, we come to the conclusion, that all drivers with interrupts 
> need to deal with time travel mode via their own time travel handler.
> What I actually did, was to write a trivial handler for e.g., the serial 
> line, which simply only call time_travel_add_irq_event(ev).

Yes, we could instead just assert that we do not have any IRQ without a
timetravel handler. We really shouldn't have, but we do have one for
stdin unfortunately (which is at least used by the hostap hwsim tests,
so we might want to not remove it until we have a different solution).

What we could do is just add an stdin timetravel handler as you have
done, but print a warning when the stdin IRQ is registered[1]. And
then, if someone tries to register an IRQ without a time-travel handler
we just panic(), it should never happen.

Benjamin

[1] We'll also need to set stdin to be a "null" channel and then
somehow avoid registering the IRQ in that case.

> I'm not entirely sure, what the right way to do it, although the outcome 
> seems to be the same, as with no time advance the actual simulation 
> time, when the interrupt is handled is the same.
> 
> I actually also have some other significant bug fixes on time travel in 
> my tree, but I was too lazy to send them here, are you interested in 
> taking a look at them?
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
