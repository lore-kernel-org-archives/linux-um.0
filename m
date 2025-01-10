Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BA1E7719E
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 07:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2WLKmmEPE7uT96J0bnuWzAWEZ+Ks9Ue/uzhm9byypE8=; b=C+/QCYCDE+Kbk0Sqm/pwAqw7Ak
	CcJcwgJXu/69Bc+Hc/NAaextE/3DUTYsvrU7QMtnuSW4BgKCSOT2QY719rvk3Q/ZmG30xBfnkBJNB
	B8xdqIFVJgUIYYGjcInsTGa0B6EdrAiEFsUEjhOa+YviVnm0j5b1Avi8lRIe35qtf6kFfZSOjqgAw
	PojvcUq87N7NTpul/JBH8oNVVJJdY5gpN8YKL6uDiXGOrgmkgHZB6r+26pFFOINq/ACo+LhzWaWJ9
	3Ga7CJ73BWkJo3ebZUu+ROjHjAepoke7Iz9CVAVlIQ6rBdgdgAK8PPnEf5cBXD9Fg5oHnEkmLk5zV
	R/Jkv4+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9cD-0000000EOrs-2JCQ;
	Fri, 10 Jan 2025 07:39:33 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9ax-0000000EOUy-0YPq;
	Fri, 10 Jan 2025 07:38:16 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509Nx3H2001639;
	Fri, 10 Jan 2025 07:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2WLKmmEPE7uT96J0bnuWzAWEZ+Ks9U
	e/uzhm9byypE8=; b=oRQpF/U/6grcr4Snq1iRk/I9GYPWsewmz147QsJg3tlJpp
	Sm/UeyETvgjJAENQaWXaSd8cfqXr/0vuRhl8N3wtL6grgFwp/aIijZOMmhsN47FV
	f5jNMRsdgk7yT4y+tHRFOoWJtkEWYjhp56XaA02mxcT8qNb30IwNF63MXXQkZAEl
	UIlk8MTqRCqzy91KOcrwItqlnQdxp2B2h/5xAgUKTct76fC0NSNLcVTVxD2ZYQ7X
	9rxhSluh+DwsIN5cVsDEsi/dxgg4ADMCRoXyhv5xzciWSwH6XZkvVHoOuULqD2BA
	tjfE3Xo8v5ux7lwgyBH9IJOGKqLEpFGzYgoJwZfA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442rkhsd0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 07:37:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50A7YWLB014523;
	Fri, 10 Jan 2025 07:37:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442rkhsd0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 07:37:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50A5a76b015805;
	Fri, 10 Jan 2025 07:37:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtm930f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 07:37:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50A7bmZl54264154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 07:37:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCF1520049;
	Fri, 10 Jan 2025 07:37:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2113920040;
	Fri, 10 Jan 2025 07:37:47 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jan 2025 07:37:47 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Oleg Nesterov <oleg@redhat.com>, Eugene Syromyatnikov
 <evgsyr@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>, Renzo Davoli
 <renzo@cs.unibo.it>,
        Davide Berardi <berardi.dav@gmail.com>, strace-devel@lists.strace.io,
        Vineet Gupta <vgupta@kernel.org>,
        Russell
 King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@quicinc.com>,
        Huacai
 Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Geert
 Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen
 <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan
 Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne
 <shorne@gmail.com>,
        "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan
 <maddy@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer
 Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Heiko
 Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Richard Weinberger
 <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
 <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel
 <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/6] syscall.h: introduce syscall_set_nr()
In-Reply-To: <20250107230438.GC30633@strace.io> (Dmitry V. Levin's message of
	"Wed, 8 Jan 2025 01:04:38 +0200")
References: <20250107230438.GC30633@strace.io>
Date: Fri, 10 Jan 2025 08:37:46 +0100
Message-ID: <yt9dzfjz6rw5.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oQL9q4Cm2OlRS0avVKS0GOik26TaXbjd
X-Proofpoint-GUID: v26jL7-Nw4XZK-M8Nskiprqug0sq7Zhb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=723 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_233815_195244_2B215CF1 
X-CRM114-Status: GOOD (  21.23  )
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

> Similar to syscall_set_arguments() that complements
> syscall_get_arguments(), introduce syscall_set_nr()
> that complements syscall_get_nr().
>
> syscall_set_nr() is going to be needed along with
> syscall_set_arguments() on all HAVE_ARCH_TRACEHOOK
> architectures to implement PTRACE_SET_SYSCALL_INFO API.
>
> Signed-off-by: Dmitry V. Levin <ldv@strace.io>
> ---
>  arch/arc/include/asm/syscall.h        |  6 ++++++
>  arch/arm/include/asm/syscall.h        | 12 ++++++++++++
>  arch/arm64/include/asm/syscall.h      |  7 +++++++
>  arch/hexagon/include/asm/syscall.h    |  7 +++++++
>  arch/loongarch/include/asm/syscall.h  |  7 +++++++
>  arch/m68k/include/asm/syscall.h       |  7 +++++++
>  arch/microblaze/include/asm/syscall.h |  7 +++++++
>  arch/mips/include/asm/syscall.h       |  7 +++++++
>  arch/nios2/include/asm/syscall.h      |  5 +++++
>  arch/openrisc/include/asm/syscall.h   |  6 ++++++
>  arch/parisc/include/asm/syscall.h     |  7 +++++++
>  arch/powerpc/include/asm/syscall.h    |  5 +++++
>  arch/riscv/include/asm/syscall.h      |  7 +++++++
>  arch/s390/include/asm/syscall.h       |  7 +++++++
>  arch/sh/include/asm/syscall_32.h      |  7 +++++++
>  arch/sparc/include/asm/syscall.h      |  7 +++++++
>  arch/um/include/asm/syscall-generic.h |  5 +++++
>  arch/x86/include/asm/syscall.h        |  7 +++++++
>  arch/xtensa/include/asm/syscall.h     |  7 +++++++
>  include/asm-generic/syscall.h         | 14 ++++++++++++++
>  20 files changed, 144 insertions(+)
>
> diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
> index b3dd883699e7..1c0e349fd5c9 100644
> --- a/arch/s390/include/asm/syscall.h
> +++ b/arch/s390/include/asm/syscall.h
> @@ -24,6 +24,13 @@ static inline long syscall_get_nr(struct task_struct *task,
>  		(regs->int_code & 0xffff) : -1;
>  }
>  
> +static inline void syscall_set_nr(struct task_struct *task,
> +				  struct pt_regs *regs,
> +				  int nr)
> +{

I think there should be a

	if (!test_pt_regs_flags(regs, PIF_SYSCALL))
		return;

before the modification so a user can't accidentally change int_code
when ptrace stopped in a non-syscall path.

> +	regs->int_code = (regs->int_code & ~0xffff) | (nr & 0xffff);
> +}
> +
>  static inline void syscall_rollback(struct task_struct *task,
>  				    struct pt_regs *regs)
>  {

