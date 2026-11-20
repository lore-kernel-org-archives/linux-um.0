Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BAC606A330
	for <linux-um@archiver.kernel.org>; Fri, 20 Nov 2026 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JfcHNCYc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aHGMMibfTK3B84l7c2TFfwJFc+Ej1l9rQZD53EE9TDc=; b=JfcHNCYcQMpCpmolwcHc/a4kRD
	isffsj3L/QyBcJAOFhfS5j527Z95WLEVLanIHxrrpPZ8sQfcwC1qd/XKPVYGNUWpCuVtiIRPC5XzY
	aPZjJuDtrpziozu3hm6RI2heOrUiU57AIZTsSW5u1F15s5P2OxWJKv8FhC+uhDnQAq5aYf5UW9hqW
	rkKfYXDqeGclBbITRGARpj1TsZ0WZpp/qS2EQxe+/xNM4OBZCREuyimiQNOP/VmRjj4g719bI7r5z
	JOpYeQEgYCXTHgVUCOg5yr37Rzo3ATF3wRbl32fh0QN7wOefDYboC3xO9fH5lnBLoL7kPGubyUzdV
	3uvTfsIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xURlo-0000000FaPk-3F0x;
	Fri, 20 Nov 2026 16:47:28 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xURlg-0000000FaOf-1Kar;
	Fri, 20 Nov 2026 16:47:22 +0000
Date: Fri, 20 Nov 2026 08:47:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <awB5mAWm9h1ksRFI@infradead.org>
References: <20261117000115.1433875-1-neilb@ownmail.net>
 <20261117000115.1433875-2-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117000115.1433875-2-neilb@ownmail.net>
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

On Tue, Nov 17, 2026 at 10:54:58AM +1100, NeilBrown wrote:
>  					  const struct dentry_operations *);
> -extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
> +extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *,

Please drop the extern and fix up the formatting if you touch the code.
Bonus points for spelling out the arguments to actually make it
readable.


