Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41389CAC597
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 12:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F10Z0OsYT+kNHV3Z5mbBWTZLBFcFmmcfUW5nyLJWgQ4=; b=mG8f3ef6y9a03ole9diQudogv6
	aaI/5+8e2V+bATMc073L6RTTYW2IkrhT4aABb+ZRiH8mqZtSUDPRbj5c1KjQUY6Ze1mntsjyRPBgS
	pYe1HSKv2DqcX5ANEQT/xMniwsXE3sjQsezIbOjtE21Dl7z1pQHn+lUhXTclLgzOIsp8wgF0OVc62
	0qj1BqHykITLl+eks3hVR+X+BqJEeVw3gWGyAjG3g8iChwVtXI71NzIptWHQy6Bbd6pUcjIyDwgY2
	J1GHXgQ8flUv0Ik7UPdA8B3BGzflbGuxV9ChkE4NG7vLxfittsR13bo87G4VuHRXTIvBU3gAjLNBO
	tuZc4zpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8CR-000000046qY-02Dl;
	Mon, 15 Sep 2025 12:20:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8CP-000000046nr-1XeY;
	Mon, 15 Sep 2025 12:20:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=F10Z0OsYT+kNHV3Z5mbBWTZLBFcFmmcfUW5nyLJWgQ4=; b=RnduAI75142f+Y8DCT+iFnJb1A
	/OqC73hNz1xc0/7aITaB+VuoUJOQiaW7TN+5RTnBYaNZU/dHRTw9F8ou8lUV7uj7bBmViC77cUsHn
	K2GrSNUfeH88NSgzOPEeGmx8JLkgWkBqh9wnDy+fxptIeRZmlBpe/jkfqBnyOGU5O/SVKVUxYUtxH
	NusNGhV9o48BtP9QP+atGWvhBiASVrwWJexaDwSMQyt7T06JWWOsKF8w+HbJB0Kvcb/q4G9UhRerF
	u6gNyF4Tw+cmoipYF8ekK7lamspp4mrtzf6KTPlqRBum8QXkQNfu6bFfFQ9GkcxvMYbLiTXzYj6fJ
	3M8DGP0g==;
Received: from pegase2.c-s.fr ([93.17.235.10])
	by desiato.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8CL-00000006yZC-3ShH;
	Mon, 15 Sep 2025 12:20:48 +0000
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cQNbF5mghz9t06;
	Mon, 15 Sep 2025 13:48:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lGkOMbzCsqbk; Mon, 15 Sep 2025 13:48:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cQNbD4NF4z9t02;
	Mon, 15 Sep 2025 13:48:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 63D1F8B766;
	Mon, 15 Sep 2025 13:48:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id OqxzzIPrAedJ; Mon, 15 Sep 2025 13:48:40 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B11BF8B763;
	Mon, 15 Sep 2025 13:48:39 +0200 (CEST)
Message-ID: <2757ca88-5841-4024-932e-637130ac6b0b@csgroup.eu>
Date: Mon, 15 Sep 2025 13:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 16/62] brd: remove "ramdisk_size" command line
 parameter
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
 <20250913003842.41944-17-safinaskar@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250913003842.41944-17-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_132046_083259_9E1111ED 
X-CRM114-Status: GOOD (  24.10  )
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
> It was used mostly for initrd. It could be used only if
> brd is built-in. Use "brd.rd_size" instead

For me it would make more sense to remove ramdisk_start and ramdisk_size 
at the same time.


> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  3 ---
>   Documentation/arch/m68k/kernel-options.rst    | 20 ++-----------------
>   arch/arm/configs/s3c6400_defconfig            |  2 +-
>   drivers/block/brd.c                           | 10 ----------
>   4 files changed, 3 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ad52e3d26014..e862a7b1d2ec 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5279,9 +5279,6 @@
>          raid=           [HW,RAID]
>                          See Documentation/admin-guide/md.rst.
> 
> -       ramdisk_size=   [RAM] Sizes of RAM disks in kilobytes
> -                       See Documentation/admin-guide/blockdev/ramdisk.rst.
> -
>          random.trust_cpu=off
>                          [KNL,EARLY] Disable trusting the use of the CPU's
>                          random number generator (if available) to
> diff --git a/Documentation/arch/m68k/kernel-options.rst b/Documentation/arch/m68k/kernel-options.rst
> index 2008a20b4329..f6469ebeb2c7 100644
> --- a/Documentation/arch/m68k/kernel-options.rst
> +++ b/Documentation/arch/m68k/kernel-options.rst
> @@ -215,27 +215,11 @@ Devices possible for Atari:
>              seconds.
> 
> 
> -2.6) ramdisk_size=
> -------------------
> -
> -:Syntax: ramdisk_size=<size>
> -
> -This option instructs the kernel to set up a ramdisk of the given
> -size in KBytes. Do not use this option if the ramdisk contents are
> -passed by bootstrap! In this case, the size is selected automatically
> -and should not be overwritten.
> -
> -The only application is for root filesystems on floppy disks, that
> -should be loaded into memory. To do that, select the corresponding
> -size of the disk as ramdisk size, and set the root device to the disk
> -drive (with "root=").
> -
> -
> -2.7) swap=
> +2.5) swap=
> 
>     I can't find any sign of this option in 2.2.6.
> 
> -2.8) buff=
> +2.6) buff=
>   -----------
> 
>     I can't find any sign of this option in 2.2.6.
> diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
> index a37e6ac40825..23635d5b9322 100644
> --- a/arch/arm/configs/s3c6400_defconfig
> +++ b/arch/arm/configs/s3c6400_defconfig
> @@ -4,7 +4,7 @@ CONFIG_ARCH_MULTI_V6=y
>   # CONFIG_ARCH_MULTI_V7 is not set
>   CONFIG_ARCH_S3C64XX=y
>   CONFIG_MACH_WLF_CRAGG_6410=y
> -CONFIG_CMDLINE="console=ttySAC0,115200 root=/dev/ram init=/linuxrc initrd=0x51000000,6M ramdisk_size=6144"
> +CONFIG_CMDLINE="console=ttySAC0,115200 root=/dev/ram init=/linuxrc initrd=0x51000000,6M"
>   CONFIG_VFP=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_UNLOAD=y
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 72f02d2b8a99..05c4325904d2 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -222,16 +222,6 @@ MODULE_LICENSE("GPL");
>   MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
>   MODULE_ALIAS("rd");
> 
> -#ifndef MODULE
> -/* Legacy boot options - nonmodular */
> -static int __init ramdisk_size(char *str)
> -{
> -       rd_size = simple_strtol(str, NULL, 0);
> -       return 1;
> -}
> -__setup("ramdisk_size=", ramdisk_size);
> -#endif
> -
>   /*
>    * The device scheme is derived from loop.c. Keep them in synch where possible
>    * (should share code eventually).
> --
> 2.47.2
> 
> 


