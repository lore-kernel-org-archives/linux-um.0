Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FF2CD4F26
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 05:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aykEWd/tLK2WVNyaAerXRB8Q6NaR+e2WP/5lvQ4teDI=; b=XYRQQNSthDeOtlrS8HlopiyqL1
	yXkEKr53uZJTj1lgDHfM/Rskksui1WRR2YHqTsrRKGwqRZqfRLjVHgdBz5u/iuEpvXqRy9XblIGNY
	Q7qaZRTGJanFivpcS3x/J/6X7rsSUNrzyQk6eNNnHYq7+gqivhOTkI9SwXr18TbSonlcP3oFHCbjy
	qV6LckDnVd+/bUrsbuOz3oVDP6OpjOFiAl4wTqxjYAC0dSx+dqRccGkRG8HMe9pqgjH5aJzeFpq1i
	A5jxEmCgPOf7w5pdSFYKqVh72kZfNEL6j1QJbFb59Q5e7eJ6/dqUCdVR7SOmz84UPD+jsfmlg/w6a
	Rp4bUEDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wczIH-0000000AWvu-0WQG;
	Fri, 26 Jun 2026 05:40:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wczIE-0000000AWuV-0zO1
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 05:39:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53D4268B05; Fri, 26 Jun 2026 07:39:55 +0200 (CEST)
Date: Fri, 26 Jun 2026 07:39:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/8] x86/fpu: Check for missing AVX and AVX-512 xstate
 bits
Message-ID: <20260626053955.GA9629@lst.de>
References: <20260626043731.319287-1-ebiggers@kernel.org> <20260626043731.319287-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626043731.319287-2-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_223958_427847_0BCD4DE0 
X-CRM114-Status: GOOD (  12.77  )
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

On Thu, Jun 25, 2026 at 09:37:24PM -0700, Eric Biggers wrote:
> If the CPU declares AVX or AVX-512 support, verify that the
> corresponding xstate bits are also set.  If not, warn and clear them.
> 
> This eliminates the perceived need for AVX and AVX-512 optimized code in
> the kernel to call cpu_has_xfeatures().  That has never been universally
> done, which strongly suggests that it has never really been needed in
> practice, but this should remove any remaining doubt.

I'll leave it to the x86-experts if the low-level details are right,
but the model behind this makes life so much easier, thanks a lot!


