Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F16C02190
	for <linux-um@archiver.kernel.org>; Thu, 30 Jan 2025 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BpEfUaBr1Cw8QWsiOsJ1W6pndXsaAOxt2vlVbbXMbZU=; b=W4j+gCnrGadE3clLumWR37j7Ia
	28po17MXBBNpjmOQjFdnUuD7NAWgsnGSg/u/eHIQGcOjv05AbtGqm0I96Ybqa0nxM9ZAxSDdjvEPO
	TbkrTMUTgO8LvV25VIcG80O9iY9TnSV9Ra9haQVRStzs4nNxVhLKmt5ECzOx47prG6SekexqO8n3q
	vcr+59xOCzwNd/C6Ictkc2+cKqk62OhjHzqhjWVH3/ZUQ2WSGgG9wkimBawX7c6g9L+AM69spuMkf
	2o301c9uiPdyPSnN08AOcMAYpVAK2QD22aO6zXGHCmcpw0fjEtAnutqCI2p9kY1NmhaqVbkfyvnyn
	anaAgysQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdSsq-00000008iZV-0gZ7;
	Thu, 30 Jan 2025 11:38:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdSrz-00000008iVp-0lq0;
	Thu, 30 Jan 2025 11:38:04 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U3S03G009805;
	Thu, 30 Jan 2025 11:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BpEfUaBr1Cw8QWsiOsJ1W6pndXsaAO
	xt2vlVbbXMbZU=; b=py0si/7i7sYpYpgY+Cd85pkVNtrLlOqwSMEhmRUcKRZj7F
	AdWm9g97BBEh/k1QMz1gyW8k5eUcYgkXR7GTOMktSJAFpG3LMbyg98XYXGPU8sUo
	eqeaQ4p53wCU0NhpBpfouxy1ummA3PnohqoCPPT9kZK6xXqL8bMd1HPK3stTNTCc
	i9hgrzpbOa8Oy7fd/8G+IJIcqiisWNhctW460864Z4NJPiiQN3G8K0UqP+6d4dzH
	cmzmA7ITybYy/TOKFRbQlq2Z27a5FDfLohiHJU8VcETS6330kiMTctNfd+g/5c0g
	zhFPjq0jgTlDsz9Dp+ySr7XDG4pHCTnnLQrHeZDw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fq5tvqhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 11:36:36 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50UBWjRY023426;
	Thu, 30 Jan 2025 11:36:35 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fq5tvqhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 11:36:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50U947Bm022193;
	Thu, 30 Jan 2025 11:36:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgjwkcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 11:36:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50UBaU8D29491780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 11:36:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3743200BB;
	Thu, 30 Jan 2025 11:36:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B194200BC;
	Thu, 30 Jan 2025 11:36:30 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jan 2025 11:36:30 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: linux-snps-arc@lists.infradead.org, Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andreas Larsson
 <andreas@gaisler.com>,
        John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,
        x86@kernel.org, Arnd Bergmann
 <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        linux-hexagon@vger.kernel.org, WANG Xuerui
 <kernel@xen0n.name>,
        Will Deacon <will@kernel.org>,
        Eugene Syromyatnikov
 <evgsyr@gmail.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Madhavan Srinivasan
 <maddy@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato
 <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
        Michael Ellerman
 <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
        Huacai Chen
 <chenhuacai@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen
 <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Vineet
 Gupta <vgupta@kernel.org>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        strace-devel@lists.strace.io, linux-arch@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>, Mike
 Frysinger <vapier@gentoo.org>,
        Davide Berardi <berardi.dav@gmail.com>,
        Renzo Davoli <renzo@cs.unibo.it>, linux-um@lists.infradead.org,
        Heiko
 Carstens <hca@linux.ibm.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Naveen N Rao <naveen@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Borislav Petkov
 <bp@alien8.de>, loongarch@lists.linux.dev,
        Paul Walmsley
 <paul.walmsley@sifive.com>,
        Stafford Horne <shorne@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-parisc@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Oleg
 Nesterov <oleg@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Alexey Gladkov <legion@kernel.org>,
        "David
 S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 2/6] syscall.h: add syscall_set_arguments() and
 syscall_set_return_value()
In-Reply-To: <20250130112207.GA6617@strace.io> (Dmitry V. Levin's message of
	"Thu, 30 Jan 2025 13:22:07 +0200")
References: <20250128091626.GB8601@strace.io> <yt9dwmecya4g.fsf@linux.ibm.com>
	<20250130112207.GA6617@strace.io>
Date: Thu, 30 Jan 2025 12:36:29 +0100
Message-ID: <yt9dsep0y1mq.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3aUZNse446PGQfVafhK1HcR2G4gnMUaQ
X-Proofpoint-ORIG-GUID: 64WUIlsja2UYCCT0QvJj0Ow022g8u5FP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=982 lowpriorityscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_033803_336335_9505D5CF 
X-CRM114-Status: GOOD (  28.99  )
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

"Dmitry V. Levin" <ldv@strace.io> writes:

> On Thu, Jan 30, 2025 at 09:33:03AM +0100, Sven Schnelle wrote:
>> "Dmitry V. Levin" <ldv@strace.io> writes:
>> 
>> > These functions are going to be needed on all HAVE_ARCH_TRACEHOOK
>> > architectures to implement PTRACE_SET_SYSCALL_INFO API.
>> >
>> > This partially reverts commit 7962c2eddbfe ("arch: remove unused
>> > function syscall_set_arguments()") by reusing some of old
>> > syscall_set_arguments() implementations.
>> >
>> > Signed-off-by: Dmitry V. Levin <ldv@strace.io>
>> > Tested-by: Charlie Jenkins <charlie@rivosinc.com>
>> > Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
>> > ---
>> >  arch/arc/include/asm/syscall.h        | 14 +++++++++++
>> >  arch/arm/include/asm/syscall.h        | 13 ++++++++++
>> >  arch/arm64/include/asm/syscall.h      | 13 ++++++++++
>> >  arch/csky/include/asm/syscall.h       | 13 ++++++++++
>> >  arch/hexagon/include/asm/syscall.h    | 14 +++++++++++
>> >  arch/loongarch/include/asm/syscall.h  |  8 ++++++
>> >  arch/mips/include/asm/syscall.h       | 32 ++++++++++++++++++++++++
>> >  arch/nios2/include/asm/syscall.h      | 11 ++++++++
>> >  arch/openrisc/include/asm/syscall.h   |  7 ++++++
>> >  arch/parisc/include/asm/syscall.h     | 12 +++++++++
>> >  arch/powerpc/include/asm/syscall.h    | 10 ++++++++
>> >  arch/riscv/include/asm/syscall.h      |  9 +++++++
>> >  arch/s390/include/asm/syscall.h       | 12 +++++++++
>> >  arch/sh/include/asm/syscall_32.h      | 12 +++++++++
>> >  arch/sparc/include/asm/syscall.h      | 10 ++++++++
>> >  arch/um/include/asm/syscall-generic.h | 14 +++++++++++
>> >  arch/x86/include/asm/syscall.h        | 36 +++++++++++++++++++++++++++
>> >  arch/xtensa/include/asm/syscall.h     | 11 ++++++++
>> >  include/asm-generic/syscall.h         | 16 ++++++++++++
>> >  19 files changed, 267 insertions(+)
>> >
>> > diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
>> > index 27e3d804b311..b3dd883699e7 100644
>> > --- a/arch/s390/include/asm/syscall.h
>> > +++ b/arch/s390/include/asm/syscall.h
>> > @@ -78,6 +78,18 @@ static inline void syscall_get_arguments(struct task_struct *task,
>> >  	args[0] = regs->orig_gpr2 & mask;
>> >  }
>> >  
>> > +static inline void syscall_set_arguments(struct task_struct *task,
>> > +					 struct pt_regs *regs,
>> > +					 const unsigned long *args)
>> > +{
>> > +	unsigned int n = 6;
>> > +
>> > +	while (n-- > 0)
>> > +		if (n > 0)
>> > +			regs->gprs[2 + n] = args[n];
>> > +	regs->orig_gpr2 = args[0];
>> > +}
>> 
>> Could that be changed to something like:
>> 
>> for (int n = 1; n < 6; n++)
>>         regs->gprs[2 + n] = args[n];
>> regs->orig_gpr2 = args[0];
>> 
>> I think this is way easier to parse.
>
> I don't mind changing syscall_set_arguments() this way, but it just
> mirrors syscall_get_arguments(), so I think it would be better if these
> two functions were written in the same style.  Would you like to change
> syscall_get_arguments() as well?

Oh. I'll prepare a patch for syscall_get_arguments(), wasn't aware
that this function looks the same. I'll send this via the s390 tree, so
it's independent of your patch series. Thanks!

