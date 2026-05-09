Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6F9CD3447
	for <linux-um@archiver.kernel.org>; Sat,  9 May 2026 02:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PWb/8pCuWmCJG+nVLKaEaMBPk2nfmeH5Kmbn10R4gPA=; b=czy+5uw00ArBPWvAyD4vQd+Ely
	hw5HhOhSBfvC6oc9HJk5vstImPNMOQXme0l+Ynam9SzdF116CladggjzfquL/rRcm/+mOHg7F96iW
	qDNuBtHizVmWDvrThV4wYVEYEcQnFGbm5gzW33JdJtyjpWsvYmjnnC4W8MexCojZIHWSnT9fLd77r
	0jKd1OdYPK2OFu5ya3nMBgA/pZsyI1m5HJzXrnb2UphTfvasd/sBxnmaiT9MLfShB/iLMmgjqOQ+o
	dlA2lVOTZe1UTTQri1DLIeTwi8h3WnG4fHhBDZ3KWDWlhT0ychflhAg0u+kBGwb9JPJn9+66/EMzA
	qHXDjphQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLX7X-00000007yIt-1VWq;
	Sat, 09 May 2026 02:08:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLX7U-00000007yI8-43Kh
	for linux-um@lists.infradead.org;
	Sat, 09 May 2026 02:08:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3DB0B42AB8;
	Sat,  9 May 2026 02:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06698C2BCB0;
	Sat,  9 May 2026 02:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778292524;
	bh=PWb/8pCuWmCJG+nVLKaEaMBPk2nfmeH5Kmbn10R4gPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNCdcpjdAQu5VCpW3RqA4eBTNGRtWeXp1I7HZL1DVMXAUZ8NlstN9bGWgHMzujNQB
	 qPZmjQ635nHRnYCVpye+nr/hpP4A1l9VXAaugF3ZwUsNRpN6B+gPPr5d4KAhDjilPn
	 uIGoPCuC66m82BEM3Q0A/3t/r0j6Op2BOY06eSCtqLoYGIs2BL3x8Kwzdg1BAIRbWZ
	 6jpxDFXSmGYWMKU9QlBCrkbiHMQ/bXPSBN0jTZMwyywBs9UPlkOahGJVccZ1tHVjF9
	 SI3uO37sRH6Kkz9vw/N0OyA7B10vbxxC9uWsimBy3MmTnx2RBcDKyyRzJWSCMJFC5B
	 Ad6IEkVyLdJkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable 5.15] um: virt-pci: Fix build failure
Date: Fri,  8 May 2026 22:08:37 -0400
Message-ID: <20260509015927.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508205241.962178-1-florian.fainelli@broadcom.com>
References: <20260508205241.962178-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_190845_026234_9C7111FF 
X-CRM114-Status: UNSURE (   7.19  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, May 08, 2026 at 01:52:41PM -0700, Florian Fainelli wrote:
> Commit a27e95a6ff3f ("um: virt-pci: properly remove PCI device from
> bus") assumed that virtio_reset_device() is present in the 5.15.y kernel
> but it is not and so backport would now cause a build failure.

Queued for 5.15, thanks.

--
Thanks,
Sasha

