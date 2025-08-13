Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08039CA0EC4
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 05:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e5U3Jru4QvSh+gZ04F1oAlS7nb9ho9LY7nJhfMe2Y4U=; b=yi94uD/VnbP4zlfKm2KZ+KwFy1
	1wN9wrjZVO6CfWs2JeRr3L52WK+bCWSRFQj8eIw4QpUADIds58xXdhxpnj5lMyfCgnP6qrwUxjg0u
	gw53OJGEEKtNSV1o348Zivcs2oKEP+JvxLvGZkcMDuwegFdB2VZmVX5AdKNojabQvt34+uTeiwtv2
	5L6+4TsL2WjoLUKOb67lpDbdwxuekIWbMOEQiUsGN+O67Lw09bDyL+5BZxg8VKevl47gNedi/iTHb
	5hJvv09LrwrG8ECOMgGM8eq6qFzOMPzx/8yl6/loKcxivMmNvv7y1XpDNeXiB4YAh2g5nP/XneLKj
	Pww0Gahw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um3i2-0000000CdPN-1k0G;
	Wed, 13 Aug 2025 05:07:34 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um3hz-0000000CdOu-2BPz;
	Wed, 13 Aug 2025 05:07:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e5U3Jru4QvSh+gZ04F1oAlS7nb9ho9LY7nJhfMe2Y4U=; b=un83pMT3ThYrtWrTPu0bibcpbE
	BhUC6V5s+qnM99OgBU47KW2hMWIdhipx/U9SZn/PdD5iZY3ahTAcXwq0aIxkt/cJakChWWNFTKPg4
	KUV08pYtA3kYj7Qi54yRbxc1ShhWm0mwXMUg8spwnTkBA2O2czkBvvncj4SlMtbpXBh8ZbIJnzhaV
	t3TqAeoDG9jd597x8lKORHvF0/SM6VIUE3IYa0LtNhsmUiE7+0UUNaiBptlPyw+SYYRdhm7rHe2x4
	clE/Z7F1jUQIcL3U0LQCMV7ZGPCCaw1nVh4wbA+er1lwdT2MMj5YKE8J7LmoK82NbdHuiQOaxtcEk
	RoN1I42w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um3hl-00000005txc-0wPb;
	Wed, 13 Aug 2025 05:07:17 +0000
Date: Wed, 13 Aug 2025 06:07:17 +0100
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
Subject: Re: [PATCH 08/11] VFS: allow d_splice_alias() and d_add() to work on
 hashed dentries.
Message-ID: <20250813050717.GD222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-9-neil@brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-9-neil@brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_220731_563273_4B50125C 
X-CRM114-Status: GOOD (  16.88  )
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

On Tue, Aug 12, 2025 at 12:25:11PM +1000, NeilBrown wrote:
> Proposed locking changes will require a dentry to remain hashed during
> all directory operations which are currently protected by i_rwsem, or
> for there to be a controlled transition from one hashed dentry to
> another which maintains the lock - which will then be on the dentry.
> 
> The current practice of dropping (unhashing) a dentry before calling
> d_splice_alias() and d_add() defeats this need.
> 
> This patch changes d_splice_alias() and d_add() to accept a hashed
> dentry and to only drop it when necessary immediately before an
> alternate dentry is hashed.  These functions will, in a subsequent patch,
> transfer the dentry locking across so that the name remains locked in
> the directory.

The problem I have with that is the loss of information.  That is to
say, "is it hashed here" is hard to deduce from code.  I would rather
add d_splice_alias_hashed() and d_add_hashed(), and then see what's
going on in specific callers.  

And yes, it requires analysis of places where we have d_drop()+d_add() -
better have it done upfront than repeat it on every code audit *for*
*each* *single* *call* *of* d_add(), including the ones that are currently
obviously meant to be called for unhashed dentries.

I realize that it's no fun at all - in particular, I'd never been able
to get ceph folks to explain what is and what is not possible there.

I would really hate to have that expand by order of magnitude - in
effect, you make *all* calls of d_splice_alias() and d_add() similar
mysteries.

