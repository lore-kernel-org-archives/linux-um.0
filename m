Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63503C3DA49
	for <linux-um@archiver.kernel.org>; Wed, 17 Jul 2024 00:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BtfyLCj6M+NZOSU2MnpCz5IhQ0yotxuhvhQ7vyFbhRk=; b=vQbQMJRpQvE6frXl0M3TAhhhwB
	qQ1aTgHKFezq/W8jEbHRxgk52U2/dgKqMDGe/kxVQwmVdMalUc4u9fKggBqr2hdzgSdollIZZ2Pui
	UnC72+IQOJ2gBT4JSRdWZdYQWGTmARI7VKtXQtkpRSlTaWwdBqqiLFLdKKqwglzTPg9H8HuAelGfC
	1BopuyDiwvWiQF6helk6NhRGaipXmr7VMXYqBedfjKF10AEwnecCe1kQfeabB7ZurXSTdrxV2pvh9
	CyRa0NOCeUozar6eksxKWRIQdDcz8BeGfyRJQeniUA+vq4yO0wxR2wV+LugABwjlzcR8mkBHj4HUa
	C/ZvZt6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTsvX-0000000CD5m-2SMC;
	Wed, 17 Jul 2024 00:53:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTsvV-0000000CD5G-0LC9
	for linux-um@lists.infradead.org;
	Wed, 17 Jul 2024 00:53:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7F9836144F;
	Wed, 17 Jul 2024 00:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F314BC116B1;
	Wed, 17 Jul 2024 00:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721177628;
	bh=NtvslSoeOcdyt9E2tMWfN3uP5NFeqWYwbzi5YQv7twI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/wXjLzpMM7BPOn8qzk8O0Je0T9ax9+77ZO0jQ2iNOPZI2aJ1Ivsst2RRpe1qWDiy
	 UYSh0B29DMX0HDI83HONEsIzcyh7oALXssfH9lHCZ7eUcW+G1BP0z/8IrwL9ij4Vfo
	 1dCiGB/g+IP1ZsmlFB9OoILIQB5lrk2yriih7E5Yqc57SKDvhuEYWkniu/gX8zvG31
	 ucLBXs02h5JM5r4cjkcu4F+x1An6fLgTLu9EPXmheRgbNxiaIxkQPJB4lHASDEWzLu
	 tdgNSPrRUA77iUJE3pov5YUxVglehLI4Yi061X/kIa3Rd9pLDK4FD5n9rmkY28eASS
	 zdyQRgxaZwlgg==
Date: Tue, 16 Jul 2024 17:53:46 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Crash when booting UML after
 e3c92e81711d14b46c3121d36bc8e152cb843923
Message-ID: <20240717005346.GA516623@thelio-3990X>
References: <20240716143644.GA1827132@thelio-3990X>
 <CAHk-=whfQoTDCd=8DYfCiX0a2ndqM-mmoxDm1xA7Kud+WQ9T8w@mail.gmail.com>
 <CAHk-=whVPmZm=rMBf1qkJzfZeBx4Es15_w7VnPK1wEs=XYDUgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whVPmZm=rMBf1qkJzfZeBx4Es15_w7VnPK1wEs=XYDUgg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_175349_193057_56BA0417 
X-CRM114-Status: GOOD (  10.72  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, Jul 16, 2024 at 05:41:14PM -0700, Linus Torvalds wrote:
> On Tue, 16 Jul 2024 at 16:18, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm... Does this simple (whitespace-damaged) patch fix it for you?
> 
> I verified that it seemed to generate the right (generic) code, so
> I've committed this fix. I didn't actually run your test-case, but it
> looks ObviouslyCorrect(tm).

Can confirm. I tried it initially and it did not seem to work but I
think I may have been using the wrong object folder or something. I can
confirm that the tree boots at commit 0434dbe32053 ("Merge tag
'linux_kselftest-next-6.11-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest").

Cheers,
Nathan

