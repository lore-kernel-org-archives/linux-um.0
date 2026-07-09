Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA48C44506
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 11:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=; b=QDJDg5MQvIaxM37gdUyTKf6tIw
	0vOjYx9bUv59lghj+ZZgfqQeULM6px+wlsLzHMu/BgyZ42vjeGJW24egLfni6ev2XMQvRf+dhz/l9
	ToNZhEFeyl/7d/7BWe+MlOEtm4rQz1vzm3Nh4M12GFdlX07g5J6BTm+Xe5ZwSdVPRQ2Ae19dzQ5K4
	uLk8380p6R7JqFPfBKwulXxmOjTMoVpMbC2tXygrXgCxGDPUzTJUoU/PGDlR3eTds1WrGTgiH8pvz
	SA7iu0v3v7lwXlqa1RuVlRHINZiT4uOe1pvj60cNFnpoSyOktgxQHTpFgIjBJzqMNJTBMELIt0fkN
	kVY/s4dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmlm-000000028ER-0QPn;
	Thu, 09 Jul 2026 11:18:18 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmli-000000028CF-2ZMr
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 11:18:16 +0000
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxFS41434813
	for <linux-um@lists.infradead.org>; Thu, 9 Jul 2026 11:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=; b=fyY0pNu1SYakkEnc
	jiua1Bz59Z/HxTO6ZZj7/6VoWVtUtY1ICmo9H1Pd2QjrZWC8gJfOm9T5qkA9XEc9
	zZ/LvhTR9YL1D4FRKeeUPeBJzIH2ig7MkQc5n0wn0ncq5EOUUpyCj9xucWrHafNA
	Mhaf5VX3wvgWTqgyvze8xNYS1i224SoOljNif2MkoC4501PXlkZEU2tlj13tOCVF
	k1OcXw5rO9V9U6F4nqjFTDFlr4SsHrosvOnlojjBDdlvWI+//0MRkxof7+sUSdLM
	DMKQPcPOu2w9XU1PRa+80kn2vAWE27oY8QNhmoRslamfrHh0e5dTRzAtOzXXQfwX
	yQEHaQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwftvdc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:18:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0408254aso9400701cf.0
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 04:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595889; x=1784200689; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=;
        b=kqwYUjFUlPP2cf5b3GxZm1vz90hwoBJQoBCdYurR1qKwU5e6SK5pFTTbPMY1lmqzTW
         qg6zCY7tBOrW+hGzg/Nrd29l5r5DiyDzyhUdZ3wEqTdOvKPtzkwqk+Uv30kvXFPn7+Ib
         01Z56hqAUUPewW2dUwW82FQQblY6QJz+n0JxaDZKM5WQWR7zSGlwfaSc/BdTk0PVh2XK
         CSb4Sss/yyFVb/VfCUckpR7BensopuJ+VYb0g1l7IF8ysgY9EbBR/wOwe56QAgk8GFHN
         pLB6ve/kEtYoUEdrrB6O8KG58fRlyRnJith5PNO2twu2csAYpjrmBYPVLduSXZO0XBze
         IjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595889; x=1784200689;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=;
        b=irBcc6SGIWdkNbd/ftAe7E1ry2WsHPKS1Dx93KXHLdTq4r6ruzAozGxV7SmFd6OzUM
         WJrrbRwVqHiF9a5fTXPqqoL583uHUU/KCnCkvWv5RdEITEUiBBY3uu/qeSWdqsXbigW3
         TRXZJN4gGKJTphcE/F0D+OPpPhN2qJCxmjpXy5cEv0yYuB6S/XG4nMqZyOIAPntCO0HJ
         2gjmVz7Gz2ylmIpsXVlDmHe2SUEWzfTV5J+8NgSn3Kn25pfJxpvoPoVz+r/2M5h5hhxx
         Mas9EXhdaDf4tAXvniGLS23rLS8zUtOPtyhHt0eRYPWcJQpNTkR0qgQebkzVkpo7zL2l
         +DQw==
X-Forwarded-Encrypted: i=1; AHgh+RqeUub1/yf2qWjBFljgl98SA/QurJaM+0++Or2YyVDaVFDNsG4s5HnCn469TZMT+v+OU9GFl5cC8Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywa+S6wath8bs8pLNZcZSpbkVRORHlry74/UrIulz7QLtUddApd
	hFJg2M1r5nn+8Yq38r2V5sFCpIjsrqQ/OJfh1qBl8f7c06yZPk2fjj21tm2+1J1lVKy9NQ0bjH+
	hduzQ+NQzuS0346lX5ac8yPASzja6PDRAbnVlG1q69Rm/NJRRM7ucv1VHBSIMFQppp1g=
X-Gm-Gg: AfdE7clRTL42wkf6uKdYBbL7ojgumOC/+cgeAnp8NZ5YYBKvQQ1buRuSLnb+JySrTla
	oVxJQTzNuBprmoTBqT30ozZcBLflhdgftccPbhGWwugbjYCqqzCGi+RlopJySN0FnqQ3Jg4MoG7
	nUuVbS4gMaL3Puoo2w+3K7HawTucwf6QRY6hdEd54j6RzOKTEWeVUtnTHN7b7BoIFzL+cFLUypo
	+Yr/iDxIWUDJHFG7TSo7IKkU/8g7+7IBFLdxTSHjArKnWGxnCbzeJ5R9TUSlh/cQy6yadOKRM/g
	WECp42yeO702AGZm1VoJEKnygBBHZ5ZGOfpX9fkwWv36Gs9lO6nqHTBRZbtX6/TLp/If7sHPUox
	yvTEBlwptlwWyVzT0PUp+9LJlJyjQTUatPXsbC04cbmkknP9N3mRT376eH8m6QA==
X-Received: by 2002:ac8:5d06:0:b0:51c:98f:f282 with SMTP id d75a77b69052e-51c9b9c9812mr22454041cf.27.1783595888690;
        Thu, 09 Jul 2026 04:18:08 -0700 (PDT)
X-Received: by 2002:ac8:5d06:0:b0:51c:98f:f282 with SMTP id d75a77b69052e-51c9b9c9812mr22453591cf.27.1783595888214;
        Thu, 09 Jul 2026 04:18:08 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm53036115e9.6.2026.07.09.04.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:18:07 -0700 (PDT)
Message-ID: <e89995a7-0da5-4581-bce0-5dafc377e9b9@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:18:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 08/18] x86/syscall: Use
 [syscall_]enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
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
 <20260707190254.079478122@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190254.079478122@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX+XQtZ1cHC7We
 h0/9USdgw63DOYzoOrxO/+qNiK6RW94eglAnnE1FghcHciHLSRojGEktf3UiR1/5fR1DYJ8Y5mu
 9INd9VydbgBUPbqOjy7T79n/iYJko7nUWHRAWcvP9D5kLI2dVokTRwfbeyyTLq5JxeCKOubOSlR
 NIK7ZJlTwvKy+m1JgUD1AjAZwZvtbxMBRoujuJMeI1BIZ7bepZRfNmFwkILHCPcTT4z8hPOhXrd
 ldK9WNxkuvH+EbIFLxqpbdEI9dzQN/iqOKiMKpKHapKYjSSw7tn+sibRcudEUB8GnhhP8mudXg3
 2oMh2tYFimfQDqZFs+mqNwMQv+m+BcIQH3d6epQtesc9zNIemPbfA2WM2lNh7lRAb9EBbdZdyNr
 sy6ZtJ9auY9eOp3kHE1VA3up4cq3wd0IdLyRXa+Xe92bM3PV3xuL//gZo6JVQcRZV7Ou7Lfs85b
 0uHO7d/4m0GwYOnR6IQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX28dxFBKKfLni
 3cjIjGlpDoLCuv2vr56mQvZ81BELOY7Qld7sLSifFiVIOZbQuU61udp6YmZ7hLV+GKaB7ZbBkgh
 YIx7qbm7A4usN1nTDMDHwWvix6TlEmc=
X-Proofpoint-ORIG-GUID: BVX4Q0a9X1uBGpekoebEL2V0f8EmVhdZ
X-Proofpoint-GUID: BVX4Q0a9X1uBGpekoebEL2V0f8EmVhdZ
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f8375 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wOAZ5We2mjvvK_q5lLMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_041814_775959_B4D3AEC3 
X-CRM114-Status: GOOD (  13.24  )
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
> These functions integrate the stack randomization.
> 
> syscall_enter_from_user_mode_randomize_stack() has the advantage that the
> randomization happens early right after enter_from_user_mode().
> 
> In both cases also the overhead of get/put_cpu_var() in
> add_random_kstack_offset() is avoided.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: x86@kernel.org
> ---
>   arch/x86/entry/syscall_32.c         |   19 +++++--------------
>   arch/x86/entry/syscall_64.c         |    3 +--
>   arch/x86/include/asm/entry-common.h |    1 -
>   3 files changed, 6 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

