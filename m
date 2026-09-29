Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4445ACA5FA1
	for <linux-um@archiver.kernel.org>; Tue, 29 Sep 2026 05:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ql48WTI1DDC42vkQ5aONYMMkjcdFwpalboLPZ35vz1E=; b=d9nlnWg2340hvkhzRZWGFIEVqi
	GQ4jd9FcIt9x0q+x+g+ZT6It7vFMCknU3NVspICoW3sD/fScEfqwX3vySTABWK23/2T8nw3jcjv9k
	59uy2KVKWMEPU3twtt2smRvJD6YbjAllnKUyBLlE3scIsAPe84b1GEN0KnI84rO9UEaEq53SS0Xq/
	arh0UYm+U6ZpXFNXwhXPopQp/XF3Bw5Z2pS8qRXXfx1TQIsBBAiSw5RlL2xfUc0m9NLUxghFY+fXg
	FVeJnrETtz8cQ35oe9ha3sBM5CfqnWPto7fsE2Kk4Eo5StII41k393Ss33tYAdia7lMaP16IoCymu
	j+7HueyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBQ4W-00000002MAm-1dj1;
	Tue, 29 Sep 2026 05:08:08 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBQ4T-00000002M9p-0MJQ
	for linux-um@lists.infradead.org;
	Tue, 29 Sep 2026 05:08:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ql48WTI1DDC42vkQ5aONYMMkjcdFwpalboLPZ35vz1E=; b=Vt8Wl6v9GXqlPdcfnYCxm8QiYp
	IjYDbFvkRSA9EwCbUBHheJvuYZdpImQ8ElWTyxGfzBNWSOW2pO6W+4J4Y1tks26kT+/1ZOyOUbTV2
	LxknNqO7/ieWoGqNfhU/6OiIm+u03J7GX8QRDAzb//I2WHU4oI0/7on5fhJYoFcx/TY3YdWmGFgOj
	4/WzgK4OYYFLnJJZ1H6/D8CD8OvFCYz5m/CT5EO8CcQq6t3LkWaAWZ3HXS+H7Eiz8dY3BcMEfr7b2
	xJxllWNFBc/BuTHZelPBr7MOyE8q5XDulXQDCXIxkADODbw48afqLDdAfkvjLTsbKv4uPDjyQv6ee
	sAjeP0QA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xBQ43-00000002j2z-3GyS;
	Tue, 29 Sep 2026 05:07:40 +0000
Date: Tue, 29 Sep 2026 06:07:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-um@lists.infradead.org, codalist@coda.cs.cmu.edu,
	coda@cs.cmu.edu, linux-mm@kvack.org, ntfs@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/7] configfs: remove d_add() calls before
 configfs_attach_group()
Message-ID: <20260929050739.GB3909609@ZenIV>
References: <20260929034158.1455429-1-neilb@ownmail.net>
 <20260929034158.1455429-5-neilb@ownmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929034158.1455429-5-neilb@ownmail.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_220805_133081_750C71BC 
X-CRM114-Status: GOOD (  10.85  )
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

On Tue, Sep 29, 2026 at 01:36:04PM +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> These d_add() calls cannot be necessary.  The inode given is NULL so all
> they do is attach the dentry to the hash table.
> 
> If configfs_attach_group() fails, then d_drop() is called so the dentry
> will be detached.
> If configfs_attach_group() succeeds, then
>  configfs_attach_group -> configfs_attach_item ->configfs_create_dir
> must have succeeded, so d_instantiate() will have been called and the
> dentry hashed there.

Neither in mainline, nor in -next...

d_add() _is_ wrong there, but this is not the right solution.  What
we really ought to do is build the subtree first, then either dissolve
it (without any pathname resolution having ever seen it) or move it
in place once we are sure that everything worked.

