Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C215CAC592
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vbe0w4DAnuCL8J2vrzWlMqCh99kSyQCieLV52a77G+Y=; b=wewpCrGcFlvws3n1ZPsAIYXX2+
	0cJ9Uk7QK+zmqWmJAoByFg2stQJ3TNBYKK2Mhp6uHozAbtvojTktiLTzDvTKZN5tYA3h3WySLP3Jo
	HIRZ4kDEsUpqeipPitAxneq91QzaYqLBkds3LJfc0IFQ3Z7aNFV3MkxyvvnBsHoXVEYBxybPxNWAN
	tuUJ2eiolMoqO2+Eus7Tx5NkhfMJU7o1Ml5czu0BiubS1dYu57ZBsCzsOM444OFr7aLjWyvf45dVN
	GUTQZr4CVw9jYG34JL1pWM/fGPqNz/S+EMzNK1rWdqUJSs7LewcXMK26Xjwk0800+zcLHTrxJvaWR
	HTqgvZMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy7jL-000000040KV-0UNk;
	Mon, 15 Sep 2025 11:50:47 +0000
Received: from pegase2.c-s.fr ([93.17.235.10])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy7jG-000000040ED-2I8j;
	Mon, 15 Sep 2025 11:50:43 +0000
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cQMxX3w10z9sxn;
	Mon, 15 Sep 2025 13:19:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lsQzt4OAL5QC; Mon, 15 Sep 2025 13:19:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cQMxW2nkYz9sxl;
	Mon, 15 Sep 2025 13:19:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 27EFC8B766;
	Mon, 15 Sep 2025 13:19:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id niL9xnZy0o5E; Mon, 15 Sep 2025 13:19:27 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E3148B763;
	Mon, 15 Sep 2025 13:19:26 +0200 (CEST)
Message-ID: <c52c2589-9d7b-4ac7-a61f-68fa9ba18308@csgroup.eu>
Date: Mon, 15 Sep 2025 13:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 03/62] init: sh, sparc, x86: remove unused
 constants RAMDISK_PROMPT_FLAG and RAMDISK_LOAD_FLAG
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
 Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev,
 stable+noautosel@kernel.org
References: <20250913003842.41944-1-safinaskar@gmail.com>
 <20250913003842.41944-4-safinaskar@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250913003842.41944-4-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_045042_746653_871E2F62 
X-CRM114-Status: GOOD (  11.86  )
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
> They were used for initrd before c8376994c86.
> 
> c8376994c86c made them unused and forgot to remove them
> 
> Fixes: c8376994c86c ("initrd: remove support for multiple floppies")
> Cc: <stable+noautosel@kernel.org> # because changes uapi headers
> Signed-off-by: Askar Safin <safinaskar@gmail.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/sh/kernel/setup.c                | 2 --
>   arch/sparc/kernel/setup_32.c          | 2 --
>   arch/sparc/kernel/setup_64.c          | 2 --
>   arch/x86/include/uapi/asm/bootparam.h | 2 --
>   arch/x86/kernel/setup.c               | 2 --
>   5 files changed, 10 deletions(-)
> 
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index 039a51291002..d66f098e9e9f 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -71,8 +71,6 @@ EXPORT_SYMBOL(sh_mv);
>   extern int root_mountflags;
> 
>   #define RAMDISK_IMAGE_START_MASK       0x07FF
> -#define RAMDISK_PROMPT_FLAG            0x8000
> -#define RAMDISK_LOAD_FLAG              0x4000
> 
>   static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
> 
> diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
> index 704375c061e7..eb60be31127f 100644
> --- a/arch/sparc/kernel/setup_32.c
> +++ b/arch/sparc/kernel/setup_32.c
> @@ -172,8 +172,6 @@ extern unsigned short root_flags;
>   extern unsigned short root_dev;
>   extern unsigned short ram_flags;
>   #define RAMDISK_IMAGE_START_MASK       0x07FF
> -#define RAMDISK_PROMPT_FLAG            0x8000
> -#define RAMDISK_LOAD_FLAG              0x4000
> 
>   extern int root_mountflags;
> 
> diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
> index 63615f5c99b4..f728f1b00aca 100644
> --- a/arch/sparc/kernel/setup_64.c
> +++ b/arch/sparc/kernel/setup_64.c
> @@ -145,8 +145,6 @@ extern unsigned short root_flags;
>   extern unsigned short root_dev;
>   extern unsigned short ram_flags;
>   #define RAMDISK_IMAGE_START_MASK       0x07FF
> -#define RAMDISK_PROMPT_FLAG            0x8000
> -#define RAMDISK_LOAD_FLAG              0x4000
> 
>   extern int root_mountflags;
> 
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index dafbf581c515..f53dd3f319ba 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -6,8 +6,6 @@
> 
>   /* ram_size flags */
>   #define RAMDISK_IMAGE_START_MASK       0x07FF
> -#define RAMDISK_PROMPT_FLAG            0x8000
> -#define RAMDISK_LOAD_FLAG              0x4000
> 
>   /* loadflags */
>   #define LOADED_HIGH    (1<<0)
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 1b2edd07a3e1..6409e766fb17 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -223,8 +223,6 @@ extern int root_mountflags;
>   unsigned long saved_video_mode;
> 
>   #define RAMDISK_IMAGE_START_MASK       0x07FF
> -#define RAMDISK_PROMPT_FLAG            0x8000
> -#define RAMDISK_LOAD_FLAG              0x4000
> 
>   static char __initdata command_line[COMMAND_LINE_SIZE];
>   #ifdef CONFIG_CMDLINE_BOOL
> --
> 2.47.2
> 
> 


