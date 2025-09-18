Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CAECA1013
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 15:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XUWQfxZZ308Qh0GEo031WQTVwmY2irHkVNeN0hT1npU=; b=HzfNhekhgK9++NIanFRIZdXfpO
	Tn6Kfj6gE8jL69PfKW5SUqeJeEZ+Z1K5CyqOTmqb4eSeJUXk5y8ZO2NdLzCsTWJYu9niXOwxbEbbT
	3LE+wXSKxhtKv94NZx0yEgeFiF1HXqfwNsTjo2H71Sy3avih+ZXwNZWwA0/QTxBxkaDWaeT1AJ8vl
	3ugYfCK9nIdGCKUOWOJQ3/aXe0BFWjFxs5AZnUkjXXCd2oOO1DFH5VkSFr8v91jOtAhyEx66DRIDC
	dn5JhxU2CWhSPGj/0HsVSmR1qQwJ+jlbQwtEBOJejqNsLYDCmTSu0vLbdhIKipJsvVF7GrklJCOOb
	BGf3eaVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzGZu-00000000NdE-3c5I;
	Thu, 18 Sep 2025 15:29:46 +0000
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzGZq-00000000NbV-2oaz;
	Thu, 18 Sep 2025 15:29:44 +0000
Received: from daria.iliad.local (unknown [213.36.7.13])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 179252003FC;
	Thu, 18 Sep 2025 17:28:31 +0200 (CEST)
From: Nicolas Schichan <nschichan@freebox.fr>
To: safinaskar@gmail.com
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	cyphar@cyphar.com,
	devicetree@vger.kernel.org,
	ecurtin@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	mcgrof@kernel.org,
	mingo@redhat.com,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	patches@lists.linux.dev,
	rob@landley.net,
	sparclinux@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	x86@kernel.org,
	nschichan@freebox.fr
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
Date: Thu, 18 Sep 2025 17:28:30 +0200
Message-Id: <20250918152830.438554-1-nschichan@freebox.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_082942_851206_A95B5688 
X-CRM114-Status: GOOD (  10.05  )
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

Hello,

> Intro
> ====
> This patchset removes classic initrd (initial RAM disk) support,
> which was deprecated in 2020.

This serie came a bit as a surprise, because even though the message
notifying of the initrd deprecation was added in July 2020, the message
was never displayed on our kernels.

When booting with root=/dev/ram0 in the kernel commandline,
handle_initrd() where the deprecation message resides is never called,
which is rather unfortunate (init/do_mounts_initrd.c):

	if (rd_load_image("/initrd.image") && ROOT_DEV != Root_RAM0) {
		init_unlink("/initrd.image");
		handle_initrd(root_device_name); // shows the deprecation msg
		return true;
	}

It is likely we are not the alone booting with that particular
configuration, so other people are probably going to be surprised when
initrd support is removed, because they never saw the deprecation
message.

We do depend on initrd support a lot on our embedded platforms (more
than a million devices with a yearlyish upgrade to the latest
kernel). If it eventually becomes removed this is going to impact us.

We use an initrd squashfs4 image, because coming from a time where
embedded flash devices were fragile, we avoid having the root
filesystem directly mounted (even when read only) on the flash
block/mtd device, and have the bootloader load the root filesystem as
an initrd.

We use a squashfs4 because we can mount it and keep it compressed. The
kernel would decompress data on demand in the page cache, and evict it
as needed.

Regards,

-- 
Nicolas Schichan

