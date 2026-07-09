Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2429C44501
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tx1kSZXz579iItxHsi1/8Nt3maK8vpLohSpfVXF4Ysw=; b=wQMEE7389MHHMjlYAn5RksMohd
	0KuHPW+l1uTZ29TWDafh63my0sPEk5H129amI90/lkU7T69TgEIWJiknkq48MFvLPO+TUtYFBAe7O
	4uMxDrfZKLgDF/FlguxbX9IUGuTwL0njA1VOLpr7CTTr4Ge+ArAJ7uo2Oj9TTjOX7VvRzjrzC91hz
	NRzLm+1lMnkAMloINArTmzz+Sj1uz49Mm0I/K6VZsHi/uvCmgjR9aMN5iZ3nzAA7J4L31BClnlzRo
	jLmYb9RqpAJyNPQb2+HEjRbORnBu0e9SVOYbv0IwEaGSRdyVc0SHmmgnueJOLTegCRTEd/EUJMCTg
	gga65C3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmgn-000000025mT-1Mda;
	Thu, 09 Jul 2026 11:13:09 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whmgj-000000025k5-1lio
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 11:13:07 +0000
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxCB91574682
	for <linux-um@lists.infradead.org>; Thu, 9 Jul 2026 11:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tx1kSZXz579iItxHsi1/8Nt3maK8vpLohSpfVXF4Ysw=; b=jqvWJK8PLEi8s+Po
	PkAhOcF1EZ0TGn8umnL5kgryJ/tFquXm2xFzKz63mEvAAckXJG2v/bBhmyd/J+vv
	w606gHPQkOOhu8auM9bbQnd68PLYN5DhMVRn/TQO3SYM9ZXEOEAB8F2FTaHvyyzL
	/gj6GXZOaZ7Kqn5MccKMlGU9Y/8NaD7WUS1XOInbClq4x0wSv71WFJfHopsmfL88
	joRiOO1NBxKuiVXV4p/tSPunQ9pAf4nwUwhwVoGhXqa2d3YUXy3NiFuuL84Sr5z0
	sFBM3VIfsHX5R32LvKrkWCid7sj7it6qPECFAQp6EaOHyXV68SwSVXRcZbVTi1ag
	vIF6OQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvuak6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:13:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51a8c689b5fso13213261cf.0
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595583; x=1784200383; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tx1kSZXz579iItxHsi1/8Nt3maK8vpLohSpfVXF4Ysw=;
        b=HvkWKGmINyLQn8uruWt3PXTqRVsBzouPvOmn5ILcxcmwx63JfDfyL7ibW+fmXY21b3
         D5TA/8N8Yfypd8Gt2BSHXj6a2XQC+tO1LsSxpP4fa79HAq6s4XuppIIR9g24mwykac4y
         sm5kn4S1zrEUVpWnkbr5bORRMRoVHYpSaZKVdXi48QjSvv/D0U+7OmIQ2qPDMhLYqKTW
         KEf3UPPgaRyduTktJB4eoodiQIu4QFhBH2E5TncUsnOiwuSm5zyQh0ED0rhd9OJIO5o0
         BDRuR8MdZ/zTl1xMwlDJDfm7kDhhjoCMHCHB+23xOviw6F9ECP83n5DEZE2BfUVC+y8O
         3fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595583; x=1784200383;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tx1kSZXz579iItxHsi1/8Nt3maK8vpLohSpfVXF4Ysw=;
        b=fXqR+3VNqf+qigkPmWsGoegFiMs27TesQyxXT4wCTpSJWOAOq46IDD5DoHQlwZUy2U
         g/FwkZ8FSHCK3CQOWZSxnaQuICKwiJSoGH26N25mkM+wqmzcK0gj90eVcfxL8eXwXINy
         yjj7iGuWT8QQE6JqUGvDcWYzzqTamYPA8mvSBads6o+Q4qzBRuGBiHNfbLLDjxOk1YKm
         IdZgqoWnsaJkqULimUKo3AUicE+YLiVDBsfHUw7CXvtHGy3KHahq5gl+gVIuxyhmWLDy
         sIq1qmIIOz52fAxztjg56KFskPtLveGD2TCe/nzWd+5vNDI6P03dIf2BHDOjv9eBLUi0
         UXGg==
X-Forwarded-Encrypted: i=1; AHgh+RqJ1uRY4XHUMuZUNd05TotW6qlldVnDbBXh6pSgSvSfUSfduh08U9hqtLJ8l45ibvESxF2l1fCSTg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyEDa9HsLcbRHBp+E9aqHyNBirabsKIND50+Wqr/hWcJ599LrFP
	6wUWO6c0H2VGXKvro+XKnNHiCX+z03uwCTC5ySgaVq3CvTSreJzLV3BrXeA8wm0qZdT0Vt/2cYa
	sUoreay2gLV8X8QM7V3KpN3BtJjBsd+Tz1e17HeHBmD4dF/puFMiBYh8ifqYVcdEofFg=
X-Gm-Gg: AfdE7clnOaySPrI644R/Art2kJL6g8GdkTi5XSyffuo6H4XSjATd14jbqCmFlPZmVQS
	gp9maX/bG1FGkJ7H4sFN1qkSDKL+h/btB2Eqm3xIYi+JeAMmoO/ZxEUy284IMHR++1mVVAcIOPW
	lojOBKzVjDaiPQMCAa2B+or7VKYpVxYMie1IC8m4/eCrY60JKUK2fi/MrHa55GRLRfLo0PY/xJw
	PcCqrE7O2ePnAmH9S2skWHRHFLKukldxkVT0q98DsY5ZRbyDp0nvsSkDOZz1O2RGb+Vv/RkJMXT
	D/K4Z+rDaoskkpfiXiUKaiyWHCWi6XO2+xCmI5b34qsbOEs9GYtpw8lav0lGJ5wIL+FSt0eeoJx
	wOEUDLPsOS6f6T9lpDPRYAn+QLExm/drytpDxEqm130YWasomb+eRlbpwn4ap5Q==
X-Received: by 2002:ac8:7d14:0:b0:517:61d5:2f7b with SMTP id d75a77b69052e-51c8b4d596amr63974351cf.56.1783595582875;
        Thu, 09 Jul 2026 04:13:02 -0700 (PDT)
X-Received: by 2002:ac8:7d14:0:b0:517:61d5:2f7b with SMTP id d75a77b69052e-51c8b4d596amr63973951cf.56.1783595582395;
        Thu, 09 Jul 2026 04:13:02 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm48543085f8f.34.2026.07.09.04.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:13:01 -0700 (PDT)
Message-ID: <835e2f62-3b66-45d4-a614-dc2198a715ad@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:12:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 01/18] powerpc: Move stack randomization after
 syscall_enter_from_user_mode()
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
 <20260707190253.718191130@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.718191130@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX08Zt9v81ttgp
 kcYQ91SFC6k3DyGm4CR34GObXWKwgGiPLcwd2cV1eKMwsbcXNkcgIydU2CAgLyAST0auwB7xzKy
 dkDUiD+qBY4c9z+VhqXZPq+8m19usRM=
X-Proofpoint-GUID: XWcTOCxpcpmkKIH20zkLpDfnYlc2H8xW
X-Proofpoint-ORIG-GUID: XWcTOCxpcpmkKIH20zkLpDfnYlc2H8xW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX/NzGbVUYnO4b
 To2xDY9LnbeIH49ADLGp0zob/xe8zer85R/5OoenVYBeemX1Z7y/Ei/aiKzzxpzVZ6WL6+4w/88
 uZx/osYNoabtjbajovJdJFuk7lbJvcw1fT9eTHoxdA30BtVGSKKo+a5wgv7Ds/qfCngrkI+DcMd
 9ASQzYC0gOV3ZWBO+ckodj+REa6CZXWyyirWJ/Y7z219SF0t40z/dL0tRER4s6ElDtyEUBLHJSx
 el8H2t9kOBv3a1W+0T4/7p9eK04ayR4CNF8J6IqDj5G+Bnl3Ot9LAuQMXxnj3sffuFjQ0BhNxH0
 jc2HVRyPGRtv7LGoOUkW7iPH2KrwzOjkkxG6IviYh+XPwa6THLxZdBHM0H05G7xQ/FTUwBWStca
 FJ+p/WtB0YhYuIf5Py34NzpcVgA/xdLuUOGslaPaTiLpOI6UmLC34LhBo+PS7t7iHEmiobCar/9
 Osj+ghdv5VcBRmyyvWw==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4f823f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8
 a=63ny2n9c4_t8xnV3ltYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_041305_569098_D77C51B1 
X-CRM114-Status: GOOD (  16.28  )
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

On 7/7/26 21:05, Thomas Gleixner wrote:
> add_random_kstack_offset() is invoked before syscall_enter_from_user_mode()
> establishes state. That's wrong because add_random_kstack_offset() calls
> into instrumentable code.
> 
> Move it after syscall_enter_from_user_mode() to ensure that state is
> correctly established.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>   arch/powerpc/kernel/syscall.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -19,8 +19,8 @@ notrace long system_call_exception(struc
>   	long ret;
>   	syscall_fn f;
>   
> -	add_random_kstack_offset();
>   	r0 = syscall_enter_from_user_mode(regs, r0);
> +	add_random_kstack_offset();
>   
>   	if (unlikely(r0 >= NR_syscalls)) {
>   		if (unlikely(trap_is_unsupported_scv(regs))) {
> 
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

