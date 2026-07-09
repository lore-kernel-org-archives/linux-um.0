Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D0CC43458
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=; b=ORQ44J+L2haRdnEYoRHoXk0hhE
	5KCekoIareWTT42NPTHKhPaUIqXLg2geEbxJ5K8TjDJXVeR/AhHZLkWd9SE1JX4b0Yrr2kxCNWccr
	vNii34CfpyQ6J+FJgcHmiS+sbsZBmRvZXsz4lQNN5OVtN/Uq9Z/oUpTcaGvRy+awtkMzb9CBRIxLS
	9+Rg8FNHxsLnJ8/Ir6+hXzFCgxbrMKe/CRJcECXELgEit6UCH2RhfjMqS+ITLAv9W+MmZu1AWGa38
	RKRDq50R5GnFEzNb7ea3JW4XI6SZ+AiQB9Ub/F/dhCcgI09Ami0rxr/t+00z6wKUwOHSJjH1Fn6lJ
	Lb0W9Zfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmkX-000000027mz-077j;
	Thu, 09 Jul 2026 11:17:01 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmkT-000000027km-0ddz
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 11:16:59 +0000
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Ax3SO1603540
	for <linux-um@lists.infradead.org>; Thu, 9 Jul 2026 11:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=; b=bZBcJAam+ibbXFwx
	fYme4cr8sBqjGZ8/bhY813m3zZdemgRcv+ZZn5hEkMKaS7vw0Lsk0C+lZaMW/4N7
	48Ti3b9W5djrMW6C6sRvr/fRMwvlr3Xwdk0O8mST92o98b2JRkz34WzfXmdlRdyc
	+GNzKHdNyJRx4XFA9Y/FW2dL+68kjj0jsC9rEzLvB9U2wtPREHvCZncHnjBH0nco
	DqfIf8EOVkC/PQXn3R9FFwNfO+c4fAiAxBDB9r3vKIUe0k0qjSg4thZ00H8jr+97
	7VzXtBysfy4u+kGoa711kKXXJoacuD/Fbabaj49b91/ZVeI4dz7AgvccLaeW9YDn
	oHnuIA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa6p3s7c8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:16:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c2af04aeeso10817501cf.0
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 04:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595816; x=1784200616; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=;
        b=Mm6+MDzC4XSOzyF/BU87cVEU5DQi4Us5FswUTOiB4exVOzb5b5ZXAEmUbFABuMewsE
         HrmWHWfmI+HbbR7wUbBL5rn0dUDKstCPczdZIFrt2LV0Aa3DQZCCcmFHN89tLwZvZ/Tl
         FeEtSdUpDF6KhumFo9v1A1acNHb74zuC8rq5aF+jLngzs4mFroVqBlX/zd+FEML3AjmA
         EMgjEf4gLFeGaq5iK10tjtlE8kbj+sgk17XxHMq9L01QqAEwdZJhIOJ+5VzCWF4B7f3Y
         hfz5SccOI1OBFaFkFvVENO05yLoza40b/37pJg/ZGKwxc2b5fIxDBx1+HhZfKeMuR9jt
         lcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595816; x=1784200616;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=;
        b=h25RLsWthCggIEmLNmtBDG/9a2fDhUn3nwfkqxLeYZgy6+mTPl3ooVtIO5+LADFVtA
         XTj3RenixU6gGjCAuGK+qjGfhe5DW3/1gvPGZrqPv6OGWbDhxUCjzCWZoo35AtldYB/D
         GebRF+VbI7gs3DY79f8SyvcbzyiIHpKiRp0PkJva0AHshTjYpoObddkvFnrXDEc24vBz
         iAX0GnGSqToZ4C2ayT7ooE+igoBGMw1DCVj5Uq83xqw7Xtfc1E8AzPDW2Y8xpi5AvHVP
         iHn7gAA6gnqWB37RS+XCAYl2pBSVLHrboLcbKgUcZDRvDMEduJRBlGJtQdJfbrblQqbl
         cexw==
X-Forwarded-Encrypted: i=1; AHgh+RqqJ8euLNfHAzwV0O9EJmJTNXRjrJ+++SJWvh3zuuP560EU7zoIlzdu4TqsUJPBSTrDpqTGNtxBiA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwO4B0/3SGD11Y+LiwD8rWmkM7QZPhS35yft3gJ2by/MmdMbwNy
	pcxeWp76Pe4UJW86CSf+s47neS4wrI3TMLIdImh57nC09af8RTq88bmBcDD+TWJlTI9gK+x28VP
	5tAW0oevd5OCD4g2WCaue+Ip0ChfsN7YA95HsVJTCI/s9FqIjXY2zn0u0ZI2s3CNF49w=
X-Gm-Gg: AfdE7clKYsRDBww6/zmjXnLM27nNP4VRa2nsNO+FVJzHi0tMLEmnc9ENltZNajlZNlo
	6PirHNLtbKFXzjQx/TMQBCSKdZlOW/gobXa2ERdCbJObY/NYea+X8gsbol777co1gFjkgqp57jx
	TGLci0fURY5/L2iXy8NM6NKujSU5phLR4WS+gfIhm1KC1gvrSTmqItrr69CUBqmDqZU2hJayubW
	0FSOa1dOITT0urtZDTMLyiVfG+IX44cDwtq/P9bGsfjfn21HLvRBwrFqIZ/1CJpYsFXBE5aRXBS
	VROiRyEs1OqmGhBrll7xvxBN+0oBzRymAXKyl+/L6HnUvWPUvEKtxUOZ4QTCZujUpPtovbRuh6k
	erUb6JCf/uVRDbviVxAdZVyVnRa7nz1l7gf6uiAzwhykZZFOMV65U8/6zKaIwAg==
X-Received: by 2002:a05:622a:1cce:b0:51c:558:cbbd with SMTP id d75a77b69052e-51c9ba21545mr21236591cf.41.1783595815672;
        Thu, 09 Jul 2026 04:16:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1cce:b0:51c:558:cbbd with SMTP id d75a77b69052e-51c9ba21545mr21236071cf.41.1783595815288;
        Thu, 09 Jul 2026 04:16:55 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm51612968f8f.15.2026.07.09.04.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:16:54 -0700 (PDT)
Message-ID: <b2ca1416-e2c1-46ac-8a26-ce671c76883f@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:16:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 06/18] riscv/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
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
 <20260707190253.974626922@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.974626922@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QhNMXlWjBgvKjsWQgCujftpTSH-62_Sj
X-Proofpoint-GUID: QhNMXlWjBgvKjsWQgCujftpTSH-62_Sj
X-Authority-Analysis: v=2.4 cv=TPh1jVla c=1 sm=1 tr=0 ts=6a4f8328 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=_O3DOGVWAAAA:8 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8
 a=DoJJhcVa48uSEvU2-xUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXwkUWR1JhpriY
 p4j82r1WsW9iWUORX2fGSRrjvFkGw7maAod7wkb6Ah6z7UvhZPNRFn9IaQ0AQm3yX55cnhPRzUE
 bmWA5UOii071U7SOm8K9WY5i8aVv9so=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX6MFbge8KOUAE
 GOTIiMGCi5Rr7cm2plOHj/zxYRjJMuhUMrclWj69avNNLi2PA3aCGfQFqsSQNMPz6qW+mfUoVIE
 n+q/ZuM5P6+E7Vt1DOmXMNfXkF6xyIrnF5DyJR8hqy7qF6fLLpEKskVBwxyxXHBYUynZ5NFJNVd
 FvR5q76QjJBV4nqNgNy2Gw2iYgugyd3mGl2umlaTS1GGrvoAnZlYhzcYtQpIJ89UI7cV84gnEKB
 fY69VXhvSmGmde4u5fz//RzXO8xR1Y+aiSbRAIOzr6MSct5N6ZTbmbN5Ybz7Rbj63W6PPJJUvZQ
 FCVP7o9nNeWTr79H19WpSKVcVNY3gVPFTUXcAWXzOqz1KlM0BVovtaCYFAlyo4r4bAzlrvSQy4N
 4p3oYptlPeb0EqIG/ZczOQuGbyD4LG7yuOLEZlRB5yDffyvC9jN1E1FmALfp5dsSWqjck5e9b8M
 ZPOoE50hfrxB1ETqijg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_041657_190385_448CCF35 
X-CRM114-Status: GOOD (  14.18  )
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
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-riscv@lists.infradead.org
> ---
>   arch/riscv/kernel/traps.c |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

