Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E67C19F32
	for <linux-um@archiver.kernel.org>; Wed,  5 Mar 2025 11:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H2YFR/HuXDQlBqaU9nbiRfdN/QrOHdj5Aj3WyqXX10M=; b=RSSA8OI6Yd4xUN8DOZj0XqWnwh
	uPSxmUjWaExtqms8AbOA1Mbno7KmqC4hDX6c/5n4jbqtGqG7ercpGbwVoLbUarG4xnSdvxaTpvx+a
	xletMosNMep0/7Mt+i24NNlzFrR1sPV38lGeik6dYHEU6l1Ldduz4hHJMpv2mmqHY8CWzVWSchA37
	xgR50mz8AL47eB+ExKSZXg31rbo1Yt3/YT6tXXhE8+iHjtCT48hYBpObGiNzOB0CyT7nfYiLEYXqP
	v01GcnbSi4tD3hLPLDE4cuDK+MDWAC5qxh1bItAOUCc9mUFWqiLm/E6sGwdq/ZOUTK/bt/4bmyVb6
	oL/A80ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpnER-00000007uTi-21eY;
	Wed, 05 Mar 2025 11:48:11 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpmNl-00000007krE-0WEF
	for linux-um@lists.infradead.org;
	Wed, 05 Mar 2025 10:53:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 80A63A45537;
	Wed,  5 Mar 2025 10:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03325C4CEE2;
	Wed,  5 Mar 2025 10:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172023;
	bh=CyQYA8QT/E8saZLnr8xc7a8hcGKPEF3OXhBq+CgiyV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GbrRUreFzF/8gWZ1gw8kq5+1oWNigoTczo7f8761DaHStemr0sBPjIFnQFM6H9Kih
	 fjOtGawlN2afh472awfTFId60JqWqBZohE2cCTk/dVE6WMzcLafLuDPYsoe3LYmkxN
	 +Dndx4cJyzqoeG76eVt0uk+aPh5gJiNwAW02GcofjnDMGNrSESCVrCScpbgE4SMiro
	 MrGLd4o9FPpfmg3V1Vr4Mg0BWZKdl9+WdyuvH5QTUBgzVDzyfTx64UD0n1dmnG/aXp
	 Tw6O9i3pStjmMcvnO84e99rU7s4VzyKe4W8+5OKZDGaE7DMPysM5uXp7V8+fEC2WQe
	 34j/D3gVZi+FA==
Date: Wed, 5 Mar 2025 11:53:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, 
	Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6 - REVISED] fuse: return correct dentry for ->mkdir
Message-ID: <20250305-bannen-zugriff-cd7508258062@brauner>
References: <>
 <CAJfpegtu1xs-FifNfc2VpQuhBjbniTqUcE+H=uNpdYW=cOSGkw@mail.gmail.com>
 <174112490070.33508.15852253149143067890@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174112490070.33508.15852253149143067890@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_025345_236711_EC4B7807 
X-CRM114-Status: GOOD (  17.80  )
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

On Wed, Mar 05, 2025 at 08:48:20AM +1100, NeilBrown wrote:
> 
> Subject: [PATCH] fuse: return correct dentry for ->mkdir
> 
> fuse already uses d_splice_alias() to ensure an appropriate dentry is
> found for a newly created dentry.  Now that ->mkdir can return that
> dentry we do so.
> 
> This requires changing create_new_entry() to return a dentry and
> handling that change in all callers.
> 
> Note that when create_new_entry() is asked to create anything other than
> a directory we can be sure it will NOT return an alternate dentry as
> d_splice_alias() only returns an alternate dentry for directories.
> So we don't need to check for that case when passing one the result.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/fuse/dir.c | 48 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 17 deletions(-)
> 
> Thanks for the suggestion Miklos - this looks much better.
> 
> Christian: could you please replace the fuse patch in your tree
> with this version?  Thanks.

Sure, done so now. Thanks!

