Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA91C77B7A
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 21:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lIpP5iOY84H59tRkmuJOo9CYvchrtq9t6gV5oxKPio4=; b=3EqG7VHJ2nHckqgfyvUnm71o3k
	CcyXm0Z7wHYPaBQChsn15KD+XVSYuYbwSbcFQoPJ/3A2HD16TCUVr5SbJbik17pnyaGUlwQDO9OLA
	8hlUae/I2AOy+wKssyHF7u/23SPEU9Uq/nQ6iBYUkAM7HRWZ9y+G8VeTGHoZqiORpO+5HaZNc878T
	bywuRQ/Sp2yLDYSmcPfC+chdgz1JZNItWUeVbVXHzsgxvdF80K8stHqp5bGQ1Qvk3z/YJj4JXLFVP
	mMJcvHvxmYZVnK5ERNS6N2AOWY2C8vzHcG0OtOnkMOXWIMv04/SP9IiTWg53V+hm9dznIfyefyi/L
	+X8iTMNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSMrg-0000000EIt3-31Z4;
	Thu, 19 Jun 2025 21:32:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRUnn-0000000750I-309I;
	Tue, 17 Jun 2025 11:48:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E682744DD6;
	Tue, 17 Jun 2025 11:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C6FC4CEE3;
	Tue, 17 Jun 2025 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750160910;
	bh=Vnr3kmvDQPz8s5uZNmSkWKP9XPj/+f6PNSLS1Tx/MzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i76Wd947DS4XwAcDpAS8fpuf+Ela4lfUx5B4Zl+sE1WJ8kzwgrCbFciE3rigUUS/6
	 wkwvrTbKDnBSYG4C5HYytRyvy7B3ZkCeJ/5F35ij31zEXxn65NXesNNhKSYHlLq/2D
	 R33NY8eYZWteN9O+9G//EUF0UQxUiz+Y2C7gC+ejd2PqldQ355joR8oksRp/9Bu+B9
	 HCJ+eqE2ygFdOjJuUuFVDO+rKmgk2g66UaZmVaAWhJlsobI+L+ldnr5kvasHnLLQtL
	 3ZDhNpWvRvvYFALgNe61XXKpKO8zT2d+3DmY+NeMp1GFEAHy45cWCYw7RMgE+f8kCe
	 WOUfPvP6PlRuw==
Date: Tue, 17 Jun 2025 13:48:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Benjamin LaHaise <bcrl@kvack.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Tigran A . Aivazian" <aivazian.tigran@gmail.com>, Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Dave Kleikamp <shaggy@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Hans de Goede <hdegoede@redhat.com>, 
	Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-afs@lists.infradead.org, linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-mm@kvack.org, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH 03/10] fs: consistently use file_has_valid_mmap_hooks()
 helper
Message-ID: <20250617-mitstreiter-bewahren-455b96bd1d50@brauner>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <b68145b609532e62bab603dd9686faa6562046ec.1750099179.git.lorenzo.stoakes@oracle.com>
 <aFD5AP7B80np-Szz@infradead.org>
 <b91c387e-5226-4c5e-94c3-04e80409ed62@lucifer.local>
 <kzp4cei5qq6gbtzzng7hmqj5avzblopfzzrks4e2gahcdvr7ro@cwziankavxw4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kzp4cei5qq6gbtzzng7hmqj5avzblopfzzrks4e2gahcdvr7ro@cwziankavxw4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_044831_794127_6018DD56 
X-CRM114-Status: GOOD (  22.94  )
X-Mailman-Approved-At: Thu, 19 Jun 2025 13:21:43 -0700
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

On Tue, Jun 17, 2025 at 12:08:13PM +0200, Jan Kara wrote:
> On Tue 17-06-25 06:25:34, Lorenzo Stoakes wrote:
> > On Mon, Jun 16, 2025 at 10:11:28PM -0700, Christoph Hellwig wrote:
> > > On Mon, Jun 16, 2025 at 08:33:22PM +0100, Lorenzo Stoakes wrote:
> > > > Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> > > > callback"), the f_op->mmap() hook has been deprecated in favour of
> > > > f_op->mmap_prepare().
> > > >
> > > > Additionally, commit bb666b7c2707 ("mm: add mmap_prepare() compatibility
> > > > layer for nested file systems") permits the use of the .mmap_prepare() hook
> > > > even in nested filesystems like overlayfs.
> > > >
> > > > There are a number of places where we check only for f_op->mmap - this is
> > > > incorrect now mmap_prepare exists, so update all of these to use the
> > > > general helper file_has_valid_mmap_hooks().
> > > >
> > > > Most notably, this updates the elf logic to allow for the ability to
> > > > execute binaries on filesystems which have the .mmap_prepare hook, but
> > > > additionally we update nested filesystems.
> > >
> > > Can you please give the function a better name before spreading it?
> > > file operations aren't hooks by any classic definition.
> > >
> > 
> > can_mmap_file()?
> 
> I like this name more as well :). With this patch looks good to me. Again a

Fixed in-tree.

