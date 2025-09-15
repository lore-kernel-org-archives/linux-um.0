Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CF1CAC59A
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 13:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G1pxbFOuDJsJnBF0m+5CY6Xwwfubv5cFdvznrZJvWPg=; b=wMB/1BjnhvttoKIpez8MR9ML0V
	biNY8iu8Zvj7k5Thc1JIU7+/KmLCuG50Rvjh2AV62XB15b0OTp07FnLZmi3uVmjvF/dZvK40IE4VB
	F56T9C7kpqEp46jKysCzIHU/Ct2RrCfJ+T4yFgr6c78UWsGK2JTURLmm9F+zWWIqUmBC5POYN/r3O
	DpxE8AYJ1j6TXMjJg3mIkSKX+LzY9Jd08yGEfrFiGOdgiyZnRxpU3RCs9jHwYXIUkusPFHKGe8Gpf
	NJS38HmYM5JrgcmpbCAci/gd3JgkgyJVismuEbXYRWESGMFUdiDH1+tTM/7BhBczCzK9oNOvy9q2J
	Vu8g124w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy9Lv-00000004LLK-0sua;
	Mon, 15 Sep 2025 13:34:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy9Lt-00000004LJq-3ds6;
	Mon, 15 Sep 2025 13:34:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9585860237;
	Mon, 15 Sep 2025 13:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06662C4CEF5;
	Mon, 15 Sep 2025 13:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757943280;
	bh=G1pxbFOuDJsJnBF0m+5CY6Xwwfubv5cFdvznrZJvWPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJGZ1vBQTvO1OLFpsKgtQvIkjtAVvJey56ZqhZxYzVB3EDoeucwA9j3Ikra0r96a5
	 jQw9/XHjAdC85R6jORBqXH6OkpLRRmI0UaRxSBMlJTyGu8sObrPf6EYsRHYnpzWABK
	 4guOhpliPb5aYSSJ1cikDCiA9fl38O9CJLfhWdf/1FUDPbaUHhsgjd/BUigP/DwSAR
	 ZgzXa5kZ1LN2Vwu2d8y8wxYWU6XMdt47ld5N4t1CFweo+0HtUX4GHSNgmsq7QjI/jF
	 wghZzlNvaq7LpEjMzkOqler37Pf0I1gD2UiJKUJFEipxphTk6d9TTXloxjbYPhi7oP
	 Dxi908vsrFrMg==
Date: Mon, 15 Sep 2025 15:34:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, 
	initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>, 
	linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
Message-ID: <20250915-modebranche-marken-fc832a25e05d@brauner>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
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

On Sat, Sep 13, 2025 at 12:37:39AM +0000, Askar Safin wrote:
> Intro
> ====
> This patchset removes classic initrd (initial RAM disk) support,
> which was deprecated in 2020.

This is a good idea but the patchset does a bit too much and it's pretty
convoluted and mixes cleanups with the removal of initrd support and so
it's not that great to review let alone merge especially considering
that a revert might be needed.

Split it up into multiple patch series. Send a first series that
focusses only on removing the generic infrastructure keeping it as
contained as possible. Only do non-generic cleanups that are absolutely
essential for the removal. Then the cleanups can go in separate series
later.

As usual I'm happy to try to shed old code but I wouldn't be too
optimistic that we'll get away with this and if so it needs to be
surgical.

