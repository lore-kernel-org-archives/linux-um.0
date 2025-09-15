Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4302FCAC592
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 12:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O1XbvmLD6s56hdCCZ7aKsrxIqtTrO4/3OkagSH/bFM4=; b=yFiEHP7pNpjtyPCWWTcQie0dUI
	lzqOZ/zPB/R3osXfX7Y8pW7fSnXigYkHs9HIuoCnclEKbbYvYIqyIXk7LGL5PebIXbKv+lf5tmDJz
	euhCYtbIiBbdSv64YvQhpcLHf3kziCsqdty3P1RhB9q10cY2yPKB5gK9/wZB/MbQMVfstfiZc2VX6
	cQTqz04kX37j5962c8SvabwsNng791oka8up2DZ8EOqVtNkklzjXvOU6NNI0P3PhKoTLG2Al1c9eY
	zQFRXEcdD72ZEWYTtBX6s6BmTc74QvnHtq6VG3io7y4fX4J5c/k20NY4ig24J9coQoXsb6lBxVycW
	hoezVzPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8Cd-00000004703-06ML;
	Mon, 15 Sep 2025 12:21:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8Ca-000000046xk-1YIR;
	Mon, 15 Sep 2025 12:21:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=O1XbvmLD6s56hdCCZ7aKsrxIqtTrO4/3OkagSH/bFM4=; b=M98Lvy8DKySChL0onMt0wEzHPu
	55XveB1dUTa4SluwnDwGkwbxVaqpM5SKVrUwD6lOR+StZt4S1AZDYc4/SVbqrgv8GVp/xQ8zT7nNg
	QmNq+8r8Gzf6ecE2q4XnMlVgwKqkQDmh21QM+W7hQ8UNjSk3e46mHD0pEanazPSpE82wW8VJ8HgiS
	S2iK40bqyRuiOTsmSy1pzAzS3t39oUPRExoMczVXwNGv3fAVO+RUgIuT8rqFU23V7I9iYJMEgqBTK
	a1EqG3hg9hIf4ufhOD3vUSJqYkNfhK8Jrba/v8M/P0LknIxdrnGuAFXOe+pOxl2Q+5qx/bGBA9naj
	XDNECvQw==;
Received: from pegase2.c-s.fr ([93.17.235.10])
	by desiato.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8CU-00000006ycK-2wO0;
	Mon, 15 Sep 2025 12:20:56 +0000
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cQNnR0pmTz9sxp;
	Mon, 15 Sep 2025 13:57:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CofbtF7b-0VV; Mon, 15 Sep 2025 13:57:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cQNnQ5DNGz9sxl;
	Mon, 15 Sep 2025 13:57:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 981DC8B766;
	Mon, 15 Sep 2025 13:57:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id aYicW_kKuipv; Mon, 15 Sep 2025 13:57:30 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 227808B763;
	Mon, 15 Sep 2025 13:57:30 +0200 (CEST)
Message-ID: <99563c3d-7322-4164-81f3-0d28e91ed653@csgroup.eu>
Date: Mon, 15 Sep 2025 13:57:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 06/62] arm: init: remove special logic for setting
 brd.rd_size
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
 <20250913003842.41944-7-safinaskar@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250913003842.41944-7-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_132054_899158_D228B39C 
X-CRM114-Status: GOOD (  18.06  )
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
> There is no any reason for having special mechanism
> for setting ramdisk size.
> 
> Also this allows us to change rd_size variable to static

Can you squash patches 6 to 9 all together ?

> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>
> ---
>   arch/arm/kernel/atags_parse.c | 12 ------------
>   drivers/block/brd.c           |  8 ++++----
>   include/linux/initrd.h        |  3 ---
>   3 files changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
> index a3f0a4f84e04..615d9e83c9b5 100644
> --- a/arch/arm/kernel/atags_parse.c
> +++ b/arch/arm/kernel/atags_parse.c
> @@ -87,18 +87,6 @@ static int __init parse_tag_videotext(const struct tag *tag)
>   __tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);
>   #endif
> 
> -#ifdef CONFIG_BLK_DEV_RAM
> -static int __init parse_tag_ramdisk(const struct tag *tag)
> -{
> -       if (tag->u.ramdisk.size)
> -               rd_size = tag->u.ramdisk.size;
> -
> -       return 0;
> -}
> -
> -__tagtable(ATAG_RAMDISK, parse_tag_ramdisk);
> -#endif
> -
>   static int __init parse_tag_serialnr(const struct tag *tag)
>   {
>          system_serial_low = tag->u.serialnr.low;
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 0c2eabe14af3..72f02d2b8a99 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -27,6 +27,10 @@
> 
>   #include <linux/uaccess.h>
> 
> +static unsigned long rd_size = CONFIG_BLK_DEV_RAM_SIZE;
> +module_param(rd_size, ulong, 0444);
> +MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
> +
>   /*
>    * Each block ramdisk device has a xarray brd_pages of pages that stores
>    * the pages containing the block device's contents.
> @@ -209,10 +213,6 @@ static int rd_nr = CONFIG_BLK_DEV_RAM_COUNT;
>   module_param(rd_nr, int, 0444);
>   MODULE_PARM_DESC(rd_nr, "Maximum number of brd devices");
> 
> -unsigned long rd_size = CONFIG_BLK_DEV_RAM_SIZE;
> -module_param(rd_size, ulong, 0444);
> -MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
> -
>   static int max_part = 1;
>   module_param(max_part, int, 0444);
>   MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
> diff --git a/include/linux/initrd.h b/include/linux/initrd.h
> index 6320a9cb6686..b42235c21444 100644
> --- a/include/linux/initrd.h
> +++ b/include/linux/initrd.h
> @@ -5,9 +5,6 @@
> 
>   #define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
> 
> -/* size of a single RAM disk */
> -extern unsigned long rd_size;
> -
>   /* 1 if it is not an error if initrd_start < memory_start */
>   extern int initrd_below_start_ok;
> 
> --
> 2.47.2
> 
> 


