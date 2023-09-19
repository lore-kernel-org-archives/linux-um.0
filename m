Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE236CE79A8
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=REFyYwqEV3kqJPoTux+EtvSopD7LdiTpwzRrRFqJbGU=; b=ftFoKjAlT7dHtx
	LsHxiSHl1auvQ02wVL/OoSCHgASdWow4vJXdkn5rAbCJiXZB0j0IhMlTrcUm81EUug2Dnz9AYo9dU
	qv8X7IUrUNjFdIM7RNehY3+qYR4XDHRKoXJVeVcaueMUCzMNx5Q5WazAREXbbMdBO1znP93xcrtxR
	hJYstnQrV1jzijA3UER6ZWjG5xGwq9iUS8I94l/YJgd0MfPXl9LPRfJeByl69L+CbcDj9maYY+h9Q
	9pxoFM9ExZ90zXdUSuc+sgHal7y5ewZMHLQL/IR9ePo2COw5/qa0gW4eyQw4Gy/zH6Bj6BzG0Mfj+
	DCauohvgFRn8qL4INjYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qicrZ-000mit-25;
	Tue, 19 Sep 2023 15:42:09 +0000
Received: from [2601:1c2:980:9ec0::9fed]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qicrX-000mij-35;
	Tue, 19 Sep 2023 15:42:08 +0000
Message-ID: <04b8a6de-2b20-4488-b20f-c8a8f6001fd2@infradead.org>
Date: Tue, 19 Sep 2023 08:42:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Sep 19 (UML)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-um <linux-um@lists.infradead.org>
References: <20230919163728.78432283@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230919163728.78432283@canb.auug.org.au>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 9/18/23 23:37, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230918:
> 
> New tree: kvm-ppc
> 
> The mm tree gained a boot warning for which I reverted 5 commits.
> 
> Non-merge commits (relative to Linus' tree): 5750
>  3717 files changed, 446028 insertions(+), 107378 deletions(-)
> 
> ----------------------------------------------------------------------------
> 

on i386 or x86_64:

../arch/x86/um/../kernel/module.c: In function 'execmem_arch_params':
../arch/x86/um/../kernel/module.c:54:50: error: implicit declaration of function 'kaslr_enabled'; did you mean 'kasan_enabled'? [-Werror=implicit-function-declaration]
   54 |         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_enabled())
      |                                                  ^~~~~~~~~~~~~
      |                                                  kasan_enabled



git blames this on:

commit 12633d679796
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Sep 19 15:14:03 2023 +1000

    Revert "arch: make execmem setup available regardless of CONFIG_MODULES"
    
    This reverts commit 3300c3af20090ff5e03e5c4bf2ef2cfaa03d4e9b.


-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
