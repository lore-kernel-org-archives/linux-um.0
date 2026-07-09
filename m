Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3290DC43458
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 11:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=; b=Ibkbp6eWF2YFMlw2DE6LJKlp92
	7iTWqg1tQ6HlKnMqaEbnnWYeHGyT3sA4aXjJVc3mS/uUBvDHBZCmaViqVvaJ3aGYyLYpCAFTJMTWJ
	D6tu2pB5U/aKa8LWlaa2Piy4KWMuFdqcxpuAuqy6fgJfl3q6tee/LWrWhq2+pKw+xuKOOMs14xQpV
	k4GSxbz+bK/URx4yvlKN43aDfACiaWR9Klbv9j3LLm3ksFsrAyDXhtsYcb7OT1aPKe0u8TpTn0XPq
	QA21S3iXqtWn79r+W1XZ4OhuoEHoB1LaKLi5ZT5BjHe2oI3IohQX/INYr964CC0zoWZhZiU9E7f7q
	pxENNVcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmoK-000000028rU-2Wqd;
	Thu, 09 Jul 2026 11:20:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmoJ-000000028qM-36CS
	for linux-um@bombadil.infradead.org;
	Thu, 09 Jul 2026 11:20:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=; b=rO03TR/pOyRuGNJPF7T/P/abXb
	FAO2agNk8Vb79N3YtIzZN9UOHGWzHhMUhzqFoeC8zQDiYS+ZwDvJnvrwgmwbr9qMo7dv910yUl2Hs
	lcOLVQGUJUkcXRVLJc/+2mh/l1TknXjkDJasNfW817cQHnGcazI/LCeoUcAh7rqyo+5Kj8dukDL+4
	VHNxcmr+7HQDkzelGErexXdpMg+O1GCR2zs/uGwEi3aHGrdvjFGGY3EGj7c1bvIIc5nmitZx+kdG4
	r2ySrmbxcL7iyBx9fN3HxkrtZnzhE1tEX1M5CbY12EdhYH15p2V0TdhAuwN7jW5Lt98AFtqnLY2Ma
	QB4BNrsg==;
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1whmoF-000000097pr-0nWS
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 11:20:53 +0000
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Ax4031603551
	for <linux-um@lists.infradead.org>; Thu, 9 Jul 2026 11:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=; b=iOWfjmK8f8Y+DVJW
	EcnBVbRqoFetWpR+MvbIm0rNsCYEYiCVdv/jb+r7ZZuAst5pdACVTyVPX1hk4M4R
	UloW32yrnx0br0O0OZPBTsUXsGcPSz6fo0b7Z9SsSAlawkneGV3knPcGuKS4ecbQ
	qUgL7kJ1kZwezKuA1OHch6fG0wR/9IjoD0gaRXopgi656DtKQN7lmNG5nDcMpELo
	+2tydKrnvkk1mYPsPWN5nD/hRUDpTxejd9pRgo55t5XyFzKGEVSWfHJeObs1qXCX
	o+wuU7kKSC/wnWW5kZ8U0x7Pvu4fl9GPrm5rLmSBf6RmcKnNqHf8RgkEBJ09ZjsD
	t7y3cw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa6p3s7ya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:20:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c01ff996dso17579791cf.2
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783596048; x=1784200848; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=h7QJriVZuTgvOrv07H1eaxDeYk/QN3U8KHvfIPc3JdCOyxq95QEbKkHDoZpkgz2dr4
         Mh7Whc7viyChmYq+uUSCxtff4YSSFByb9VlrF2k+zC+TsO3GohB2FVkrdWuvtBjm4mEY
         kjuZwX3MbRvHBvxU3yM2G5kI+KsXxgmPpKQJTCYSqUTe4qlzuoZMlGTcr/LnnXbc4IzO
         idi8k3QE30mMA8+8NG5tUJY4/V7NKpwdLgS6p4OsJXiWQ34yucq49lXE7/U2Uy53G3DT
         8Gb2cbzdDegvp9hy/zXpKWWYCNj6YORet4O+saDIyUC1O+VjTpcof89Q+lAocVyPCIY4
         aSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596048; x=1784200848;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=k2/VHJew5Chgug+iTe18L1F8EJg11w7zsnIjgyRENf2L0Z15Yl2dsMPKK8LWJvMp6g
         cCuhsV/ODKq87dScy6CFsgT7d2vFvSBM1u01JMFcKyqAoFNY16RzhAUPF1DOImunUSVC
         wiAOh8YRQiRa06OQ/nRh/pFuuxFOmiLDg/1eQfZcvZiqqxExyAs7s6dltjzwQlVP69DL
         4QnA4H1ElxDs5YzdB5YDHSTfSh/sYGVYKssOTtA9gyACNIRufvmkcTo8wI6IUL1QnOy0
         ly57q0cwJLyj9jMyQHieRhFKerBMkyKZRG1iMRNW9OTvnFhS8dAWX7kYls8WjWPeI5bS
         EQDA==
X-Forwarded-Encrypted: i=1; AHgh+RoNQlpRoQjJG6KVWOmLx8Kj4whcQ2h8WBtJ10vNOA7uP66GEmOK6tYO3Ixq8UhRBoxJo9F0VAHxrQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxB7TnwPVXizWyZpsqDTj9asqnY6vDIJFiPeEtJU91NI+dlOHWp
	g+vTasmkeNpnuhx7uA/fWs0Vpzp/kMBpWqLg32JLr9k4SeZvXuVvStHzXsTSn5q3tpxKyxcETBB
	h3h3Pf8fawMIoAZtu7klCQfIJ0YJRqsf4qJyK+rqE952iAUoRsSE4Igb3AVjqFrV1ZoU=
X-Gm-Gg: AfdE7cmtK/YEVVAe4RxoZmMBRiYpnFOD3aa2+yiw8U5bkF+0FxzrdEx60AVLpWbdCgp
	3ibwVa1wJxxd0xJdrWtPMPzVpVGUV80qOSV4Szc6IS8slSWAxIr7uAUJnNvmJkWUSEHgGQwf9jm
	XmEx6cbOUnRzMtre0wDdiqHuJaSWMO2kBudn04G7FsQ6qcg6dhltv12X/YBLeK8CD/PLAKAZLNa
	ma06XTbTlL9GEY4pfqTJClbwK9W45jKvrJzaX7skh3FfSaD8PE/0qgDr6XYlVD83bZj3RGYDGeF
	s1PuRO6RRfHwn5PO0NFubRwdHMS5aF+zNZ6aLtvvP2JIFwiuo9uVkx4685deIPYIIwsxu7ZQhdq
	8OqgR2RMQbpaoEl0yDm5hInVu9/4SfRwCm3oRLU3LzIapnucrVKrteD7ebCDnKQ==
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71755001cf.27.1783596047580;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71754181cf.27.1783596047072;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69acd1d32c6sm1861799a12.31.2026.07.09.04.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:20:46 -0700 (PDT)
Message-ID: <73b82749-2df3-4c12-bc2a-ff7628dc8292@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
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
 <20260707190254.181086755@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190254.181086755@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5i-QWvhzvwqWBcLSVNfpWf4T2D6fVTRI
X-Proofpoint-GUID: 5i-QWvhzvwqWBcLSVNfpWf4T2D6fVTRI
X-Authority-Analysis: v=2.4 cv=TPh1jVla c=1 sm=1 tr=0 ts=6a4f8410 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=uucGcSui7XbmpEV0VHgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX8/PpB0EZoWqu
 aiyhuqyTcCc+QKSuFDfKIhYWR53jPHTOq7YJBD0zR2ks/wp41uyMWTN3ruEW6yx+o1g09DqsfbA
 Z+4DZ8wxoRHXUC2h24iJOiYuRbkTylo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX2MSCKGMzTGO6
 kIm6qDkKkokIViuUlAyxZjGWfGRlzJu4Kn1HvHKqxC1/+jfq/NEo3wBY2REgwFk8Hjp7i8qlcSA
 YQwHbiSYvL1lGe8dIENvu221PtKs8tZL55QjZ43moDzSm/QVRbwUeKvi8TKzQnShJXmkfivtzBw
 gbr6ZUsQWkqfNDuD1vTN5S4p5Sln5AiL0lV0Y8tX3Xp8sfyfxmbA0oDpPwOEb7cchH7epYa8+nj
 COOCavvOpjGe2a5r9XY1E8OymcytNTyZFFybzp6bEEhiaqH+NlVxqFT209gjkKDZWp71vDZ+WXv
 zSm4GRor9cP+KTV/I+NkqvlwbiWkXRcp4BG2s2EPr8+I5iq13uPrksTYH0vKmO1y251Tl0oOIgU
 685vRHhoZpRKN+M8IyJ7KP9vJ1b3FoKKzhdpMa1HLjKZTqB7DG7zOIIgTVFoW49KWSCt0IbrELt
 rcVur6/0OyUbgpLc+vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_122052_155405_08673654 
X-CRM114-Status: GOOD (  12.40  )
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
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>   include/linux/entry-common.h |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)



