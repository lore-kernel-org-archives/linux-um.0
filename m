Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2D0C4332F
	for <linux-um@archiver.kernel.org>; Mon,  6 Nov 2023 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T7sbufs5kTTgM2R9JcgvUSie3u/C96Nvhjslts5OeVc=; b=xKUnuXU8iigH61
	Yqx86mSHIZad63xzcjlWwuau6tn4KOTKS7xSBBYaVDD9hq04gpIsOf+UUi38w02s0QezgeQlVnA6x
	k3Anh9MHqnT+6RJpGYR+zbPtK6AAm04ISiRoenPTTKIkGJ9DpQdqT4HBTJMBZJGy/t5/dJ9O0yOXO
	+e3QOABFHdgoycoDY5c3t9To4rA1iwXO49lKF9kOSB7WJjIVEl/H9ltcw8LjI1I8qwQLk4vHnDkgZ
	gZ/jjWVM9LIwrqiU7fMybr44PRcLkQ4Tq1ogQimDDtfj00SHy6XYk6FPJ0t86JLTIqM6wYP9HaKLC
	+IeR9GpucYcVKoh/uipQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r06OP-00HWCE-0t;
	Mon, 06 Nov 2023 20:40:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06OM-00HWA7-2L
	for linux-um@lists.infradead.org;
	Mon, 06 Nov 2023 20:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LV4SaRoVTeYXOUa0lriFjTOhuj7g4S8hXczoP7gmiPo=;
	t=1699303211; x=1700512811; b=HC2nKx+PMkefQ2HJuZQNq1ca7B6Prwa3M69OsXLg6KJyxfc
	zQlfZvZyl0mhhS7kOHLICUOyH2hBRJ90e7j74IUhWv9cJf9kni2eP6GxoOVWF7IuidYXTufYiRZlw
	uMz/eumgMD4xecTzT1rz/xF184oCBMq2xLsS3fUoIwmsn3+ehMK8+mSdosavA8D2mVB91/1ApW0Dt
	8K1GxXfeCSyTL5nHBx4Xdopn+QP4oiKc+73IIXGuoKMKhMSla9Ihc4Ndu5BBKlVTMOiMLj86kCyRj
	/0qyF+M5o3WR6e8BQk6jOKzJmESOTAbsy51jDpw6XzGYwEaeky1JBP5WUDRELZ2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r06OC-0000000FtDG-1kQu;
	Mon, 06 Nov 2023 21:40:04 +0100
Message-ID: <a40a4f7c95e2e2f320b351978c7d16a7d3c29d85.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 09/11] um: Delay timer_read in time travel mode only
 after consecutive reads
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Mon, 06 Nov 2023 21:40:03 +0100
In-Reply-To: <20231103-bb-timetravel-patches-v1-9-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-9-e2c68efcf664@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_124014_772484_2EE0799F 
X-CRM114-Status: UNSURE (   8.83  )
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

On Fri, 2023-11-03 at 16:41 +0000, Benjamin Beichler wrote:
> Given the presence of numerous timer_read calls in well-behaved code
> within the kernel and userspace, particularly those that do not employ
> busy loops, we introduce a delay in reading the timer only after several
> consecutive attempts (currently set at 10).
> 
> Unfortunately, it is challenging to differentiate between various
> callers and pinpoint specific misbehaving code, so this is only a
> mediocre heuristic.

Could use with some more comments in the code I guess. :)

Generally I'd say what we have now isn't a _problem_, but in a sense if
you implement infinite CPU speed ... why does reading the time take
time? Not that I think it's _wrong_, and arguably you always should've
expected reading time to take time, but ...


Arguably though this should be squashed with the next patch since you
restrict it there?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
