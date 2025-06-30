Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FD1C8302B
	for <linux-um@archiver.kernel.org>; Mon, 30 Jun 2025 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dZVMGl4ViErQo4fFQ8VUnT+LNcHK9FWrYiT4XPKoVoU=; b=f6Kg3fnooIBBtGOnuQj/BJy7dn
	BDIAbKjuXg1o9NJTYL6eKvZ25PBLkvz/90kVwHTddgPCaXGuPYi9yy7XZZsshwkTR5iSDpPUkqHiY
	iP+M7IdRNnaKLFcvZzktqJ/p9QWvUVXkyGJIYEzdNG5ECxO82SGzvB5qfqxeW5xsA8p9+5E6NdrOk
	JL06WyjXcficeKpoFa4PZkQtFHGSb70QMXDS87/9Ify/oD2Pgdu/F/Vfg7FEoGPlXa6ZJ1S3NUq6J
	iR2OZEdtuCnFJ/ectBXLW+vXfasU/KjMM3ZLFTA0Ic3pwlsO1GrnMZwMdowW/YehPYyNPMFQycm9l
	KBnT6UXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWGCa-00000002i5q-3Ek1;
	Mon, 30 Jun 2025 15:13:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWFga-00000002blI-2vyv;
	Mon, 30 Jun 2025 14:40:45 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U8xoVD015498;
	Mon, 30 Jun 2025 14:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dZVMGl4ViErQo4fFQ8VUnT+LNcHK9F
	WrYiT4XPKoVoU=; b=LvjN75Dcyo3Mg6vi1nvhrVHjbLsaMQ+4ridZrQWrM5H+m4
	T8k7nKbVNZ4P7K7v/YGFuTeD2t7rOEw9IaJObFYMGeSqzJW7/zUSRGhEe0/hx5KT
	b8vcmp1YHBa9oTnPU4DF8grkhIf/VLHFHTcE08pIbZzxWZUGXKBIDZwvbNF9G5nz
	UcjjbUZ0QbBD7OtNYaaavGW0IqlsOhQZVwtNTtYOQn3JEOk5FOBKJ7yZEoSATva+
	VqslOGK+1/R7RzXo65jlAXvy/+RPaXenkxiJffflbZSg9xEnWzdPg4gZSgEZKbtZ
	n6Cby79kZ59Mh8Ypp+uc1phO9exlUyIpDaSLPKsA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wra0bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 14:39:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55UEX7fk002972;
	Mon, 30 Jun 2025 14:39:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wra0br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 14:39:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55UE1gX6021934;
	Mon, 30 Jun 2025 14:39:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpe8ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 14:39:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55UEdc3544761382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 14:39:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DE0A20043;
	Mon, 30 Jun 2025 14:39:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8161D20040;
	Mon, 30 Jun 2025 14:39:35 +0000 (GMT)
Received: from osiris (unknown [9.111.82.77])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 30 Jun 2025 14:39:35 +0000 (GMT)
Date: Mon, 30 Jun 2025 16:39:34 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        chris@zankel.net, jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
        justinstitt@google.com, arnd@arndb.de, rppt@kernel.org,
        geert@linux-m68k.org, mcgrof@kernel.org, guoweikang.kernel@gmail.com,
        tiwei.btw@antgroup.com, kevin.brodsky@arm.com, benjamin.berg@intel.com,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 01/11] kasan: unify static kasan_flag_enabled across
 modes
Message-ID: <20250630143934.15284Caf-hca@linux.ibm.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
 <20250626153147.145312-2-snovitoll@gmail.com>
 <aGKDhPBgDv2JjJZr@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGKDhPBgDv2JjJZr@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E/PNpbdl c=1 sm=1 tr=0 ts=6862a1b1 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=AeL96baZ9YmIqE4yH0MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 2hwphgPZI837FabFeudLVjFicIoSmhXG
X-Proofpoint-ORIG-GUID: FiHtpeYVQCPMFgF1X9Rek_sDm6f0w0qN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExNyBTYWx0ZWRfXydsoblXBR0ze E9HvMeQ14kc+Woe5xd/SFPBcu0vlwEb2rfyIotIQPVlF4ubkEgP5011gPNTSWqTF2yHh0XA+4Ys YtUR6UrKRuqNmHUZHfVrDRMN52XXJ8jmaoDUHFwngVMl/S0kuPwOX0KnQ08i7W5uZum6/pQlsxH
 PSRM68qtAJ+io/RlKpS8hVyp8JhMgoeN7tOOZYNJa4YzA3PSVAQzl1PZ5jjF5v+hYU4evHZAXNO 9IYq4VHNT7cT81dC5A7Z/s9IYQVPzNtDhaXj0Dc9jHPz9/phE/B/idozZZjcYiqY6iFL3AYGZq0 UJK05i7AMCYmP5WJn4xDjjygHxdSbNqoEBEmoYZebnEX4uBv0r9o5LI1Se2/L8pc7bQ8CW0e8qY
 COnK5bFnlwiVLGEKcvd+kJLxqLtFo59nsnoiQfRh0QLr6h7E4OxTno1X7/1yF98bvPZMX5sU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1011 adultscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300117
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_074044_743155_693B0E7B 
X-CRM114-Status: GOOD (  23.86  )
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

On Mon, Jun 30, 2025 at 02:31:00PM +0200, Alexander Gordeev wrote:
> On Thu, Jun 26, 2025 at 08:31:37PM +0500, Sabyrzhan Tasbolatov wrote:
> 
> Hi Sabyrzhan,
> 
> > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > index d54e89f8c3e..32c432df24a 100644
> > --- a/mm/kasan/generic.c
> > +++ b/mm/kasan/generic.c
> > @@ -36,6 +36,17 @@
> >  #include "kasan.h"
> >  #include "../slab.h"
> >  
> > +/*
> > + * Initialize Generic KASAN and enable runtime checks.
> > + * This should be called from arch kasan_init() once shadow memory is ready.
> > + */
> > +void __init kasan_init_generic(void)
> > +{
> > +	static_branch_enable(&kasan_flag_enabled);
> 
> s390 crashes at this line, when the whole series is applied.
> 
> FWIW, it looks like kasan is called while its state is not yet finalized.
> E.g. whether calling __asan_report_store4_noabort() before kasan_init_generic()
> is expected?

It crashes because with this conversion a call to static_branch_enable() is
introduced. This one get's called way before jump_label_init() init has been
called. Therefore the STATIC_KEY_CHECK_USE() in static_key_enable_cpuslocked()
triggers.

This again tries to emit a warning. Due to lack of console support that early
the kernel crashes.

One possible solution would be to move the kasan init function to
arch/s390/kernel/setup.c, after jump_label_init() has been called.
If we want this, is a different question.

It seems to work, so I see no reason for not doing that.

Vasily, since you did nearly all of the KASAN work for s390, do you have any
opinion about this?

