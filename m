Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48171C43458
	for <linux-um@archiver.kernel.org>; Fri,  3 Jul 2026 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GmRpAk0oLfd0gWfVh+rqnEOK9BfphxBIPqfUy4WToJg=; b=TPrrYgsrSILwV7yEKX6UIpZUem
	5ngpow5Q5BU8X/PxaOeiDJ+b0HnRj+NA8/rMDi88NLOM5M0WGl534i8Ag3SWBe1xPMII2y3wthNgs
	c0zqcz0JHbJk8N869tFeu8RUn0P/kQudsfT+E2CfBjuBaZVZUvD5UWjnknLqHksb1+knR9R4p1zYK
	f4EJVp4tLnvWCU08RQJTXilmD9yEw+KPptOkUW2GUmCeQ11vzklJm1h7AGzYSOV6sLYtcbNULGUyp
	wnky8TDNVUjIs36Zcdz7CK3993dOGzyUYrdzYbSSVd1FrtMnBvuyLk1lCtlof/adsgbq61EK72lLp
	zzxNe7vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wflJH-00000007vUr-3wW3;
	Fri, 03 Jul 2026 21:20:31 +0000
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wflJC-00000007vUA-39EH;
	Fri, 03 Jul 2026 21:20:30 +0000
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 663L1ZSA3634717
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 3 Jul 2026 14:01:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 663L1ZSA3634717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1783112500;
	bh=GmRpAk0oLfd0gWfVh+rqnEOK9BfphxBIPqfUy4WToJg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XsI115ZBOQE6RF8kLr3qg2nWr/ZTSr4Cc85qgkCOplrXGEthFkxyO4lr4Oxope3Ei
	 uXNwCi3aZ7FCtu+IMJnAqz2+ucRqWMj1Z7USJtc8sJ3JeZ97gpLik9L3v7EKJiITZs
	 v3dorB7yOn0T5r2CkG54hpyoXlryh4wtyjAKA2DelYGyZEF7zAgS971DjfDngm3ESi
	 xNG5a833nv7cyD8PK/+FW1vBKez1uSFK+Mw4JZVnFQTsSNU/45Xgc7/odbqex1xmxx
	 hXA4rZMcbl0HR+NkDB+kp5lErI+aTQzy/C6IBW2f20LsUByG25W5uHpF7doGhQ6iHG
	 wsGBsVIphvsfg==
Date: Fri, 03 Jul 2026 14:01:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Thomas Gleixner <tglx@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>,
        =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
        Mark Rutland <mark.rutland@arm.com>
CC: Jinjie Ruan <ruanjinjie@huawei.com>, oleg@redhat.com,
        richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, geert@linux-m68k.org, tsbogend@alpha.franken.de,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, chris@zankel.net, jcmvbkbc@gmail.com,
        peterz@infradead.org, wad@chromium.org, thuth@redhat.com,
        ada.coupriediaz@arm.com, linusw@kernel.org, yeoreum.yun@arm.com,
        song@kernel.org, james.morse@arm.com, anshuman.khandual@arm.com,
        broonie@kernel.org, liqiang01@kylinos.cn, pengcan@kylinos.cn,
        ryan.roberts@arm.com, yangtiezhu@loongson.cn, sshegde@linux.ibm.com,
        mchauras@linux.ibm.com, austin.kim@lge.com, jchrist@linux.ibm.com,
        arnd@arndb.de, thomas.weissschuh@linutronix.de, sohil.mehta@intel.com,
        andrew.cooper3@citrix.com, jgross@suse.com, kas@kernel.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v16_01/18=5D_seccomp=3A_Convert?=
 =?US-ASCII?Q?_=5F=5Fsecure=5Fcomputing=28=29_to_return_boolean?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87echjlrs4.ffs@fw13>
References: <20260629130616.642022-1-ruanjinjie@huawei.com> <20260629130616.642022-2-ruanjinjie@huawei.com> <akdp6GAu77-ipsXA@kunlun.suse.cz> <87cxx4mmim.ffs@fw13> <akeIK5TRCjlKbzbp@J2N7QTR9R3> <akeOjqMy7HVgRRCr@kunlun.suse.cz> <fa1f5b39-2703-40a1-81d6-3feba87e19b0@arm.com> <87echjlrs4.ffs@fw13>
Message-ID: <F0993CE8-27EB-42D9-80F7-04A7A73C2395@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260703_142028_934364_C2ACA1F9 
X-CRM114-Status: UNSURE (   7.49  )
X-CRM114-Notice: Please train this message.
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

On July 3, 2026 1:52:43 PM PDT, Thomas Gleixner <tglx@kernel=2Eorg> wrote:
>On Fri, Jul 03 2026 at 13:59, Kevin Brodsky wrote:
>> On 03/07/2026 12:27, Michal Such=C3=A1nek wrote:
>>>> If we're changing the return type, it might be worth renaming the
>>>> function something like:
>>>>
>>>> 	seccomp_permits_syscall()
>>> Then not only it is clear which way the boolean value should be
>>> interpreted, it also pervents the accidental inversion of existing
>>> calls=2E Overall great=2E
>>
>> Totally agreed, if we have the opportunity to rename a completely
>> undescriptive function name like "secure_computing" we should take it=
=2E
>
>Absolutely no objections from my side on that=2E
>

Hell yes=2E=20

