Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8106CC4332F
	for <linux-um@archiver.kernel.org>; Mon,  6 Nov 2023 20:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OTanzPfuYLxiJ1PI7lbhdfvaAPMsYXoTYdiHgyuqPwY=; b=dFux913W9Gv8uI
	RJH9SlBjeQmpe/VVia3mufuHlB/1nGwCikdV4YTNfWGJssL4NH9CFJmPtXuioht/FYWXAh/u11hL7
	tbSlo/7r9Q/xc8ycdrz9l7ImL/q4onKGUV3/8thfabF1UejX6KQLeWEA5fRFkPduKbKFL3jQjIpQY
	p1OirQ3u0af+EU3NhGNUj7Z6dmfU5EhGkREI9NCjXrqgtVP8Q0NS6PTqftXdBRC2klTeZScI9W4An
	HrOlwBCpSwRu5u5BNbuV8RvVlF1mEny0IPrsAh3Yt/3WAHGHI3DkcONN/J8vISjnmyGylGXhza7rd
	B2wMZ5SeYSeFlmAl3x4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r06bE-00HXqZ-27;
	Mon, 06 Nov 2023 20:53:32 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06bB-00HXq9-1N
	for linux-um@lists.infradead.org;
	Mon, 06 Nov 2023 20:53:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OU7IKfkZbU91/9FTsMXHHr0jq6qDmwk9OlM7HLKA+K8=;
	t=1699304009; x=1700513609; b=VuTQGcGau1FBxCh00kNkTsm+58Tsn5xWfe9JaWsiHiLUVc1
	7hJS+Naryvl5+TNV06Z1dqr5HoGnAaVH37tlBHMtW0N6AEjYbLG4Ay3ho7Hf3OljVALwDzzrQDjFT
	P805HWn3LE3e0iFhGOqRd+MHAPu0/B/E21ZPO3nWvfh5yVxZBgZrR0vfKOAfmbU2kmjQU7aoqEwGF
	1dajJHkaFQZ1O4i0fb+ptCGt9nWg4JtJ12tBmo1/TOQX23+R2a9x37k2v4W2KaaFHZ0HSOrQXBFVb
	GkJXPNZ3Jmy9MFi9uIL8+SAUiZQDU21MDfJueDQSg+/sX1CRkLmNR36Qk4Pdqzmw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r06b9-0000000FtdD-2FDk;
	Mon, 06 Nov 2023 21:53:27 +0100
Message-ID: <81e45374e70c5b57812311c7532bf4024048db84.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 04/11] um: Handle UM_TIMETRAVEL_RUN only in idle
 loop, signal success in ACK
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Mon, 06 Nov 2023 21:53:26 +0100
In-Reply-To: <20231103-bb-timetravel-patches-v1-4-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-4-e2c68efcf664@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_125329_464447_C95A831A 
X-CRM114-Status: GOOD (  23.69  )
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

On Fri, 2023-11-03 at 16:41 +0000, Benjamin Beichler wrote:
> The Timetravel socket can be read from the SIGIO handler, which may
> catch a RUN message that was expected to be received in the wait loop.
> 
> It can happen that the device simulation only "created" one interrupt,
> but an uncertain (i.e., hard to predict by the calendar/device
> simulation) number of SIGIOs are emitted, with each SIGIO interrupt
> producing a GET message. The calendar might try to send a RUN message
> after the first GET message, which is then processed in the SIGIO
> handler, waiting for the response to a subsequent GET message. However,
> time is advanced by the received RUN message. Typically, this doesn't
> pose problems because the interrupt implies that the next RUN message
> should be at the current time (as sent by the calendar with the GET
> message). But there are corner cases, such as simultaneous other
> interrupts, which may desynchronize the current time in the UML instance
> from the expected time from the calendar. Since there is no real use
> case for advancing time in the SIGIO handler with RUN messages (in
> contrast to UPDATE messages), we logically only expect time to advance
> in the idle loop in TT-ext mode. Therefore, with this patch, we restrict
> time changes to the idle loop.
> 
> Additionally, since both the idle loop and the signal/interrupt handlers
> do blocking reads from the TT socket, a deadlock can occur if a RUN
> message intended for the idle loop is received in the SIGIO handler. In
> this situation, the calendar expects the UML instance to run, but it
> actually waits for another message, either in the SIGIO handler (e.g.,
> a second interrupt) or in a poll in the idle loop, as the previous
> message was handled by the signal handler, which returned execution to
> the main loop and ultimately entered the idle loop.
> 
> Therefore, this patch also allows checking whether the current RUN
> message was handled by the idle loop or by the signal/interrupt handlers
> in the ACK of the RUN.
> 
> With the information in the ACK of the RUN message, the calendar knows
> whether the RUN was answered in a signal handler and can act
> accordingly.
> 

This is going to take a bit more review cycles, tbh, still processing it
and probably need to sleep on it :)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
