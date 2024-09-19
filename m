Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526FECE8D4F
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 06:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wMrl/J5mwscJ3KK7xQ5ASWguz0o0XYHHN/LKrWKA1mQ=; b=nbz0KcHIX3GuCcNLRSdTm+7DRd
	zYxD06RJ1zJrtsj+s1EZmOh93Mrtpjx/pggYB7pc65lMwZWcIPPh1+Co1HDyMYQYlGlqgOxwPqyhU
	ZbSLcSMzy/eKLJ5E9cz11WFRQwtJ4PRBU/4Oyi/vYGfHGyzE+AZWPifI5BCoXRyVM6rOwVk7tPkvi
	6qip78KsffsvfX6V9zsfTVisYLjThT3XeZcJonM8HuA9PxquhnN0B/L5THd0Yu0RTXafSBAXCh01w
	7DmjRCoYGjBNynHRkvlFKMRdA2/tDgdwtpETORhqn5EBiT3vDEnHUMq/pH0Eg6CfZI1tGdpAG0u7P
	BByrn2+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srB3U-00000009azg-1kAV;
	Thu, 19 Sep 2024 06:54:20 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srB3S-00000009ayv-0LT7
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 06:54:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wMrl/J5mwscJ3KK7xQ5ASWguz0o0XYHHN/LKrWKA1mQ=;
	t=1726728855; x=1727938455; b=nCtsuiOxu8MfZy2PEmsqzl9+VW8NA6HHFoyVDTyXopH9Lnr
	U8MMqWRBzxcQjArU8gayfDjnUuLOlsZvzXfIVhaQjWinGYIGst5C7XrNYz9RHuUBbOMq4jj6zHQyt
	Y6XQiAk17yjWsy8NnZPNTrnpdVBCscpIRlMGAXZeBkFo/xW/74ERegs2Km0l8eNQoTQ/B9Rt3sy/c
	7Euf/3gNqL9eV/CtfRnJBCiziGLnSpdRsivMz5k0YxjXeS1aRpIr7p2Av2kZ3ZWR/iP0y05e/ShO3
	jr6Fw3wApoCivUXit2BvpvVur94MArAohfEJNAx7IWtXweRovxIeqMABi/SOkTVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1srB3K-00000003PFN-1wEh;
	Thu, 19 Sep 2024 08:54:10 +0200
Message-ID: <0a73298f1c0ed189046360ea867e6da32276381c.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Remove 3-level page table support on i386
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net
Date: Thu, 19 Sep 2024 08:54:06 +0200
In-Reply-To: <20240918061702.614837-1-tiwei.btw@antgroup.com>
References: <20240918061702.614837-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_235418_153358_CBA73432 
X-CRM114-Status: UNSURE (   7.65  )
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

On Wed, 2024-09-18 at 14:17 +0800, Tiwei Bie wrote:
> The highmem support has been removed by commit a98a6d864d3b ("um:
> Remove broken highmem support"). The 2-level page table is sufficient
> on UML/i386 now. Remove the 3-level page table support on UML/i386
> which is still marked as experimental.
>=20

No real objection, but with the 4-level page table work on 64-bit
pending as well (which likely conflicts), I wonder if we should just
remove 3-level *entirely*?

johannes

