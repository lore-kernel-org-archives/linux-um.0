Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C377EC44501
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 11:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=; b=ydSNohA5MmQ6hQoeQMR5ktopzw
	Did7e8SdY7HOG6qWGbnUCaPFd61zzFl/YGeejmlt/5fDMJ8JBEGY380s4Chb6dOTECAslvvGpd04m
	p2TXOfrhwZpfdkhxKB0a/3oyarSJXsnSB+RvA2hJdTAq9pmjHZMdNTR0xjLgsCKwSzJFs52nSgcsr
	OgT1pXbuB2sb/2VV8HwfxC9Nqp1I5dzZGrguADBVh6hDV/oSRMaFMZ8FjQaE9xCzyjOebmnoNtH54
	8RraLbOgUytaMe6Jn7MOf5KDJZDbo67YjqG41MXLrtpGfMqsn+9NfUOKeGz6L3ihpBu5jlYLXoq3r
	ul/pfPng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmkv-000000027yY-2DmU;
	Thu, 09 Jul 2026 11:17:25 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmks-000000027wU-2UIr
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 11:17:24 +0000
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Awtw81660527
	for <linux-um@lists.infradead.org>; Thu, 9 Jul 2026 11:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=; b=L5+SzP63bgPAWhp4
	W0cUVg2l9n9I+4k0Akz43rpejx4oS0/IbbWAmLMXE7C9F37E36sY/GsXk3zuJt0e
	7WRl8xWn74pDgWLAKB7VqpUweKGfDHpjZadrDE/thxVaWuDjHJ729famrINqKMDx
	0upb87A5cv2e3e9cOgTo/VDABpH4Tf/6q96s0WSa2IFCTqdWIxx3GVEJhdklhdir
	gMzNGoVv54cFMR8lTrj5sNzMMQDcUrBjV8bPTBpznG6YMJOrkgy1v18t2RPVEfx/
	2v3dDdCotvg9oshrPidheW6ip0HZ0YECDQHkCxRsQPUi1HLjdw3FRE6oVFrVR41W
	qvGWIw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4vug3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:17:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c19493ac2so11529711cf.1
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 04:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595841; x=1784200641; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=;
        b=AefqBe/5MSqmtGKVRmMQcKqlhluRSXcwJY1rMF4+kHMFAKkhJpBiXFJ5qIf+y77ses
         4pQoce9Sg3Vq2J9iuWXxZ0Jye9DaWCvoLOVe/+OygS1d0V1cqZA6gNlmPQk020tEzbvK
         ZHfxXuS8caOUsCh+rOnLtuX9wI+qKzrA0agSMprRi0mANZGlHA8mUK/f1fswXhaOzYj+
         iziXv6GGW7phSr2jDXliACHazNc1dIp+/kAeH+M4Mrbp6asAA3JaXsg0GzEH7QATc0Kj
         o+dmGYFxg9YAfsAgUtCnhjBgTMR8EEzdG2BViSSSvcqRc/Q1/1OgOd4XToPyQsYlaib+
         +J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595841; x=1784200641;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=;
        b=Rf5ckX2lU+Ghs03mRJq+1vZen3+ns0I2Y8xRmodM8/LLL9YJV10BEUG8i6oB28oS0D
         4/wo+Zea/mTmdsWvnx4sqDnTa8Gr0RGkxGzWZ0Hq89k+bHK5D7nBh/8kaB5zjU2u3gQ8
         lazCiGdXnwdOge8If6RPIaB+9T9iNAur00updJU/iFIEzIzOy2/bmwQUdzEEcKf5qpLZ
         NgOxBV+ipwEHGdXQunQB+E4lMNItuJe9eCk2GnuwllNdXvAe6Ls+L6zkXUX1l7jbborn
         ILG73ke5cwP2mJ/p0YdFgXGYvFSfoBuXL7hkKebRmOKe9eJArkJ5E+/z1gHnJEtFlSjA
         nhAQ==
X-Forwarded-Encrypted: i=1; AHgh+RobvjwylZA2u1JTjr56OeFRxRxJGynbuZqfaL/3xB7/++pmlvZoS+DXzZgP8/jQPNitUpCDzq3v2g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxo1gf6mf6aB8f6Xs2JVehU3DubbRoUdmWGs/YF9NvCNPUemKkl
	XmNCrRcCGqO8LFBUteFBwTtsaPaoEfw4PGkn+bPFSceKfkdGpR3TJxj0fCskEaYKDhsz25xoiYL
	SSl8+5OTEzfNtkA+wdIYzk/revqKjHfLYaOd+/K7MU9s64GtDkN+W+sgmzxJIIJyouFE=
X-Gm-Gg: AfdE7clY0c5fvvUOmGD0sNqD6clifN1AY0vXGWHKZW5QyYjvWuiOl0PSSukeMQzaG4x
	0ZOvtZwlj6pZMARMwRmWBQJr1zxzsbbQeaKL9eSEd/0w/IabgW9+slMCTcbNprim5Ustzp3jMY3
	r1FNoK0ZawAb+hoIJc8Y04on+A5J9JepJjqeRyFBv14+9aE/vTmgr//wLe0nr6lv0M45M9VLnGZ
	ccFBdrNdEE/A38CZgATSjzqwKYJbPuuOmu9YPx79zmZGRq+701eeh1AGeNWtn3Wi3ubcZX2tjc1
	2KpMnXQ3uOSn7PZ2gPXDIYmCaZcJpUwqB5uIJorda8ZwUOaudjf3NEfXsx2cYcmoBiaKTGA5sI7
	cAF6xSmyUwHBrZMHdgif/v5++0hFnLTqyueA50Dm87VPcvTExZfsHMuN918EVhw==
X-Received: by 2002:a05:622a:c86:b0:51c:7b11:41b2 with SMTP id d75a77b69052e-51c8b51c97cmr72541611cf.78.1783595841155;
        Thu, 09 Jul 2026 04:17:21 -0700 (PDT)
X-Received: by 2002:a05:622a:c86:b0:51c:7b11:41b2 with SMTP id d75a77b69052e-51c8b51c97cmr72541381cf.78.1783595840774;
        Thu, 09 Jul 2026 04:17:20 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6cccfdsm54034235e9.1.2026.07.09.04.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:17:20 -0700 (PDT)
Message-ID: <8d15c107-30b1-48df-9e69-a7e8520f4e36@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
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
 <20260707190254.030598804@kernel.org>
 <499eca86-8def-4044-8b69-8f290528e10f@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <499eca86-8def-4044-8b69-8f290528e10f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MC7cKmsbTbjz-eyouepQZPxzN4GECoxQ
X-Proofpoint-ORIG-GUID: MC7cKmsbTbjz-eyouepQZPxzN4GECoxQ
X-Authority-Analysis: v=2.4 cv=GIg41ONK c=1 sm=1 tr=0 ts=6a4f8342 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX10m/FhCAxmmL
 xAWw8/Rcd5pLer69u6J77Xc/MeCWUF1lSKrioAWqUDNuv09KEM0BNkAt0UqpdpSGwetp2Xo/xZr
 Ti0VY/ayX8DI3F2ign4vId4Y0ZxZf/AfnKtLB1FniFCXGYP1TXtOOXIEFr/+h7qYoaLjyENe41R
 JtEP9b19canwY0+wiWtZ5Se9A1K6Ga7yWLCp4zg5Vcz6p6I+cJnruxjzimHqj99NeUP9YpFO+NP
 +yqmiezvH8547VfTwZudkJMFKNUFdgwFVyfQodKRPqXmnVXAa2TANBLAU1MxEPsM1Xj92bGpyIM
 XOkFi6fg9urcLPp7YDV1qDcmtQb2g+lasI9lLWLq8pIixkSl6YarMTbNdAq2GXYGh9KCjnx3Srz
 j2L2wAdUH3Rmpsx/znf4E0VE/KgMz+HjMUjx8HRU0t9ffiEQeX6pA88X1OCQOiW6+n/oLZ0BafL
 vd8VWPSJ4ZmwtkPuoUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX0OnIFkwkykJp
 1/xBTYKDtWj30cbyEeeSobsTtwRNe69n665YAF3zI2pIB/asv8iUKg4w9FwHN55VquLwfPajNxC
 yxz965q5HQYANvEChVJfZvg681F9SSM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_041722_629642_EBCC385C 
X-CRM114-Status: GOOD (  14.60  )
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

On 9/7/26 04:46, Jinjie Ruan wrote:
> 
> 
> On 7/8/2026 3:06 AM, Thomas Gleixner wrote:
>> enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() and
>> the subsequent invocation of add_random_kstack_offset_irqsoff().
>>
>> As a bonus this avoids the overhead of get/put_cpu_var() in
>> add_random_kstack_offset().
>>
>> No functional change.
>>
>> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
>> Cc: Sven Schnelle <svens@linux.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> ---
>>   arch/s390/kernel/syscall.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- a/arch/s390/kernel/syscall.c
>> +++ b/arch/s390/kernel/syscall.c
>> @@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
>>   {
>>   	unsigned long nr;
>>   
>> -	enter_from_user_mode(regs);
>> -	add_random_kstack_offset();
>> +	enter_from_user_mode_randomize_stack(regs);
> 
> The #include <linux/randomize_kstack.h> can be removed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


