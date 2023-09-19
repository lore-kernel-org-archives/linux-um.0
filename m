Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78884CE79AA
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 18:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4aWEp0zNLoqcyHKMxGbC8Ml7HHLvVwNBrLjx/kNkfCY=; b=MGkmRLhcQhtPWW
	xL6IBoFlDPoe/RTab2RQ+m2RoHKh6sRNvSoEp/9C+pXTe6fSsLuphbporI14Kv9x9ct8XxmHZt7rh
	YA01kh5ELwsDoof3rqmsv1GZm29BcEb+0P0LAe3VsqvMIHwI9+/cKAzhs00LUODDhESBVy4UGKmdo
	xvcHCnJDnBe6bFNmr8tT38CbRm+GNG67fUYg0smhedYHeXVHOmdFVcbs50Ijjjyz91bo1Ex4IBc3m
	gozxOqbEl++Mm8+eR3E5VCXqJMyvN1orDf4VVUmz+YBoZN3M31SiOeOy/rRIaiZiFP/wbDWT7QgKN
	ScgfY150qAA7+Ribtp5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qifbf-0015M5-2g;
	Tue, 19 Sep 2023 18:37:55 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qifbc-0015KL-2U
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 18:37:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 542FBB8168C;
	Tue, 19 Sep 2023 18:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CD8C433C8;
	Tue, 19 Sep 2023 18:37:43 +0000 (UTC)
Date: Tue, 19 Sep 2023 14:38:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Zijlstra
 <peterz@infradead.org>, Matthew Wilcox <willy@infradead.org>, Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
 luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
 jgross@suse.com, andrew.cooper3@citrix.com, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Brian Cain
 <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: Arches that don't support PREEMPT
Message-ID: <20230919143816.1741760a@gandalf.local.home>
In-Reply-To: <87pm2eui95.ffs@tglx>
References: <87zg1u1h5t.fsf@oracle.com>
	<CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
	<20230911150410.GC9098@noisy.programming.kicks-ass.net>
	<87h6o01w1a.fsf@oracle.com>
	<20230912082606.GB35261@noisy.programming.kicks-ass.net>
	<87cyyfxd4k.ffs@tglx>
	<CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
	<87led2wdj0.ffs@tglx>
	<ZQmbhoQIINs8rLHp@casper.infradead.org>
	<0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
	<20230919134218.GA39281@noisy.programming.kicks-ass.net>
	<a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
	<CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
	<87pm2eui95.ffs@tglx>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_113752_984437_9BB723A9 
X-CRM114-Status: GOOD (  11.21  )
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

On Tue, 19 Sep 2023 20:31:50 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> The removal of cond_resched() might cause latencies, but then I doubt
> that these museus pieces are used for real work :)

We could simply leave the cond_resched() around but defined as nops for
everything but the "nostalgia club" to keep them from having any regressions.

-- Steve

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
