Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4C6C43602
	for <linux-um@archiver.kernel.org>; Fri,  3 Jul 2026 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4eAaXEt312UQloawJo+yaYovtDfAeaYocuuY17b1XAY=; b=L3IeamiPNaSINgHi25EPnFcCZ9
	GF+mRp1o0Ax2LjHz7PJRP97HjvH6e+VwYQH2ivhaz3vu4diYe/FZsSHzaauTVBn20aen5qExtbXX8
	B10tYodC5y1Tj51NNgPNTAYHrMMD6NB4gSyd8ekf2iM8CIeEDzikb1N+MvipVTFaw8MQBU+PhyxO9
	OEnvs+pwdsCWTv6O7IBcBlkLNuVDESniWh2zNPnFSXL1yEYbODiYxX+S89RYI481SW+IpKTg9IrCt
	vycImKftS5bYQNWR8tEa/1bLX84rW5zkryQztRopIDLaP5IskU6CV7+CahaDXgMRrzwj1r1avXqlH
	gC0TLvIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfahE-00000006X0N-0WXj;
	Fri, 03 Jul 2026 10:00:32 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfahB-00000006Wzb-2Dsh;
	Fri, 03 Jul 2026 10:00:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77B231FC4;
	Fri,  3 Jul 2026 03:00:23 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A98773FAA1;
	Fri,  3 Jul 2026 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783072827; bh=aCTCeigzdW+DLmQcURYHBbc2LLCBHkNsbpfYvvGCiJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7QhjRah1ACbDsWq1fyjeQXt+EKdqlo9vLYGLe10grZ3du51t6ZFb4OLnHfKmugvC
	 xYIGBaOHJhM7/+St8RX1L1+kEfNfOXq3codPouX1rlw+gMBwRumJ3t0IzbR4AAn6ks
	 AEhSYO6Tc+ug7ijrNB2evf01wmU75WbW8DbnvJvM=
Date: Fri, 3 Jul 2026 11:00:11 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>, oleg@redhat.com,
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org,
	kernel@xen0n.name, geert@linux-m68k.org, tsbogend@alpha.franken.de,
	James.Bottomley@hansenpartnership.com, deller@gmx.de,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, chris@zankel.net,
	jcmvbkbc@gmail.com, peterz@infradead.org, wad@chromium.org,
	thuth@redhat.com, ada.coupriediaz@arm.com, kevin.brodsky@arm.com,
	linusw@kernel.org, yeoreum.yun@arm.com, song@kernel.org,
	james.morse@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
	liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com,
	yangtiezhu@loongson.cn, sshegde@linux.ibm.com,
	mchauras@linux.ibm.com, austin.kim@lge.com, jchrist@linux.ibm.com,
	arnd@arndb.de, thomas.weissschuh@linutronix.de,
	sohil.mehta@intel.com, andrew.cooper3@citrix.com, jgross@suse.com,
	kas@kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v16 01/18] seccomp: Convert __secure_computing() to
 return boolean
Message-ID: <akeIK5TRCjlKbzbp@J2N7QTR9R3>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com>
 <akdp6GAu77-ipsXA@kunlun.suse.cz>
 <87cxx4mmim.ffs@fw13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cxx4mmim.ffs@fw13>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260703_030029_649594_75F36FF1 
X-CRM114-Status: GOOD (  19.68  )
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

On Fri, Jul 03, 2026 at 11:48:49AM +0200, Thomas Gleixner wrote:
> On Fri, Jul 03 2026 at 09:51, Michal Suchánek wrote:
> > On Mon, Jun 29, 2026 at 09:05:59PM +0800, Jinjie Ruan wrote:
> >> -	if (secure_computing())
> >> +	if (!secure_computing())
> >>  		return -1;
> >
> > Hello,
> >
> > I am not fond of this logic inversion. The boolean is meaningless in
> > itself.
> >
> > Previously -1 was used to indicate that the syscall was filtered but you
> > chose to invert the logic choosing true to mean syscall was not filtered.
> >
> > You could choose true to mean that syscall was fitered avoiding this
> > inversion.
> 
> That's just wrong. Boolean logic makes more sense with having
> (!condition()). Just because the old 0/-1 nonsense had it the other way
> round does not mean it has to stay that way.

100% agreed!

Bikeshedding below; sorry.

I think the bigger problem is just that secure_computing() is a terrible
name that does not express the intended semantic -- it's not clear
whether "secure computing" means "seccomp permit the syscall" or
"seccomp is enabled and some special rules now apply" or something else
entirely.

If we're changing the return type, it might be worth renaming the
function something like:

	seccomp_permits_syscall()

... so for the code quoted at the start of the mail, we'd have:

	if (!seccomp_permits_syscall())
		return -1;

... or for arm64, where we have NO_SYSCALL:

	 if (!seccomp_permits_syscall())
	 	return NO_SYSCALL.

Thomas, any thoughts on that?

It's also odd that seccomp aquires the syscall number itself via , rather
than than being passed down explicitly by the arch code. That completely
obscures what seccomp is doing, vs having:

	if (!seccomp_permis_syscall(syscall))
		...

... but I guess that saves some duplication in the ptrace code.

Mark.

