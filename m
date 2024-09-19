Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB79CE8D58
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 07:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kXe44D4oPW7CPCoxcbg896TShv4XLJMnwM4n0Dy3AXw=; b=VzUajSmUbTDzsxuObXi0/CUJZx
	g0/jq5lpycTJM7wmH40+ihlX+qAenX2wPtiqPg12ooHuhrrpVnYpu8hC+OPv1RvPpEaQaQCynn5Sp
	O1qxj1h8W+x79KXClhkBwE3EetnOBqJmpbrtSjdk4wQ7OHgfDPwIY+UbqdbCrXlk+tr2PGlQGIeIB
	/GD2ondnBj+Kr+wBA6xLXjnD2A+d7QhbabEufD7TLImqZQuu59MEp8L/w6azd5qQt94Tj1C5rwAJY
	ovtM7/L8cUmXWCU0VN3OKsAj4dgXfgt07+l7gV4q0DpOFZ+aqNUMVQwgdAQEgoAxFMu6vVroc0LfN
	H4k0rL0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srBUl-00000009du9-2OXT;
	Thu, 19 Sep 2024 07:22:31 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srBUi-00000009dtI-2UEH
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 07:22:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kXe44D4oPW7CPCoxcbg896TShv4XLJMnwM4n0Dy3AXw=;
	t=1726730548; x=1727940148; b=AWEf3V2UCBwmSi89jTnRNE22dpi0L6giZannzawgvUPkslc
	vEiV2LLyyjT74b3Wt2rmUGWFRoCOX2ChraPp2vhWnUzQ8qhOnNF4FLOhx4gbi3+c10U35XDBklTfJ
	geFPdI+QPCsVK/Nxfbucj06UpUej78yWf+Hdu2+q3HkSRJ+SzcP2JVy5n8WqEbJ8SSWq9xorY2YZ/
	d6QrQm+9YcByeQq8H/siU+ljJFjUPSTFukGnDbHoLfmTzNHPG8JWj29hHLHI/kag01QnS/ZU0erDI
	ajpkADX9kqqYv1hZyeXKFqMRLjwMpNqs5MEuJ+a0XBCTHohjVQvZf1Thy+odfz8A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srBUd-00000003SkL-0W6a;
	Thu, 19 Sep 2024 09:22:24 +0200
Message-ID: <627bd11a7fe69fed02719c2ecf5370b59328e80d.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Remove 3-level page table support on i386
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, Tiwei Bie
	 <tiwei.btw@antgroup.com>, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Sep 2024 09:22:19 +0200
In-Reply-To: <0a73298f1c0ed189046360ea867e6da32276381c.camel@sipsolutions.net>
References: <20240918061702.614837-1-tiwei.btw@antgroup.com>
	 <0a73298f1c0ed189046360ea867e6da32276381c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_002228_651978_ABF04FBF 
X-CRM114-Status: GOOD (  12.63  )
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

On Thu, 2024-09-19 at 08:54 +0200, Johannes Berg wrote:
> On Wed, 2024-09-18 at 14:17 +0800, Tiwei Bie wrote:
> > The highmem support has been removed by commit a98a6d864d3b ("um:
> > Remove broken highmem support"). The 2-level page table is
> > sufficient
> > on UML/i386 now. Remove the 3-level page table support on UML/i386
> > which is still marked as experimental.
> >=20
>=20
> No real objection, but with the 4-level page table work on 64-bit
> pending as well (which likely conflicts), I wonder if we should just
> remove 3-level *entirely*?

Fine with me. There is only the tiny advantage of saving a few pages of
memory for each process. I just erred on the side of keeping it in case
anyone is cares to the option =E2=80=A6

I'll resubmit the patchset without 3-level support then, possibly on
top of this patch. On the assumption that no one actually cares about
3-level page tables on x86_64.

Benjamin

