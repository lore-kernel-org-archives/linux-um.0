Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BCFCAC599
	for <linux-um@archiver.kernel.org>; Tue, 16 Sep 2025 17:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AIXyc3Fa0oN4a5i/p3ClDZo8xo9GAZJtSKI5SCU0zd8=; b=2J3ctPzgO1CZshJSf26lNKeEc+
	oaGLR8jWXNY47o0o8rx26WZRWY/+yAzOaemiO/saRkUmgTQXLBcYr+nT8j4g1gob9Xb1lEzuSvOfg
	d8fgO100CJu/9IFc2bu5kADsGX806LGxHyyJkcJduxzZkt4F24T26T7VUJfDcgYJlbXaku0tKae5w
	g1yRDlDku2nOzSnT4A4ixYe49Wx/Z3BctT+8iOzxIaz0l4MPPVEQ6+dxfscujduJXcWYPfl9bGIGj
	iWP5Hjk5ePkclgremYTubFK6+07NJVRBtVS/x/CCd80QRzzdB4SyxOihuzppzb5lZSrR6kUJtD5S8
	esr9T29w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyZAT-00000008aC4-1R1F;
	Tue, 16 Sep 2025 17:08:37 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyZAP-00000008a9B-0tKR
	for linux-um@lists.infradead.org;
	Tue, 16 Sep 2025 17:08:35 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3eb0a50a4c3so1644913f8f.1
        for <linux-um@lists.infradead.org>; Tue, 16 Sep 2025 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1758042511; x=1758647311; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIXyc3Fa0oN4a5i/p3ClDZo8xo9GAZJtSKI5SCU0zd8=;
        b=JZDCUwzNIL5tc0KzzKC1h1hvyA/NrAP4qNhVIzbEsRl7J2TWLRup1j9uKpwYo/Gb/Y
         gPfqnxXjaxkH3rjEMvwLggfLTtAjtm9A9jQMBMLiYb3SFRdTk0QSVR9iGP1fipvQK3k0
         MPlW8nhSMqgW2BeYOobP3qTBEBVMaT0nFyLd3G5nmBmiiq2WLggL0vCw1TVkQq3cqKcb
         51lcSs/0uLPTLk+f4lebTnJzjLL1MQK2XUnyzPEPoxmtv384ohaGR8lSmyOiljMN0az1
         NdfzzYFYUoHTnSpK2hYX7CpnF/N3w1dipkcq6ybvYGdMuQmBMFMbnwDi/wByUvcKf0Zw
         Sw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042511; x=1758647311;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIXyc3Fa0oN4a5i/p3ClDZo8xo9GAZJtSKI5SCU0zd8=;
        b=s4oC+sOPVK5YhTckXGB1kat7agh9og+fwA54VuWtpPrR7DWJ59dMO1H8Gn3fV6QHD0
         N7hPXLbw2UyVxA9KY/KBJvxvOI/DW31QmEbZoSCKFFySGSjDiH+GNgVo9qrNGXarvL91
         0K9Yej8a0Pf4q7bdZMZ93qGnuEFael1oVjyTRaCKdiYZnV8ZD+zP4+YA7N//T4wyNgR6
         9TlqM4clWcl+bySVQGkNtM1QrJWk4DOFeM5zkOqcT8iEnyT6lIwwHlDp6aSFbZPKvXNR
         KSUxoYvyq7st8H1RalhFKiXcq7dpS00OvICO3R6VkH0iSJxbC7s0NTp8/bfhbqug9ZFe
         lRAA==
X-Forwarded-Encrypted: i=1; AJvYcCUr1CqLcut8sHQAobiVI5EkpSkkRfgbHKIgD0oTFTOwKzCUhaXiNntZypIMvZUDDRmBRI0p+XOTxQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3nSry11JROoREHTJDSn4S4u3Q+oXT83qPn/BLi9rEEuE8KW93
	zhp97oLY/Hj9yboftDZuwIRwjIS51EkreKxxlVPelROMo7+c9Wnp2f0JLmoN7utcQ6Q=
X-Gm-Gg: ASbGnct2w6mvorbe8AW8HAeLMI2NchD5dwHfKqGMge6t717bPggCcaWcACYT/DhtRdw
	84ZmJMsA3qLnE0ECo96hatrxXRjZoeV9dD/mvcYJZfCYFVyjVvkM0prX1kF8VJ3p/4Id1rfXunz
	4ECnUmAjpmRv3mz44Cbzs+do92tZMYSSdyfN+6jkM7mY504U0NlLyHF89wG2fohlaU+94xso6Zo
	ZlhlzoyXsEoQ/NeBSSCKDQyAM9z4+gYGbgo1bxU++VHX2LIKS0eUHhGRaSc1f50VQS22ogGLLAe
	5/NkxfcTvKq39b/nx6mM7MfnTsozutUjtk9T1Xj1wdwt5Zd1+FgyZ0FtxXkg5pCajwIHye70WDe
	UFl05t+C9EVOeCdmxYvFcHf9a5EtnyR7/B5m8C6QSeFriuCE9JY9zgTP35w==
X-Google-Smtp-Source: AGHT+IGdFovreVsG0VTuKKVTgWJJEqEKFnO21Mo+tI9uoQq7jJrFi/9vVCfXuUmfB6QhCbWUaAaAkg==
X-Received: by 2002:a05:6000:2dca:b0:3eb:2437:97c5 with SMTP id ffacd0b85a97d-3eb24379a13mr7083124f8f.22.1758042510664;
        Tue, 16 Sep 2025 10:08:30 -0700 (PDT)
Received: from smtpclient.apple (nat-184-7.net.cam.ac.uk. [131.111.184.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd0a7sm22520843f8f.39.2025.09.16.10.08.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 10:08:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
Date: Tue, 16 Sep 2025 18:08:18 +0100
Cc: linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Aleksa Sarai <cyphar@cyphar.com>,
 =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Julian Stecklina <julian.stecklina@cyberus-technology.de>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 Art Nikpal <email2tema@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Curtin <ecurtin@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Rob Landley <rob@landley.net>,
 Lennart Poettering <mzxreary@0pointer.de>,
 linux-arch@vger.kernel.org,
 linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org,
 x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 linux-block@vger.kernel.org,
 initramfs@vger.kernel.org,
 linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-efi@vger.kernel.org,
 linux-ext4@vger.kernel.org,
 "Theodore Y . Ts'o" <tytso@mit.edu>,
 linux-acpi@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>,
 devicetree@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <kees@kernel.org>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Heiko Carstens <hca@linux.ibm.com>,
 patches@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <A08066E1-A57E-4980-B15A-8FB00AC747CC@jrtc27.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
To: Askar Safin <safinaskar@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_100833_286682_E4CC99BB 
X-CRM114-Status: GOOD (  10.89  )
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

On 13 Sep 2025, at 01:37, Askar Safin <safinaskar@gmail.com> wrote:
> [...]
> For example, I renamed the following global variables:
> 
> __initramfs_start
> __initramfs_size
> [...]
> 
> to:
> 
> __builtin_initramfs_start
> __builtin_initramfs_size

I strongly suggest picking different names given __builtin_foo is the
naming scheme used for GNU C builtins/intrinsics. I leave you and
others to bikeshed that one.

Jessica


