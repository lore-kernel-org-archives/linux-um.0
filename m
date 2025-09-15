Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DCDCAC592
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8LbZZQXBwakk1o8HoHgvDq6wMKD6k92z7xv9wHGbqAg=; b=HcTqhF/KLMfRz4lJzm/QS7/bVT
	+0W8CuSaKYKCBPmZfIoJnEaJIbeBwuuZeWGp6KdfUlAKuXwbv1boEyTKvsnccW8Rtn/U0zmczu8M6
	isOyDTzE1nrhp60fHmWXnS46W4qobhonzdjwRBGLR91nqVFF4k4vZ61slAhydG/71V9gvPY8TWlMf
	R5bNUGNSlYsKBrSQjRofZ2TnfNJwMEouMgX/EJwG7XGU990fmHpLmrmaXl+i7OIW28CRfRBn6J1h1
	ySFbjNzAoeIZqHxMHTyLBBuLhithtQCggjw8mNGUZ+fyfOPyJt+wi4bEGNS5zGerW6MfaXo2V/gIK
	nRTrWGFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8CO-000000046nS-0aAC;
	Mon, 15 Sep 2025 12:20:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8CL-000000046lr-3hGr;
	Mon, 15 Sep 2025 12:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8LbZZQXBwakk1o8HoHgvDq6wMKD6k92z7xv9wHGbqAg=; b=qriL60QvErCuV94eB/2ji76sLO
	AS/wAUwdma9N7/K4ngnC0BhR37kCBPm0AXqo6ChzYWuXCCENEGw1+lRPDvX1lMjE3m2QNsFjT9zx2
	+NCmNhLSZhbbmb6sCRJ/vv78aQhivyGYdERLLLBK/RvmqkVCtaY1IaxGS/nVELkpM9+aqPvnsSBO2
	3kkqcRIsyFOo3j2CsWZgNtUQ71+Ku58lCO+4o3Y4KQEpB0crwAo+IsD+M1Dj0j3bazqoy9/Hjzzl5
	wLlLMjWZ7j8aKwgNunbNFHckRelXzc43yPUiktE8aCOol1yfoYa+aadY398YB1mnK+jIW9ywAcMU/
	mz2V0IjA==;
Received: from pegase2.c-s.fr ([93.17.235.10])
	by desiato.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8CH-00000006yZC-3YpN;
	Mon, 15 Sep 2025 12:20:44 +0000
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cQNk651SSz9sxh;
	Mon, 15 Sep 2025 13:54:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zyKNPbK2UxYX; Mon, 15 Sep 2025 13:54:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cQNk52qX4z9sxf;
	Mon, 15 Sep 2025 13:54:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 307338B766;
	Mon, 15 Sep 2025 13:54:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id kYegUs-5AFEi; Mon, 15 Sep 2025 13:54:37 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 92F668B763;
	Mon, 15 Sep 2025 13:54:36 +0200 (CEST)
Message-ID: <a246ee31-1ea3-4278-b103-65fda6e692a9@csgroup.eu>
Date: Mon, 15 Sep 2025 13:54:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 08/62] arm: init: remove FLAG_RDLOAD and
 FLAG_RDPROMPT
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
 <20250913003842.41944-9-safinaskar@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250913003842.41944-9-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_132042_043746_D24C02DB 
X-CRM114-Status: GOOD (  12.23  )
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
> They are unused since previous commit

Since which commit ?

> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>
> ---
>   Documentation/arch/arm/setup.rst | 4 ++--
>   arch/arm/kernel/atags_compat.c   | 2 --
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arch/arm/setup.rst b/Documentation/arch/arm/setup.rst
> index 8e12ef3fb9a7..be77d4b2aac1 100644
> --- a/Documentation/arch/arm/setup.rst
> +++ b/Documentation/arch/arm/setup.rst
> @@ -35,8 +35,8 @@ below:
>       =====   ========================
>       bit 0   1 = mount root read only
>       bit 1   unused
> -    bit 2   0 = load ramdisk
> -    bit 3   0 = prompt for ramdisk
> +    bit 2   unused
> +    bit 3   unused
>       =====   ========================
> 
>    rootdev
> diff --git a/arch/arm/kernel/atags_compat.c b/arch/arm/kernel/atags_compat.c
> index b9747061fa97..8d04edee3066 100644
> --- a/arch/arm/kernel/atags_compat.c
> +++ b/arch/arm/kernel/atags_compat.c
> @@ -44,8 +44,6 @@ struct param_struct {
>              unsigned long ramdisk_size;         /*  8 */
>              unsigned long flags;                /* 12 */
>   #define FLAG_READONLY  1
> -#define FLAG_RDLOAD    4
> -#define FLAG_RDPROMPT  8
>              unsigned long rootdev;              /* 16 */
>              unsigned long video_num_cols;       /* 20 */
>              unsigned long video_num_rows;       /* 24 */
> --
> 2.47.2
> 
> 


