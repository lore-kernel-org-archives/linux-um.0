Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5326ECD3423
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ncv8uWEvFLrjsrxiy0kbeJvTU6jYqHTFbCTf6/M1fCg=; b=QIcJbCxYf8O3x3
	PcCg91QqI6XIEfWbU+k+DGZX0DZ74tqiHLJmFPxjfjXV6MGLe6rQFekjfWUXT2NcX1lrXx2KejoUk
	6eBBPZsVrb/zLVV0mgeppe4kXs3JIKheKC8QqOHOhCt4+7OqDdwoN1kF/+jxFEMgLHzlcjHEEyWnu
	JPnJBirEyzyThjWrABK5lKiP2tHc/p24yAatEKpakeCsOKB5CLcv9+Bhvw5AjWA6qqSorCD+YIkjt
	eUdUZbThek6cogxZUYUaGfzcUTiVfadPSp1GS3J2Ozg/g2nyX3rxrHrV4PQ71J358sz8FWsxODFIM
	jMgNtanglRgUVwjanWXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiOAj-00GYYB-2T;
	Tue, 19 Sep 2023 00:00:57 +0000
Received: from mail-4022.proton.ch ([185.70.40.22])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiOAg-00GYWw-0X
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 00:00:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1695081647; x=1695340847;
	bh=Lli3Yj6tPCTPu+N9cNfbF8RCVOR8MAz0xLiJXkVxWMI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hlGTyd596DF2dmgY1RxK0nQKhn95J6GICdAnV17WrFbnFOG+MUmgHjlK7mvMUvSEW
	 Ny4WgaiMDNZDqse07BwO8txDjO1zp+XCxYLRYfUVTs73ENUZWdUW3K0uwPYGnlgd/G
	 BO/jK2xmW9w8NhmGRL9T08JW7TZ5A05Hcx9idS+msnB0qobVQ7g2S387X/W2cCyH+s
	 +cfQQ5WzCJy/YxylDrE93+mUvvi8MVrAFAbcB+EdRp/WqkuaiR2cNd0V5FTmvVb5+f
	 If3BANatKOYi35sl2kqXvBNdhpWK8CBBDctN/+jKC4EWv2dLWh3Nt1kHLo9r03mTki
	 KBwkIvgnmCEaw==
Date: Tue, 19 Sep 2023 00:00:34 +0000
To: segher@kernel.crashing.org
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: anton.ivanov@cambridgegreys.com, geert@linux-m68k.org, ink@jurassic.park.msu.ru, jack@suse.cz, johannes@sipsolutions.net, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org, peter@n8pjl.ca, reiserfs-devel@vger.kernel.org, richard.henderson@linaro.org, richard@nod.at, tsbogend@alpha.franken.de
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-ID: <20230919000026.7409-1-peter@n8pjl.ca>
In-Reply-To: <20230918234108.GN19790@gate.crashing.org>
References: <20230918175529.19011-1-peter@n8pjl.ca> <20230918234108.GN19790@gate.crashing.org>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_170055_120009_BFA8F8A1 
X-CRM114-Status: GOOD (  10.76  )
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

On Monday, September 18th, 2023 at 19:41, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> On Mon, Sep 18, 2023 at 05:56:09PM +0000, Peter Lafreniere wrote:
> 
> > ReiserFS has been considered deprecated for 19 months since commit
> > eb103a51640e ("reiserfs: Deprecate reiserfs"). However, there are
> > several architectures that still build it into their defconfig kernels.
> > 
> > As ReiserFS will be removed in 2025, delete all ReiserFS-related options
> > from defconfig files before the filesystem's removal.
> 
> 
> This is essentially equivalent to deleting the filesystem now. Why do
> this? Is there such a hurry?

This is not equivalent to deleting the filesystem. The filesystem can still
be configured into kernels, and few distros use a defconfig kernel anyway.

> 
> 
> Segher

Cheers,

Peter Lafreniere
<peter@n8pjl.ca>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
