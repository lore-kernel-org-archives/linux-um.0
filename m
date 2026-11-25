Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF07606A31E
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=m2FVXM/x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HRfXrjy4cFvSqBw76P9cqoRaoe+61N3iyVA9tyup4k8=; b=m2FVXM/xE2mZFPQ/bq6tjkpFol
	MLlaiWs0MRxbkFuPITwWL6UUh0tJC7JT8LBOzCklryl0+lNPxROLruqkUeOBDZAB7WhnrwVRvh3Ha
	+Q2kdXjI7aQ3rwjPm18D6gQUcVPC5EKqo0XkFnHmBINRLwM0d+2cIqbTbof63itgGwN/P1A/J5HWN
	i8zbHhgLqCIMOUG1dKkPZOjrysgXYrzFzwkUYiGtSe4T1AH/HaaiDh7SIltUnotJpLMLTZYAcg2nL
	rOwEZBACWBQBK7blz7rzznfjX2d3pUf60r7TiIogMZuo7G8qWm81oQtH8vSUETCybmnASEWhW7elC
	Axpfdpsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW7Uw-00000008uDZ-24xz;
	Wed, 25 Nov 2026 07:32:58 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW7Us-00000008uBv-150Y;
	Wed, 25 Nov 2026 07:32:54 +0000
Date: Tue, 24 Nov 2026 23:32:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
	Jan Kara <jack@suse.cz>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>, Carlos Maiolino <cem@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu, linux-fsdevel@vger.kernel.org,
	linux-um@lists.infradead.org, ntfs@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] VFS/xfs/ntfs: drop parent lock across
 d_alloc_parallel() in d_add_ci()
Message-ID: <awaPJqPMezCU5LKD@infradead.org>
References: <20261117000115.1433875-1-neilb@ownmail.net>
 <20261117000115.1433875-2-neilb@ownmail.net>
 <awB5mAWm9h1ksRFI@infradead.org>
 <179540759290.1728055.6042791276963817025@noble.neil.brown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179540759290.1728055.6042791276963817025@noble.neil.brown.name>
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 03:19:52PM +1100, NeilBrown wrote:
> On Sat, 21 Nov 2026, Christoph Hellwig wrote:
> > On Tue, Nov 17, 2026 at 10:54:58AM +1100, NeilBrown wrote:
> > >  					  const struct dentry_operations *);
> > > -extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
> > > +extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *,
> > 
> > Please drop the extern and fix up the formatting if you touch the code.
> > Bonus points for spelling out the arguments to actually make it
> > readable.
> 
> I think inconsistent formatting is not much better than bad formatting.
> Maybe I'll insert a patch which tidies up the whole stanza.

Well, if you keep this mess it will never get fixed.  So please fix
it up on the go as we do in most places, which makes a final cleanup
pass easier and more likely to actually happen.


