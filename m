Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B839C3DA4A
	for <linux-um@archiver.kernel.org>; Tue, 20 Aug 2024 06:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EFXLGZEJkQUFQN28krLsjRFbPfS1YdUIsO6keM3oM8o=; b=pE3HVptF4oZeTGSUZ10p7fyIcI
	no78bw59M0p6xWFraSSEy9o0oqP5/xuUckm7PGkZpTDapaGy+C4gFWPvZZAmjvJXoGAucNS/hO1IF
	ispFSuCJNb4xxgtXNwq9qQBjU8eMVYVb8uq9XkgPIxZq5d2BkkPSAO76DiWlgQ1KrzioPDkAfziyx
	3KSrlymPIOzSkrjpPL86dUPwpYkjf0SvRSbViV42ejD/lZKwoOX94oBUbFvetrEokveTRVa4Ky/NW
	yuVr34e3W/v5wSe8PjdKFWMlh9xijjP5RyhXCo3H2aqveh6p308XVTnAStiUU6UY01ASb4IG/SNRS
	r9MHDzJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgIKZ-0000000408l-1FBd;
	Tue, 20 Aug 2024 06:26:59 +0000
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgIKW-0000000407g-0mpM
	for linux-um@lists.infradead.org;
	Tue, 20 Aug 2024 06:26:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724135209;
	bh=EFXLGZEJkQUFQN28krLsjRFbPfS1YdUIsO6keM3oM8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZDNcrElUZ2xY3s8w2eLhoYpi2YViK/FMkN+ADmqFd+TanHYCabHsCvxKxJDrMJmQ3
	 PALcnEi8+N6YuFVo/NT9ULv1COUzAljpcuypZ5EsiRuQHXj0Y4ejCBMJvxI3/YPw22
	 Cx1ZzVd1bkUvMnEHpxzGLiv+yEvYtXyS5Oje/tUckPFLL9zIPpyvzxzVgz2GUBwZ3N
	 6mpBsvhBFEiLa9uIceT/jTftvX4piUfkdT2doVoBbq3BLaEwDAGmCQLSZo7ixVG2WD
	 U/UKzAas2jHBiOPL5qaZxuF4uBCF+93ttNCAf/R7WStVDr/gZVSeIwEjWOctOtHn7y
	 lqUl+TYJ99dZA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WnzyD15rhz4wd6;
	Tue, 20 Aug 2024 16:26:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor
 <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain
 <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, christophe.leroy@csgroup.eu, jeffxu@google.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, npiggin@gmail.com,
 oliver.sang@intel.com, pedro.falcato@gmail.com,
 linux-um@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon
 <linux-hexagon@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
In-Reply-To: <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
 <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X>
 <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
Date: Tue, 20 Aug 2024 16:26:43 +1000
Message-ID: <87y14rso9o.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_232656_391494_1B52A24E 
X-CRM114-Status: GOOD (  13.42  )
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

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Mon, 19 Aug 2024 at 13:15, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Ok, I did a quick hack-job to remove that disgusting
>> install_special_mapping() legacy case.
>>
>> With this [..]
>
> I forgot to actually attach that "this". Here it is. For real, this time.
>
>                    Linus
>  arch/csky/kernel/vdso.c            | 28 +++++++++++++++++++++-------
>  arch/hexagon/kernel/vdso.c         | 14 ++++++++++----
>  arch/nios2/mm/init.c               | 12 ++++++++----
>  arch/sh/kernel/vsyscall/vsyscall.c | 14 +++++++++++---
>  arch/x86/um/vdso/vma.c             | 12 ++++++++----
>  include/linux/mm.h                 |  4 ----
>  mm/mmap.c                          | 32 +++++---------------------------
>  7 files changed, 63 insertions(+), 53 deletions(-)
>
...
> index 1bd85a6949c4..5e68ab7a8898 100644
> --- a/arch/sh/kernel/vsyscall/vsyscall.c
> +++ b/arch/sh/kernel/vsyscall/vsyscall.c
> @@ -36,6 +36,10 @@ __setup("vdso=", vdso_setup);
>   */
>  extern const char vsyscall_trapa_start, vsyscall_trapa_end;
>  static struct page *syscall_pages[1];
> +static struct vm_special_mapping vdso_mapping = {
> +	.name = "[vdso]",
> +	.pages = syscall_pages;
                              ^
                              should be ,
> +};

cheers

