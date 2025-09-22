Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6EACAC592
	for <linux-um@archiver.kernel.org>; Mon, 22 Sep 2025 16:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sAEwtjep6KPW2sIc9ODEoUQqiaNDbVlAlxP3uFXqMJs=; b=NbtOz5s6FP7FMGfT2cRBDk3Nyf
	eF9qE9blfsb2HxLRLtJWY3iz7l9sIa6RLuhmwnR5bFX/tnEqnaNvmb86qjZxWDUHL7WNiO6vOk3bS
	I9OtASxhTQBLU9NDmb/am2COrmNZYiaB2e2iivLFfZLHUEm1zWYL5wBdILe2L2Mj9FQYSBkfOWkMp
	IscvhRyL1KAeDH1kcU1Gt8NNnY4X7OawuyCCRHMMpdssfMKkVBPwEzrvxWpBZRL9A5qbs/svnERLe
	Le0tKby/r4fwDrlXzS6eOH6gHkPd9zeTlVi8kAARuiOs+c4gmICzJIpfEfeyu+6ZU0++fqg+jOoof
	wdvpn/GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0j26-0000000AvVN-2aeq;
	Mon, 22 Sep 2025 16:04:54 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0j23-0000000AvTm-347Y
	for linux-um@lists.infradead.org;
	Mon, 22 Sep 2025 16:04:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758557089;
	bh=eVcTWrZCCQXQKEvyt0ECeLBgfnYB7E4UW/QXsjEnE6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iByImEF+ESPqh+9OVfLJbkxlhK/cOt7POvbPMqVjyOl28YXYmxd3zcJo+HYOPT99q
	 oiIz8mTt9jZlhPB+oEyBjvJucJOSuoPYdjvi8uFuFOjmb+jbeP6rUvLMAbCyRHC3+R
	 pU7O/DzaK+P6RsTYduWKMZjhLbjwnh+ohe4KJi9o=
Date: Mon, 22 Sep 2025 18:04:46 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, tiwei.btw@antgroup.com
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Message-ID: <61ae09df-d65b-4c9d-a0c1-7de915246590@t-8ch.de>
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
 <20250922045020.48158-1-tiwei.bie@linux.dev>
 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
 <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
 <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de>
 <366bb558c3fd23b9a80008d923f29ed0234e17b9.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <366bb558c3fd23b9a80008d923f29ed0234e17b9.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_090451_936688_B12CFCA9 
X-CRM114-Status: GOOD (  27.47  )
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

On 2025-09-22 17:14:18+0200, Johannes Berg wrote:
> On Mon, 2025-09-22 at 16:01 +0200, Thomas Weißschuh wrote:
> > Right now it does not provide any advantage over a regular syscall.
> > Essentially it is just overhead. That said, if you do want to make a
> > real vDSO out of it, I'd be happy to help in that.
> 
> I don't know if I'd say "just overhead" - depends on which path is more
> optimised in a typical libc implementation? I'd basically think it's
> identical, no? You either link to the vDSO, or a __weak same function in
> the libc?

The code also needs to be built and maintained. AFAIK __weak is only for
the compile-time linker. The vDSO call will be an indirect call.

> > > I mean ... on the one hand, sure, it doesn't really do much after this,
> > > but OTOH it lets userspace actually use that path? So might be useful.
> > 
> > What advantage does userspace have from it?
> 
> Right now, none? But it's easier to play with if you have the
> infrastructure, and I'm not convinced there's a _disadvantage_?

So far that hasn't happened. The disadvantages are the ones from above,
nothing critical. But of course it is your subsystem and your call to make.

> > > > Also the functionality to map the host vDSO and vsyscall page into UML
> > > > userspace looks very weird and error-prone. Maybe it can also go away.
> > > 
> > > Surely host vDSO etc. is never mapped into UML userspace and never is,
> > > not sure what you're thinking of, but clearly that's wrong as written.
> > 
> > This is how I understand the 32bit implementation using
> > ARCH_REUSE_HOST_VSYSCALL_AREA and NEW_AUX_ENT(AT_SYSINFO_EHDR, vsyscall_ehdr)
> > where vsyscall_ehdr comes from the hosts getauxval(AT_SYSINFO_EHDR).
> 
> Huh, hm, yeah I forgot about that ... 32-bit. Yeah, agree we should just
> kill that. I'm not even sure it works with the host kernel trapping
> there? Oh well.

Ack, do you want me to send a patch? This was my real gripe with the UM
vDSO. I want to enable time namespaces for all architectures but these
need to be handled in the vDSO properly. For the 64-bit stub vDSO it's
not a problem as the syscalls will work correctly.
But the interaction with the weird 32-bit logic on the other hand...


Thomas

