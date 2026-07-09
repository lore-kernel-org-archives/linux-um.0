Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E715C44506
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 11:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQNxQw6rO9fLZuzYn+ybwybDNA8F5Y/5chm6JwlKasE=; b=nJxBykhUbr7wr+lMC6/wmPg/jE
	wuypkWeRCRBLNQ3YUbKdY81RbQmpIomlQn97hQcREiYMvDXqaQiWWzcdJADsowpQkmzGjuGD73U9O
	dhjWGLjq3dDgSQ1gll588CLB9GOFaaEOOB2Ns/Rf+GFyPN+tW06ojF7qaMmOB4vT9DEHPKv0eCViu
	fnfrNBNZjjxzEw8gYqAR3BYe8FXjFnz9JzDgKeobF5Rfx9rtd6lrM5sD87qBxMw8H9LLwjVTTU3H2
	WeDZuSsRgKTZDEozBCakCuo3YsmwE6axI2V9zffNurLMHUUfOdvzo9orlJ0DTZTS0xjqN4CVXt7E3
	UbPHycpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmk2-000000027Zh-1rip;
	Thu, 09 Jul 2026 11:16:30 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmjz-000000027XE-3FxH
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 11:16:29 +0000
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Axhwl1614734
	for <linux-um@lists.infradead.org>; Thu, 9 Jul 2026 11:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lQNxQw6rO9fLZuzYn+ybwybDNA8F5Y/5chm6JwlKasE=; b=i6Z+l6cz0ADxMir5
	PP7gquUEvOGqieG+lf85k6tqb18XN99Vb/XbQueU32Nh4DFYdvrk7j7dFspHsXdS
	Cy7w+CsZ/lI338HKy004q1RoAkSXUYbZGedzGtf6/R1/0ogaog7QiT/r0AH6uhhW
	EGub/EAkoHwsQwiSwXadb/oYPAyoLb8nSMPbvA5/LtqwV8trHzPhgOS4T3OKYTVp
	y5/p6PBjRcCgw7xpwdmKpUFT5d7kIO23k48hxSlZ8uRGHGGnWe45xji+gjzdUnc9
	Wyi3IdVy9kYk4bNta4UN3ybii4hmT7hogdBdgOfzXklVyIt2UwzF5HAMNiWsF/IF
	edCxbw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6kdmr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:16:26 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ec235c7c66so27795176d6.0
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 04:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595786; x=1784200586; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lQNxQw6rO9fLZuzYn+ybwybDNA8F5Y/5chm6JwlKasE=;
        b=dRvZk4vC2hQEd/7eCjIOOrXm/MEWVOnnjdbFTLxihiHkjuWdhVu25tjiQwWIfwiMWa
         fNSkcZR/Of2Psr2O+mfkCeP7fJT7wDKHS7tBtxiOd4R1xO0ih4rbljuOLlSKApSQvkrE
         c88w56obiTK55QvVCheTJk3jPmv2E5cYPFNVGKtwnbl1JsJh0bXnxXTLQrMh7TWF3KBk
         hZEwWl66OHceQJielw62MJleMqPRMoElMy+n4lLy8vkS/mDIXhhsxlL2V14w7RZPrZfl
         dbaBeot08A0NIiTmrnhzLWRaQn2Hn/nfptedjYHqbZGd3yRGu7J5U5L+LQZpZP0xz7Mf
         ZV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595786; x=1784200586;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQNxQw6rO9fLZuzYn+ybwybDNA8F5Y/5chm6JwlKasE=;
        b=fG8NMnNk9S9iI4Kxsl88H5Shh4b0GnyjKTHQ1FOGyovxkqPkI4FURpeWb6c6q1Krqd
         +P1BTmA/r8G8rsYl7+Krttp1InW/u8mTSe+jjBOfC7NsTEs87OUTRYAOC8RsJZ/Ik+Vv
         Pp8ECEJr7MB+XNQr0oL+7csTY1E34LxgKfLTKBlyHKAgukSf5umr2oIcYUEzAa4DwIm9
         IR4n196YB+PBhzAMGm/94CRveolm9JQCo+PqWAQszfu263rrkuec9O0tSlh9N6TvI223
         kJHsycAYcPhAQhI4FSrUNZ2sta+ywNd2Dqh4brwl3QjJVanAHzs6fUdVotpQKe0QhPuq
         bp1g==
X-Forwarded-Encrypted: i=1; AHgh+RryHKWVh/Ft6aUuzXxsfFHAB+hIlhRbdY3xSgc3XhyMmWLGjXcWUU6g0JLNcx2wnGjn7cirZwVCzg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyguF8HsH024YJ+r5Xlga4CGE+IfF9s0w/hds+LHf2SOgO8JV8c
	F+EHP91RHh9L5G/sPLJYNsPkD15oHOn7pFuB3TShIOlboaRWJG6fKErQ87ZeWajWNh91mefEtR0
	ljyDMEX4tVJcbyvNjZR+2A23WwpKh0ogPq/jq9N1Zd8GDBugpZX+cGKoey9FLUQIEkrk=
X-Gm-Gg: AfdE7clzgC7LVQ8dPzL89hd54x29s9TZ6fNgPUD3yYVIf4xQqcHKhMXHg+l0207/o6G
	WPU1khu+tOD6cZziVvLtsDFlqNOrUcWKvBA9+aCDGHj6YmpFUT62Zdm8Hb1VyQG0whNvktT5seX
	tzqrldg8SPg7Jw2GSNEIkMM2DnObUC+N3q2i4vKMnSi+BBxFSktpMwkytzV80oi8CzQrOAkNjLO
	Wjd57THECgkPTIAkMmM667/gIVW6L42lhpj1V4jBioT/dfUQS+Lu7YXA70FqSC1nJcZ3h0M78yy
	1AYgieXCgc6zErJIi0glu/DUfW7BCIMeAxhwg1RmEshQPagX/iCo6oMb8JeDMaIzqHE9K/hsZuh
	K5WLSzN+QCstB8HF2cDVKEr8Zw/MCN/tmcaJsaeMDim4M5CovdqOkgKJ+P2latw==
X-Received: by 2002:ac8:5a94:0:b0:51c:22c5:daf4 with SMTP id d75a77b69052e-51c8b3033demr72817901cf.28.1783595785833;
        Thu, 09 Jul 2026 04:16:25 -0700 (PDT)
X-Received: by 2002:ac8:5a94:0:b0:51c:22c5:daf4 with SMTP id d75a77b69052e-51c8b3033demr72817641cf.28.1783595785396;
        Thu, 09 Jul 2026 04:16:25 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8cdsm54261424f8f.1.2026.07.09.04.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:16:24 -0700 (PDT)
Message-ID: <b45abac8-0e8a-4005-a050-a0d37e1c8e2a@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:16:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 05/18] powerpc/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
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
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190253.918861529@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.918861529@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX1+/YuivLOF42
 O9ha9+MlSjVFLFiIGCXV0JexymsFPgtajTj2kH6F5GlDcw8D3yQqwB6SU/zbNYMORln9IfNzyRi
 iMHUXtB09RxjpJHaK3PxcFQkEwP+WLs=
X-Proofpoint-GUID: v6YQz-YZcpfeN7ktzg3bJcFrJwxiyQZh
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4f830a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8
 a=DoJJhcVa48uSEvU2-xUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: v6YQz-YZcpfeN7ktzg3bJcFrJwxiyQZh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX3eOCWhvtJSjA
 xVsFj31SO9J9IKFQ7M41ZPPBjw6wYPu6JQVlq9OSwhekUsJk3qtGOuLJdZVuBtRmmrnu6RrS90B
 IOaDb9db+qC5fl9rsS8sCpzvLoSS7Hch4En+1MDtd2CXakMmqXRjSzvJ9iQHzVZgIm0OY4+vsRk
 DccfurTvxBDVoBFGMRRDUwDoe4OyfReGA4cJrH0/yugYV9OvLFIXYn/ses9j5E13kBGF9BpvekJ
 6djKH1j1gm5Ua6HMimYxbPTQaQNF4OIL1qYehs12cCe9IiZQjiRB3GQ7hoKiTPUFtQtj0LBr1f/
 gGZ6th481kIIm3em6NiBfpAQPNfb2gaScdMfITBO1gKNldC5xJ56eZzYmTJO5Oum//uh2BmCqFd
 KpcdPzTjVaDRy4diVbK4Czr7eTfdpGNQGXixeny4B0NN1DP/Lw8w/p+7bCrBa87zQplQRiND6Wo
 4uEE+bc7BI6ImkezT/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_041627_922471_5444FF99 
X-CRM114-Status: GOOD (  13.86  )
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

On 7/7/26 21:06, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
> 
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
> as that code is invoked with interrupts disabled.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>   arch/powerpc/kernel/syscall.c |    4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


