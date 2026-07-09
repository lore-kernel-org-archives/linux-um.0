Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABF5C43458
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 11:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=; b=bMUDIAtKijQxBgRsVHnnY5T6Gx
	AWrLEJfGefimSPdAm2OnBt4/xMFavFGxfOZUSqKcfyJDblE80GL+r2kebhFF3L16yEB4YzqQGH0Ra
	nLN1PCHm93CraYVxmGDW9yeMkndwqpbyRkUpaBWerPZBTw4CUCj0kyed8k6chluQJ4VLDkVMlX86i
	F+1nV4zqcjQ5cRnAsxk/bXaml3z72bGvQSgE8aFKdn0sXxoruyRu5TtqNiEYhxJLpRvVkXJZz0uo6
	av/d6h4LjVC+6n3tsVKKtGXtnc1YiAPNo3rLWHZI2aYQJJXXwD5tan1e2GYhzeGFR1qMSNcAwyIWT
	4uI5rgmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmjc-000000027Jk-1xWs;
	Thu, 09 Jul 2026 11:16:04 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmjY-000000027Gd-2qCS
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 11:16:03 +0000
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxYvK1571761
	for <linux-um@lists.infradead.org>; Thu, 9 Jul 2026 11:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=; b=ULLpdAqjhcPbhl+a
	9wkFVF2/lY0nTNUibaezE3oRQ6lteQ4HDVcOfqHDE7vtflCsPuubuaBt22suHv5C
	J/GboNexxusvk46SeLD4YSCgJibhGpTyBp7Ew2CmZmE5Kc85FL5xmUGbwX2SNRRm
	AUKTk+C5LBwuGwFJB3/1RH6SX3HPCEtPeI30OoMKGubID5ux/F8g5HbF1COPW79s
	OzhxWi76MMCFcorNKYBBg01ItlLF46P4rAQRFOMzzGhz1/Bz8zCwIh87EUtM9Vze
	DADpxILacbIASbBx5FZNfW6HGEmYrVnOynweeKBYk1Yd0I8v8nqfQQ/58XsDZx94
	8Wm00w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9rq348jv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:15:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0199faafso12259931cf.3
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595759; x=1784200559; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=;
        b=gkGZ0zRwByyK6jHOZJyDyA1Ubci/8ux+OVvT0CjddBXFopYpuj5NyCxxAQTrMQRaut
         qhyPoSpuhZARUID3HlOWjCh4GXgqu/Ipz4Ue59KYU5vBGfylwIQZmIvtEDdfpL6g3sAM
         epPI9wdmBOq395eRaifc7YTaO3NsHdsGoXbfWqI70132vZY/b7WWo+Ze/rVfbI78U30h
         4Cg5sHuFAT85vY0eT6GWPrjVZohvUDzEhnDHw13a5VFW7MloTj2O5VaIhivfMx4ujjwT
         MZb6gyK3OxbFtQzIWQW613isB5cFxPqVE4H8DwOoPUR/KN4mF0sU+CHlRcwClgi9u19W
         J/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595759; x=1784200559;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=;
        b=cGUZHqjOMEnsn8TL5pnsb0BD2yXa8gA62BJKS8rUA7MzXJIFMMEcfIhOpEWgO5MCe7
         DMuedj5IPMItV3MhpGyQAIVQWHQvA3jWm+YzNpGpedNyA5O3BH8XKN6gFsirwtyNrpfy
         DEIMLv7J4Id67xsSO0PRDgLWEfVhX6KuSdXkMGlQ+pDbJH/Vvi8aKET0tOMZRFpXaLbG
         jf9wJgLeqaJbxuykc7LfV7vDbIfX6kJN56ymIRFDW9DD9gFDiwvwYZVK7VVWowHfwj8S
         RwjKut0Xd1vjC3yi3RQT/WPpeRf/piQxcw1CV8xiO8RIzWfYgAqc+CGYlSM3dIGXhjez
         PnFQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLkSGNFTI0H5mGROonis49ztdAFklobcQKYdeCNavUvUD4+zlrzxeLpW6flYMcGFE+WjcAfIHrfg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwmHC9SjAT9M5JbOpJ+YxYnVr6FjIoHsKQP1cdKxbJDFTSdRJ8a
	8aG6TBvxqJRsyKuL93zzilKaeOysiIKTum5lC0go8r34HcN6LcdAwUaaJIVK0rb97tLDIszKerQ
	ac8yKodTGV3UniSrPObbIGSfKlhr/REtu9VDr49BLh3KFmHbZB7lEhc8wHA1vW2dQT6o=
X-Gm-Gg: AfdE7cmHo2Bj5wWFEEFGs+d7JP/lD6mgQgEch8nD7FshyLixYSPVRWuyh1X8Q8Nl9d6
	QfwPvIqc8c/ANb4HaPmft7av4SNUMIbxUkyRcfwZOnqiJbbA5JtSyP1cxLStEUzi2F3hkDVuFhm
	LR6Ko8oRAPhfkn9JxVWcfaUUN90e28zHvJoxxiXZgRQQsNEwvqVVkYCD9ol8nOUPjnGdBABOQDg
	Q7r/YtkfhBKQE10aaX3iS4fnXYtbh05h17BRWD+wJ3GUL6g/8Bh/+Fly/9dy2Yt7nMLUchKFSx2
	gqxkqccd/uWXI+Jy7Y4yxlt6fwqfBUnYOEE1huJk50nv2/b/EBnD13GbLZwdAzroMqQAV2HO4PG
	ns6uth0Q2aiGAQi+BLaQFCneRnDu6pX0P+q+fAQHBQBAxnbChtwnnNZSIgYuNhw==
X-Received: by 2002:a05:622a:1113:b0:51c:1b3d:fe62 with SMTP id d75a77b69052e-51c8b2dbe87mr68191821cf.28.1783595759108;
        Thu, 09 Jul 2026 04:15:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1113:b0:51c:1b3d:fe62 with SMTP id d75a77b69052e-51c8b2dbe87mr68191231cf.28.1783595758685;
        Thu, 09 Jul 2026 04:15:58 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b126sm50274140f8f.24.2026.07.09.04.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:15:57 -0700 (PDT)
Message-ID: <cf26fe68-5a8d-4d6e-b9f9-d69faa8a6012@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 04/18] loongarch/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Paul Walmsley <pjw@kernel.org>,
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
 <20260707190253.865955911@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.865955911@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3O_LBrWmboRrXgPS9vKfWdghoHAq7_pn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX+3xwGvgAH71B
 Un/mM/nN2AzaN4YjgogDork8xa6Eu2WIVa1GWoTLM6iovy69HTEEAftWOXP7SYRKm1XXBQiyL5E
 nhRD+6K1in2KcF3iLC8nElTUNH2QsgVp5bkQ13uYYrSj1zJ7G7LI5Ml8ON2q+eeFbJG16h9pMtR
 mVBvEaSklujr4Sg1n4ncULo/HT+mfeJNcmoA6xXJf5k1b9bAwmHkxtRl2elj9N4YMnhGbj1HRkf
 z/ZkFIJO0X4K6cbxbUkRRCeGR0aVqb6Wy2FJS7aRTsgf2C6n90lhBDN4Yv+/Ao2oG1UzZeyjyMJ
 6eEJ+Lew3dX0m3nQ5Ruxl9aMjoyELgZm7D5EjzQkH/4eht/rjsHcRO+imKT+trQyA+jjAP4X/M+
 cPY5DOoCoxCh5krbVXoR+9tvaLYrmImEjJzaWTeTnjQJUI6YopqkOHnyaeddb79YPE3Awossi+W
 XCe6h3bhrbdq/30UYHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX/vX+5fh5NwHD
 eKnbw1bXXr5PXHt+BQ17v5iLsn/jPSxksgXdA0Y619cQHHP4GOYlPwfqqJ+cCp1Jz+IjtJBpWvy
 cRSQCsQaxZ543Diam6YoIiuSTMwvEVI=
X-Authority-Analysis: v=2.4 cv=PYPPQChd c=1 sm=1 tr=0 ts=6a4f82ef cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DoJJhcVa48uSEvU2-xUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 3O_LBrWmboRrXgPS9vKfWdghoHAq7_pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_041600_837376_83CA0DE4 
X-CRM114-Status: GOOD (  13.84  )
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
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: loongarch@lists.linux.dev
> ---
>   arch/loongarch/kernel/syscall.c |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


