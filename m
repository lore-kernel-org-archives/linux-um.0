Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533D7C6FD1C
	for <linux-um@archiver.kernel.org>; Sat, 11 Mar 2023 20:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ehx+GYffu9NYw7XRDnx1ubBM5gLamM7d+38cRvr5Tj4=; b=ttRLc8oE9Fc21z
	xEIb14I7b5nC3E1E4BlwLiT7apjzDuOl1cYouRNiHk+heDDjr1c3PbcBwamS30NsbfV+suRai6C4m
	vqObylM/rcVTtvasWKf0s2QY8JoD4LFoMrV3g5HEoJOd3pNrOKB1shrxX41XU6NQd2GXHQQ1XFIWq
	qjH4gTIqwJSR7Jq1kaevpwrQ1FqYyD2B/wHrm4XBtx3jxOUmjM1njaGaRtW2nruOyj+ZSNqveCcJP
	LKoFpvfVRiKzuObMCOLqmni2UDNF4vXqVJX0ko8G6/883QCIfz76YlYiOFgyXu7uD22W62KjkE3Pv
	8Ra1MV+Md9h+6bV3pxbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pb5qD-001C2J-P3; Sat, 11 Mar 2023 20:29:21 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pb5qA-001C1a-Fu; Sat, 11 Mar 2023 20:29:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=J3DyTIvOV/2SVP81VtW3lO9g8GsGdpbqAk1yKC2K1qc=;
	t=1678566554; x=1679776154; b=Q/xo6imcHiY8vjBGigvtwnmwLdxAZGGPrfKjS3msnK7KgQl
	NN+ctwQibzdVWdZv5iqP4ISst6qq5QflwxgK8l0d6Njn2vkW2OI+atl+VjdzoCMqfpmOWhKLWOmIg
	Oir7xQSJX63IRTXQgW8+PQdCOGV5+Q/ZHu+ddFUY+hmj/UlYi/PlJsdL4mV4ZSM+bFqA9LTzbxWTk
	+OB0guwhkaGthbtICpvuBV45W4KHwSxHzjS6HDjcFHBjPHagnHk3B7ll01ABPgHPv6wtS+5c9q5sw
	zpogi3dTUO+1XklifJ1cRUpevLrmsSHgU44ku9StZId6K2oDhMTwoMGSRTvPFH+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pb5q2-000TLz-1F;
	Sat, 11 Mar 2023 21:29:10 +0100
Date: Sat, 11 Mar 2023 21:29:06 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: David Woodhouse <dwmw2@infradead.org>, mark.rutland@arm.com,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
CC: catalin.marinas@arm.com, dvyukov@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, quic_qiancai@quicinc.com, valentin.schneider@arm.com,
 will@kernel.org, woodylin@google.com
Subject: Re: [PATCH] Reset task stack state in bringup_cpu()
In-Reply-To: <2873ac05521c218c5a7911741e91ed073df26fc2.camel@infradead.org>
References: <2873ac05521c218c5a7911741e91ed073df26fc2.camel@infradead.org>
Message-ID: <11A8071B-D9FC-418A-B0B5-D2AE608F740A@sipsolutions.net>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230311_122918_563189_2961D637 
X-CRM114-Status: UNSURE (   4.58  )
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




>Hm, in the !CONFIG_GENERIC_SMP_IDLE_THREAD case, idle_thread_get() will
>have returned NULL. Won't these then crash?
>
>Admittedly that seems to be *only* for UM, as all other architectures
>with SMP seem to set CONFIG_GENERIC_SMP_IDLE_THREAD.

UM doesn't even have SMP, so maybe CONFIG_GENERIC_SMP_IDLE_THREAD can just be removed?

johannes 
-- 
Sent from my phone. 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
