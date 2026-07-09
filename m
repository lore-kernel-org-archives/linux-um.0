Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF1AC43458
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 11:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GMTUKuNW7nHEjTmJYQtVLsm+lxP07KtZQHvvJ99eHNs=; b=Dk9lU8F2Fjx3PlfccDOjQGKbwE
	7UgEaKh4mxgpTgMZwWmcQSHLj4EXeNwBRZkUXZSsGEPZyEdup2eteaE8JbJJVF8/Ixkp6auI7UcmH
	3ob84BYw7T/3JVcT9SGyjv27X87lp/C6Z+WLxPxBxELlzM9NubbsYyPXPiOq0MWOaDSsYDiZq0baJ
	dn8AG+bH6zLwtuNsjvq6pbx8UnqxYiCFqEkhUumWvIinYDqmwdA1DnCfxM5BC1wo/39jd6Fybdb1d
	iIBUpIN+YNFnH/GRgxYCvzie/Bu+6yXE2rtwL5MUKqfnzgFVf+6Hw6s9obLKtyqhF1WcCGZc4L6ZA
	1ATyaM9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmpv-000000029RT-0R9S;
	Thu, 09 Jul 2026 11:22:35 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmps-000000029Pv-0d8B
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 11:22:33 +0000
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxAhM1603599
	for <linux-um@lists.infradead.org>; Thu, 9 Jul 2026 11:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GMTUKuNW7nHEjTmJYQtVLsm+lxP07KtZQHvvJ99eHNs=; b=jTI7fkXQl7cmfY8u
	/6bNS+Fwu0N0JYJjqKlpNE/bUkl2mhzeMCIy9YTKs/eoShIUpl8OQCJgxUcCe1Qs
	3cJw4qK9vv+hDmJX2IozRyra6X37WE8v8Vxl6bxaUL0j5/MLQKzhvIKs34reKXrh
	QWs1Vb41u8wIG/o9knrL4GgKq2/ZBNYGTwPnHTuT5u7jJ3EMLnaiRdEBXGlLErlS
	QMBDjPbvcSMQgesyK7qkf9Xbt4GVvlCDF7pU0Ep4e6tiqGpO14UiKVK+WJIifgMb
	eFDVUlYtLgbk+5e07s9PeDWnBLvsQTPHVnHxEKk6PFxWS/VH6saUNZqOsHQv410+
	3wCVHw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa6p3s88y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:22:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d7886cdso16217301cf.1
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783596150; x=1784200950; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMTUKuNW7nHEjTmJYQtVLsm+lxP07KtZQHvvJ99eHNs=;
        b=B9b6LhShy8NFKbrYlFawzpA9BW5sL3WZIaor3JjJN5dijFUSLMn4TTHJBumJ1jHmLB
         4pkeQ3NABLEWGRyxm0d4IuZnWvzE5LtJYPUfbihACAZon1Z6AqGPttvlnU0QV9H5jHNN
         RIgLUe2B8o3Qgk0ROk8+MybzDAzgqFINgGSsz7yrr5hsqLqLUMxNUD9C1oElwqIAfvxM
         JleHAL9jT8ewb18K92fVCE3GT20YSxSVCK8zdsIUGJip5Lu8rf6fxnmixj40lGvhqq/X
         UNkXjhP2l3bG069E9FgKnVGCDin6v52/TCUh7BwYIHk8ih237Y0IfkUzecjrUdtEiBkG
         HOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596150; x=1784200950;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMTUKuNW7nHEjTmJYQtVLsm+lxP07KtZQHvvJ99eHNs=;
        b=c6LDSQPDJARWeQEN/4CA2ZBAj84SDUUAX5rwPIAeu/d9QREDTJt+EbCURwah9f/jqA
         FiqWtPe1bNPHBXg2C5gAdkA9CHIoIe342GtKDC+Zws50rkMsw4ynnVfnzSU5thBgtjs3
         Ztz5Om+kVT0lazEMlsD3ys+DUSxgCMwowJQwrXr/GoV82P5TU9qg6fgxegtJSnX3tvbt
         stru8zY9Dp/NDqtyqAce3vHMUeP3p9Kjb+05RHK1h+MMgd8HoDqW2RD10MR16Sk5zb1A
         sIBC2zpJejgvpPIyu+KEuZIqCg1N61qd8vwIW1WxvGq6dKObdHilrPCeJ4bNYNVu+5KP
         6HrQ==
X-Forwarded-Encrypted: i=1; AHgh+RqSAdUOEWOLIL25PkayCjEVuFrhq+G1FmGEeh/wYohzUoMUAkDHzS7fCT7atpXqIEq/Mj090kpOkg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzhr+WtTUCRVHtMbq7BbEaxeCJl31YuISma02O6riuD77QuAlX4
	Vqun0koZzZQUJ/U3DTYRzDY2a5NsRdmrUG1r4h52tbj+WSo4EjDURQvjZUaGqIrIXbIj5PHYdxu
	YJzqQyHe3DgNb5hyMbisiDqUxOSMC6GxMvkqQTaiqNOSvXe4H2hIDUB/BUhsoII2a3io=
X-Gm-Gg: AfdE7ckbiauNJ+Lw5t+iabeg/Dpek05fZozYLzmrCGqTl/uWeWgJ93skC5gV0UqVOTI
	J6LBvim8l+zFduqn6QNFAXTUkPQZRJlh1ZXUzRDVtNTEZ9R2StuJI0LUnJQpNYQFTiNR0lJxbck
	4qyn4nboAd+65wPOJX0+A+JgMJ9NtfDObQQ0whiCP6IU8nAEh9jMAlGUT6Lm3VEtIObXjgE/ng6
	hRgywMtjgNlSUTE6kyW1Nhm4cIHiqC31u03rSK1+d+Y4kF7uJsoUYPqz/m2NiiTQ2JxSay09CPu
	ZnceEMKsvChiCL4eqb0rK5yTLb52bn+yCMgIXL1GY4zKccRZsothf2oLkiK6exA8I6wSVyysHcr
	HoqqZ89/QeCMBvA9WAVOOrDnrWjOmiBvtvUnpJEYQj0iH3SSG7qhB40Sqmoz9xA==
X-Received: by 2002:ac8:58d4:0:b0:51a:8c86:bd4a with SMTP id d75a77b69052e-51c8b407e1cmr74987961cf.71.1783596150601;
        Thu, 09 Jul 2026 04:22:30 -0700 (PDT)
X-Received: by 2002:ac8:58d4:0:b0:51a:8c86:bd4a with SMTP id d75a77b69052e-51c8b407e1cmr74987351cf.71.1783596150195;
        Thu, 09 Jul 2026 04:22:30 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm50814277f8f.5.2026.07.09.04.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:22:29 -0700 (PDT)
Message-ID: <ea24e611-91e0-4397-a49c-1493966094f9@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
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
 <20260707190254.181086755@kernel.org>
 <73b82749-2df3-4c12-bc2a-ff7628dc8292@oss.qualcomm.com>
In-Reply-To: <73b82749-2df3-4c12-bc2a-ff7628dc8292@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JYIV_KLEW5WOIufb3SXNo0vH7R70IV3w
X-Proofpoint-GUID: JYIV_KLEW5WOIufb3SXNo0vH7R70IV3w
X-Authority-Analysis: v=2.4 cv=TPh1jVla c=1 sm=1 tr=0 ts=6a4f8477 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXxQ0vVF5dfauI
 QoLQT5lxym98uSvlXHkw2aVH1r4PFnbF2hYO2tkd10YGlX84Fow8AvvTJ+9ujIlj+fWlbjcRilY
 EAAabGw6dRdoCacq9V3cOgK7AzwVRgI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXzvvv3xsXCOwX
 jhWA/g0iwQHemsmKfHhu106W2y7edmup5GKBmFve/Oaw152Tuh01mQ9NWx8wL3MmU31SR95iaU3
 Nn0tc+F3cE2FM7udD9fyrpm9+81/ltgF2s87RweOwCkVaxadgmYnR70q2J7laYVKgd9Y+jbJpNf
 jC6ljHjlYpeYkiAT79ON61oDPSTZHFsQYjP+oSvtDo+wtMOsB3x1m8ST2dQTJ5q3OhXcrDW92HW
 nR5v86J6/DHn6r1gDSGjuIvP6CUu/S9iOPBVELZ1vgTZJVt5SVpvQr+bseFoD5m1T6RL9PisOIw
 acK8RYRT9jAWEdvLKq1d/n9KE35KI1cogaHVa8+mCZKKilRpaUT3YQc4GHQvUjZ38qVHPSczVLL
 B7MKLrd2ECSej3upK7uU3RU3uKhCBPjsbjTTHx7UHU55yfhRlBmTttfb+8KVNwlnitt+lOFKPUz
 3vf32cSSUJP+awD6x4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_042232_208414_DD99A70C 
X-CRM114-Status: GOOD (  12.23  )
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

On 9/7/26 13:20, Philippe Mathieu-DaudÃ© wrote:
> On 7/7/26 21:06, Thomas Gleixner wrote:
>> rseq_syscall_enter_work() is invoked before the syscall number can be
>> modified. So there is no point in rereading it from pt_regs.
>>
>> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
>> ---
>>   include/linux/entry-common.h |    9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


