Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710B1C3DA7F
	for <linux-um@archiver.kernel.org>; Wed,  7 Aug 2024 09:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=60H60kILv9Bav9pTakzp3GjJPhswXxdFsUwDJslrUzY=; b=SZAN2aLcWtAH2uVx8HCA1l1MkZ
	65Ig/1thk6aL1JbIbV30jyOyMuHnSI7RdsAdabsyQCuopumy/Y1jYDWjfORYlhA6b59ESs/+2gUiv
	SRBZTKJT3UJOr8ElSUEzKh7RChNhw2V5naHKnzT5oeZAlBuULYTIa0/GKebhvlq6f9Q4010LZnVOd
	ytJ5G6ZQTUkcvYRGhKOA85vz7xNlhapZ2x8H32v62P2+pE+Akp6YvnBdbCxJHxvyav/qPNpUQ1Rsf
	IXBiKOnhqh6qZ1/QF1M1UPzA1S34sN38lxwe3Xw0QClYY72VqIfJmnZJp5H/IxZqG1KpqfvWdIOl1
	O/V0BxkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbd5U-00000004a8o-42X5;
	Wed, 07 Aug 2024 09:36:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbd5R-00000004a7E-2S9r;
	Wed, 07 Aug 2024 09:36:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A161561127;
	Wed,  7 Aug 2024 09:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42EDC4AF0B;
	Wed,  7 Aug 2024 09:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723023364;
	bh=SIN474AVw4y1MoDQyBN2l9zLDxAG8yJpM+IZg/xSlBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btbhCRAZArjLvUl8j5Ej+vHzQoO1vTjwqrNsQBIT0/x406nNG6tlbPi9O+sN17d4Y
	 QICBpuxQ5Bjmn0gXNfW6CQYVZcH8G9ejnTHAA9QFo2zZkYlDWAI6Ot2tDmga9anM+b
	 WGgtBA/ZIv47FtykXIpoPT2AFtuvlcGoPU21CF4LWL98hI/ZRbIPlQfOtpM6SjubXy
	 OlCR91eQljQjrJdxLmEtfQYDLsvKApDB3/uWNI88bc+X4QiyQeaPCNomUP+ive0rEL
	 gGm3BEKgE3wm60LcEtCDTOpcEofl8MTOn6i7t19oigLeiBJBu3URtJDBmLKsiEuJyf
	 nO0JARebaxVPA==
Date: Wed, 7 Aug 2024 11:35:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, linux-bcachefs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, reiserfs-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [fs]  cdc4ad36a8:
 kernel_BUG_at_include/linux/page-flags.h
Message-ID: <20240807-fazit-bergbahn-25781f6167b7@brauner>
References: <202408062249.2194d51b-lkp@intel.com>
 <ZrLuBz1eBdgFzIyC@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZrLuBz1eBdgFzIyC@casper.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240807_023605_707505_F3C82DDC 
X-CRM114-Status: GOOD (  10.26  )
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

On Wed, Aug 07, 2024 at 04:46:15AM GMT, Matthew Wilcox wrote:
> On Tue, Aug 06, 2024 at 10:26:17PM +0800, kernel test robot wrote:
> > kernel test robot noticed "kernel_BUG_at_include/linux/page-flags.h" on:
> > 
> > commit: cdc4ad36a871b7ac43fcc6b2891058d332ce60ce ("fs: Convert aops->write_begin to take a folio")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master 1e391b34f6aa043c7afa40a2103163a0ef06d179]
> > 
> > in testcase: boot
> 
> This patch should fix it.
> 
> Christian, can you squash the fix in?

Yep, done!

