Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD135CA0EC4
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 07:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hm2PPtsNJuhxIDGNuJHriEQn1/qO4cQcfmhS7NNUXJg=; b=gwWmWQ2ztpgmGYMH6ykKTXRk4h
	UnnqDcpvwiU5oaJlkvnnXoO/TuvI+/j4RzbgIuEQWag/R++AfKJ+o/rqeA6pRO6oJpT3B2zCFVZjp
	zcumKJCW9PYiJVVEFuQ1wAlQfPco7iOfsHJF3++A2sOZpNXmRPFPvgXUogQsbhfQvj5iY4U4MsC4/
	58vtWz5Vl0V/NGor0cRT5eftN2l+Lnq1wGQXOdWl6PWyVpXHki73rfMqRsQutMQ2eoCXuPCwD/qvd
	WTkhEhtEpAbGOQJuReHmUHec7NChyAYmmvy9phMkoLGA45fSn2jWZcv19SS1Sq2pxJ+Y10LmQgcRj
	SdwxWJIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um66d-0000000CxRC-2SxC;
	Wed, 13 Aug 2025 07:41:07 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um5Ml-0000000CqX9-1azF;
	Wed, 13 Aug 2025 06:53:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hm2PPtsNJuhxIDGNuJHriEQn1/qO4cQcfmhS7NNUXJg=; b=Wiz2DxV1z9TM0lkmOxo+TJ4Vyd
	qaiPgAgUlzH3xCeLVoqdhjk7kJp8cMmXYoXTwPYofwtXHrSvl9ppyTshskwHpMRPhlYCPhUJMpTsW
	+vVSXhupFsOFNuR4VbYt3owuewFlVzfQcb1JsbZ7Jiusct2xvleX1CdDxxTvJ8BJ1TnX+j6e+Ku7s
	y56pYVKPdxxRHSymM6lmpFG4sirXoAdBByGwJP5wHvqMg3ug2hH7dgBGlDuYBWTuO7R6N29I3aSAW
	+sDrkOErZO7FCVjKQYxCFBUQuHjT2Z9MS7ggd9RMaGQLx4GQeZLgzzsSedW2k5IyAZs9+AnXrvVq1
	8O4crq/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um5Mb-00000006n9D-1KiH;
	Wed, 13 Aug 2025 06:53:33 +0000
Date: Wed, 13 Aug 2025 07:53:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] VFS: introduce d_alloc_noblock() and
 d_alloc_locked()
Message-ID: <20250813065333.GG222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-12-neil@brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-12-neil@brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_235343_418209_32541C5B 
X-CRM114-Status: GOOD (  20.86  )
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

On Tue, Aug 12, 2025 at 12:25:14PM +1000, NeilBrown wrote:
> Several filesystems use the results of readdir to prime the dcache.
> These filesystems use d_alloc_parallel() which can block if there is a
> concurrent lookup.  Blocking in that case is pointless as the lookup
> will add info to the dcache and there is no value in the readdir waiting
> to see if it should add the info too.
> 
> Also these calls to d_alloc_parallel() are made while the parent
> directory is locked.  A proposed change to locking will lock the parent
> later, after d_alloc_parallel().  This means it won't be safe to wait in
> d_alloc_parallel() while holding the directory lock.
> 
> So this patch introduces d_alloc_noblock() which doesn't block
> but instead returns ERR_PTR(-EWOULDBLOCK).  Filesystems that prime the
> dcache now use that and ignore -EWOULDBLOCK errors as harmless.
> 
> A few filesystems need more than -EWOULDBLOCK - they need to be able to
> create the missing dentry within the readdir.  procfs is a good example
> as the inode number is not known until the lookup completes, so readdir
> must perform a full lookup.
> 
> For these filesystems d_alloc_locked() is provided.  It will return a
> dentry which is already d_in_lookup() but will also lock it against
> concurrent lookup.  The filesystem's ->lookup function must co-operate
> by calling lock_lookup() before proceeding with the lookup.  This way we
> can ensure exclusion between a lookup performed in ->iterate_shared and
> a lookup performed in ->lookup.  Currently this exclusion is provided by
> waiting in d_wait_lookup().  The proposed changed to dir locking will
> mean that calling d_wait_lookup() (in readdir) while already holding
> i_rwsem could deadlock.

The last one is playing fast and loose with one assertion that is used
in quite a few places in correctness proofs - that the only thing other
threads do to in-lookup dentries is waiting on them (and that - only
in d_wait_lookup()).  I can't tell whether it will be a problem without
seeing what you do in the users of that thing, but that creates an
unpleasant areas to watch out for in the future ;-/

Which filesystems are those, aside of procfs?

