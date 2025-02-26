Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58706C021B8
	for <linux-um@archiver.kernel.org>; Wed, 26 Feb 2025 13:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HCKfrFYRRQmKsYa/z4pOerVlFi/2lb9UNKaw5O+iG2I=; b=wQzQj7wTjKpaH2ckK4Mi/Fc5no
	PQV7AG+bM2j6XuOzYF8RRVYxYtV9/d3rqMSknYnEACdyKpJS/sPa7D2FgZKtQusYihi6H3iK467qb
	wK2lJWU1p6dcAWWfoVSB4cE9eJ9Uo945aZPEItTlPW3C/GJYjtWs9qRwzkl5kdF0jwE7402rh0SUr
	1SbJs2+K9LsUGhL4HaDJA+Jnc8RFDIty1MgGiwwA0gw6YIVA91WsKMjUxi/hcfKqh+z5sZN3HR4D9
	EeINmHFAStecw98zBJ2sNEfn0F0jfYaayGehW4NuLxJLCUyeBWT8Ps/kDNxx6t1sVkUtJXEItKZu+
	728HRzXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnHT1-00000003vXY-0OAC;
	Wed, 26 Feb 2025 13:28:51 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnHNY-00000003pDF-49uI
	for linux-um@lists.infradead.org;
	Wed, 26 Feb 2025 13:23:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 97EF66123E;
	Wed, 26 Feb 2025 13:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1F9C4CEE9;
	Wed, 26 Feb 2025 13:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740576191;
	bh=jp+L3EEqUZilFyzTlCkcQPWm08dxgvd2umLQ5g78EOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkECZJmpQ5FtsegftLysD8xfz7G0DFh0TmuCy7MPfs2ABM4y5cfjhJbBzXNXHoXtD
	 vRySXb0kcQjiCdn5a5bO2r3tlJszbVVPu53nRX9Hp4qGoihkQbNcT668cukq/FtZ5a
	 ZidvZV4WLk32YqnICphiGO8wNzaDIyXnQgmC5S9PnN6BoyPWDvKbKmOC5OnpP71vZV
	 DPvQia7UAZ3rfJiQLelgwaugPyl9dg28FrwKUigUC+oAI4ta4XRF0+u1BQiEO4hiWN
	 +ff5pjWqDEicckbrmnHiXx7kOtM3I+Z/R4oDppD96lqpFpDasgWtqvbhuJ/H7FUaa9
	 OhROKKLRMO47g==
Date: Wed, 26 Feb 2025 14:23:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-arch@vger.kernel.org, linux-um@lists.infradead.org,
	x86@kernel.org, briannorris@chromium.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH 3/3] x86: avoid copying dynamic FP state from init_task
Message-ID: <Z78Vt8yCcPrFQeqo@gmail.com>
References: <20241217202745.1402932-1-benjamin@sipsolutions.net>
 <20241217202745.1402932-4-benjamin@sipsolutions.net>
 <Z78SVdv5YKie-Mcp@gmail.com>
 <159a83bf5457edbabcc1e88ee5ab98cf58ca6cb0.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159a83bf5457edbabcc1e88ee5ab98cf58ca6cb0.camel@sipsolutions.net>
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


* Benjamin Berg <benjamin@sipsolutions.net> wrote:

> > Note that this patch, while it still applies cleanly, crashes/hangs 
> > the x86-64 defconfig kernel bootup in the early boot phase in a KVM 
> > guest bootup.
> 
> Oh, outch. It seems that arch_task_struct_size can actually become 
> smaller than sizeof(init_task) if the CPU does not have certain 
> features.
> 
> See fpu__init_task_struct_size, which does:
> 
>   int task_size = sizeof(struct task_struct);
>   task_size -= sizeof(current->thread.fpu.__fpstate.regs);
>   task_size += fpu_kernel_cfg.default_size;
> 
> I'll submit a new version of the patch and then also switch to use
> memcpy_and_pad.

Thank you!

	Ingo

