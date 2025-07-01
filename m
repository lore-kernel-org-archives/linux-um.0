Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8512C8303A
	for <linux-um@archiver.kernel.org>; Tue,  1 Jul 2025 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7esW/yK2Ns6SLZnOUSKrafMmAGOUpfV8Cs3qACaymS4=; b=scVCrMP3YCAbgAQ7p8YSudXDhv
	U6Ptkykqoarvj/JTK1FVa/1/0dcj36NL1lEXB5AEKjtFfPhbsZiUlNLx1+EYiABBxnrGdOoTRsEfy
	e6oQOcUv8YWZkP+O2IcPTcpqO4PD1EOES6Mp6wVz5Xx01HFLo0gsokRewGu5E7RCxDUpohU6hU0KE
	jEuVPTJnixWHFyCnhGj8bCGxI3jN/y8Wj/W9ta1IxIz0qWy2yOAV7mvbWW+nvb21Kr7wAfS7Nz9L/
	yDTKmkM8XWYm8s+6eabuxR/3mQQZp4N9aRnT68Rt4ubDJGmPZF3pDBJkpEmbOVAM9boMPhnVDkdsV
	dR0BwH6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWbKE-00000005ZCc-2aT0;
	Tue, 01 Jul 2025 13:47:06 +0000
Received: from out0-220.mail.aliyun.com ([140.205.0.220])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWa0X-00000005Cq8-2S61
	for linux-um@lists.infradead.org;
	Tue, 01 Jul 2025 12:22:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1751372555; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7esW/yK2Ns6SLZnOUSKrafMmAGOUpfV8Cs3qACaymS4=;
	b=QZE/N4yjBnh8fsXtf2MGXTPcKpMxpNI028XyOkCTIoroFWnxcAwi2t2RJ1hEqZ2w02tXOj6K0vjtIJ81h6xysdXWfXBcvC3Yoc/7VaPGZys+asYGNrmsfiSUT82Pt8heB4VIc/VjCjT1U9BjxRvRyMERb/JTp7KWueB80plrPj4=
Received: from 30.230.89.205(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.daiTUCq_1751372548 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 01 Jul 2025 20:22:33 +0800
Message-ID: <c71581d8-350f-4523-862f-5be84358ad8f@antgroup.com>
Date: Tue, 01 Jul 2025 20:22:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Turn HAS_IOPORT_MAP off
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 kernel test robot <lkp@intel.com>
References: <20250628164740.353989-1-tiwei.btw@antgroup.com>
 <CAMuHMdUa1D3mLtNfOhE9RB7uWyf765-9kiQzG5ku05zz2f+zjw@mail.gmail.com>
 <e7d95c03-5098-401e-b885-1569822cdd0e@app.fastmail.com>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <e7d95c03-5098-401e-b885-1569822cdd0e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_052242_128076_2F320465 
X-CRM114-Status: GOOD (  14.39  )
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

On 2025/7/1 16:43, Arnd Bergmann wrote:
> On Tue, Jul 1, 2025, at 10:26, Geert Uytterhoeven wrote:
>> CC arnd

Thanks for CCing Arnd. I missed that.

>>
>> On Sat, 28 Jun 2025 at 18:48, Tiwei Bie <tiwei.btw@antgroup.com> wrote:
>>> Since we don't have port I/O support, we should turn HAS_IOPORT_MAP
>>> off as well. It will fix clang warnings like below:
>>>
>>> ./include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>>  1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>>>       |                                                   ~~~~~~~~~~ ^
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202506271049.MtzHqdSd-lkp@intel.com/
>>> Fixes: b8c9c3b822fe ("um: stop using PCI port I/O")
>>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>>> ---
> 
> I think this one would be a more generic solution,

+1

> does that work for you?

Yeah, that works for me. :)

> 
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -381,7 +381,7 @@ config HAS_IOPORT
>  config HAS_IOPORT_MAP
>         bool
>         depends on HAS_IOMEM && !NO_IOPORT_MAP
> -       default y
> +       default HAS_IOPORT
>  
>  source "kernel/dma/Kconfig"
>  
> It seems silly to turn off HAS_IOPORT_MAP on platforms that don't
> have HAS_IOPORT to start with.

I'm not entirely clear on the meaning of HAS_IOPORT though. It looks
HAS_IOPORT was introduced to support disabling compilation of the I/O
accessor functions inb()/outb() and friends [1]. And looking at the
code, xtensa supports IOPORT_MAP [2][3], but doesn't select HAS_IOPORT
(which is also stated in the commit log in [1]).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fcbfe8121a45152a3cfbe1c28c96a3b611b7347d
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/xtensa/include/asm/io.h?h=v6.16-rc4#n25
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/xtensa/Kconfig?h=v6.16-rc4#n81

Regards,
Tiwei

