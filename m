Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FBFC021B6
	for <linux-um@archiver.kernel.org>; Mon, 24 Feb 2025 02:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cWXFKPf926VJJcQwfoughMuI6A4RSR+t+lfCQtUUhuQ=; b=vhLuzJTP+pfyX7xhRkVF747+/O
	I+kfWJ0tzysQHyg/O7D00oegO2zQn2ClxIqH7fAu8xKLepTJGm5ZDZ+Xr9hutE0ZcNHsEN2mwOEKL
	4Ai3/p2P+v4w6YaqVulhMwM3PNY7Qb/C23ZHh7+CXZ0Xcg+5pOtHw0PZZHqajQX5kFN/i81U5PLhg
	/h8vmdl0/qy56cT3LTzVFZ4tJW1pGpqil5AlcxXhRBMfuYKqrO6OQjeZUryHky483touUw8K6FTLC
	+BaD6yBGowFF8tBvSuqbbQqsuOHQ9uS7tRceaBdOTF8yyN8vq+Bx3LqWXcxAFrawH8M1EBRC6wLp9
	kTGlwK1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmOfC-0000000CCS3-2Eo6;
	Mon, 24 Feb 2025 02:57:46 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmObG-0000000CBsw-1WQY
	for linux-um@lists.infradead.org;
	Mon, 24 Feb 2025 02:53:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cWXFKPf926VJJcQwfoughMuI6A4RSR+t+lfCQtUUhuQ=; b=LkyZhZLoeJ8FJVwaMHQP3yt0JZ
	vUicAmWY1WE0fG5qRelvgFrpLS2DhAbO/mWxPlFHY+v26Ni6SnRhPHVXR2oVn3EehvMZ4Rv7H7ByS
	fed6xx12fWXbQb2XAOykHBOmaRbLm5c5j8XoFX0u/8MDeqFKYe5b+7YlLFE5/HoQ+crR/jKcS0jql
	qIggXENPEaDarE1h7DnG3zSPi6Aq9c+3CiOfMVUmbydTvH6opX6cafl0SKJxzqk4F4JI+PvwTa8Hn
	h5aQGYsoFYXDoszTosOSULJIPtw4dQIZiBA/lIOikECMEaeZmVchiuIqz0+hO+9Bkry/4t+1GWIQR
	8eujRs/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmOb4-00000006c7z-3gIl;
	Mon, 24 Feb 2025 02:53:30 +0000
Date: Mon, 24 Feb 2025 02:53:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: Re: [PATCH 4/6] fuse: return correct dentry for ->mkdir
Message-ID: <20250224025330.GW1977892@ZenIV>
References: <>
 <20250222042402.GN1977892@ZenIV>
 <174036397835.74271.9038146946135155196@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174036397835.74271.9038146946135155196@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250223_185342_413604_D616077A 
X-CRM114-Status: UNSURE (   9.31  )
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

On Mon, Feb 24, 2025 at 01:26:18PM +1100, NeilBrown wrote:

> Probably now.  It would require S_IFDIR to be passed in the mode to
> vfs_mknod().  I don't think any current callers do that, but I don't see
> any code in vfs_mknod() to prevent it.

Not allowed (and that's caller's responsibility to enforce).  Local filesystems
would break horribly if that ever happened.

->mknod() instance _may_ be a convenient helper for ->mkdir() et.al. to call,
but even for ramfs it won't coincide with ->mkdir() (wrong i_nlink, for one
thing).

If that's not documented, it really should be.

vfs_mknod() may be called for block devices, character devices, FIFOs and
sockets.  Nothing else is allowed.

