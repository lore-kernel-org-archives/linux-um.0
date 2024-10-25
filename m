Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF750D0C5F6
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 09:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X8n/FFS31TMWa82sFmM9LV4LWpxmceFUUIwRVSq+8Ek=; b=yujRNm48pJUjikabO7QZ1866X9
	EmDc9SDcRlwPrSY20gQgHqcqJgTlQckDuNQUKh7k465IwUYk3MLv87tfaivHpgeYUsNoLvOr/Np9U
	/REmzB8+fPbljbhvmzwtkjfii2/ip7jJHXWSf0xQL30VJQ6n/60Sk0mGXGWNUvYG4JW2Z9w92NK8S
	SLRCE6md0RjRcAVXhQ++ZIxPUUOx/avtPgd5nnmLOjYenSta74OGCrT8gj7Lj6rIAFUUv0EyL/U+n
	W5YG2sfK/lZOminsFOFkN0UkSZq0eqNNJDXYo8TEcVnataULyLc2sTRSdDqJWczrB/oTbmwvNUYuG
	rXeekSrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GWi-000000039wB-0KkR;
	Fri, 25 Oct 2024 09:22:36 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GWe-000000039uM-3wA2
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 09:22:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=X8n/FFS31TMWa82sFmM9LV4LWpxmceFUUIwRVSq+8Ek=;
	t=1729848152; x=1731057752; b=OcGcfYBlMsOnb12bJgRYA8DwPwXZyIUpTKnP9VJLZEJQrSE
	ea7SRz0VnwQ+etcwC7C+XSIxVbeIzIdCSoHIF2Raf8yy6Oe5IYJSo5n23BqiAgqlGGN8GvByZOOJW
	rWCUpFmBIQVe//0Qeji4axWRYVHD3/XQrrkW4VffAJY6kXnH1tby1NzVXUCB5OGwDy2K6SKpHIa0d
	5angdG3BDHaxvP3fiIZ22hne6raWVtVvi1W3WTID3lrgq5KDzjrtA6ZpAYiKhZobOexXtsNVNrwe8
	pdo9IahmaWRwTwGpAR6i67K7nbzMruzty364SydB47VbF8n0Q8zGxOowRTYsqAvA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4GWc-00000004Sbk-0CmY;
	Fri, 25 Oct 2024 11:22:30 +0200
Message-ID: <002f4841451479c154acae08353b8091ffd91472.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 06/13] x86/um: nommu: process/thread handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, 
	jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: ricarkol@google.com
Date: Fri, 25 Oct 2024 11:22:29 +0200
In-Reply-To: <88b3cdd8cd1437e45184fd26c6df5d7ceb93de55.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <88b3cdd8cd1437e45184fd26c6df5d7ceb93de55.1729770373.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_022233_002620_5F6389C5 
X-CRM114-Status: GOOD (  13.53  )
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

On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
> Since ptrace facility isn't used under !MMU of UML, there is different
> code path to invoke proceeses/threads; on an entry to the syscall

typo: processes

>  /* Called magically, see new_thread_handler above */
>  static void fork_handler(void)
>  {
> -	schedule_tail(current->thread.prev_sched);
> +	if (current->thread.prev_sched !=3D NULL)

nit: no need for "!=3D NULL"

> @@ -134,6 +138,21 @@ static void fork_handler(void)
> =20
>  	current->thread.prev_sched =3D NULL;
> =20
> +#ifndef CONFIG_MMU
> +	/*
> +	 * This fork can only come from libc's vfork, which
> +	 * does this:
> +	 *	popq %%rdx;
> +	 *	call *%0; // vsyscall
> +	 *	pushq %%rdx;
> +	 * %rdx stores the return address which is stored
> +	 * at pt_regs[HOST_IP] at the moment. We still
> +	 * need to pop the pushed address by "call" though,
> +	 * so this is what this next line does.
> +	 */
> +	if (current->thread.regs.regs.gp[HOST_ORIG_AX] =3D=3D __NR_vfork)
> +		current->thread.regs.regs.gp[REGS_SP_INDEX] +=3D 8;
> +#endif

Kind of ugly ... but I guess not much choice.

> +#ifndef CONFIG_MMU
> +	current_top_of_stack =3D task_top_of_stack(to);
> +	current_ptregs =3D (long)task_pt_regs(to);
> +
> +	if ((to->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)] =3D=3D 0)
> +	    || (to->mm =3D=3D NULL))

Put || on the previous line, "!to->mm"

> +		return;
> +
> +	// rkj: this changes the FS on every context switch

Not sure we're allowing C99 comments yet, and there shouldn't be a "rkj"
tag either :)

johannes

