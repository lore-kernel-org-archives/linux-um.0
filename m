Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B70C77B72
	for <linux-um@archiver.kernel.org>; Fri, 14 Apr 2023 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GaTBXQcHj2gTmvHBzA77BV+yAM3VbFhnZCWqEMXdKYw=; b=nYxokdg2dsBrqi
	NW8riWeUmxYXb2dpyIGvc8CEU18FYIxWoCPptPyX8bkANeLx4jRGEiKLgaNEvpHegdanD8OFwAbl3
	I8xw3u4PdGHRqzwOkUl9EjC1YH41Nhh5xAL6TrD8o7xhBjh/ZzVFvPYrWJTo96dWfp8p2hmJlqg9W
	qfHoX5Kl5lZAcstz/jxzwmUU/HEMNxOBJuMahnJd0bMQMmCT+MIG3H1o7EcETLMMcwLO6zvsEiNfw
	+qhJaePdYTDpMt3BgfSz25PKDLAxjghTjYQdfqJylLinQx4W4M4vIxvK2fvSR5XiddII0+3ZeYTyS
	RYErrJK5hRK3/UKJ3ECw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnLMf-009y8V-1Q;
	Fri, 14 Apr 2023 15:29:29 +0000
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pnLMd-009y7r-0c;
	Fri, 14 Apr 2023 15:29:27 +0000
Message-ID: <5e040d45-ab76-c62d-d7f4-e7a6a35fa8fd@infradead.org>
Date: Fri, 14 Apr 2023 08:29:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with
 TRACEPOINTS
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 linux-ide@vger.kernel.org, linux-um@lists.infradead.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230410011325.26850-1-rdunlap@infradead.org>
 <099028386d683dcc585693d85b6b2739952fcdeb.camel@sipsolutions.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <099028386d683dcc585693d85b6b2739952fcdeb.camel@sipsolutions.net>
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



On 4/14/23 06:55, Johannes Berg wrote:
> On Sun, 2023-04-09 at 18:13 -0700, Randy Dunlap wrote:
>> Current build of pata_cs5536 for i386 UML fails with:
>>
>> ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
>> ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
>> ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
>> ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
>>
>> Add the arch/x86/lib/msr.o binary to resolve these undefined symbols.
>>
> 
> Hm. Does this make sense? I can't see it'd work on UML to configure an
> IDE device through MSRs? Surely that can't work? IOW, that entire driver
> can't really work anyway can it?
> 
> OTOH, maybe theoretically it could work in PCI, just not with MSRs, and
> then this patch makes some sense?

Hi,
I was happy with v1, which just did "depends on !UML".
Anyway, I'll drop this part of the quest to make UML build cleanly.

Thanks.
-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
