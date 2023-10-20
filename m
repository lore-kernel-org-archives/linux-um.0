Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA81C001DF
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 11:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4r/VBIRK2U8KX+dD2+oME47qqBXc9An6h8m61PUuMHM=; b=teHs8t6JQSsFRX
	l0RMAXQHrPFoZDMxZMI+GDUt5WfLEXd6XG4rkpWgI2H/EM8fI4+yoUcdeSgDXLLU7Ppu/zIThrSCa
	qdYDA4aKz/Ci7qneaNenSbPK6uLX3vSwHsILAm7o6H/1zM8ns9qnUalg5scvUim+FX0EnsFn9/e7o
	YJoEry+oYKnl30w40awCEE4u8wdE6GY/LW6csZtCoONxvDfPF9dGBwbL9pdCl4n0KjQEyD8bx23r6
	/uVccElJq5ZMWS1uts44GvWayJwQuY6z6Ln1rhWPlMmq72/3MsJifAJWIsxULJGDZkQG5zQX7Ea79
	T+hx/+TKeSHgyx+6a28w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtnrD-002AJO-1k;
	Fri, 20 Oct 2023 11:39:59 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtnrB-002AI3-28
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 11:39:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sX8C1D212xnxtza62uHEDjYjswVRewK48O8cTa2fkhI=;
	t=1697801994; x=1699011594; b=aQIFcGRu1e1PT6CMz7qTV1W4Qg72IhTHv9ay9qXSF2rVVsZ
	NiP2DmvEQ3tKR/9BaV+4D2PlIgnaa8b/ryiyOkrEGpfKAsL69J1e3/htNuJc5ByTckir40zMwJuDv
	GgCXT2Fu4u8PjQ2dVUChvlh9fFAfZahMbDSRonuJtcSK+Pjy1BbZG+N14WUQBG6eEPPCjUFzIZKSU
	Nb7InI1ewMyDEjC6WPYiPTdotBjm+ufl93+mzR84AwL4Alba1Wf6yp5jMVYehO/+kbN2SSe0Q4Kj+
	XlOCuyUX2fcXlFJWh0F/u5p5sezBiTvrdE8cz3+coVBImBoaiQyNdZTJY7+Q747Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qtnr6-0000000EWTg-2NK3;
	Fri, 20 Oct 2023 13:39:52 +0200
Message-ID: <348de3de5cbd6df96ac51bb07d6e485b2ecc5cc8.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, 
	linux-um@lists.infradead.org
Date: Fri, 20 Oct 2023 13:39:51 +0200
In-Reply-To: <549de9c0-05f8-437e-8460-5b013b0cd87b@uni-rostock.de>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
	 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
	 <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
	 <549de9c0-05f8-437e-8460-5b013b0cd87b@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_043957_719670_0766A858 
X-CRM114-Status: UNSURE (   9.48  )
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

On Fri, 2023-10-20 at 12:38 +0200, Benjamin Beichler wrote:
> 
> Can you explain, why a time travel handler for stdin may be bad? It 
> sounds like you want to avoid it, but I see no immediate problem.
> 

I need to read the thread, but this one's easy ;-)

The thing is that on such a channel you don't send an ACK when you've
seen that there's something to handle. As a result, the sender will
continue running while you're trying to request a new schedule entry
from the controller. As a result, it may run past your new schedule
entry because it didn't know about it yet (this would likely bring down
the controller and crash the simulation), or the relative order of the
two entries is undefined, in the sense that it depends on the process
scheduling of the host.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
