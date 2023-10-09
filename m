Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA49E95A91
	for <linux-um@archiver.kernel.org>; Mon,  9 Oct 2023 07:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MCq5fpFaXfOSoIMBgwG4kOj5FJoPjM0JO14Qld0uNks=; b=xPPo6U2MVUr8XW
	xqovnTsDMcwHS0jDShY2g30Bev5HJmGzY/d4+2OEXR1iPna9DE91Na6FZewEuuBlfD6AezGUBbjIF
	ChMtv+kcxzy9nNMUR2pwxhtl96hvTXRbRM10W5cRvUu9meZPQHwYvr/GioMGcArCAq8scd9+hqwAI
	TWlWJTKfFvICLMLzZGoPSpahEQm3WcpwU8Zp0KsefTNKQQmyLiAK6GpTWtbmUElqVFyseeEqQHnIX
	7Ps4gfU80kMqDJB+ptukV8ySUOWlntDanjsaz6FarDYuBLtc946j9Rx2PqetoczgVnheDKaiv7jjk
	ctCxPUlQwHJJNM9qHxSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpkkM-009u4t-0V;
	Mon, 09 Oct 2023 07:32:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpkkJ-009u4Q-0r
	for linux-um@lists.infradead.org;
	Mon, 09 Oct 2023 07:32:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aiMNjsVcGqhrNnfDi/djcbfbRpTfabEPyQg6HFOpBK8=;
	t=1696836718; x=1698046318; b=kqMn4MoMDQKmqJ7ib9nYU1gE50jdBiIe/1oPGCxRLnlB56C
	g8Vaf0lHeZNH09DKDB2L1Gage+S8DM5abGkT67faYcMoAiXWcKl4G3czXbnguKK0FcHMxEIc/Z9EQ
	uYiHzLhWyOm+4k96NU70V41FNx8TbyslXAG32yu7FQvVS4YuYuJjvn6BdiaCl/umZcLZkilXUOvGR
	sSVyLDdp3vhkSohmQUNIzBmh/u6OV4zPcrXq8UXzkRFSo8341LDTcVF+DovgwkkFckpYtgjkSkpzP
	8wq3EbcIlyVSnWagrY7OYo8ytrPF0vfwOeDM/xBg7qu9ana5ikcmSXDOOGbw8nLw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC0)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qpkk6-0000000F6yQ-20cA;
	Mon, 09 Oct 2023 09:31:54 +0200
Message-ID: <ff46c71a7eb6c43c9e06e99d30bdcb1f8152ee7e.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: fix return value check in vector_mmsg_rx
From: Johannes Berg <johannes@sipsolutions.net>
To: Ma Ke <make_ruc2021@163.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, xiangyang3@huawei.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Oct 2023 09:31:53 +0200
In-Reply-To: <20231007005104.3994678-1-make_ruc2021@163.com>
References: <20231007005104.3994678-1-make_ruc2021@163.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_003207_535330_CDF4FEFB 
X-CRM114-Status: UNSURE (   6.46  )
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

On Sat, 2023-10-07 at 08:51 +0800, Ma Ke wrote:
> In vector_mmsg_rx, to avoid an unexpected result returned by
> pskb_trim, we should check the return value of pskb_trim().

And how exactly do you propose pskb_trim() will return anything but 0 in
this scenario?

Please. If you have a static checker, _think_ about it's output before
blindly sending patches.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
