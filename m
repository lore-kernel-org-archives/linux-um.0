Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CF7E77188
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MY+iiPye8+N17txRsEvkwvzUmMz0DV07GQ1GbnTJG4c=; b=3E3dYaDjYtIvB1qXEekZJKqlUG
	FOWea0F4a8VOnQ28X8vq+lmSyOOj3w7EDNpWP/OdmYaQICSxdQWQ0xJwUWpWgXBNoOYWcSd3doCIA
	5hEq79B+OX1A6QKW56lqIr8fWudap2Sv+rlq+JsdqvaRRbispWmXrnLUdBenkgQD1+NdSOqUpYkFU
	GBTJpJ0L/4QFPZjRTgRe7hkWaMtym0azzH4nqzGD3ADZI0rfGO188lrQ6T9NZ/KUZ46SQZgcMnd+L
	GZEH7ZZ33M6m8SDXOrZ7j87Y68GklgRT3A84lGbTzcWE9FB871s2dSaIptX/nSLVsmqxX+3yD5r5V
	lTdHektA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVYTv-000000094zR-3VBE;
	Wed, 08 Jan 2025 16:00:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVYSA-000000094YS-0yWi;
	Wed, 08 Jan 2025 15:58:43 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508E6Jqq032725;
	Wed, 8 Jan 2025 15:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MY+iiPye8+N17txRsEvkwvzUmMz0DV
	07GQ1GbnTJG4c=; b=dshx/WuZ0Qv/bc4mqlSJYaiOkN7jL0FodFWBDrBRH8iVF8
	WAI9eK0nOPSGi4Ue0KDd+kgkKDTntcs4bUutgiouUjDX4BlPvF1UbzvRZEeb3Yw6
	EYTqt4W5bBOGMNO5lCOURgKWnE2+9zAe6O/Oi7PzYz1zsunM//DdAAdZ5CSYAoym
	I1KKvecZW9WoTLLd5M4scUQzNpw16OKZOLo8aIO+e1US2KI25lwksMICBEo9VsrG
	Mx/KdyakeC0LBfanBnRQnFUaCc0X15p84Er7Ocmg2Dwx7xXczkSnHguQxll55fap
	bPfOIn5luAQOagl71oTApOOe3UjCBq+fJjBvpx5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441tu5ggka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 15:57:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508Fnvql003022;
	Wed, 8 Jan 2025 15:57:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441tu5ggk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 15:57:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508DgGTv013576;
	Wed, 8 Jan 2025 15:57:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap0dkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 15:57:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508FvsnU36372768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 15:57:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14B4C20043;
	Wed,  8 Jan 2025 15:57:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4553720040;
	Wed,  8 Jan 2025 15:57:53 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jan 2025 15:57:53 +0000 (GMT)
Date: Wed, 8 Jan 2025 16:57:51 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, alex@ghiti.fr,
        andreas@gaisler.com, palmer@dabbelt.com, tglx@linutronix.de,
        david@redhat.com, jannh@google.com, hughd@google.com,
        yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
        vbabka@kernel.org, lorenzo.stoakes@oracle.com,
        akpm@linux-foundation.org, rientjes@google.com, vishal.moola@gmail.com,
        arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org,
        npiggin@gmail.com, dave.hansen@linux.intel.com, rppt@kernel.org,
        ryan.roberts@arm.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH v5 07/17] mm: pgtable: introduce pagetable_dtor()
Message-ID: <Z36gfzNyKLuldFvE@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
 <47f44fff9dc68d9d9e9a0d6c036df275f820598a.1736317725.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47f44fff9dc68d9d9e9a0d6c036df275f820598a.1736317725.git.zhengqi.arch@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: idHm2yZqvsjSn96DmI6ivvBkTbSLnUtC
X-Proofpoint-ORIG-GUID: RLWMWP920gTrXASiDmVZwB5jZaufsLsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=337 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_075842_385765_D5EC3A18 
X-CRM114-Status: GOOD (  15.54  )
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

On Wed, Jan 08, 2025 at 02:57:23PM +0800, Qi Zheng wrote:
> The pagetable_p*_dtor() are exactly the same except for the handling of
> ptlock. If we make ptlock_free() handle the case where ptdesc->ptl is
> NULL and remove VM_BUG_ON_PAGE() from pmd_ptlock_free(), we can unify
> pagetable_p*_dtor() into one function. Let's introduce pagetable_dtor()
> to do this.
> 
> Later, pagetable_dtor() will be moved to tlb_remove_ptdesc(), so that
> ptlock and page table pages can be freed together (regardless of whether
> RCU is used). This prevents the use-after-free problem where the ptlock
> is freed immediately but the page table pages is freed later via RCU.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
...
>  arch/s390/include/asm/pgalloc.h            |  6 +--
>  arch/s390/include/asm/tlb.h                |  6 +--
>  arch/s390/mm/pgalloc.c                     |  2 +-
...
>  include/asm-generic/pgalloc.h              |  8 ++--
>  include/linux/mm.h                         | 52 ++++------------------
>  mm/memory.c                                |  3 +-
>  28 files changed, 62 insertions(+), 95 deletions(-)
...
For s390:

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

