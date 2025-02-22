Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5805C021B2
	for <linux-um@archiver.kernel.org>; Sat, 22 Feb 2025 04:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfUBrmsjEzlreUx4AXwJcqcuev0D4ASn1NvBbAj8CU0=; b=ixJtTlm2pRkRVEfRn4ShHOIOSv
	AR1f6JK9EL0sdWmWsFnqjbjNXj5apq4bXtBx+ijdg5GFg2GG5u5WfcUf5jP3ryQGt76WAFS3uHD8k
	JDdaHf6ghyiUKoDy/+Ya9vTv0sXV6p9+m2o4jDyDD4ERzYqnzVT0nTC5EoMvg5u06rkJ+pUqPT1Ej
	Vw+yOn5TDKPPgCuc78hYEQH/GAY4j5BsUboGFDUWXuG+w0lOwn1vZFB3qq0CFoSWraqH8Q0xeMrMt
	93ro1qqYzago3/kbb3mU3wym3xGGrDV94AJ2IeXOEV12JmAt1OBBYhrtilEATi4Xeprvu988TiXw6
	RkOBvBpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlgzh-00000007R8R-1ypx;
	Sat, 22 Feb 2025 04:20:01 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlgze-00000007R7h-1yl6
	for linux-um@lists.infradead.org;
	Sat, 22 Feb 2025 04:20:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qfUBrmsjEzlreUx4AXwJcqcuev0D4ASn1NvBbAj8CU0=; b=EHqfOfLP9VxWQT6m6l+8Kqb+8D
	Y/KlagZgn9RkQHu9FwnQ5H6MelwTA+wmY44O9vuFq41lY+jB0bC36GC1iMXRJBRN5nrcgug2Pki70
	kISTP+dD1MJozKroh0sH6AxxkYUketYRci+k66PXl7v7R/q58wlNyzcJeLqL7zbuhIYXf/csxKnN4
	VH5IkAClhhCxx5OMw2kXfDGs5prmq+kxor8YRBDndqLLzqeUYg4jelxYLnkQLVnHuc/ktsHneeuWG
	goVu6wB/tCfwmkMw8ROOkrtvNgMawXX1O5CyNh8VqurD56b+GRJheL0VZa2hI9FdXXK90vEbfwK6c
	uN4g9LKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlgzJ-00000004dod-0CaC;
	Sat, 22 Feb 2025 04:19:37 +0000
Date: Sat, 22 Feb 2025 04:19:37 +0000
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
Subject: Re: [PATCH 1/6] Change inode_operations.mkdir to return struct
 dentry *
Message-ID: <20250222041937.GM1977892@ZenIV>
References: <20250220234630.983190-1-neilb@suse.de>
 <20250220234630.983190-2-neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220234630.983190-2-neilb@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_201958_508406_A417F42A 
X-CRM114-Status: UNSURE (   7.44  )
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

On Fri, Feb 21, 2025 at 10:36:30AM +1100, NeilBrown wrote:

> +In general, filesystems which use d_instantiate_new() to install the new
> +inode can safely return NULL.  Filesystems which may not have an I_NEW inode
> +should use d_drop();d_splice_alias() and return the result of the latter.

IMO that's a bad pattern, _especially_ if you want to go for "in-update"
kind of stuff later.

That's pretty much the same thing as d_drop()/d_rehash() window.

We'd be better off dropping that BUG_ON() in d_splice_alias() and teaching
__d_add() to handle the "it's a hashed negative" case.

