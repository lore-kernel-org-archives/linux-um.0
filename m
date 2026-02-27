Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F56FD5316
	for <linux-um@archiver.kernel.org>; Fri, 27 Feb 2026 09:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9fJNQ8hFc6Hs06NykvFdnbwjP22Qa4Czsab7f5+iT/s=; b=KZXTsUOAkwxcdig5Di8zLNIjws
	VBqQTAsHO0xvvfc0K1IHMtQWxYQyssZmuJiuAmGEms3UOuvZItFd8ElF0DNX46qa4xNK5KYUxZ1Fl
	A5Hv3zhkmNqsB2YqNwkxhuTyDyEDJTS2vkweOzVbVlKMnRUT5MY4/oXWYRJtkt979LYq8XW0iP4Ju
	/HZjr1mTgCwkyTwB38NZoLVG6GZ9OUGC27xkyfYxRaZBa5EQdCoI2/zKRI6r5x8eKuZESxpwFF+od
	jTi+HMuZnGZ1KMVBPOPOCgNiAeZ3+hb8NaB2+Kj2dGHiPSUpmad6qxOB++JbhtLhbgFXXDOXXAq6u
	m0Q2vlcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvtsr-000000083mA-2G83;
	Fri, 27 Feb 2026 09:11:41 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvtsp-000000083le-0373;
	Fri, 27 Feb 2026 09:11:40 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R42kun3100088;
	Fri, 27 Feb 2026 09:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9fJNQ8hFc6Hs06NykvFdnbwjP22Qa4
	Czsab7f5+iT/s=; b=WsV8TR6rk52sfgi0yEDU4EhQlIECmYdEVoCyjTqw7gZ3F3
	eeHg+aJhMwLYBfRrvCTB+X1E8112JloZG505tr4YoHOHpsA+0VMCmikGSenHxCgI
	8HXR4cEHiWmwwkzLwBscjDqpDZO3ne2k4EEE07xYvkotrBxJdXJpgPVvwn27muSf
	xqBav/gaocnH+/b+cmw7rtzjfv7peKnbFuS/n+xyS+NBW6dWAjUvlxf2Z1nhGNyZ
	JW8mx8qyfv8JeTYDboY2RdD3NfJMbMKBk4Cfsm9yXyMH2NxCMnd5vEs8SgkmIVEz
	9iyvjXnemPAPNRZVT+C81oevbnLXFbPBfFIhRcFg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34cjvka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:10:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R7xVgm027794;
	Fri, 27 Feb 2026 09:10:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr291xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:10:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61R9A3w526345784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 09:10:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E7ED20043;
	Fri, 27 Feb 2026 09:10:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88C6E20040;
	Fri, 27 Feb 2026 09:10:00 +0000 (GMT)
Received: from osiris (unknown [9.87.152.66])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Feb 2026 09:10:00 +0000 (GMT)
Date: Fri, 27 Feb 2026 10:09:59 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 17/25] s390: move the XOR code to lib/raid/
Message-ID: <20260227090959.10882Af7-hca@linux.ibm.com>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-18-hch@lst.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA3OCBTYWx0ZWRfX82U5aVPSCKMj
 b+0tJb22GfHqv9v4ECkZvrQTVdwe0NpyD3M0iH/J0+Xwr+YNeZjI36wIQPTa9rvjnE1UWrx9YkQ
 JHFDvWeaZB3m0vLeSHPjQ41gZNyK3P7jz3/RMGU+PQUjTrl/esmjGZf3JQqOP9wpvYUJI8IGwZd
 /XesnT0Fp6f7P6zmIK4NRyzDQXfXKB/frdS7KrKVpjV7P2YYv2qXUSwm17bcz6D+3OU43mCcNJw
 VglTApNotpU5nP84m/1BO0OHu/I+7q5gBb6aF778m34dUw2mKpCO0GIw5iCL/18UvCIDVst+Cg2
 or+7hBFh9lVuTlBEIYrN26hWcqnQmJk+cg6nVuLOR39apbYgayyTTwj8euDUuBGnNDky60OnBzo
 zdR2VUTZDeHZGzwsBRd/sH8aRuZ3XZmPmK5c8OM2MVccRTGc8Hd/VLBtD8pqPq/pRTFgfAMLrBX
 75ZY0FEa+686cu8Lnvw==
X-Proofpoint-ORIG-GUID: F8S8ZNtQow6uofq1eM08rQyj9jFeslmn
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=69a15f71 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=HpkjO1BTjMN3Ce6vPK4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: j1a5E8YeCxBUvXVfRM302zEA8A8N1Tzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602270078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_011139_172698_470082A4 
X-CRM114-Status: GOOD (  20.12  )
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

On Thu, Feb 26, 2026 at 07:10:29AM -0800, Christoph Hellwig wrote:
> Move the optimized XOR into lib/raid and include it it in xor.ko
> instead of unconditionally building it into the main kernel image.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/s390/lib/Makefile                     | 2 +-
>  lib/raid/xor/Makefile                      | 1 +
>  {arch/s390/lib => lib/raid/xor/s390}/xor.c | 2 --
>  3 files changed, 2 insertions(+), 3 deletions(-)
>  rename {arch/s390/lib => lib/raid/xor/s390}/xor.c (98%)

FWIW:
Acked-by: Heiko Carstens <hca@linux.ibm.com>

However, I just had a look at the s390 implementation and just saw that the
inline assembly constraints for xor_xc_2() are incorrect. "bytes", "p1",
and "p2" are input operands, while all three of them are modified within
the inline assembly. Given that the function consists only of this inline
assembly I doubt that this causes any harm, however I still want to fix
this now; but your patch should apply fine with or without this fixed.

