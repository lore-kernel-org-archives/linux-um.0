Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A947C4332F
	for <linux-um@archiver.kernel.org>; Mon,  6 Nov 2023 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JoHSCF16BTOr+Dt/OV4v0qFV27fk3oi4KC4+/UhFZas=; b=x4Py+HJT3AS6Xc
	Gj4qT640rq9eRGKDUt45AjTmw1aXr+AYgLPVa77sDHZjle9QM10YxBre8YfhZxk1pR79GpHUYabFF
	tlYE2tRzN+JMTpdXrg7vNdgxPLnyUYupARo+CRkhBGo4ud1ZT6xpFTT4hJtaeX7e8a+DPMniFtmbP
	7WUdy/Ro/fZ+wsm0ho4YRp6jNe2Wznu8EOfV1YmeA9yq1wf5xqOmPC2Tq5MTMOiVdMq3xEBjYFayF
	FTgIAia+qaYO5jMwYJjvNiWjTz4diF9psCrRwdiL54oXXQjoILgVjAG5qicwB73p18GUwGpD9ql4J
	bgNeBnRf8mM4cU5+0Ybg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r06BU-00HV2C-0a;
	Mon, 06 Nov 2023 20:26:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06BT-00HV1v-1E
	for linux-um@bombadil.infradead.org;
	Mon, 06 Nov 2023 20:26:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BE5d5CTvbLqnJbo+C8RUFuEtgwl8naYRCkkXXxC/Ji8=; b=KuQD8vZA/4VJtBXyuHL1JVRVBP
	Jlju/DO3bEWMeabkudNuYeuqBA5LZ+9e8sElh5xUhECkRVAEBrMwwvllwDit7kodqFSwfZyu/7PYX
	tim1G0BwTHI9xwgUPV1diYbBWo+p2jubnIa5DQKa1CDqE9sVsT9CesuhcTNpW2o2uhEmh60SAM/E8
	14FlNG9Z4BkXmIEv+lvVIpT06zeYGPGno0TWt8yinQo46rOC+QWRt1iczGQC6cUAL3IdqOLPitHU0
	i8SHWBc2LGulChTZ76B6towPo3NN8QdBM/LLpnR+q6qHeupZvIo2Nf4gdyYaX8BuZBuyIVhjTBwgC
	AT7gvDNw==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06BM-00AmMV-1u
	for linux-um@lists.infradead.org;
	Mon, 06 Nov 2023 20:26:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BE5d5CTvbLqnJbo+C8RUFuEtgwl8naYRCkkXXxC/Ji8=;
	t=1699302408; x=1700512008; b=eBtPY85+X0RyiuFIsbCaHiK0O3hASwpWuUxLZzOmP7LtxKR
	RVQfoOwYFXs7WkzywHHWinUx/H7svEBYcJfw4S0lZDJUj8jIekft1nReMXTk1Yro4e2oop49vO4Ka
	lV/eRu4TFeVKtz7AuuGHlsQVHRV19GONXJ22ZRzrkrShhDthtGLg6siw7d4a5BQ1/lsd1ewQvqdGo
	QQ4d6Ntvugy8OsZzg0pKRgXXXeJ+x/gKhmeN4kGeX3JQyrzgR/syIoSOtXMvMlJYqxVedRuP5AmhI
	ktqb3YYLT4PpnRGfy7yqosi95iY0NuUyPE3xSrb1oNZNyM0y257k8zHZS1EAVvkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r06BL-0000000FsnD-0ADG;
	Mon, 06 Nov 2023 21:26:47 +0100
Message-ID: <71657ebd4a582b1a3c876de4d778ff67bd29c49d.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 03/11] um: Use a simple time travel handler for line
 interrupts
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Mon, 06 Nov 2023 21:26:45 +0100
In-Reply-To: <20231103-bb-timetravel-patches-v1-3-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-3-e2c68efcf664@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_202650_282617_46F0F5D6 
X-CRM114-Status: UNSURE (   9.68  )
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

On Fri, 2023-11-03 at 16:41 +0000, Benjamin Beichler wrote:
> This change permits interrupts on serial lines in time travel mode,
> especially in external mode. However, these interrupts are processed
> with the simple handler that does not provide any acknowledgment.
> 

Yeah... we had this discussion in the other thread.

At least in my mental model this is broken because the sender of the
event basically has to prepare the calendar for it happening, which
feels ... odd.

But I can see where you're coming from, and switching to virtio console
that does it all right might be tricky, so ... perhaps this still makes
some sense.

I'd still think we should put a warning into the code somewhere when you
actually use line interrupts though?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
