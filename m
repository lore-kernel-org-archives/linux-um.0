Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731A1CCFA18
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 06:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LTM5LkyL3mfB0IbHJeS1oRharyj4iNDNdaZ7y5irjmg=; b=e3xktkxu9GqPXd9+kyS44/+hEI
	ijCCM1Ki3nHt/ffoK1cyGXKUqCVv0eYNKy/uADNi3gCDTgpQclagXq1ifikzVU6mp+WojC3V17PR9
	dwKCMCQ2AbDRUiJypP4QPHBpRP1yUH6eXgYOzqCMIVl8gixfk74+6ZMw/9dxtbf7tR42XnP593KTZ
	neyxRzMJpBqCJQrb0noHvWgXYkJOFLn7UnffHBSvuC8IH3aABMir5cUwz0oN8l1/xNu0QwzrZlxFp
	TC2QuQCC368mzGDIeDNmy/Y+uB2q6VgiE+6J58sWWKjVUXstDkaZYOBkbn5K4tKYyepOlc9ymIP8r
	XXFpP+eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHcC8-00000002aMU-1gl3;
	Sat, 08 Nov 2025 06:13:04 +0000
Received: from submarine.notk.org ([62.210.214.84])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHcC4-00000002aLm-2aHl;
	Sat, 08 Nov 2025 06:13:02 +0000
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A419014C2D3;
	Sat,  8 Nov 2025 07:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1762582373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTM5LkyL3mfB0IbHJeS1oRharyj4iNDNdaZ7y5irjmg=;
	b=B+D3byKtJ5aLyRiu2rooP0B2TJlyh9NnWKaBHKY3oGl5WrI9R/ZTOokRqfrmQkRjA4d6PF
	hVA+2jtaIxDHKJVm19YOlIu00RJFzbMjiJ2IJMY5v8SjTtfCjEZWBxEPfRtzuPasj++KiY
	8Sahe5eVbfmwmhQeo5uzL3Rp7AKK7Nzr7m3ipU5qmaiTEStLej1x9iBcfVqKnY9WidAi8X
	rwVB6qqUGBZMEcUSkoPWBbqf240gmgWcLbAb7B4RNHuho0O1rPy72OuweBfiXGGrgaJqO1
	amO1aDXHVrMyRWIApKs7c+o9NFvUODZZvMkcXugNCGdZ2S65dzPgh2BACKmoHA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 26a2c8b4;
	Sat, 8 Nov 2025 06:12:25 +0000 (UTC)
Date: Sat, 8 Nov 2025 15:12:10 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Chris Mason <clm@fb.com>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>,
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bob Copeland <me@bobcopeland.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Hans de Goede <hansg@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	NeilBrown <neilb@ownmail.net>, linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
	ecryptfs@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	gfs2@lists.linux.dev, linux-um@lists.infradead.org,
	linux-mm@kvack.org, linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-xfs@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] vfs: remove the excl argument from the ->create()
 inode_operation
Message-ID: <aQ7fOmknHIxcxuha@codewreck.org>
References: <20251107-create-excl-v2-1-f678165d7f3f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251107-create-excl-v2-1-f678165d7f3f@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251107_221301_072936_674B4C53 
X-CRM114-Status: GOOD (  18.36  )
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

Jeff Layton wrote on Fri, Nov 07, 2025 at 10:05:03AM -0500:
> With two exceptions, ->create() methods provided by filesystems ignore
> the "excl" flag.  Those exception are NFS and GFS2 which both also
> provide ->atomic_open.
> 
> Since ce8644fcadc5 ("lookup_open(): expand the call of vfs_create()"),
> the "excl" argument to the ->create() inode_operation is always set to
> true in vfs_create(). The ->create() call in lookup_open() sets it
> according to the O_EXCL open flag, but is never called if the filesystem
> provides ->atomic_open().
> 
> The excl flag is therefore always either ignored or true.  Remove it,
> and change NFS and GFS2 to act as if it were always true.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Good cleanup, just one whitespace nitpick below but:
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>


> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 4f13b01e42eb5e2ad9d60cbbce7e47d09ad831e6..7a55e491e0c87a0d18909bd181754d6d68318059 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -505,7 +505,10 @@ otherwise noted.
>  	if you want to support regular files.  The dentry you get should
>  	not have an inode (i.e. it should be a negative dentry).  Here
>  	you will probably call d_instantiate() with the dentry and the
> -	newly created inode
> +        newly created inode. This operation should always provide O_EXCL

This and the block below change halfway from tab (old text) to spaces
(your patch)

Looks like the file has a few space-indented sections though so it won't
be the first if that goes in as is, the html-rendering doesn't seem to
care :)

Cheers,
-- 
Dominique Martinet | Asmadeus

