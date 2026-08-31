Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CCEC61DD3
	for <linux-um@archiver.kernel.org>; Mon, 31 Aug 2026 19:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lfk4Zm0mu1VaJNyCW+feQLM2PduJnrH08+Q8uKNAglM=; b=TofamoaCl41OufWlguBGX9TZR1
	a0zPNvouJ2pWWcQetup3tFQBAHDWV+Hj4+F9PCPT/01TZrTOo5sT83XHp0HIkfgDQZG4GPMtFEG3l
	EbP9JV/jdU+nTHBkonpUKzRE5pbKw8AXc7Rs9np66bre9vaEYwUeROaWahMtw8G5lniB+14P9hVjg
	zQ9BrvI/NjxC8vBM/4tVG8SxlAwf1YyVsZBcImJkl5TBt0x1teT6Ij89eVR+NDCmo0GX1+I9PFgvL
	Lpz3Y+TiI+tYSmy+R5AsDK+7tydVEyc8PzcnntPPzszn5l1mUtSGQ+WnX1mCWccXBYLyN9Wn0iDTd
	NwiPZAVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x189d-0000000APJQ-1J0R;
	Mon, 31 Aug 2026 19:58:53 +0000
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x189Z-0000000APIk-3qiB;
	Mon, 31 Aug 2026 19:58:51 +0000
Received: from [IPV6:2601:646:8081:8d71:2faf:8150:30da:aafd] ([IPv6:2601:646:8081:8d71:2faf:8150:30da:aafd])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 67VJvbar3264483
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 31 Aug 2026 12:57:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 67VJvbar3264483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026082801; t=1788206263;
	bh=Lfk4Zm0mu1VaJNyCW+feQLM2PduJnrH08+Q8uKNAglM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hRWHGA+w8FeyeULwEDoEDUDPGkwf8JT2eZmPRRthmhsNz9HWOb7HiXCTZLLUmuztp
	 lWRv7ug1Z+kxGR18u2FB1NAFu/6cVMaURG6BetJiHKBnIMtH9EfefRvmdaf5cQcfWS
	 Iv6R5AMN9t7OAQ114p39WCAynQY5oir3FFMoBbYdgUDXZtV4B07Wsr3e2OhubFmvQs
	 ktT4EOmqNjonvu8hUPE3i1g0T9wDBDboBsSqe9LwY819N+bvUhSesPS4zzwQuLkCru
	 dSZCFGqC+rA/gs0WgODW7ZBr87rVZStGsxS6+U65Nf/RVAnAJDMEX94B5D/OKkRTEH
	 BWNnKAFiy16zQ==
Message-ID: <1238a07e-ce04-47d9-b8ac-8b7f557b401f@zytor.com>
Date: Mon, 31 Aug 2026 12:57:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry
 handling
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <ed8b99e6-4d90-4622-9d43-451bf6a8db2c@zytor.com>
 <20260831085056.34274A00-hca@linux.ibm.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260831085056.34274A00-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_125849_969873_82DB94FE 
X-CRM114-Status: GOOD (  12.87  )
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

On 2026-08-31 01:50, Heiko Carstens wrote:
> On Thu, Aug 27, 2026 at 03:22:35PM -0700, H. Peter Anvin wrote:
>> This isn't a hard thing to solve in any way: replacing the pointer argument
>> with a two-element structure return would do the trick. As far as I know,
>> *all* architectures that support Linux support returning structures with two
>> register-sized values in registers.
> 
> That is unfortunately not true. The s390 ABI defines that structures,
> regardless of size, are returned in a return value buffer allocated by
> the caller.

*Groan*

You guys should use an improved ABI for the kernel like i386 does (different
from the standard ABI used in user space)...

That being said, perhaps s390(x) isn't affected by the underlying problem, and
passing a pointer to a structure isn't any more expensive than passing a
pointer to a variable...

	-hpa


