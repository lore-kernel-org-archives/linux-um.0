Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4B3CD5BCD
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=10Edmgrg0laaIwxHzvg4Kk4mmnvvWpzveYCXBFe8JLg=; b=l1evXCtEqWjLM+
	xwNYgLynGep1ecaN2KDVRh8qbKnItAMBWwSRSXOzgHGqPLTR4vXSB3YhDLXGmrrU2um1756+miMx3
	fA4SyEl9Wc/njsamcCbX17sfO+l5WGYxpYisds+04Mrr8qmgKZpJXpT7qnOjygMZXCsY5dPu2jztS
	d32iAUIZh01EnrmxEplhebW27Ymod+RwSFkGjMzHEKpvIg32yG22pmtkArmIy9OKzjtd24iuJCt10
	DH7PkYGSL3cMNkbl+95jyk4Je3nbPdM5uh9lHJrjml2xxYT2pQ7T0NIdFTvEZVI5NKQDiZvt2Zex1
	jqYw6lkw8JjVeJeZwSKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qicTh-000kQG-2p;
	Tue, 19 Sep 2023 15:17:29 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qicTf-000kPW-1k
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 15:17:28 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695136644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ziuwOLCbw6a4ZLSyQtFECkdi5DpyFdO1Yq7Iy0MyDm0=;
	b=xfTYwe+EZSOhJ5ZWyANndueq2hUu/L4a8CM1/oAoRZtzh4dXrcGLYGZmFDRlRbbmYt7Vk5
	q2a8s67GoVgkH/vtyTkmPv/zMoH9BYGxAEHj2NTitWpnBbFutuNDI6H1JPYV43N7FKxaoQ
	4hC/61NGBBGSMcuN2eSwwtsASqR3q3H06Cy7Z7rF614qv6pL1DZ+t3J4cwWM4+dA2YExPS
	Yj2UGnTJ24Wa6zHkGlCKoO+Zi6tBfDavDhwHUDdHZm3LfgYdhB7jLgydTPgxJk5eQXI5DE
	90AM6SeB7t4A+rORL9BVHHLD86RdMOvst214XGduAHjS54S1ZtgQLqiA15ULdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695136644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ziuwOLCbw6a4ZLSyQtFECkdi5DpyFdO1Yq7Iy0MyDm0=;
	b=1eCCtDGKEUrDxtL8LY3g3sZgbE2u2Gi+z3OLPbxme25w5xD5smNfNB+DrDuC//vli78Ete
	kk+DBO2N6UphuqAw==
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Peter Zijlstra
 <peterz@infradead.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>
Cc: Matthew Wilcox <willy@infradead.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Ankur Arora <ankur.a.arora@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
 rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Richard Weinberger <richard@nod.at>, Johannes Berg
 <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Brian Cain
 <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 linux-alpha@vger.kernel.org
Subject: Re: Arches that don't support PREEMPT
In-Reply-To: <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com>
References: <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com>
Date: Tue, 19 Sep 2023 17:17:23 +0200
Message-ID: <87y1h2ur98.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_081727_742767_BBC000FF 
X-CRM114-Status: UNSURE (   7.90  )
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

On Tue, Sep 19 2023 at 15:21, Anton Ivanov wrote:
> On 19/09/2023 14:42, Peter Zijlstra wrote:
>> If you're working on one of them, then surely it's a simple matter of
>> working on adding CONFIG_PREEMPT support :-)
>
> In the case of UML adding preempt will be quite difficult. I looked at
> this a few years back.

What's so difficult about it?

Thanks,

        tglx

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
