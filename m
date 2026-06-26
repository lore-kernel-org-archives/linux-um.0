Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C495C43211
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 20:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bmd+bJ8E0pSDSvOLP7c5yac+5ujgjGsTnNkq8rNq6v4=; b=pCb2odbgT8bhIX40w8+HF1VQbB
	nRoT/CSYIb8syTvG28balWX8yAecKmAdXmWq4MmBbREJ5VNrzn+x2GFCDpG1Htaoz47OiprJYrE6t
	Dvtyyskm9amwZN2omdTY5N+BGOb/kYVVoHaFddhysK4WF+hp0jNHTHAQJiLF3Wbr++nJbZDCrmX0t
	6CXb3SGwaIPbAq3ATVyZrrdkXos/rJZsL1PBRRuH6/Kpfu1rJG2z2B22j6WTaTuv+Kok2XV4+CHkR
	V+tioqMYKqWQPmWSZDPgzU9W4J3aZ1k2zW2UpzSznQxiQzci8JorSYcZVmKuAdXRBL1gfrWs1ojE6
	auL/NqWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdDbn-0000000Bs4D-3Vem;
	Fri, 26 Jun 2026 20:57:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdDaV-0000000BqBo-3T7E
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 20:55:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AF89E600C8;
	Fri, 26 Jun 2026 20:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE511F00A3D;
	Fri, 26 Jun 2026 20:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782507346;
	bh=Bmd+bJ8E0pSDSvOLP7c5yac+5ujgjGsTnNkq8rNq6v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oTOfpc+B+HOBKinlp1xH4fRAZHwbvFNBi25NB5k+1VUe1uuziWX9PugRW3/hD1kXR
	 Cdv8/55oqAI0U05iiUxfpVEE9UFWAZPcfknrwCVLDgofQNBWLeJQro79H1IkmcHC/N
	 fKFWPB9I242KzyHJRO69jUFxlaaOm5G5DvzWILCOlJp8qJLDLWTa8sT/neVHR1fA8R
	 pnpRb8pr8N+clDwvN1lmlowmMhoeg5j0+lWWEtjkrQ33+bUmhMZTmAi9BwgR3vskCw
	 Q5Kvs0L8huc/1T0NdOIxsOjGLY0qx7jsFj151BuQO4SxYtZQ6gC0MVK6ArnYAHx/ZG
	 K8E2tJhPVHF3A==
Date: Fri, 26 Jun 2026 20:55:44 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, x86@kernel.org,
	linux-um@lists.infradead.org, linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/8] um: Check for missing AVX and AVX-512 xstate bits
Message-ID: <20260626205544.GB2368695@google.com>
References: <20260626043731.319287-1-ebiggers@kernel.org>
 <20260626043731.319287-3-ebiggers@kernel.org>
 <20260626084113.42eae31c@pumpkin>
 <6a20b442-b97f-4cae-9168-30201d5ef82c@cambridgegreys.com>
 <20260626114957.1a2b7e5b@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626114957.1a2b7e5b@pumpkin>
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

On Fri, Jun 26, 2026 at 11:49:57AM +0100, David Laight wrote:
> > UML is just another userland application from this perspective, so
> > there is no reason for it to behave any different from the rest of
> > the userland.

Which is why it should do the XCR0 check that the vast majority of
userspace programs do, right?  It has always been part of the documented
way to detect AVX and AVX-512 support.

(I think this helps explain why LLMs notice this too.  They've been
trained on lots of code that does it correctly.)

That being said, it does seem likely that it's basically obsolete now.
So maybe we could take a shortcut and omit it.

The important thing is really that we make a definitive decision *once*
for each of UML and native x86.  The status quo is that the decision is
instead punted to every individual AVX optimized function in the kernel,
which isn't working well.

- Eric

