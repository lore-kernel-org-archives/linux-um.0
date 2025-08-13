Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A403C87FCF
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 04:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u67lLptIlOEVkxY+UQlg96GCCWG+NT0y06EWpooB788=; b=A+u1HmhXX25N5+KwUSSsslN5Wr
	bUhpVK7etiz2qErCePTjnby5Ziepzbg+X4oyEdhvNSZFegxMVvSBh8QuZEsKyzhKH4QyFlgp41f1P
	SyPhu9tFB8H5DtMeE1c7TqV5WCUbCZRdfKfdv/dS9AMwa08NNU8HtVsff3/uYP/vurfO2HElEgRtJ
	TfGGxDVLC9XwA4sFRPF16NpXdM72H+flId4op16vqIKxPipTBR4qdy+h7myt+bJyqOsJOI7YM8Z8O
	oO2u8LcQrr3OrqSLRp4Nv+mRLXH+ZjoUPAD5f5b8cwFjrsLissZ6yY8rcyEYxXY889Ro3izHYmejb
	btebZb7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um3EG-0000000CbDl-1Jj6;
	Wed, 13 Aug 2025 04:36:48 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um3EE-0000000CbD6-2Ht1;
	Wed, 13 Aug 2025 04:36:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u67lLptIlOEVkxY+UQlg96GCCWG+NT0y06EWpooB788=; b=fXl1pxUqejYMr0pZigsVgjV9dO
	UVRUzITj4tWVCcrNPDrkv4fTBmHF5mrwx5dch9Q+Ly2ivOfzIAFPHMN7920ewFr+J1eIX/OzkFBmK
	Hkjt7ZZC2jPRWuF/98XqkLo0757agn67cEXeqZP2Hch2garqdZZZX3PMzDoRGIObmtAGoM9478kxa
	6esiN9Rhmuto6ThcBOjGN922Nic67jJ05CTrlwOIjQPch+Xb9Sh1Al2CrP+iAsOGCZxAv9IfanyyS
	hOqkxPjiR4r4598Kg1FaoBYFzrtKo3QyBiuefL1CG4Ljecm6yZ11F86Xu7Ho9Vo1ICMHc8yI83LFJ
	CwF4v1sw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um3E3-00000005em9-26h8;
	Wed, 13 Aug 2025 04:36:35 +0000
Date: Wed, 13 Aug 2025 05:36:35 +0100
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
Subject: Re: [PATCH 06/11] VFS: unify old_mnt_idmap and new_mnt_idmap in
 renamedata
Message-ID: <20250813043635.GC222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-7-neil@brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-7-neil@brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_213646_581935_B96E4ED4 
X-CRM114-Status: GOOD (  10.04  )
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

On Tue, Aug 12, 2025 at 12:25:09PM +1000, NeilBrown wrote:
> A rename can only rename with a single mount.  Callers of vfs_rename()
> must and do ensure this is the case.
> 
> So there is no point in having two mnt_idmaps in renamedata as they are
> always the same.  Only of of them is passed to ->rename in any case.
> 
> This patch replaces both with a single "mnt_idmap" and changes all
> callers.

Looks sane and IMO should be reordered in front of the queue.

