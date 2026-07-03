Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FE9C43602
	for <linux-um@archiver.kernel.org>; Fri,  3 Jul 2026 20:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qc6RQIMJ3TCgtwMlpFywp2lkPnh2VJAI6hIxptvIyMs=; b=vjd0tKJFtjG7XcCK5frPrJD5jB
	TOUXpOaHovZ6p2oqy4EgAD1xJuYPSUidXy2+INk8Vq75tRjO63jGk9TpgHvzXB7Qi2P6D+Z2ygplF
	aHeYe5RmSyZ8nrCMF7c/CxdV+vXX8BUrfgYYahLANPEHByuO683qiO/AlAs+JBPUwtKANL87SnWIf
	+5HOGsJX6j/2Gtyv2bfd1h3O1Dwvy9LiHuNMW8HrMISnOVT1ea2sBsdDHWMp0ZREAqvNbnTLihRl2
	zdVYLxWnFRWMtIo5IeNAmmCUadd+7Jl78bcZwAvPAB243Q2DsTox5ZDTy3pVrBNW8hOqTB4+c9U5i
	BzPs/maQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfksU-00000007tQn-1yi2;
	Fri, 03 Jul 2026 20:52:50 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfksS-00000007tPo-1P2y;
	Fri, 03 Jul 2026 20:52:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3A304600B0;
	Fri,  3 Jul 2026 20:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A6E1F00A3E;
	Fri,  3 Jul 2026 20:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783111965;
	bh=qc6RQIMJ3TCgtwMlpFywp2lkPnh2VJAI6hIxptvIyMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=m/AEFhD/QQMVr60LVSSrHBJhZzSHloaCLPk21mBJcgCOInHXk9skqaY/SzJJ84tEX
	 UmT6M2g7SmZe+Xfl7u66KmHjHFowNBAw9iuDKrQPpkA0d+AKOFoNGiI4ScRdGq9tzV
	 5Bw71e6tMbrrNqTc7h68y+P8wFXYypmrKhsg4IoUL3B2t/kFt2ZfrsDK6qF5Axq7m+
	 0X+YpoR5DWk7RItGPbLuh218SieWYIlmdker7qyk9wbsyvgoZgAjV4Uu3czl1MVLAt
	 DcAB4UvUtBhMMozkhoRv21B/k0znEvzlBngIXWCHw9H0yTbipW6aseVsPvTnj3WZDs
	 DRMEjZMu/EqhQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Mark Rutland <mark.rutland@arm.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, oleg@redhat.com,
 richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
 linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
 kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, geert@linux-m68k.org, tsbogend@alpha.franken.de,
 James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com,
 ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de,
 richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, luto@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 chris@zankel.net, jcmvbkbc@gmail.com, peterz@infradead.org,
 wad@chromium.org, thuth@redhat.com, ada.coupriediaz@arm.com,
 linusw@kernel.org, yeoreum.yun@arm.com, song@kernel.org,
 james.morse@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
 liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com,
 yangtiezhu@loongson.cn, sshegde@linux.ibm.com, mchauras@linux.ibm.com,
 austin.kim@lge.com, jchrist@linux.ibm.com, arnd@arndb.de,
 thomas.weissschuh@linutronix.de, sohil.mehta@intel.com,
 andrew.cooper3@citrix.com, jgross@suse.com, kas@kernel.org,
 x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v16 01/18] seccomp: Convert __secure_computing() to
 return boolean
In-Reply-To: <fa1f5b39-2703-40a1-81d6-3feba87e19b0@arm.com>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com>
 <akdp6GAu77-ipsXA@kunlun.suse.cz> <87cxx4mmim.ffs@fw13>
 <akeIK5TRCjlKbzbp@J2N7QTR9R3> <akeOjqMy7HVgRRCr@kunlun.suse.cz>
 <fa1f5b39-2703-40a1-81d6-3feba87e19b0@arm.com>
Date: Fri, 03 Jul 2026 22:52:43 +0200
Message-ID: <87echjlrs4.ffs@fw13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jul 03 2026 at 13:59, Kevin Brodsky wrote:
> On 03/07/2026 12:27, Michal Such=C3=A1nek wrote:
>>> If we're changing the return type, it might be worth renaming the
>>> function something like:
>>>
>>> 	seccomp_permits_syscall()
>> Then not only it is clear which way the boolean value should be
>> interpreted, it also pervents the accidental inversion of existing
>> calls. Overall great.
>
> Totally agreed, if we have the opportunity to rename a completely
> undescriptive function name like "secure_computing" we should take it.

Absolutely no objections from my side on that.

