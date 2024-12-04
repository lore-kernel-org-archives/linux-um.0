Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E55E7716D
	for <linux-um@archiver.kernel.org>; Wed,  4 Dec 2024 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uEsax6Gdc1GHK3xxwEyIv5TCqQDaaFEIB2x7aHjuHFk=; b=pjh02htbQuGP1DHe8uy6EBBKrP
	5eIZilwqO8koWmNXwEo2tbSAZnpMPk7NhQ0X+pe4Fuco9TmsevRtzOIzkEqDX9D0Nasztj0gzgTpI
	Eo2a/zBc4qeWe83dFtJjY+RjRSIPUqhFcaYhlxpwzRKGl4hiFpGjH+Io+sYUGVVnZm4vrOF8IBEjV
	KMNSJ4iNgfO40WIKq23loXj6H+2kltKfUGeumGRqvsNJJkF9XH8phjB+leNlkVWDCrxyb55v99KzT
	xTlakyq36j0WIlDCMTMfO9t09kSdS1fSE3DtnfY4NlU/XkqFKOSBkhLG5u6dfmdhrrS61oS0b7UoB
	rJyLXASA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsS9-0000000DDs3-2rBN;
	Wed, 04 Dec 2024 16:42:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsS7-0000000DDrK-2Qk7
	for linux-um@lists.infradead.org;
	Wed, 04 Dec 2024 16:42:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uEsax6Gdc1GHK3xxwEyIv5TCqQDaaFEIB2x7aHjuHFk=;
	t=1733330535; x=1734540135; b=ANqB6JT2gN+H/N5Y6AC9jB8/qSeS47wiJoY5tYBFPy4fJhh
	fr5JDKBJb0OeX5Gj+NSPV9Ml2JyajZKzUxZkR7RztiwWELYPP4tKSFApad2wcSRzdIo85wU4NZKQ9
	l/F8EM2H48ebFd2B6DEAArKuWd/SCpVYdmM/Cgj0G7qMH16/SWzJNQUoogUOjKwj3cGz7zhdPxdml
	0g2XCnK/YKGXF3XDM2MU+LutvuNQlc5AA8TRPK4V3nkxovh0TbstWu7faskeoQd2CG7sUyCkxwVQe
	HjkRq/APfYyrK3Eu0UQqnKinxEOumGmuhm7pIsVNvx4/bRv7ETybL2JKjQoYy2WA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIsS4-000000077q4-2yrX;
	Wed, 04 Dec 2024 17:42:12 +0100
Message-ID: <c5c8a72aa008fd23fd1c7f64def54e94253b3016.camel@sipsolutions.net>
Subject: Re: [PATCH v3 06/13] um: nommu: syscalls handler from userspace by
 seccomp filter
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com, Kenichi Yasukata
	 <kenichi.yasukata@gmail.com>
Date: Wed, 04 Dec 2024 17:42:11 +0100
In-Reply-To: <f1aed0f9233f49880510e9506deddd52b33c2fc6.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
	 <f1aed0f9233f49880510e9506deddd52b33c2fc6.1733199769.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_084215_615418_A678586C 
X-CRM114-Status: GOOD (  12.25  )
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

On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
>=20
> +#ifndef CONFIG_MMU
> +extern int um_zpoline_enabled;
> +#endif

That doesn't make sense, there's no good reason these two mechanisms
need to be mutually exclusive.

I think you should leave out zpoline initially, get all the other stuff
sorted out, and then add it later as an optimisation where possible (can
map at 0, can rewrite the binary, etc.)

> +void trap_sigsys(struct uml_pt_regs *regs)
> +{
> +	struct task_struct *tsk =3D current;
> +
> +	pr_info_ratelimited("%s%s[%d]: sigsys ip %p sp %p\n",
> +			    task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
> +			    tsk->comm, task_pid_nr(tsk),
> +			    (void *)UPT_IP(regs), (void *)UPT_SP(regs));

Shouldn't do that, not even rate-limited.

> +	if (err) {
> +		os_warn("SECCOMP_SET_MODE_FILTER (err=3D%d, ernro=3D%d)\n",
> +		       err, errno);
> +		exit(-1);

exit(-1) probably isn't quite right, it's more like a u8.

> +	os_info("seccomp: filter syscalls in the range: 0x%lx-0x%lx\n",
> +		__userspace_start, __userspace_end);

not sure we need that, but at least it's only once?

> +#ifndef CONFIG_MMU
> +static void sigsys_handler(int sig, struct siginfo *si, mcontext_t *mc)
> +{
> +	struct uml_pt_regs r;
> +
> +	if (!um_zpoline_enabled) {
> +		/* hook syscall via SIGSYS */
> +		mc_set_sigsys_hook(mc);
> +	} else {
> +		/* trap SIGSYS to userspace */
> +		get_regs_from_mc(&r, mc);
> +		trap_sigsys(&r);
> +		/* force handle signals after rt_sigreturn() */
> +		mc_set_regs_ip_relay(mc);

I don't understand why this behaves differently with and without
zpoline, it seems it shouldn't need to. Anyway, still think zpoline is
future work.

johannes

