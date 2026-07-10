Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DE6C44506
	for <linux-um@archiver.kernel.org>; Fri, 10 Jul 2026 11:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=okIzKFIsL/4R4vmkR+TFByt5pFrNsTBzPM+Bl8mNt+c=; b=RxMBesCU8XPWNrT1b7qfgiDOgH
	3IiBdAdC/kvLFdbvsUiHc8j7wf4w5LJl/YXTeaRP4aFQ7GZXkJC+rOSbg4JM3WYLQfGQXUEKJapgp
	EFDpDEI7QGuDP205HfgBJ2sQH4j6XXAfSpyC+kgGhEx2onGKNkWG8MFCpitavFnaCudYYDFGwKIPM
	IseoK2XLeUDJ9763gLVhWPAtOmkMuk445qF6ebSH5gzjiPlWU+pR792yJDhLBEOyVkcWYGVeOUFTn
	vj9g0cb85RO5KvQ787EckAYFi7WGByr740zwLYF8HGTKnOgciXCyUIUx7Z/j0oq28XBJDgowX55dj
	T7JdOIQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi9bd-00000004qI5-0LRE;
	Fri, 10 Jul 2026 11:41:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi9bZ-00000004qGJ-1R3P
	for linux-um@lists.infradead.org;
	Fri, 10 Jul 2026 11:41:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783683676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okIzKFIsL/4R4vmkR+TFByt5pFrNsTBzPM+Bl8mNt+c=;
	b=HaqNJ8BwqzmfGqzMy9UshBeMYbBy1fXbPuCXT12uHD91i9yId/r5cWfTAkSHC9JMCIC8Pn
	fbv1m5BIz1HYxwEMngw1LmlpawzODgPi57OFHwMjyvUd2sJF9ehnVuu+5QwrcO1n3h6sfM
	fbY3RwqGa6ZV9VQqy+XNKqcdj4WNMe0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-qfsr_rx-O6mPQrP7hF_qjQ-1; Fri,
 10 Jul 2026 07:41:12 -0400
X-MC-Unique: qfsr_rx-O6mPQrP7hF_qjQ-1
X-Mimecast-MFC-AGG-ID: qfsr_rx-O6mPQrP7hF_qjQ_1783683667
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B188F1800844;
	Fri, 10 Jul 2026 11:41:03 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8F127195419F;
	Fri, 10 Jul 2026 11:40:45 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 10 Jul 2026 13:41:03 +0200 (CEST)
Date: Fri, 10 Jul 2026 13:40:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [patch 13/18] entry: Make trace_syscall_enter() return type bool
Message-ID: <alDaOw8t-e3rxIPm@redhat.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.338083894@kernel.org>
 <ak5ySpil83TNWxeq@kunlun.suse.cz>
 <87se5tqkyp.ffs@fw13>
 <alDQ7isUKJFl8Va4@kunlun.suse.cz>
MIME-Version: 1.0
In-Reply-To: <alDQ7isUKJFl8Va4@kunlun.suse.cz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: rD99MDuI9JQ0YfcwJa006f4VayacQeLa8DvkeC-itFo_1783683667
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_044117_440775_F8CF1D73 
X-CRM114-Status: GOOD (  18.76  )
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
> On Wed, Jul 08, 2026 at 10:34:38PM +0200, Thomas Gleixner wrote:
> >
> >   1) The set in stone rule is that if the entry code returns -1L as the
> >      syscall number then the architecture code has to skip the syscall
> >      invocation _and_ is not supposed to change the return value.
>
> Which stone?
>
> Pics or it did not happen.
>
> >
> >   2) There is no guarantee and never has been that any of the involved
> >      mechanisms (ptrace, seccomp, tracing) will change the return value
> >      when it sets the syscall number to -1L.
>
> For ptrace to correctly emulate a syscall it needs to set the syscall nr
> to an invalid value on entry, and the desired result if the syscall on
> exit AFAICT.

I can only say that ptrace users do want to skip the syscall and set the
return value on entry.

See
	[PATCH v5 1/2] ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
	https://lore.kernel.org/all/20260709100949.94345-2-renzo@cs.unibo.it/

The changelog explains that currently this doesn't work because
among the arches which define HAVE_ARCH_TRACEHOOK (at least) arch/mips is
broken in this regard.

Oleg.


