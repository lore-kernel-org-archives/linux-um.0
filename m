Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51088C77B7C
	for <linux-um@archiver.kernel.org>; Wed,  2 Jul 2025 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JSSCyio0xYBncmoxXNAsInkV4XW7fMPCxoFUFl57Lcw=; b=tWzK0nzwbZ32/MAwkp2KUjIVg6
	S9NieXHWDU7+XU4gsLb2VoGHyQ4egviUQbQRU3+ouoUPkbZ+E/2F7gtXE8Doo9tmjoPSJe7+wE4nS
	BzkRe04MThbM39E2J2EopgEZVuj8ZraI/98DE1n6nnYeKlpY/Qb3aY47EWhSoDFrC+EBc0fpuaxZ3
	moevXya/39WzFw+AKVLaYjKNtTvd7o8nD63FVIyBiJjz6tn0S9B2HCzgJlxfyTQwUvlJjexc9i9Re
	/mVV+5/LA0gpg23hhPSrOJsAAsS7DdcdgWdBKxLd5nOfWadnBkVtxkn8i221R/IXiVstjou9v/K/C
	/q2uH5QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWx79-00000008Nzh-1Q57;
	Wed, 02 Jul 2025 13:03:03 +0000
Received: from out187-4.us.a.mail.aliyun.com ([47.90.187.4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWx76-00000008Nyo-0oQV
	for linux-um@lists.infradead.org;
	Wed, 02 Jul 2025 13:03:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1751461371; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JSSCyio0xYBncmoxXNAsInkV4XW7fMPCxoFUFl57Lcw=;
	b=dW5k83PTojvKWGlDDMm4kPLylniexPMwK6IgBZT6fYQ8OmRj8oOqdqPIOwZ1vV2OAUblgbPCGXjIIWdrPgeV5WdL5oBeBEql3P0yHeRg+VulWaI+fsp1ymSTSy86OeZDIRq7riqgvc8QLtAWU2Uq0OWrr4gYAKE1GiOsDW78AXk=
Received: from 30.174.123.102(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.dby5PPC_1751461360 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 02 Jul 2025 21:02:47 +0800
Message-ID: <dcb0d307-a0cf-480e-888f-1020d1441d1d@antgroup.com>
Date: Wed, 02 Jul 2025 21:02:40 +0800
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
 <c71581d8-350f-4523-862f-5be84358ad8f@antgroup.com>
 <1724be1e-174c-4837-8768-83a90004f7fe@app.fastmail.com>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <1724be1e-174c-4837-8768-83a90004f7fe@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_060300_845913_5E6B6712 
X-CRM114-Status: GOOD (  11.92  )
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

On 2025/7/2 19:09, Arnd Bergmann wrote:
> On Tue, Jul 1, 2025, at 14:22, Tiwei Bie wrote:
>> On 2025/7/1 16:43, Arnd Bergmann wrote:
>>> On Tue, Jul 1, 2025, at 10:26, Geert Uytterhoeven wrote:
>>> --- a/lib/Kconfig
>>> +++ b/lib/Kconfig
>>> @@ -381,7 +381,7 @@ config HAS_IOPORT
>>>  config HAS_IOPORT_MAP
>>>         bool
>>>         depends on HAS_IOMEM && !NO_IOPORT_MAP
>>> -       default y
>>> +       default HAS_IOPORT
>>>  
>>>  source "kernel/dma/Kconfig"
>>>  
>>> It seems silly to turn off HAS_IOPORT_MAP on platforms that don't
>>> have HAS_IOPORT to start with.
>>
>> I'm not entirely clear on the meaning of HAS_IOPORT though. It looks
>> HAS_IOPORT was introduced to support disabling compilation of the I/O
>> accessor functions inb()/outb() and friends [1].
> 
> Correct
> 
>> And looking at the
>> code, xtensa supports IOPORT_MAP [2][3], but doesn't select HAS_IOPORT
>> (which is also stated in the commit log in [1]).
> 
> xtensa selects NO_IOPORT_MAP, which means that HAS_IOPORT_MAP
> gets disabled here:
> 
> arch/xtensa/Kconfig:config NO_IOPORT_MAP
> arch/xtensa/Kconfig-    def_bool n

The value of NO_IOPORT_MAP on xtensa is inverted compared to that
on most other platforms that explicitly defines NO_IOPORT_MAP.

When NO_IOPORT_MAP is explicitly defined, it is typically set to 'y',
which disables HAS_IOPORT_MAP [1]. However, on xtensa, NO_IOPORT_MAP
is set to 'n' [2], thereby enabling HAS_IOPORT_MAP.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/Kconfig?h=v6.16-rc4#n468
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/xtensa/Kconfig?h=v6.16-rc4#n82

Regards,
Tiwei


