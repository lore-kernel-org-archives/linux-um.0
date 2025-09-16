Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4C6CAC592
	for <linux-um@archiver.kernel.org>; Tue, 16 Sep 2025 03:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=clS/RriAH6/uzgbxBAN8eXzKr1t8+yo2uadqdbTxw+Y=; b=W86UU0i9hgKN4WpAH1S4q14Dd6
	YKu0/uS1h8Og1WfJBJhBWukfRGwDxxColp4B4Jv2wUp1cQN9h2l7PAlqZ5vxzFS6jsxHqIdoKvW9/
	M311C+aT3uX4Nojuyoi48aLFJDcABMf6HPOUIMuvCGdAv9Y4z4YtxS1CMTEkJsdsigrBr66fSees7
	G8/BoAEYQlFtFjMLdorZ6AWJN56rKm2xrVsLULtlBkTa2yAGWHIPyEFY5h4/CIWOAWSX6pHDvePhZ
	ugl+iWlz7fJtlUrvlUWwTMeIvmTdOVZLPwRFU9k/7d4oZ9ICXeijRZV2GdT67hGu0WNXi5SlsW5+C
	Nlg66Vcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyM44-00000006YtH-24vm;
	Tue, 16 Sep 2025 03:09:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyM41-00000006YsL-3mPi;
	Tue, 16 Sep 2025 03:09:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1DFDA600B0;
	Tue, 16 Sep 2025 03:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD31C4CEF1;
	Tue, 16 Sep 2025 03:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757992144;
	bh=clS/RriAH6/uzgbxBAN8eXzKr1t8+yo2uadqdbTxw+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBxS8q66YdKGXiHFPJJ3//BAWLCIYoh1qbHxHfe2QgUS7fzvi8AFYBbIitGKJPiDy
	 J0h5xdTTy4wuRH1ymZPr5e0f/C36eUMrkOUag+lWBj8YkZln2Sd8hzT0pfkU01q17O
	 RT8NuwYenprY6H9Bdb8qKRjkND6VpsGEt1Rf1iUB6mNa5MQsHkHWoiFIr0vmJLaUBy
	 +Mg6Bb5Jrp6AOX9r3GJRBHhtRWiiY7tieeEbNFvl6251o5yIBpkK00NoObReShSwrw
	 BlICrcV2YfDygf6hS1MD81NdPJlMqltFalaDERfXuFBjtYfsWMd22V+qS8nHm3+ffq
	 gVOH5pLBuuEEw==
Date: Mon, 15 Sep 2025 22:09:03 -0500
From: Rob Herring <robh@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>, Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org, initramfs@vger.kernel.org,
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Subject: Re: [PATCH RESEND 28/62] init: alpha, arc, arm, arm64, csky, m68k,
 microblaze, mips, nios2, openrisc, parisc, powerpc, s390, sh, sparc, um,
 x86, xtensa: rename initrd_{start,end} to
 virt_external_initramfs_{start,end}
Message-ID: <20250916030903.GA3598798-robh@kernel.org>
References: <20250913003842.41944-1-safinaskar@gmail.com>
 <20250913003842.41944-29-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913003842.41944-29-safinaskar@gmail.com>
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

On Sat, Sep 13, 2025 at 12:38:07AM +0000, Askar Safin wrote:
> Rename initrd_start to virt_external_initramfs_start and
> initrd_end to virt_external_initramfs_end.

There's not really any point in listing every arch in the subject.

Rob

