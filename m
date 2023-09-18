Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65323CD3424
	for <linux-um@archiver.kernel.org>; Mon, 18 Sep 2023 23:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Mime-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JcXkFkHDm7w8HsQlEPZofgf9MPAWSAk8lC/S+zCJM/g=; b=dguzzKthARSCoD
	dEgSRAkewc3aMe79nAspOsXzQs3TjbXeJdxEBdkJl8rkhzpFYjX1Qr3pgd4CEEdd0BFqeX4pVI5V6
	wX4XvIh1yS4QlpphD6TiADWQn47ytHYbm8Abg+EUi/DyMrhHT4AU6FOYqM6xo5gJjU4wStSBt6APR
	6SmpHKdYCxuryXkaTGPOzM3h7uQiAEFPG6Kj47v4yYLoleIkJcRiqHkY2a+puKAc0Gn+Cd6jCZTFY
	4UTxViQtDqNlu4C/GCD7oGGD2Gs6TBBT9jf/LxC5Yw3/xrTZNaUE6iH8+sZvgNtHgIignrPxiFX47
	Ppsru61WkhWf9vqwJ3Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiNy1-00GXkl-1z;
	Mon, 18 Sep 2023 23:47:49 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiNxz-00GXjr-0m;
	Mon, 18 Sep 2023 23:47:48 +0000
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 38INfC75019228;
	Mon, 18 Sep 2023 18:41:12 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 38INf80d019225;
	Mon, 18 Sep 2023 18:41:08 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Mon, 18 Sep 2023 18:41:08 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Peter Lafreniere <peter@n8pjl.ca>
Cc: reiserfs-devel@vger.kernel.org, tsbogend@alpha.franken.de, jack@suse.cz,
        linux-sh@vger.kernel.org, ink@jurassic.park.msu.ru, richard@nod.at,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-alpha@vger.kernel.org,
        linux@armlinux.org.uk, johannes@sipsolutions.net,
        richard.henderson@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, anton.ivanov@cambridgegreys.com
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-ID: <20230918234108.GN19790@gate.crashing.org>
References: <20230918175529.19011-1-peter@n8pjl.ca>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230918175529.19011-1-peter@n8pjl.ca>
User-Agent: Mutt/1.4.2.3i
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_164747_590966_D8E4AB34 
X-CRM114-Status: UNSURE (   7.96  )
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

On Mon, Sep 18, 2023 at 05:56:09PM +0000, Peter Lafreniere wrote:
> ReiserFS has been considered deprecated for 19 months since commit
> eb103a51640e ("reiserfs: Deprecate reiserfs"). However, there are
> several architectures that still build it into their defconfig kernels.
> 
> As ReiserFS will be removed in 2025, delete all ReiserFS-related options
> from defconfig files before the filesystem's removal.

This is essentially equivalent to deleting the filesystem now.  Why do
this?  Is there such a hurry?


Segher

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
