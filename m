Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B64CAC59A
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 11:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A7SCR9BDVn4RNVUVtun87smf4PKhLZ879PG0u2HnQME=; b=eb73bCpD2aCVVrAnCscUQHwCTT
	tm2+xu92S+s+UkdIXISN42RswDLNEZ4NndpelfWuy1nyjcbq75zWL7icS/nDT1h6uME1v6d3UkKEv
	nb/PZoZ3kR7Ghv7I8soOtVW7/niKBBrKPwn0hcAuHUc247yShWuqkawUnLEdWSp6ZAcL8oSxQPL3z
	xoploEyKAZTRzuMxFNw6fz8R7RQB5oEgE0KSMsmDdbvDXcTjqF4iV/79grqx/e1Yxyx6zRj8UbK9v
	XevYVHkudfraLrtk6l4r+OMtiC071Vf7T75GUyKoGK8MIS7A3EBbGMTYYjDc4RT8L5LokiFojdPNd
	mk8hx23g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy7jP-000000040Oz-43zr;
	Mon, 15 Sep 2025 11:50:51 +0000
Received: from pegase2.c-s.fr ([93.17.235.10])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy7jL-000000040JR-2S9P;
	Mon, 15 Sep 2025 11:50:49 +0000
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cQMty1PZPz9sxj;
	Mon, 15 Sep 2025 13:17:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3y6qLNUbAYQ5; Mon, 15 Sep 2025 13:17:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cQMtx060wz9sxg;
	Mon, 15 Sep 2025 13:17:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BF74D8B766;
	Mon, 15 Sep 2025 13:17:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LLgTqAL1YNfN; Mon, 15 Sep 2025 13:17:12 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F017B8B763;
	Mon, 15 Sep 2025 13:17:11 +0200 (CEST)
Message-ID: <8b56da8e-42d1-4548-8e39-286010c5d84a@csgroup.eu>
Date: Mon, 15 Sep 2025 13:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 01/62] init: remove deprecated "load_ramdisk"
 command line parameter, which does nothing
To: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Aleksa Sarai <cyphar@cyphar.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Julian Stecklina <julian.stecklina@cyberus-technology.de>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>,
 Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>,
 Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org,
 initramfs@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-ext4@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>,
 linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
 devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <kees@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>,
 Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
References: <20250913003842.41944-1-safinaskar@gmail.com>
 <20250913003842.41944-2-safinaskar@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250913003842.41944-2-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_045047_785658_9B85665A 
X-CRM114-Status: GOOD (  15.24  )
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



Le 13/09/2025 à 02:37, Askar Safin a écrit :
> [Vous ne recevez pas souvent de courriers de safinaskar@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> This is preparation for initrd removal


Squash patch 1 and patch 2 together and say this is cleanup of two 
options deprecated by commit c8376994c86c ("initrd: remove support for 
multiple floppies") with the documentation by commit 6b99e6e6aa62 
("Documentation/admin-guide: blockdev/ramdisk: remove use of "rdev"")

Christophe


> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 2 --
>   arch/arm/configs/neponset_defconfig             | 2 +-
>   init/do_mounts.c                                | 7 -------
>   3 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 747a55abf494..d3b05ce249ff 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3275,8 +3275,6 @@
>                          If there are multiple matching configurations changing
>                          the same attribute, the last one is used.
> 
> -       load_ramdisk=   [RAM] [Deprecated]
> -
>          lockd.nlm_grace_period=P  [NFS] Assign grace period.
>                          Format: <integer>
> 
> diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
> index 2227f86100ad..16f7300239da 100644
> --- a/arch/arm/configs/neponset_defconfig
> +++ b/arch/arm/configs/neponset_defconfig
> @@ -9,7 +9,7 @@ CONFIG_ASSABET_NEPONSET=y
>   CONFIG_ZBOOT_ROM_TEXT=0x80000
>   CONFIG_ZBOOT_ROM_BSS=0xc1000000
>   CONFIG_ZBOOT_ROM=y
> -CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) load_ramdisk=1 prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
> +CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
>   CONFIG_FPE_NWFPE=y
>   CONFIG_PM=y
>   CONFIG_MODULES=y
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 6af29da8889e..0f2f44e6250c 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -34,13 +34,6 @@ static int root_wait;
> 
>   dev_t ROOT_DEV;
> 
> -static int __init load_ramdisk(char *str)
> -{
> -       pr_warn("ignoring the deprecated load_ramdisk= option\n");
> -       return 1;
> -}
> -__setup("load_ramdisk=", load_ramdisk);
> -
>   static int __init readonly(char *str)
>   {
>          if (*str)
> --
> 2.47.2
> 
> 


