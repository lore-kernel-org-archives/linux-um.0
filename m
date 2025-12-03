Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621F8D1269B
	for <linux-um@archiver.kernel.org>; Wed,  3 Dec 2025 10:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i9QD6HVcKhaudvgQUmcrPWxae5Gbkj5XejxdA7YCuNM=; b=CDWKmqsYW2LkJKGJo9JGc6z5vG
	nJpRkEjtsAxFH2wIhU2Ekw40VMTm/c2oq+dP+OAeu0fPz0T7IZlOxuEtxWi69B1PCNXo0DrV0AKOC
	l2L8ru+i19jnrd0FlmiyG23HBidRxzI87MDZzCEwbWGXS0Y5JAP2KNQ7QW4f1ESD61woTg9hbvn3e
	76PDQoE2HW8MBVEehiLNyXvKmRnho5a7hYPBkPvW+/Zd4q8sZ2CEBzEIPXWn+hScmnzpEuz3QaNTB
	jD4OpaCDedJym0XaMQ7ta6BqAnqcF84pGRRvCD9uwBHk6jcbmZApp3WMtfvCG1HfqWXnA0B+fQ/sz
	wmf2yS8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQjx6-00000006RbL-1hBs;
	Wed, 03 Dec 2025 10:19:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQjx2-00000006RaZ-3vhG;
	Wed, 03 Dec 2025 10:19:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BE02C40235;
	Wed,  3 Dec 2025 10:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25361C113D0;
	Wed,  3 Dec 2025 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764757150;
	bh=1ALGFmGlgOHY6f+bdLdgKebsX+au1yQ5dTRhimTaFoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sia1MYILwN3OHyU8vJVbFzEbPmh+E9Rkdc13NmENJiNAQwujMzrx7aLJDYQwnRJH2
	 icv0Cs7+2DiJlUtJrJ3jFjsxz5e5SC+H4b4cDPm/4/s+aTZepyO4AvrHMcRjPs8po7
	 P0lAluHlqilBXk1Sh/B/XN0TZMdipTL7EolZ0FehsZ8XGO0/aidHMHK8ayQiiiT5TA
	 U6OOgYna9Ec2DgYD68Hcv9/StfMLZVIApf1YAZumWdYivMJy+S1b4NF19fKc5R60wD
	 vv/cJLS0nI7ttPeXB8OyKOFM1iSYjxfn/4avfs6o2Xu7czGUpIFQziUIbMv79dw+WM
	 YExRE41C2xh0g==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@ownmail.net>,
	linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	ecryptfs@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	gfs2@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net,
	linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	devel@lists.orangefs.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-xfs@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Chris Mason <clm@fb.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Tyler Hicks <code@tyhicks.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bob Copeland <me@bobcopeland.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Hans de Goede <hansg@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RESEND v3] vfs: remove the excl argument from the ->create() inode_operation
Date: Wed,  3 Dec 2025 11:18:32 +0100
Message-ID: <20251203-sechzehn-lethargisch-cd739d4ff49a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251201-create-excl-v3-1-8933a444b046@kernel.org>
References: <20251201-create-excl-v3-1-8933a444b046@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=brauner@kernel.org; h=from:subject:message-id; bh=1ALGFmGlgOHY6f+bdLdgKebsX+au1yQ5dTRhimTaFoA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQa8NXdfyOWEe7C1j7j3H39MtmOfckhfYU3uPbO3GJ5W X9idSdfRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER6JjEyXElxiNLjXsTcG/zF veHQZtE3X3LuXMnZx/2vIaPja/5RBYb/9Vo7JnHefOS2MX2Dr5zm5id7fnmJz3GXVk7n4Wu5Kpf KBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251203_021913_043409_864E0287 
X-CRM114-Status: GOOD (  14.28  )
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

On Mon, 01 Dec 2025 08:11:42 -0500, Jeff Layton wrote:
> With three exceptions, ->create() methods provided by filesystems ignore
> the "excl" flag.  Those exception are NFS, GFS2 and vboxsf which all also
> provide ->atomic_open.
> 
> Since ce8644fcadc5 ("lookup_open(): expand the call of vfs_create()"),
> the "excl" argument to the ->create() inode_operation is always set to
> true in vfs_create(). The ->create() call in lookup_open() sets it
> according to the O_EXCL open flag, but is never called if the filesystem
> provides ->atomic_open().
> 
> [...]

Applied to the vfs-6.20.mkdir branch of the vfs/vfs.git tree.
Patches in the vfs-6.20.mkdir branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.20.mkdir

[1/1] vfs: remove the excl argument from the ->create() inode_operation
      https://git.kernel.org/vfs/vfs/c/7d91315b4335

