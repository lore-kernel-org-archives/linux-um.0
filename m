Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E92EF8FF3
	for <linux-um@archiver.kernel.org>; Wed,  4 Mar 2026 15:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UnYxYUy+8zrFTWbwR9LeZFJwwqG9YYaU/e//3QPYJZ4=; b=Wv+OggXRFBxMXdbsXxfUDdkytd
	F+BfZfkufOKGYW55f71QSnF1x8P8qWhtBpghaJPZqvz6HnRqyoJIs7E7lBnn5njKe+xDikKO48869
	EyLc0ucbc+HwZVLJ6WrPjxVxE6W9KUDAE7zlajF8Ab888mKSNreZvI6l122DbdRj8qE5loBKqNuu4
	G37wY7Ab5j1RX6SxgxJNh9RO36Qw73Xt0qkaQBYvxxupXbF+WJgrc63OmY13t81FqrwJjI0Dz67N8
	RnHUBsk0gWSSI0zanlxBvDvBU1PGc5M14LwyQ71hzqDVL9L2sXAICozKWnN1NMSkkRc3mj8f1Y4vJ
	aE6bDEMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnr7-0000000HW8m-1z87;
	Wed, 04 Mar 2026 15:09:45 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnr4-0000000HW8B-14gg;
	Wed, 04 Mar 2026 15:09:43 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6247KJ691508241;
	Wed, 4 Mar 2026 15:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UnYxYUy+8zrFTWbwR9LeZFJwwqG9YY
	aU/e//3QPYJZ4=; b=FZNErBDp6qjhxSEbMiU9l04mc298SEH8tvnPLaJ9ean4A7
	7K2xPOV8CgfxJ0imtFEqEnzLpkzNC4c/bEg2Hvea3i/uSbisjwgNBmjI3cUiAuyX
	XPPgoEI4BzihZrjSOdrN8yM7PcU2sVQb++QWYxMPVUMr/lisSRi9AuVwiLitXCAm
	1X+EB0luNAC+JaoFK3v3/WvLJxDgTwYOKiaqsfcSrhQqUEaV60drcDSUJi+1u8+4
	hT5jkYKrixvnhvlk5C829/WjbjQwNdjiyQUwSpLNw3r00Hlu0Mex784CEb0aa58m
	fVEriNiAX4lHjUycOThSzI4JSS9skGA9/I1ieitw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3yfpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 15:08:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 624EU8Rs016408;
	Wed, 4 Mar 2026 15:08:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpn74yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 15:08:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 624F8ahj25100704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Mar 2026 15:08:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B983C20040;
	Wed,  4 Mar 2026 15:08:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D11C420043;
	Wed,  4 Mar 2026 15:08:33 +0000 (GMT)
Received: from osiris (unknown [9.111.25.254])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Mar 2026 15:08:33 +0000 (GMT)
Date: Wed, 4 Mar 2026 16:08:32 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
        Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/25] xor: assert that xor_blocks is not called from
 interrupt context
Message-ID: <20260304150832.10892B56-hca@linux.ibm.com>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-2-hch@lst.de>
 <20260227142455.GG1282955@noisy.programming.kicks-ass.net>
 <20260303160050.GB7021@lst.de>
 <20260303195517.GC2846@sol>
 <20260304150142.10892A0b-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304150142.10892A0b-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 04z9E13OM3Sfpetrjwu_knlQ4Pm57vSK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDEyMyBTYWx0ZWRfX1qKC5vwiiVti
 imQl88p4f5EEaUs36Cqd8CD0grmVfOVhch8H/6EkUdKTFPntYFZhNzfiLwzeEcRPVdfmfw/csJd
 5XjBomCKez2kWT0xu+TyUO5m86iaOsxE8uVSmI3WWQj0EIwj+0zha8PMo4rZS7UmHkn2EA23gC3
 fCKaD2O5LTbrNnhcy/sqDaVZg5VdeGyPlf7sKjPqlGMWdy7lKR+Sx4YT9Ue13j1krenv+apDdTG
 9u7pc7ax3/s4b9EW0qdkkSS/EsWcFCshcemu3qKx2gHNe1V0XILuw8E8ekEbHaLm1XHrSGLXtR7
 0VblM3ek7WLeLeq24Eb3kVOGtogA+y9AGwS9Ox7ga75U7hxD6x81KJm+aga4X4uPi6MKdrTmsXu
 Fw4NYf7Aga7uVW+KCzrlr3ubI8K6ypZGyMfLvJiVX97w/NtWfeIQ5EAiC+Bq+Ht/ezhYzKmvaFi
 hJyU1cpGtH/CwXFvztA==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a84afb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Lex053stx4sflTLgQTUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: EsSB8XvTAoZu7uY0i22CxoZDWK6YvNNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040123
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_070942_422322_0965732E 
X-CRM114-Status: GOOD (  23.04  )
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

On Wed, Mar 04, 2026 at 04:01:46PM +0100, Heiko Carstens wrote:
> On Tue, Mar 03, 2026 at 11:55:17AM -0800, Eric Biggers wrote:
> > On Tue, Mar 03, 2026 at 05:00:50PM +0100, Christoph Hellwig wrote:
> > > On Fri, Feb 27, 2026 at 03:24:55PM +0100, Peter Zijlstra wrote:
> > Because of that CPU feature check, I don't think
> > "WARN_ON_ONCE(!may_use_simd())" would actually be correct here.
> > 
> > How about "WARN_ON_ONCE(!preemptible())"?  I think that covers the union
> > of the context restrictions correctly.  (Compared to in_task(), it
> > handles the cases where hardirqs or softirqs are disabled.)
> 
> I guess, this is not true, since there is at least one architecture which
> allows to run simd code in interrupt context (but which missed to implement
> may_use_simd()).

Oh, just to avoid confusion, which I may have caused: I made only
general comments about s390 simd usage. Our xor() implementation does
not make use of simd, since our normal xc instruction allows to xor up
to 256 bytes. A simd implementation wouldn't be faster.
Also here it would be possible to run it in any context.

