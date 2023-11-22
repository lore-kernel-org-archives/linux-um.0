Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C98C072A2
	for <linux-um@archiver.kernel.org>; Wed, 22 Nov 2023 07:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5NsIcYbCW0V4BOPln/2anSOvEFL11Y8saMOHI2N0OoE=; b=bRacJJWbkR3AVg
	KHZ6krx5PQr6UutYbN3jdVWFHmzFnIJ3lGE11dmuqdXmmiTufaBYf27W99v8tqGggKTfm5z4w7UOo
	/yl3FPlwbyMpEU2ZrtqS0LtqQ1JHdpy8Cf4DHcyyoGdLwxfbv9IR4oGqmkGrzShkGRWme+GMt3V0/
	Gegl4lf0QaUdTnIQ57RinkOzgm5dKblc9RNe9s0CMz1w9f1eL6D0g+0HoWRwLtcyPFysXeUIH3stQ
	EOz5fHpjIDp6IQUdfIJS7BrogSJsterpOLU9zKseQ+xN8YzuRYWF6ixU3G8sNxABb9Oini/sqKhNJ
	XAL0e5hzIPVO2m1choZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5hcb-000uDF-2n;
	Wed, 22 Nov 2023 07:26:05 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5hcZ-000uC5-06
	for linux-um@lists.infradead.org;
	Wed, 22 Nov 2023 07:26:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=a/kbKeCEYGAl3Cpnin1U0qriK39m5Dp28jqz4j6h/qM=;
	t=1700637959; x=1701847559; b=IpgxpIQJaEQ2X2h5Lko1FLFP4HQd+TaDdFPAsdK93saPmn5
	WieSQewt092TNoZHaMgRNgHCsJ6R1CZfI3S2ex0xpA0F2Iz5no6LolB4xvwidGyBKUFuBjOCCZwmg
	uNbmkbCprEJCKdIbNnJFfPUKQKPNbtaNWD36ptZTusRaGBtQfeFRdxWOZSpyQrjJ5HXqFmdzsLulz
	C1/DPSdwfabmV1LYDhD4dW/fcJ2u6qzz7qT5qF5RLsJR5syyz9d7o5MCxw3FFdbkW0PLJcyVzl4hV
	0S9AISDcYOekOLBo+vFwvS5EHWL0Jyqh5YuUP+fGxsCCSgCuPNXmYz4a6rph/tjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r5hcS-0000000HUHW-0f9N;
	Wed, 22 Nov 2023 08:25:56 +0100
Message-ID: <3fa7ec68a0302667f1b73682e4db96f6ba618397.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Use swap() instead of open coding it
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, richard@nod.at
Cc: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Date: Wed, 22 Nov 2023 08:25:54 +0100
In-Reply-To: <20231122032518.53305-1-jiapeng.chong@linux.alibaba.com>
References: <20231122032518.53305-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_232603_361312_99D8DAA5 
X-CRM114-Status: UNSURE (   8.03  )
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

On Wed, 2023-11-22 at 11:25 +0800, Jiapeng Chong wrote:
> Swap is a function interface that provides exchange function. To avoid
> code duplication, we can use swap function.
> 
> ./arch/um/os-Linux/sigio.c:81:28-29: WARNING opportunity for swap().
> 

Hm. There's already a use of swap() here in this file, but I actually
think we should revert that? This is basically userspace code, not
kernel code, so I don't think it should include linux headers, even if
those happen to be "standalone enough" right now to work.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
