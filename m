Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632A4C43458
	for <linux-um@archiver.kernel.org>; Fri, 10 Jul 2026 11:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hft+KFsru/NQK2GFVwrW+rNgrjQeb+hZeEo2ASl1/i4=; b=NeDUu0q64ZQoVtnrMOgGbunkiW
	XICLHHam+8QmVE/Z89Loc1mknMudWrvS+saaQL28ZXuG9dP0FcbyIgYB4K1dkk6IGdb8RHudrCg9s
	VRxAzm4u8u1+VBah0B2j+GhikJOOqLpK1pLNL/lbNKd7Lh2LeFzb82gPOm7x6dQWfKgQydY2GYmRi
	m88gR+LLfPYnHOP+oWbNrvcUyF4ZlEDTUp2122u0enn6+xCerp3BYhPiFXVvwwyy9ftgM4z+eA1a1
	HAZd85B6RE5v4DIwAyCyBRfUbJ1KOQWn0Loux0N0Os/Z0JEpIfpQnYdn+hMVLJldp2WFss5PEmVIy
	fd6rkLwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi9F7-00000004ofx-28vq;
	Fri, 10 Jul 2026 11:18:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi9F5-00000004of6-0Hbv
	for linux-um@lists.infradead.org;
	Fri, 10 Jul 2026 11:18:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783682282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hft+KFsru/NQK2GFVwrW+rNgrjQeb+hZeEo2ASl1/i4=;
	b=NC33rnHbldxTrsOAGIBUj/qjrnpbB1k9xz0F/we0kJm13bnLSTiJDQNBjuWjFgXieKdZ7o
	kGKYkHmoxkKv1OKxevY8ExJNzXjE8IjR/6FU438XKYGRhaiBm5HPOyXBqdchXJ/O869xgu
	W/AzkMNRpruP7/ohecvDC5HnATV0kiM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-1rPiqdCGMI-DqX1kFaFhcQ-1; Fri,
 10 Jul 2026 07:16:50 -0400
X-MC-Unique: 1rPiqdCGMI-DqX1kFaFhcQ-1
X-Mimecast-MFC-AGG-ID: 1rPiqdCGMI-DqX1kFaFhcQ_1783682205
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3A3E1800BDF;
	Fri, 10 Jul 2026 11:16:41 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4B2CE195419E;
	Fri, 10 Jul 2026 11:16:21 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 10 Jul 2026 13:16:41 +0200 (CEST)
Date: Fri, 10 Jul 2026 13:16:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 12/18] ptrace, treewide: Rename
 ptrace_report_syscall_entry() to ptrace_report_syscall_permit_entry()
Message-ID: <alDUhFt9eadC880v@redhat.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.280015701@kernel.org>
 <alDMlSYN1eKkjNCL@kunlun.suse.cz>
MIME-Version: 1.0
In-Reply-To: <alDMlSYN1eKkjNCL@kunlun.suse.cz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: _UdMN6l7LgEXvTrVUBGAYvt_JCReH_XU9pQ3NEIjUIY_1783682205
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_041803_170692_5B5BA57C 
X-CRM114-Status: GOOD (  14.36  )
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

On 07/10, Michal Suchánek wrote:
>
> > --- a/arch/alpha/kernel/ptrace.c
> > +++ b/arch/alpha/kernel/ptrace.c
> > @@ -375,7 +375,7 @@ asmlinkage unsigned long syscall_trace_e
> >  	struct pt_regs *regs = current_pt_regs();
> >
> >  	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
> > -		ptrace_report_syscall_entry(regs)) {
> > +		!ptrace_report_syscall_permit_entry(regs)) {
> >  		syscall_set_nr(current, regs, -1);
>
> Why is this done here?
>
> Presumably the ptrace_report_syscall_entry returns false here becasue
> the tracer put -1 into whatever register specifies the syscall number
> (or it was there to start with) which was then read back, compared to
> -1, leading to returning false.  Now it's set to -1 again?

I don't know why arch/alpha/ does syscall_set_nr(-1).

But note that ptrace_report_syscall_entry() doesn't even check whether
the syscall number was changed. It only checks fatal_signal_pending().

Oleg.


