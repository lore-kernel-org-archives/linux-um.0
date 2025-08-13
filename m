Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBF4C87FCF
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 05:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KjOxKUPYOtNCnCd/lus2iP6rL3ZLot/rSauSdHj7XKM=; b=bFonHXsonEl5RllAHUzthacdZy
	bCmNaw7XjKKjmw4yhH/rRkK47MjL631EffPI99+m0yRP20ZBgplOZxuNOug/X/hMRLZOiI1u06bws
	iVtezAB/Eme9gLr5ZOm5DPh8MtvX0kE3Xgg/UsWcLcJ0Lu4y2quUNMwox6Kd019g/5Fau2f7pOg8+
	uRGWE9/5iVXqwWnxwtdzjdDpR+UgP0Pa8QtCvdpXjFH+icRZ7VB9PBxoW1tZ942YhefkpicdeC8np
	NRanSBMO/wFpCG07S8aHv6dgQ7RKBhz5eHpii09Em/oinxsw4JCGSIs25GIh9OHGnZDlwsjFLFpCV
	Fr24Oz3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um3uE-0000000Ce78-2iWw;
	Wed, 13 Aug 2025 05:20:10 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um3uC-0000000Ce6h-1PD1;
	Wed, 13 Aug 2025 05:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KjOxKUPYOtNCnCd/lus2iP6rL3ZLot/rSauSdHj7XKM=; b=iTDCL4fxLjR1WN6UEkahPvC+Y2
	GNjJps5E4fZouWLRmdQbBwPPH1mCH8GZuT1VtFvidzQL9pFIjrGIy8ger7QFw7qUyB6DSxBFMCmOF
	LWPLns4WENW88IC5y4vnenhiTfcrGz8QaFmiqlZW4dgt3+6URBn25Y2dWP0fnObUcRYE8u8S8Js5y
	356r4/zM5bVk/SCK07iXGFW/ISD/v++GRjYnfAAg17BYdfFru3K+z/kofWvdZPtyUz04rBR64zWhV
	xRBFvJ9qCQ9oZR61+VgVm7T7iOng5g5A6eo9EhDBsPuoLLKcGhLWYsTuqHrwQk8XzDEDDy/1Shto+
	7gs0hgMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um3u1-000000060h7-0Shj;
	Wed, 13 Aug 2025 05:19:57 +0000
Date: Wed, 13 Aug 2025 06:19:57 +0100
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
Subject: Re: [PATCH 10/11] VFS: use d_alloc_parallel() in
 lookup_one_qstr_excl().
Message-ID: <20250813051957.GE222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-11-neil@brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-11-neil@brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_222008_370992_395BAE75 
X-CRM114-Status: UNSURE (   8.48  )
X-CRM114-Notice: Please train this message.
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

On Tue, Aug 12, 2025 at 12:25:13PM +1000, NeilBrown wrote:

> + * If it is d_in_lookup() then these conditions can only be checked by the
> + * file system when carrying out the intent (create or rename).

I do not understand.  In which cases would that happen and what would happen
prior to that patch in the same cases?

