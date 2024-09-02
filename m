Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65271CA0ED3
	for <linux-um@archiver.kernel.org>; Mon,  2 Sep 2024 06:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HHgEOXh7sKDdLlkFOPXQwu8Qe2Jbr6SkQlE+sWd/XmQ=; b=rpLcnA8XwlY3OZ2XnSLuesUUNn
	LjwLRpmJZ1ofHiAPXZiTOFgvlUeMnkNLuKzDLgoAaRzwt+/t7bBjThhr/HU/XjQZYThgc00hUOaE4
	TXVxoCM4YFa/IZBnsw7fmUTQkZwXERuNMpE9Vg4Ta85hsc1tOuAZJ1Y3pM5pMvqUwJPp2bzSE7SAZ
	QGV/GQqdawZDC2sIQ70FJ1PeaNBdyZIZpi1sRDbJGGtXUdFW50QhsJLp2P/aYPzvUhO10LwlOfFwd
	olkFy8PJoZ9LbDQWrimRLih49JFCHh6mTUeQN/NpdlwLSQhAIoqETSWyP371CbwSTm1LCVseX89ml
	AeMs2HDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl0QZ-0000000D8Mp-39u3;
	Mon, 02 Sep 2024 06:20:39 +0000
Received: from pegase2.c-s.fr ([93.17.235.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl0Pd-0000000D8DH-3V9x;
	Mon, 02 Sep 2024 06:19:43 +0000
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wxz9y3zggz9sSN;
	Mon,  2 Sep 2024 08:19:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oh9ReoBVOWjB; Mon,  2 Sep 2024 08:19:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wxz9y2zjLz9sSH;
	Mon,  2 Sep 2024 08:19:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 50A268B76C;
	Mon,  2 Sep 2024 08:19:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id gAfIussLeGez; Mon,  2 Sep 2024 08:19:34 +0200 (CEST)
Received: from [192.168.234.158] (PO19952.IDSI0.si.c-s.fr [192.168.234.158])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B2F1A8B763;
	Mon,  2 Sep 2024 08:19:33 +0200 (CEST)
Message-ID: <5fa50d78-6764-4f99-87b3-7bd7edbeea5a@csgroup.eu>
Date: Mon, 2 Sep 2024 08:19:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: make copy_to_kernel_nofault() not fault on user
 addresses
To: Omar Sandoval <osandov@osandov.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-um@lists.infradead.org, kernel-team@fb.com
References: <cover.1725223574.git.osandov@fb.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1725223574.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240901_231942_059953_78EFA9CD 
X-CRM114-Status: GOOD (  12.79  )
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



Le 02/09/2024 à 07:31, Omar Sandoval a écrit :
> [Vous ne recevez pas souvent de courriers de osandov@osandov.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Omar Sandoval <osandov@fb.com>
> 
> Hi,
> 
> I hit a case where copy_to_kernel_nofault() will fault (lol): if the
> destination address is in userspace and x86 Supervisor Mode Access
> Prevention is enabled. Patch 2 has the details and the fix. Patch 1
> renames a helper function so that its use in patch 2 makes more sense.
> If the rename is too intrusive, I can drop it.

The name of the function is "copy_to_kernel". If the destination is a 
user address, it is not a copy to kernel but a copy to user and you 
already have the function copy_to_user() for that. copy_to_user() 
properly handles SMAP.

Christophe


> 
> Thanks,
> Omar
> 
> Omar Sandoval (2):
>    mm: rename copy_from_kernel_nofault_allowed() to
>      copy_kernel_nofault_allowed()
>    mm: make copy_to_kernel_nofault() not fault on user addresses
> 
>   arch/arm/mm/fault.c         |  2 +-
>   arch/loongarch/mm/maccess.c |  2 +-
>   arch/mips/mm/maccess.c      |  2 +-
>   arch/parisc/lib/memcpy.c    |  2 +-
>   arch/powerpc/mm/maccess.c   |  2 +-
>   arch/um/kernel/maccess.c    |  2 +-
>   arch/x86/mm/maccess.c       |  4 ++--
>   include/linux/uaccess.h     |  2 +-
>   mm/maccess.c                | 10 ++++++----
>   9 files changed, 15 insertions(+), 13 deletions(-)
> 
> --
> 2.46.0
> 
> 

