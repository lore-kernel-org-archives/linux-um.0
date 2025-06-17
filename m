Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31FEC77B7F
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 21:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VadYNfxPDS9mWpWiEQHS/5/7snz8zXTvd9oaZpSDKWQ=; b=pfPehXtH8pAiiaC4FTj/L23u9j
	m/ftPWau42GISo3qNjF6gxxMnc+yR2UnwccLUCmNk6dLRW4fo+9Us3ULkOh9QYE6gdvT8Zq8o7NzA
	0yL06U4azQHI1Yj1IsRDHGgfi81y6NV1RIA8x/fAe/D+6w4ilqurWdXIKrAyQra202vWy1fkpSAwH
	csEoxF1Sgjo99haq2ciSx9UK3SZGvT2WmxDPW1XKJSMSvCsFF9x94wQPSxkGdDEIbw8cnohSE+Rfy
	whXcY/Tm5AX+lC/bp1Ky0oZJqOzv4Si66tpf3HHEf5QsSAh6h8nPNXD+GDU2dzzqX2A80M/pfQ+a5
	TYtYfBcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSMrh-0000000EItl-2YWB;
	Thu, 19 Jun 2025 21:32:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRUz7-000000076nD-3PYE;
	Tue, 17 Jun 2025 12:00:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4F92D49D8F;
	Tue, 17 Jun 2025 12:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F729C4CEE3;
	Tue, 17 Jun 2025 11:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750161613;
	bh=d7N8Br27sigUm6RwJ6QKDyuMIfLKb482gs0GJECdYqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbm6eSpOXnYTKVf24fD5wSecYeYAtaJSPLtzA/cg7YuA4PJRPYSNZqoHGrOB9vedO
	 xE+Kw4QDbA/4jdsP7oXbPhVrMP5XKHSj57b+LizHRuDadEPqGBM+ZxF2QhTJG4KKld
	 niMYuWEWwMHm5apCVpkqg1uA/sm57a3OJs6XP47Q03JuvcLdBMJ4BZLJME8mGFpquF
	 OAV54y1YNZFqwgygvgnolLyQkxdfAP1bT54VMRT4yd/LwvYOK0H78h2s/9FU+jHgJZ
	 /1P5yb/ScvLTgMkRASvu83CdtUFgXaGEFmmqSgC4JGFIOk41SmtzQEJEUL45wKXKIE
	 copUCuL9W6X/w==
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Tigran A . Aivazian" <aivazian.tigran@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Tyler Hicks <code@tyhicks.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
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
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-aio@kvack.org,
	linux-unionfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	ecryptfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-um@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net,
	linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	devel@lists.orangefs.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-xfs@vger.kernel.org,
	nvdimm@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/10] convert the majority of file systems to mmap_prepare
Date: Tue, 17 Jun 2025 13:58:21 +0200
Message-ID: <20250617-neugliederung-erarbeiten-58c2ad93db83@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2454; i=brauner@kernel.org; h=from:subject:message-id; bh=d7N8Br27sigUm6RwJ6QKDyuMIfLKb482gs0GJECdYqY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQERqz1Wd3by3g/duuF6rmP/N/MPRV+t8Tf5qpaV67t4 jKOJ7rXO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaysIiRYfKb1+w2vf8O/mdg vPFO8PHqRzML+F0vTZYp4bqm1fwkeyXDP4PuJqblPl9UmcRtf/n65jge6ap97PLc+43T4+kid/k fMgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_050013_927012_2BD53EA8 
X-CRM114-Status: GOOD (  16.04  )
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

On Mon, 16 Jun 2025 20:33:19 +0100, Lorenzo Stoakes wrote:
> REVIEWER'S NOTES
> ================
> 
> I am basing this on the mm-new branch in Andrew's tree, so let me know if I
> should rebase anything here. Given the mm bits touched I did think perhaps
> we should take it through the mm tree, however it may be more sensible to
> take it through an fs tree - let me know!
> 
> [...]

This looks good. I fixed up the minor review comments.
Looking forward to further cleanups in this area.

---

Applied to the vfs-6.17.mmap_prepare branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.mmap_prepare branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.mmap_prepare

[01/10] mm: rename call_mmap/mmap_prepare to vfs_mmap/mmap_prepare
        https://git.kernel.org/vfs/vfs/c/20ca475d9860
[02/10] mm/nommu: use file_has_valid_mmap_hooks() helper
        https://git.kernel.org/vfs/vfs/c/c6900f227f89
[03/10] fs: consistently use file_has_valid_mmap_hooks() helper
        https://git.kernel.org/vfs/vfs/c/b013ed403197
[04/10] fs/dax: make it possible to check dev dax support without a VMA
        https://git.kernel.org/vfs/vfs/c/0335f6afd348
[05/10] fs/ext4: transition from deprecated .mmap hook to .mmap_prepare
        https://git.kernel.org/vfs/vfs/c/8c90ae8fe5e3
[06/10] fs/xfs: transition from deprecated .mmap hook to .mmap_prepare
        https://git.kernel.org/vfs/vfs/c/6528d29b46d8
[07/10] mm/filemap: introduce generic_file_*_mmap_prepare() helpers
        https://git.kernel.org/vfs/vfs/c/5b44297bcfa4
[08/10] fs: convert simple use of generic_file_*_mmap() to .mmap_prepare()
        https://git.kernel.org/vfs/vfs/c/951ea2f4844c
[09/10] fs: convert most other generic_file_*mmap() users to .mmap_prepare()
        https://git.kernel.org/vfs/vfs/c/a5ee9a82981d
[10/10] fs: replace mmap hook with .mmap_prepare for simple mappings
        https://git.kernel.org/vfs/vfs/c/a1e5b36c4034

