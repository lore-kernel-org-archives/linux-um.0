Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD491C197BF
	for <linux-um@archiver.kernel.org>; Thu, 27 Feb 2025 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HFPSqa30/UCTiXYb05zzBd7gqUA9X8EQnh2eycJgwh0=; b=DSAa8t9ZuXHQIUtg9xk/iGMw4n
	x49v6Oy4t/gi58meKZPAAugNgLb6j+aUwDku2Hf/DhEklcad4PQIySuoIu1aVQKUI3kQFzABe5ICn
	qF74M3y0anCYM06IAXVxhaAKPdesavLgVDSnUWro4dSSjVY0bBbIDEqkayF0qexBAkl7tus8iMM5W
	4maAAK0uydZe05J+HACjecT9d51+aqA92OWWDFzqQdZKXq19DHDAWkbKNxaoz1xol8R9WOF/6iMW8
	LGdReePtBk8LKpwQ3GE7OJd81pVFEb+T/QP+YUD7fIrfO6e3iGZMA8vrtYAvZJUuFxloYLKzSRuAE
	ePTYUTsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnchI-00000007IaY-1Fct;
	Thu, 27 Feb 2025 12:09:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tncAa-00000007Ctg-3rwV
	for linux-um@lists.infradead.org;
	Thu, 27 Feb 2025 11:35:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D10D55C0F02;
	Thu, 27 Feb 2025 11:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39177C4CEE4;
	Thu, 27 Feb 2025 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740656111;
	bh=f2zhIojI4Naq7mtH4LGVxFe7wqMNQCsUSDGEZbYfv3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHmsJEzQeJeJG7tScJcX1VhaWytUO0RRE7k2SlPy+jtF8TOIoFRVsk6d/cBdEiLZs
	 DofoE9H61qcheY32zoZdi0bcy+yXFYT035Xx3r/n2hZYeyW0vSKLwrGLihaDOWpZuD
	 EBakHOUwTR3K4bgTDlm/ydk/qBBIj1JNOasqhLfmfO0uJfjDhxrLEzEd6fixlKujRV
	 T+8pvVGnaQqr+loSkdvR2vyKWj4HQ7ykfTazivD3118mHJdL6nlEPX/n0AODsZ9YLl
	 t6yt07oSLhHbjs/QIBcIyvB0upxV2VUN9Fx794u66B4mAxPS0nMeNvJ8OrqXT9l0/X
	 +gHgoXuBVpRQg==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/6] Change inode_operations.mkdir to return struct dentry *
Date: Thu, 27 Feb 2025 12:34:53 +0100
Message-ID: <20250227-narzissen-haifisch-2bf97aeb50d8@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227013949.536172-2-neilb@suse.de>
References: <20250227013949.536172-1-neilb@suse.de> <20250227013949.536172-2-neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=brauner@kernel.org; h=from:subject:message-id; bh=f2zhIojI4Naq7mtH4LGVxFe7wqMNQCsUSDGEZbYfv3E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQf8H36MVdGktGBUeTtOpUDH6Z3nzud3NchrNJcaKAe5 ZFgJ7W+o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKvVzP8T0rZ+3L6lG+Sa0r7 t+/ewD2DjzHD5ceFDoeNC1dZSxxTW8Dwm+2dn6h/yOv5e9L3xmv6XD0d7HZuWQZfgadE7vqXKze lcwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_033513_034327_3BDD2327 
X-CRM114-Status: GOOD (  14.80  )
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

On Thu, 27 Feb 2025 12:32:53 +1100, NeilBrown wrote:
> Some filesystems, such as NFS, cifs, ceph, and fuse, do not have
> complete control of sequencing on the actual filesystem (e.g.  on a
> different server) and may find that the inode created for a mkdir
> request already exists in the icache and dcache by the time the mkdir
> request returns.  For example, if the filesystem is mounted twice the
> directory could be visible on the other mount before it is on the
> original mount, and a pair of name_to_handle_at(), open_by_handle_at()
> calls could instantiate the directory inode with an IS_ROOT() dentry
> before the first mkdir returns.
> 
> [...]

Applied to the vfs-6.15.async.dir branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.async.dir branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.async.dir

[1/6] Change inode_operations.mkdir to return struct dentry *
      https://git.kernel.org/vfs/vfs/c/10a5b48c3eeb
[2/6] hostfs: store inode in dentry after mkdir if possible.
      https://git.kernel.org/vfs/vfs/c/28d16ecaa2a8
[3/6] ceph: return the correct dentry on mkdir
      https://git.kernel.org/vfs/vfs/c/948ec6393e44
[4/6] fuse: return correct dentry for ->mkdir
      https://git.kernel.org/vfs/vfs/c/ef04f867aeb2
[5/6] nfs: change mkdir inode_operation to return alternate dentry if needed.
      https://git.kernel.org/vfs/vfs/c/5ca75f993a4a
[6/6] VFS: Change vfs_mkdir() to return the dentry.
      https://git.kernel.org/vfs/vfs/c/9cdf09f608d0

