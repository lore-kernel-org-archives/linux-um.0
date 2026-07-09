Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AB1C43458
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 11:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h+HMbGg4SL+5U70oYYJ2l7pisY/QrLqdUOSZy/EbODI=; b=2oHlhwjAoaQ4VhbxuO3JhWQHvY
	erd1nsaua45tXR90AS+Hvc5c3KmUnfKi7CDnbCX2XeE7WT3TFchm3w0XruQAmhW7+7dhdkpHtDzvB
	1eiAAIUduwlQA10qqu0T7PXTXfKDk16U3heDGwivOHHcOfC1YxrezemfJCeTFZlcOESvCHsv1ryVW
	3uosJ0GzlcJyEuKrXZ0WpOViyXyCNyc8kkySfHfv8u+1qhSkf2KBdKSyqv3r6qpnnWSHLclU9m+fs
	e+lfGQSBHb8xAH06ayRArLI/fFsDg0jBX+549bM9QMFZlUdcrqQoHwz7VoufWBlssS4LpuEbnVEtD
	bsLuKlnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmiw-000000026vX-0RFQ;
	Thu, 09 Jul 2026 11:15:22 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmis-000000026rD-013k
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 11:15:20 +0000
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669B03vq1620682
	for <linux-um@lists.infradead.org>; Thu, 9 Jul 2026 11:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h+HMbGg4SL+5U70oYYJ2l7pisY/QrLqdUOSZy/EbODI=; b=QY+QAjG7JhI01DOL
	wrAWMBSfa2EsIJlZOBwNOpqR74GzzqMsWGKTL1nRLElce+kxLmPXGSEYyErRT9bs
	jrNUZ5qVhOMFlBS0g8+r8Lj5pkWx0HY2wr4Y4a6rA/soxkxGEv/GhwH6BfRMk7jC
	wxIkHw7CzIPD4C4hy06RY+nKd1hJsp9iQzkVAWdtTEM+7XcTYBvK6npbb6yBBaJ1
	CW4Qj8HEgGXE+RZq1+7fNu0Wd4ijs3A5FZcUaa9zPvqhQLDRRhC6VCASBWFqdB7d
	2iZ0nRAY5gwJd6YOiD4NmrqJffwjsCb4nFAr/D46CSDxbk0OC7RRzM/ZY22CoVf3
	XPhT6g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqsbx93-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:15:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0ab07320so18504261cf.2
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595716; x=1784200516; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h+HMbGg4SL+5U70oYYJ2l7pisY/QrLqdUOSZy/EbODI=;
        b=b9AQLgvIMl5VebszQdlXHqlcx9PfDZlDxjA3oKPjsGLvhN+wJideAnKg7dp0R8UC2B
         tgKYVzDdANCIraGCDZagNobbg7epAZGuPDSkdbYgM2Wjw+MBxgbgGcoj1hBjFl5hijhC
         s9gj2SWpm/LhdD33G4C17xSxLf37KIDnWktY0gotZWkH3yHFnXBXl8+ry21TyPPSkg6j
         tD/A7gnvoaMlCNQrrEmOcN1fEH9Egk5mMxyrR9dqGZ7jpDFNEH1S0BQD6xrM2exKz32T
         O00ODYxGvYE7MOCPecKIiknbedd6ZnJDXgE/BezmivGh9iWAu8ZJkCDEieQ0NpnUO4oE
         1M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595716; x=1784200516;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h+HMbGg4SL+5U70oYYJ2l7pisY/QrLqdUOSZy/EbODI=;
        b=n2krhz4F5gmlw4cbILs4PjIr/7+WZssfbOAhucr8C8o0DAwz+r4qb4EoHjuHqWV7d0
         RjmIVkDTMvTImwOMebBR0mmk9zQ0r/MrVLiKrS4Zz9aP8pHgOe0BZK4vZZoCO1R3qCNy
         N9cQDMlr9SdcJRlMbUAN6+XJ73ZF0VNDIBEA7ZB9+hRqSHjx0Jl8dxjMMxoBWHtjyRiS
         k61fI8Z23klVbK8d1rlHUrkMmCHjwZ12kzVCVDBdwDCFx9826ZxFELHX5zSqsOrd71t9
         CC5a1eGN3c1Na6bGXZoDGQ6W9/hVPyKKWnfoGar3PVTB3eGblcUGDVVLaO39WQ9vKDe5
         2q0w==
X-Forwarded-Encrypted: i=1; AHgh+Rqr3/e4ctmlF1Vg9eqAO3rJarvSLPNHdnZZe+wjJVAjeyCrQsuo/uRy+bBfYvhjVs6DPXCBNs8ksw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwndP7QMd4XwP2eoA0p3A84G+RKJZjLE2KJizIAtVHZyyku01LO
	xIlsToBS/ZGw2t8wIDGaHKGpsz0M1BjsJM279feU6HYpoyCoy1LG3sfe1Z+IARlZflB6a/VBEn2
	gibS3HhrOynu/F+9QG4PWVkeTxJwJtF4w1P0CqHBcFSk1HEDhdZhjgIDdMBEZsNiwzk4=
X-Gm-Gg: AfdE7ckd9mPXwV/3t6r59bXzi4JSTOdcGyXnYGcT9e5X6lii+0SeZKe7RpEG6a6otFW
	kp6aG7ILC6q8+aqBvXSurtz7sqs4Csh2A2miCmnvNIxWSlrxpoGqhGnNJNwlPdpCSODWBprEdoJ
	4U5dP5/OdNRj8NVfgT9BCQd7bF6/PbH+9hJ0u7lzPX8tJWomJLM/r3mj5aeofIestwq36Wf/5uo
	HLWkR61DBH9uJzYU+CCJ4HGPCkVzCoQhFOmFEwGujSYXuXfrGs5m142lLoMj7bbBPMQSbXLJsmy
	YDZf/XBl2amlu+f98Ad0Yze+1YwL2FWQl2C1HQ5LGzd4e/7/crdXDK9fQNdRR5kjOBrzSyxDuFo
	0Y8d2TiebbW2i/mJromo8AISXZzZDC6M15v69V8JFP6Mk2z0CR9x3QzpUtRiraw==
X-Received: by 2002:a05:622a:58cd:b0:51a:89db:95a4 with SMTP id d75a77b69052e-51c8b2bdfecmr69627101cf.6.1783595716197;
        Thu, 09 Jul 2026 04:15:16 -0700 (PDT)
X-Received: by 2002:a05:622a:58cd:b0:51a:89db:95a4 with SMTP id d75a77b69052e-51c8b2bdfecmr69626741cf.6.1783595715754;
        Thu, 09 Jul 2026 04:15:15 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm49838232f8f.14.2026.07.09.04.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:15:14 -0700 (PDT)
Message-ID: <954fe87d-9d43-4819-9f5a-eb0e5e5affea@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:15:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 03/18] entry: Provide
 [syscall_]enter_from_user_mode_randomize_stack()
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
 <20260707190253.816918647@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.816918647@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX2CxZmA6jzBSF
 hi5Knalud7Mpyh2SQyRnH8tiMhUq99wHSORgawpVwKZ9u2/a2VBwoYtDkjhScV9csfzNoBQCSFh
 sOe3EBBhQx3Wvvp5V3gHX7jyBnxBDro=
X-Proofpoint-GUID: 2oGFtvDPAd6pZTZEOZ6LGHsk7LmS2-JO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX9nSuBAeWJJQI
 MfxA3yrjMOzTJwHS8FFrXi6MkCDZarVXXiIB02sZkOAfYmElzOlniKu2Ld5VXjDL/cEu0dfCcj2
 AQOxaNA1eqXKOoN+zvy68So1ljO61eOsLGVRahN/xTfXu10i1+ceJg6jn5qls1nkowyAwY7/8Bm
 5Xg4IaBTMOcg6bTWit2zmWVD63oZR0SnKwbERLDr8Q0Gh/BzPiqQXSWY7qS0mXvIpMAveQYRqz0
 /x9WuhuFQNgHDNFxnUW8Mjwtqm0hk5nKzrvbdVDwr9z4OHdhcNsZJgGxmiFmHI9DMqi+7AcpUkc
 Q8+6P5Xk5LtVQZpWrt2UHgxT7kxv0yvfdD51MH5rM15nK5xEL+LIt7musiis80TMofOeYk1On/K
 ePaJbuwBnPeWfZI0ZPkIf3gvRLAeFGrsLBz4Ybp+0G79fwTYRYk0s4sHeyo0/hBgIh3GDY06RVG
 BCs1W2bkUmQ44QTNxKg==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4f82c4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vLKI4MkW7k7maJ7H7gsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 2oGFtvDPAd6pZTZEOZ6LGHsk7LmS2-JO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_041518_157525_2DE914E9 
X-CRM114-Status: GOOD (  14.58  )
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
> Randomizing the syscall stack can only happen after state is established
> via enter_from_user_mode() or syscall_enter_from_user_mode(). The earlier
> it happens the better.
> 
> Provide two new macros to consolidate that:
> 
>    - enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode();
> 	add_random_kstack_offset_irqsoff();
> 
>    - syscall_enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode_randomize_stack();
> 	syscall_enter_from_user_mode_work();
>      
> to reduce boiler plate code.
> 
> Those are macros and not inline functions as the latter would limit the
> stack randomization scope to the inline function itself.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>   include/linux/entry-common.h |   56 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

