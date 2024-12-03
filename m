Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B25E74ADD
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 21:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YqeodRpJKebzz6fYmxkatTU7a25SHyYlpQwBNJ5fWLc=; b=QDK5di8DDsJ6iS1gVMqQFOw6I2
	hjDRRSI6qMUiIlXIx0Q7CuQl1lgt7NMuYdJGrzSG6NujB4AwFt47+f83ST39sbVO0zlbqhMOjlnE6
	DfNEzqCjDmKcC1ieUdmJK8Y792qXLs80RXT6hTCS9hOemKmTDYGx2BvUZKetDTCHkRJcQ2YBsSnJm
	riuX3zxZUKml+SOF3V62Fi9+RHg+aKkPPOBAsbjFgKzbzOIfjKLC95L1Y9FXmXJmsd+S42zAQ7JNe
	PUve8UNrxxwNDb/rBTn/czMXQcCYYip+RIOuxfdte3+yevzOKwh8gFU7blcN7H/4As4ZvWrtCWUU4
	T31LIQFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIarQ-0000000ApsB-1sMD;
	Tue, 03 Dec 2024 21:55:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIarO-0000000Aprl-0KTc
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 21:55:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A412B5C6CDE;
	Tue,  3 Dec 2024 21:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237F4C4CEDF;
	Tue,  3 Dec 2024 21:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733262909;
	bh=Euy/KchHPYfYxNOem7d+viyR5Sq8MWIJEQrAIEf42/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uy1s2U0saqh8FY5Gp25lY2ywprFHtvqXWhIqAwW2vBpmvehAcyxSnHj3dX7ALzcc/
	 HCHOBH+2hjTBDUa5xOIMic/0ftFy7jMIHzsWB+WS7Qx6QPv0RidieTB9T/dpPyKAZB
	 Wv1750G5iGhAA8odtTmwieWgbgLFMGFgXBm8VKpCsTKYgnM6FN30jzQn7j/u76cdHQ
	 mgS+/1Wz8IZ07IbG9pl9C4a/D9Amv2asu5MbvOOo3IfwYaBxVyTDhSMOKQuFeYGeMC
	 p+ZalZA/RZ6DAxwZHbIAqe2x/w8Qz0DM2z6aI1IKOKRL3HIB/QuXgJhw0Bcus+WUxP
	 hkoVhUNaJ7GFA==
From: SeongJae Park <sj@kernel.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: SeongJae Park <sj@kernel.org>,
	linux-um@lists.infradead.org,
	johannes@sipsolutions.net
Subject: Re: [PATCH v5] um: switch to regset API and depend on XSTATE
Date: Tue,  3 Dec 2024 13:55:06 -0800
Message-Id: <20241203215506.5082-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <57281ae15f35f1b7ec5b898d12de44c96827cb27.camel@sipsolutions.net>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_135510_158926_D67C4908 
X-CRM114-Status: GOOD (  24.21  )
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

On Tue, 03 Dec 2024 18:07:36 +0100 Benjamin Berg <benjamin@sipsolutions.net> wrote:

> On Tue, 2024-12-03 at 07:56 -0800, SeongJae Park wrote:
> > On Tue, 03 Dec 2024 07:01:09 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > On Tue, 03 Dec 2024 09:40:34 +0100 Benjamin Berg
> > > <benjamin@sipsolutions.net> wrote:
> > > 
> > > > Hi,
> > > > 
> > > > that probably means the size detection for the FPU state (i.e.
> > > > PTRACE_GETREGSET for NT_X86_XSTATE is incorrect on a 32bit host
> > > > in some
> > > > way.
> > > > 
> > > > Is there anything special about the qemu setup or it is just a
> > > > default
> > > > qemu-x86?
> > > 
> > > I use default qemu-system-x86_64 on my system.
> > > 
> > >     $ qemu-system-x86_64 --version
> > >     QEMU emulator version 8.2.2 (qemu-8.2.2-1.1.hs+fb.el9)
> > >     Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project
> > > developers
> > > 
> > > I forgot saying it is not just x86 but x86_64, sorry.
> > 
> > Oh, and seems my qemu has some downstream changes.  I will try to reproduce the
> > issue with upstream versions and report the result again.
> 
> I doubt that is the reason. The code tries to detect the size of the
> NT_X86_XSTATE register set and something breaks.
> 
> Thinking about it a bit, the only good explanation is that the qemu CPU
> does not have XSTATE support. This would cause the ptrace syscall to
> fetch the NT_X86_XSTATE register set to always fail (with -ENODEV).
> 
> Honestly, I just had not expected such an issue. Could you try the
> below patch to add a fallback?

Thank you, I just confiremd it fixes my issue.

Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

