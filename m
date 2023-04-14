Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE83C77B77
	for <linux-um@archiver.kernel.org>; Fri, 14 Apr 2023 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f96RGcEkjauLw+kLuO8sqgjUM1KM3Mk50AqJuotWjak=; b=WuDexwli+iJZ+C
	qNkp1Z0Cc+Kz5vqvUf2nDLkLmowgVHyABcB7uum6BVRU3zNI6Al6RRjlNY8W//9Cvum22U9+47mvI
	Uw2qHyv5DNOPcg0xIxZCUA8ONQVwHe7Xx/Smty6i4vBuIdz+NqN9lyfOeRbH3zy2Fobn7vSUmK06J
	aM2lxeLTxUfU74+6ZZLFP5dAUX/Se+E/2eZDxJBHhd0AI+SBa2c7DOzBvTGa/XM1uNpq/l6UajSTa
	ZWbOH9JFs8ChfI0HOj65piyc8jjJG8bRnKoh4pjCI0VT3F6I6x5knVOjcVD9GV0s1CQlYf5HWtjH6
	+Fz/gQd4NCNbGSFqa81A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnJtX-009j1B-0F;
	Fri, 14 Apr 2023 13:55:19 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnJtU-009j07-0g
	for linux-um@lists.infradead.org;
	Fri, 14 Apr 2023 13:55:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4riDwi82epKmnE7d/5W5DyjvMFTPTQCx9+hBpCrTkWM=;
	t=1681480516; x=1682690116; b=JydusDmlzC3A2Jmmj1LeOrAJ8kbkeU6AAHw2eeEAeXop2Sg
	i9mrfAT9/aBiYsX6/w1jOpXUF4rcssoIY/y+ccbqLR3ZmrolHwHhxBX+3R3DY6I9fkWBNwnuf2nhH
	xl/hNOUkn8U6F5CTv+hEhZpWm1YCqYB6wNU1YXH2/v6UXj7+Rr7X/J2VoPOrXi7cu6RXFNkkgVKWO
	32EXSC2tarzzIv/UcP4KVge6pxeYeQmIhhFbewSksrPZmxtJFe9ikuik83oS5OwMZB24PAkKBgRd+
	Pp24FaXYMSBb83Y8EFqQ/DyuiNZdXP+PxXz3LC5wxHQIeASkuQtCK4XtnW3sy4Ug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pnJtM-00Fc5q-29;
	Fri, 14 Apr 2023 15:55:08 +0200
Message-ID: <099028386d683dcc585693d85b6b2739952fcdeb.camel@sipsolutions.net>
Subject: Re: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with
 TRACEPOINTS
From: Johannes Berg <johannes@sipsolutions.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov
	 <anton.ivanov@cambridgegreys.com>, Damien Le Moal
	 <damien.lemoal@opensource.wdc.com>, linux-ide@vger.kernel.org, 
	linux-um@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Apr 2023 15:55:07 +0200
In-Reply-To: <20230410011325.26850-1-rdunlap@infradead.org>
References: <20230410011325.26850-1-rdunlap@infradead.org>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230414_065516_277907_5CE99BF5 
X-CRM114-Status: UNSURE (   8.03  )
X-CRM114-Notice: Please train this message.
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

On Sun, 2023-04-09 at 18:13 -0700, Randy Dunlap wrote:
> Current build of pata_cs5536 for i386 UML fails with:
> 
> ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
> ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
> 
> Add the arch/x86/lib/msr.o binary to resolve these undefined symbols.
> 

Hm. Does this make sense? I can't see it'd work on UML to configure an
IDE device through MSRs? Surely that can't work? IOW, that entire driver
can't really work anyway can it?

OTOH, maybe theoretically it could work in PCI, just not with MSRs, and
then this patch makes some sense?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
