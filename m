Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE742CA0ED3
	for <linux-um@archiver.kernel.org>; Wed,  4 Sep 2024 07:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AU1p1DXBVmXIl6YxYAEjEuw7v6nXJYuynqitO9fDnNA=; b=f1YbtGknFsvVZl5EuXKzdjAYUe
	3z9cQbYVgd/ptwUN2L+pg/robp+LcZ0cpkG57sNlN+4QO3mQtaEnojTWdPtb+mTcGtwWIENZBXNvO
	zUsw/ifYw/xDrk5OHsz4Pr+uig4QR6abndRYwYON8JUbVKv//m7BzO7dgVro6T2qEH3Qnt9imu+0v
	ac+jJ/Ecq1SNU3kwmZbwyyVOL0uellKnDYc0DPpIp/7aC6eU39Dx8BJ9Lj9texOvZVpm0gCvdGeEo
	qy6osaHSXYDLFzycwDasm9nZOrKyHssH78V7gN+xiTZUcTo7uO788GUl7g5x/m7I+s7vg1Efue1qB
	1lMS+luw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slkoF-00000003Gg4-1Ygy;
	Wed, 04 Sep 2024 07:52:11 +0000
Received: from pegase2.c-s.fr ([93.17.235.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slknB-00000003GF9-0jii;
	Wed, 04 Sep 2024 07:51:10 +0000
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WzF6T6FRvz9sSC;
	Wed,  4 Sep 2024 09:50:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MyT5AqoNw1ah; Wed,  4 Sep 2024 09:50:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WzF6T53SRz9sS7;
	Wed,  4 Sep 2024 09:50:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D7618B77A;
	Wed,  4 Sep 2024 09:50:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id XVy8Rvp824KA; Wed,  4 Sep 2024 09:50:57 +0200 (CEST)
Received: from [192.168.234.246] (unknown [192.168.234.246])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EC5188B778;
	Wed,  4 Sep 2024 09:50:56 +0200 (CEST)
Message-ID: <64e74f4d-948d-442e-9810-69907915401c@csgroup.eu>
Date: Wed, 4 Sep 2024 09:50:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: make copy_to_kernel_nofault() not fault on user
 addresses
To: Omar Sandoval <osandov@osandov.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gray <bgray@linux.ibm.com>,
 "Christopher M. Riedl" <cmr@bluescreens.de>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-um@lists.infradead.org, kernel-team@fb.com
References: <cover.1725223574.git.osandov@fb.com>
 <f0e171cbae576758d9387cee374dd65088e75b07.1725223574.git.osandov@fb.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <f0e171cbae576758d9387cee374dd65088e75b07.1725223574.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_005105_395531_C6CDD467 
X-CRM114-Status: GOOD (  19.09  )
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

Hi,

Le 02/09/2024 à 07:31, Omar Sandoval a écrit :
> [Vous ne recevez pas souvent de courriers de osandov@osandov.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Omar Sandoval <osandov@fb.com>
> 
> I found that on x86, copy_to_kernel_nofault() still faults on addresses
> outside of the kernel address range (including NULL):
> 
>    # echo ttyS0 > /sys/module/kgdboc/parameters/kgdboc
>    # echo g > /proc/sysrq-trigger
>    ...
>    [15]kdb> mm 0 1234
>    [   94.652476] BUG: kernel NULL pointer dereference, address: 0000000000000000
...
> 
> Note that copy_to_kernel_nofault() uses pagefault_disable(), but it
> still faults. This is because with Supervisor Mode Access Prevention
> (SMAP) enabled, do_user_addr_fault() Oopses on a fault for a user
> address from kernel space _before_ checking faulthandler_disabled().
> 
> copy_from_kernel_nofault() avoids this by checking that the address is
> in the kernel before doing the actual memory access. Do the same in
> copy_to_kernel_nofault() so that we get an error as expected:
> 
>    # echo ttyS0 > /sys/module/kgdboc/parameters/kgdboc
>    # echo g > /proc/sysrq-trigger
>    ...
>    [17]kdb> mm 0 1234
>    kdb_putarea_size: Bad address 0x0
>    diag: -21: Invalid address
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>   mm/maccess.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/maccess.c b/mm/maccess.c
> index 72e9c03ea37f..d67dee51a1cc 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -61,6 +61,9 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
>          if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
>                  align = (unsigned long)dst | (unsigned long)src;
> 
> +       if (!copy_kernel_nofault_allowed(dst, size))
> +               return -ERANGE;
> +
>          pagefault_disable();
>          if (!(align & 7))
>                  copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
> --
> 2.46.0
> 

This patch leads to the following errors on ppc64le_defconfig:

[    2.423930][    T1] Running code patching self-tests ...
[    2.428912][    T1] code-patching: test failed at line 395
[    2.429085][    T1] code-patching: test failed at line 398
[    2.429561][    T1] code-patching: test failed at line 432
[    2.429679][    T1] code-patching: test failed at line 435

This seems to be linked to commit c28c15b6d28a ("powerpc/code-patching: 
Use temporary mm for Radix MMU"), copy_from_kernel_nofault_allowed() 
returns false for the patching area.

Christophe

