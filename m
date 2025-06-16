Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECB9C71159
	for <linux-um@archiver.kernel.org>; Mon, 16 Jun 2025 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RY6jvlftqYj16RlZ8cMi5ktPdnRQwqLwReUIv9YTb9Y=; b=4v0PGMmp0yDyX6lsDee+p+VKkt
	YAq6kIh8Uz+gc2X1VrqS6cCXKIMkM/wQgbIgrAIjbQc2G+hRBcCsC2B+UAfEe1Fwo81IN454HNTk6
	b31Ov002inkG0kME4dtfFrxsAzoehSyyFM/NxwyKv1LscKVohdglf0hTkTCP3bwwObb68Dm5ixvl5
	uJZmzhIPhjTcO4Na9Sdj76d1npR+1/za647N36qunzRDinUz9ZpMf2rZHenKarDmee7d6W8GYuPH1
	JeOscrCeR1zHT9ga/hi59DUAs8LwuUv8OcLW/TGlUbkVFz+PPQu2yGi3ztw5qvumtCqkpvMMnNnYl
	9BnYBQVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRFwQ-00000005Q90-3p3x;
	Mon, 16 Jun 2025 19:56:26 +0000
Received: from out-173.mta0.migadu.com ([2001:41d0:1004:224b::ad])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRFwN-00000005Q8A-1bPW
	for linux-um@lists.infradead.org;
	Mon, 16 Jun 2025 19:56:24 +0000
Date: Mon, 16 Jun 2025 15:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750103779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RY6jvlftqYj16RlZ8cMi5ktPdnRQwqLwReUIv9YTb9Y=;
	b=hfTMIphzIV1UP9YZShGN/2c5XF+1HSCXXUsJYRJXY1L6Aclc1GU2E07+0kGNeThs5vuF28
	AC/+C5qGR5vwjAZWxQnLX9XOq2VPangJK+zHBHTevwRsO8AM7teSfcER/FwsKkzBj8c3T1
	2J2uYc2bohx4O0D5BW29EVxqbVb4hNk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org, 
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH 00/10] convert the majority of file systems to
 mmap_prepare
Message-ID: <tz4x7atqjhxr3rixvgklfss4r5u5jod5qoeqr6iueois3ywdap@losa5evtlekp>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_125623_702663_934A1951 
X-CRM114-Status: GOOD (  16.31  )
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

Mailserver is rejecting with "too many recipients" - aieeee

On Mon, Jun 16, 2025 at 08:33:19PM +0100, Lorenzo Stoakes wrote:
> REVIEWER'S NOTES
> ================
> 
> I am basing this on the mm-new branch in Andrew's tree, so let me know if I
> should rebase anything here. Given the mm bits touched I did think perhaps
> we should take it through the mm tree, however it may be more sensible to
> take it through an fs tree - let me know!
> 
> Apologies for the noise/churn, but there are some prerequisite steps here
> that inform an ordering - "fs: consistently use file_has_valid_mmap_hooks()
> helper" being especially critical, and so I put the bulk of the work in the
> same series.
> 
> Let me know if there's anything I can do to make life easier here.

This seems to be more of an mm thing than a filesystem thing? I don't
see any code changes on the filesystem side from a quick scan, just
renaming?

Are there any behavioural changes for the filesystem to be aware of?

How's it been tested, any considerations there?

If this is as simple as it looks, ack from me (and if it is that simply,
why so many recipients?).

If there are _any_ behavioural changes on the mm side that might
interact with the filesystem in funny ways, please make sure the whole
fstests suite has been run.

