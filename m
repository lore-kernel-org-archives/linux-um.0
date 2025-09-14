Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B5FCAC587
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 20:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZnyDJvO2Mn+VIk33nJO1BzAqt4g5FhopoIJFFkjc1Ek=; b=NXWBub3BAgILteXxspgQ1vhjpL
	IEjueeUaHmM5TMdL8mpLHMGzgyDIa1Z/T0jRhsT/P3dfB50nA4b5mJJ3JV7c08TRPsTRbIx0+8nb6
	7gmCXOYThZMJhpAQur+E73E3E+I3HvAsgdLKouOmXKBAolroVJL3LmBNHcxZEmsj11qjT3BXo0iCZ
	8wRudai4kJmoM/Rt7hO8tHI+dxrUiN7nZvfA/g/7Ab7ij3Mw6T9TiXCiAS+DZf8T7TL9aPR6v4dr0
	Tlmc+ZTRFVbckHBuek1oeaVIAJbhD4PC1cwKgU4iI2PyH4diKOaAH9/9scDaY1brzdBVIznplIt5H
	8dzjTGjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxt6F-000000027h8-3Ktn;
	Sun, 14 Sep 2025 20:13:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxt6C-000000027fe-1d47;
	Sun, 14 Sep 2025 20:13:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B693437D6;
	Sun, 14 Sep 2025 20:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D19C4CEF0;
	Sun, 14 Sep 2025 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757880803;
	bh=S1O2mYg/nuSFWiepEfi3INn1/VxeJMAKyzsDV4vYqvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2UPxRGMw8I/maQZ+HN3ir+gn07zWGBMkkdWTdW2X4OKEgkpUDDbZLiyj3E0pJDtL3
	 1+D42ZKa/D0blrtutGoeATk6sFzQAtpGrIpNKIWACFz+9+7ensOkK9v2abyA5QnetQ
	 dB1gPfBNpyMhvJhlFN9WW4x1lQUIWNYqbIuD5q6A=
Date: Sun, 14 Sep 2025 13:13:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, Al
 Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig
 <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, Julian
 Stecklina <julian.stecklina@cyberus-technology.de>, Gao Xiang
 <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, Eric
 Curtin <ecurtin@redhat.com>, Alexander Graf <graf@amazon.com>, Rob Landley
 <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>,
 linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org,
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, "Theodore Y . Ts'o"
 <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek
 <monstr@monstr.eu>, devicetree@vger.kernel.org, Luis Chamberlain
 <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Thorsten Blum
 <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>,
 patches@lists.linux.dev
Subject: Re: [PATCH RESEND 21/62] init: remove all mentions of
 root=/dev/ram*
Message-Id: <20250914131321.df00dfc835be48c10f4cce4b@linux-foundation.org>
In-Reply-To: <a079375f-38c2-4f38-b2be-57737084fde8@kernel.org>
References: <20250913003842.41944-1-safinaskar@gmail.com>
	<20250913003842.41944-22-safinaskar@gmail.com>
	<a079375f-38c2-4f38-b2be-57737084fde8@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_131324_889183_D01D05DA 
X-CRM114-Status: UNSURE (   9.00  )
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

On Sun, 14 Sep 2025 12:06:24 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:

> >  Documentation/admin-guide/kernel-parameters.txt          | 3 +--
> >  Documentation/arch/m68k/kernel-options.rst               | 9 ++-------
> >  arch/arm/boot/dts/arm/integratorap.dts                   | 2 +-
> >  arch/arm/boot/dts/arm/integratorcp.dts                   | 2 +-
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dts     | 2 +-
> >  .../boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dts    | 2 +-
> >  .../arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dts | 2 +-
> >  .../arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dts | 2 +-
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dts | 2 +-
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dts    | 2 +-
> >  .../boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi  | 2 +-
> 
> No, don't do that. DTS is always separate.

Why can't DTS changes be carried in a different tree?

