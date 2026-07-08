Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC05DC44501
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 06:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5NHaxsIUhuT4+gPoK3v5GAm1W4gFqozMGBzG5dhHB64=; b=lyxzZE5NvVfAnC1pWDmkUaQzkt
	WHj67qs0tZk7vPoaC62y6xIWWBMRh+yg3QxLLChjGuQKSBJG+Y30q0jzau+A7q2dHK/fw2+i/0iXB
	swrM1DN9Gksp1MsU0j6gA63svA4EGDZNif0sk02zQlZlSq4pvbCHXjGHrNizQcdCxfCJUk8UTjjNE
	jyESNLcSshRQBrCai+7HjduZYEqHstHUamFs1YBbqnZRI18L6vMBXNs20ghMrILeBSPuczHXNZ5Gv
	zZc4G+88l6kBy4NtludGuq9RbJAs6nwtslPxkMCuB+wnysGkgXkUQxQKCx5WhRURZUwjPYVOT5YKY
	Dg/Mmf7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whM4c-0000000GR19-0M7e;
	Wed, 08 Jul 2026 06:47:58 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whM4Y-0000000GQzc-36WW;
	Wed, 08 Jul 2026 06:47:55 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667MmZNI820082;
	Wed, 8 Jul 2026 06:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5NHaxsIUhuT4+gPoK3v5GAm1W4gFqo
	zMGBzG5dhHB64=; b=J3VvRJOPVCo8sfswlNLclj5tEllTcDb/5mOo4UwrcEmwj9
	kOcib6SJfoOPHBqfKEFzjNZQd2EwJ57/yD6sG6B0H0tNDzXD0wPRsIJ0gKTgnWVA
	9JsrNlpGhEja0n+s390NL3qqR6LSh3vnBOyCGMWPrvuvLPrc+xg0eqGbCG9GpFQt
	T6IXomRuMHhJ8IUHLiU8SEMvKhLQvSru/L88QBvsa6uwMTaUt3hfk/CVTVbxikmA
	E2o0GDHMrGc6K06KjQtEHO/0pun9gVtSFIiO8WD/BwEDrzHsyEsZJRJzRzP90hSH
	1GPjR3pHagQg1Xr7sMrs+qCTC9VvOfizqWMYYnbA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4u21t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 06:47:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6686YexQ019843;
	Wed, 8 Jul 2026 06:47:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg65y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 06:47:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6686lGMb12976422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 06:47:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84BCD20049;
	Wed,  8 Jul 2026 06:47:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09F8D20040;
	Wed,  8 Jul 2026 06:47:16 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jul 2026 06:47:15 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra
 <peterz@infradead.org>, linux-s390@vger.kernel.org,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        x86@kernel.org, Mark Rutland
 <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Richard
 Henderson <richard.henderson@linaro.org>,
        Russell King
 <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo
 Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard
 Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller"
 <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
In-Reply-To: <20260707190254.030598804@kernel.org>
References: <20260707181957.433213175@kernel.org>
	<20260707190254.030598804@kernel.org>
Date: Wed, 08 Jul 2026 08:47:15 +0200
Message-ID: <yt9d1pde6kr0.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _L7edkq3BwnBWML6vUHeJ0rb1UtEu9CY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1OCBTYWx0ZWRfXy3LHxWa7PIH+
 8urugSBuUbrtJi57OI87IYjkuqIiXGOGFK+88q8gEVOe7ERBr8TsrVGypKfNgvFuShFuK5wtiHj
 Zfx4VvtSTJG9XBXaO4MYfRBFI5rBkjhHVxI5WzazNrE1rEbw178sbd/cxA6Auww+KIhdddwtejJ
 248bkWj12S+T6W3/mrf0LUiPVaXvbe32OIrqpAKj3jON8/Z4sW461FTCn6oauugcrSdf4ngCG9A
 Bjd+1hUZ81iR2MpsmkN2NtBwDJEQ+ZZf2mqghRWaGHeLLWTgm34cVk/vHeRpsZXUWFoQ1vYe+5X
 tbeYGoFzMCGLc9Qs5veIX8EC8xAv74iY/tqVUC8qt3d6EAvNIn5PzUFU1St8HVwn1XFeDmcRHny
 oEoQT+YS+miZuXlhWPhpBKCjMLxdBjJ9JOvWOsxszLTqO3yRBp31v2W/sChgHwIr1VV7XgJC5Cp
 eAQ5TpTCNimIS0W4vmA==
X-Proofpoint-ORIG-GUID: pEfjwvvoAjoHowG9Dv6PDIJZE3RmcFmr
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4df278 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=buEBMWGfP5CXRQqppmAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1OCBTYWx0ZWRfX+R5HcxjXVv1w
 RVsRwLeD9F3N1eXzMOe+apX4IAesgta7GXGOixJqeU/NBHDn+tO8IhjIk+MU7dU+sY37T5/6W7w
 fxWFhXVc37deMYvOOlkRHjGNzgYwS7c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260707_234754_844601_85E4AC3C 
X-CRM114-Status: GOOD (  16.31  )
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

Thomas Gleixner <tglx@kernel.org> writes:

> enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() and
> the subsequent invocation of add_random_kstack_offset_irqsoff().
>
> As a bonus this avoids the overhead of get/put_cpu_var() in
> add_random_kstack_offset().
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/kernel/syscall.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- a/arch/s390/kernel/syscall.c
> +++ b/arch/s390/kernel/syscall.c
> @@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
>  {
>  	unsigned long nr;
>  
> -	enter_from_user_mode(regs);
> -	add_random_kstack_offset();
> +	enter_from_user_mode_randomize_stack(regs);
> +
>  	regs->psw = get_lowcore()->svc_old_psw;
>  	regs->int_code = get_lowcore()->svc_int_code;
>  	update_timer_sys();

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>

