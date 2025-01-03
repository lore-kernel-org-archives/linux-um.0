Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDEEE77198
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 05:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SIGi5SMCJUmJYg30g8DWwZYJMBTKXWhgRft845gxHoo=; b=4V4738ZxYw8lvbmPDCDw8E05Tf
	FLUnymq4AJFhv1mTHQt/W5jwelHar/6dQsDg/+1QZ48VXp6cfEF1h2hJCgf/6DEBviOuTb6fxjzse
	cnclaYyur3zfKlontXwPKjt+Z9cbDZn0CFArV6CqJQa1igQSy0jcAojoPoIXDwFutqbToZXowPXp7
	a8VdaAr10Ra3Cnhc99IRHsRuaorvMKZxyU6ulYcGgOk1qwCjexP1Xrv8Q6T6RTdFaGCjDDQuSTe0U
	nHEsuB+kotKoPSowEcTeEeI5/qy7jDCYLnHrzxE94LITnctgm8Ljg27rY7R+dgBzkbs/TV176bWpq
	y2DUYhvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTagT-0000000C9d9-0wJN;
	Fri, 03 Jan 2025 05:57:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTagQ-0000000C9b1-1nBD
	for linux-um@lists.infradead.org;
	Fri, 03 Jan 2025 05:57:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D8B725C3A56;
	Fri,  3 Jan 2025 05:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77287C4CECE;
	Fri,  3 Jan 2025 05:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1735883836;
	bh=ahkJxGtysqPWgnOL67yhgSmmIjzKoeYD0h3gq1Efw8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aQZpAR0mwD+9uME8jJKLdIKsDsBBNx7RFftbrdOt2Z9ezUhGkaSxQYeWN3B5a5lXK
	 swbw4eAbHvBcyBGp53eUADLv9enJyd7F1VABGcwP2T6kkfI7+ZcsM5B7c9YUKvQsve
	 5gOb9teUK9gxiG0ELqADgwYPpQaTpTwlUT6BuhO0=
Date: Thu, 2 Jan 2025 21:57:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: lorenzo.stoakes@oracle.com, anton.ivanov@cambridgegreys.com,
 bp@alien8.de, brendan.higgins@linux.dev, da.gomez@samsung.com,
 danielt@kernel.org, dave.hansen@linux.intel.com, davidgow@google.com,
 dianders@chromium.org, hpa@zytor.com, jason.wessel@windriver.com,
 jikos@kernel.org, joe.lawrence@redhat.com, johannes@sipsolutions.net,
 jpoimboe@kernel.org, kgdb-bugreport@lists.sourceforge.net,
 kirill.shutemov@linux.intel.com, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 live-patching@vger.kernel.org, luto@kernel.org, mark.rutland@arm.com,
 mbenes@suse.cz, mcgrof@kernel.org, mhiramat@kernel.org, mingo@redhat.com,
 peterz@infradead.org, petr.pavlu@suse.com, pmladek@suse.com,
 richard@nod.at, rmoar@google.com, rostedt@goodmis.org, rppt@kernel.org,
 samitolvanen@google.com, shuah@kernel.org, song@kernel.org,
 tglx@linutronix.de, x86@kernel.org, Juergen Gross <jgross@suse.com>, Marek
 =?ISO-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH 6/8] modules: switch to execmem API for remapping as RW
 and restoring ROX
Message-Id: <20250102215714.a37e828cf073ea6a14d30559@linux-foundation.org>
In-Reply-To: <d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com>
References: <86eba318-464b-4b9b-a79e-64039b17be34@lucifer.local>
	<d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_215718_505494_6592FC7A 
X-CRM114-Status: GOOD (  14.64  )
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

On Fri, 3 Jan 2025 02:06:10 +0000 Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> > Hi Mike,
> >
> > This commit is making my intel box not boot in mm-unstable :>) I bisected it to
> > this commit.
> 
> For what it's worth, we've found the same under Xen too.
> 
> There's one concrete bug in the series, failing to cope with the absence
> of superpages (fix in
> https://lore.kernel.org/xen-devel/6bb03333-74ca-4c2c-85a8-72549b85a5b4@suse.com/
> but not formally posted yet AFAICT).
> 
> The rest of the thread then found a crash looking to be the same as
> reported here, but you've made better progress narrowing it down than we
> have.
> 

Thanks.  I removed this series from mm.git while this is worked on.

