Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141D0C4332F
	for <linux-um@archiver.kernel.org>; Fri, 14 Oct 2022 18:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=UR4ProZE1o+G0LuCRw5a+iLvfe5oYiTTRoXzKrsGx1Q=; b=MgnF8GVl+lLQj8
	14gkHZOqwjRX2x8yevieD7/UylJVJh3EOxJe6LcuJcgeqqnwfOMpjYSqdBhqRNQosDNV7+ZEf3j//
	hML0dl6tYtdHiP6CxUYWY7x6v/z6FqH8wDiuUmgmGM1lN0Kw9dYjKmUjFEpZxw6p6tqy2bS0fp4XY
	CLzSqX2jDSgaVzPv0iCq/2qUxEq+C3cU0hGs+ffhp9xpW3BKwf/yz64wCUVYZRomuY80KJxQ6BW8G
	zouAHMNh/BJLXuy3SgDX5Ql1Y5QB7bke/k7EJPhet//J7FLHAGV6bQm7Oo+V1kQ2IovpieyWN/wS1
	LiuzAg5IZyZv0820L4lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojPce-00FdSl-CM; Fri, 14 Oct 2022 18:41:28 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojPcb-00FdS5-KO
	for linux-um@lists.infradead.org; Fri, 14 Oct 2022 18:41:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 75CFDB82352;
	Fri, 14 Oct 2022 18:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25ADC433D6;
	Fri, 14 Oct 2022 18:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665772882;
	bh=m3HaRT4Am8hiRILJCA1BmK39Zfen9jQhjt24Wl83ADg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kK+Y7Fkc2B0IlmR6GHKMpQX9PjJicT4YxghIJDDddyVv7yOlYX98IdCct89YQbwER
	 LEJ/hCd5KCyTWn9lVt7z7zNmQaHGlMpix8gMsWjGXIoMm39PdlVpuGjVxQtmTWn3BQ
	 ogubK4BE5FrJNjbsuozm+SJ8L1lHCWjLLJKVGisUALyv4GFD1RylJdrz0oluYoMLLu
	 0pTIJNo5i7/MhcpWvjX+KIEd3WRXY4TGCCBX9qunAe6pqdaFNtZerkgc+ZFoBH7mfF
	 Yu6I3ah5Fowq0B+aNg5WewpCJG6revmYR11iRIZZrvst4vsN84RB+ZcMiArik5qmmc
	 MagDOXW/o/ECA==
Date: Fri, 14 Oct 2022 13:41:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Richard Weinberger <richard@nod.at>,
	anton ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um <linux-um@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	helpdesk <helpdesk@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: Add linux-um archives to lore.kernel.org?
Message-ID: <20221014184120.GA3395472@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221014_114125_847768_7CCF5759 
X-CRM114-Status: GOOD (  12.54  )
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

On Fri, Oct 14, 2022 at 08:06:43PM +0200, Geert Uytterhoeven wrote:
> On Thu, Oct 13, 2022 at 8:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Konstantin: I believe there is a bug in the sending procedure [3]:
> 
>     tar cf full-archives.tar dir-with-mbox-files
> 
> I guess that should be
> 
>     tar cf full-archives.tar ~/linux-kernel-announce
> 
> instead?

While you're looking at typos, there's a "list-archive-marker.py" in
the last section [4] that I think should be "list-archive-maker.py".

> [3] https://korg.docs.kernel.org/lore.html#send-the-archive-to-helpdesk

[4] https://korg.docs.kernel.org/lore.html#can-we-use-mailman-archives

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
