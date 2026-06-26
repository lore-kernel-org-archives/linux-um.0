Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC30ECD4F26
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 05:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZusCNbIc8LrRJZFkRoqPByl27UFG7XUmGsTF9h8YKP0=; b=dOLV9HBfGVy2HP2ziv4IWWhM2H
	GPr+fty5J4vf2TLEmSw20uDLP7iQ7f66BEI0O4qpEIcSa7nmkZdYtgkTe2J7acc7nXrmDRPkbNpb6
	K379q72ismOpVTJtBTbFJOSJer+zBR44v/bIbuCizr3bVEnHVahPpN+jENaCL0CaFjgUijw9aJsjl
	enD4xVPwOOOA+0KqbOR/sm8upPmVmHbO6xJ3GtarX8gtPwp1jhVxXctTziIWKIhZ3ekmEFkGTtpGe
	HGztRG4qXfCxyUpFA+9KOyS3DrROvVKYce6xkOsGb4kosHExPGzfjEJR2HzKkUD4AIkEfO/aANsAV
	1CoeoL5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wczPd-0000000AXcT-0jYt;
	Fri, 26 Jun 2026 05:47:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wczPb-0000000AXbX-1eT7
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 05:47:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD31968B05; Fri, 26 Jun 2026 07:47:31 +0200 (CEST)
Date: Fri, 26 Jun 2026 07:47:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH 8/8] lib/raid/xor: x86: Add AVX-512 optimized xor_gen()
Message-ID: <20260626054731.GC9629@lst.de>
References: <20260626043731.319287-1-ebiggers@kernel.org> <20260626043731.319287-9-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626043731.319287-9-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_224735_597349_F7EF7BE3 
X-CRM114-Status: GOOD (  11.65  )
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

On Thu, Jun 25, 2026 at 09:37:31PM -0700, Eric Biggers wrote:
> +	if (IS_ENABLED(CONFIG_X86_64) && boot_cpu_has(X86_FEATURE_AVX512F) &&
> +	    !boot_cpu_has(X86_FEATURE_PREFER_YMM)) {
> +		/* AVX-512 will be the best; no need to try others. */
> +		/* !PREFER_YMM excludes CPUs with overly-eager downclocking. */

Can you turn this into a single block comment using full sentences?
Right now the two separate comments almost feel contradictory even
if I get what you mean.  While you're at it also through in a blurb
why we dont bother with AVX-512 (number of register, no one in the right
mind would bother running high performance code on modern cpus in 32-bit
mode).


