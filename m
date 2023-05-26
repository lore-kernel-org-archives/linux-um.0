Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EB6C77B7E
	for <linux-um@archiver.kernel.org>; Fri, 26 May 2023 02:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pmbJUG1pFQy53Atat6xbLW2RnK8FAQnc5UXnygmEHLY=; b=DHDKke9ymxsSfu
	vqJJ1T/Rb5exnwBDx4HJlTVorK7U1hSii1n+DSJq8NcRB5C8TpZND/o1YB6xV49tA6Nf2BXFxhU+A
	Ev6YoX/VtkUUxrJ0shBpiu+4QWwYMnJQ4NAyEojtVa0IoOagVGbkI0iQj15F24ayKmNKnfpjfCStd
	ZsQwrXRl5mM9dYhTXPApfHmwHEKhJ3nCSiNnLbPSbAYNQ6u/wZ1vjMZBwqYmyguCRIJLmL+9W98NF
	LokbKOxt+PI3Ryz3dxSL5jiYdmTQzrWCbmr62A0NJ83xKZJbQmgwAAjbh/jQAbO4boZwIuT/m83E1
	wXHE1nJYPheMwIZc6NaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2NCL-000ktJ-2J;
	Fri, 26 May 2023 02:28:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2NCH-000krd-1C;
	Fri, 26 May 2023 02:28:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 40D5264C56;
	Fri, 26 May 2023 02:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15528C433D2;
	Fri, 26 May 2023 02:28:47 +0000 (UTC)
Date: Thu, 25 May 2023 22:28:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Thomas Gleixner" <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-um@lists.infradead.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-mm@kvack.org, "Andy Lutomirski"
 <luto@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Borislav Petkov" <bp@alien8.de>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Nadav Amit
 <namit@vmware.com>
Subject: Re: [PATCH v2 2/3] compiler: inline does not imply notrace
Message-ID: <20230525222844.6a0d84f8@rorschach.local.home>
In-Reply-To: <20230525210040.3637-3-namit@vmware.com>
References: <20230525210040.3637-1-namit@vmware.com>
	<20230525210040.3637-3-namit@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_192853_470250_F541B16C 
X-CRM114-Status: GOOD (  18.55  )
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

On Thu, 25 May 2023 14:00:39 -0700
Nadav Amit <nadav.amit@gmail.com> wrote:

> From: Nadav Amit <namit@vmware.com>
> 
> Functions that are marked as "inline" are currently also not tracable.
> This limits tracing functionality for many functions for no reason.
> Apparently, this has been done for two reasons.
> 
> First, as described in commit 5963e317b1e9d2a ("ftrace/x86: Do not
> change stacks in DEBUG when calling lockdep"), it was intended to
> prevent some functions that cannot be traced from being traced as these
> functions were marked as inline (among others).
> 
> Yet, this change has been done a decade ago, and according to Steven
> Rostedt, ftrace should have improved and hopefully resolved nested
> tracing issues by now. Arguably, if functions that should be traced -
> for instance since they are used during tracing - still exist, they
> should be marked as notrace explicitly.
> 
> The second reason, which Steven raised, is that attaching "notrace" to
> "inline" prevented tracing differences between different configs, which
> caused various problem. This consideration is not very strong, and tying
> "inline" and "notrace" does not seem very beneficial. The "inline"
> keyword is just a hint, and many functions are currently not tracable
> due to this reason.
> 
> Disconnect "inline" from "notrace".

FYI, I have a patch queued (still needs to go through testing) that
already does this ;-)

https://lore.kernel.org/all/20230502164102.1a51cdb4@gandalf.local.home/

-- Steve

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
