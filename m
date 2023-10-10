Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C44DCD68ED
	for <linux-um@archiver.kernel.org>; Tue, 10 Oct 2023 07:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x8hlcRi1NlPkCpysFhzGWK4Ida6JbkmywvB4Vmuio1k=; b=yGMtXv9kjhg7ET
	HBBlJaFcDxMTN2U7AiYpp7tbBsuxNOR6gpfuq0x+s2vj8rW2FviLydUOo1frRXvED5w7DCYAhRB9G
	iaVUEJTAli84jiss0XZszpw67lm5IhTeBL5hL3A1hW09koluctoP/YmUnkHF+5mX14zhnMjgirAI/
	5UmOPOD9EWZQZkKe2rqbzkSsCrUb2lc6sAtEHEjPklAwAj/C0Suw2L4NFLd3GYtOZvPSwAj1Z/ACv
	7ZHZOCalr6A3z/qKRFIFoU4R2arTWVy5DCe9fijYqLKbkznjfuIDZTHvHWrFppuCMhbWgd+TWlG50
	1/pRNjvvfFxdxNJ8nFQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qq7JT-00Ciot-2A;
	Tue, 10 Oct 2023 07:37:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qq7JP-00Cink-06;
	Tue, 10 Oct 2023 07:37:53 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39A79XvC020878;
	Tue, 10 Oct 2023 07:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=5aaW2dPRZNtep/xpizNo1N37xs+hP26eCD8NQHP4dYg=;
 b=fVtGrVHngctrT1pbGLa4kXC6Fe5YJewBoz+fvd2PlEeRlwxFa8Mz8htlgo7LyeE5ZKxo
 c38UNaXtlvi9WBRAV/TfG4SKfPb4XcA+Hbld4wCXOaoJTNV2SbPzFI5HGTPFPnrhOkuz
 i+YzokrsJB6sw/l2hFqMyvVR7xdXygmj1olabaYPAf+NZfRUu6ndv/LPY5Er8eJImBtA
 U9r8/auWcw6/6ciwOREGLWgjdv+uTA6uft3ai5yHqErbT2l3rHRRts1J7YocsGqZqScZ
 OCiu5nb92oYYMMDAZNTDF5zdFqt9utJzeOSvHKZyurFYuaX/3geRwZTDR8N1jW9Y/2nh KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tn1yq1513-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 07:37:04 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39A79caK021024;
	Tue, 10 Oct 2023 07:37:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tn1yq150m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 07:37:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39A4lurn028185;
	Tue, 10 Oct 2023 07:37:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1xy0hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 07:37:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39A7ax5Y22086166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Oct 2023 07:36:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F70A20040;
	Tue, 10 Oct 2023 07:36:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4797420043;
	Tue, 10 Oct 2023 07:36:58 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Oct 2023 07:36:58 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>, Borislav
 Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen
 <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>, Guo Ren <guoren@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Heiko
 Carstens <hca@linux.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>, Ingo
 Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick
 Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier
 <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley
 <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas
 Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, WANG
 Xuerui <kernel@xen0n.name>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 4/5] kbuild: unify vdso_install rules
References: <20231009124210.1064021-1-masahiroy@kernel.org>
	<20231009124210.1064021-4-masahiroy@kernel.org>
Date: Tue, 10 Oct 2023 09:36:57 +0200
In-Reply-To: <20231009124210.1064021-4-masahiroy@kernel.org> (Masahiro
	Yamada's message of "Mon, 9 Oct 2023 21:42:09 +0900")
Message-ID: <yt9dfs2judwm.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _CGlDQcO5kaF2u-illDRNoa12BhAMAB3
X-Proofpoint-GUID: 5Ae0OhPocEUKJk2CSLcSZHHAMy_Wm0U-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_04,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=931
 bulkscore=0 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100056
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_003751_208822_76524195 
X-CRM114-Status: GOOD (  28.28  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Masahiro Yamada <masahiroy@kernel.org> writes:

> Currently, there is no standard implementation for vdso_install,
> leading to various issues:
>
>  1. Code duplication
>
>     Many architectures duplicate similar code just for copying files
>     to the install destination.
>
>     Some architectures (arm, sparc, x86) create build-id symlinks,
>     introducing more code duplication.
>
>  2. Accidental updates of in-tree build artifacts
>
>     The vdso_install rule depends on the vdso files to install.
>     It may update in-tree build artifacts. This can be problematic,
>     as explained in commit 19514fc665ff ("arm, kbuild: make
>     "make install" not depend on vmlinux").
>
>  3. Broken code in some architectures
>
>     Makefile code is often copied from one architecture to another
>     without proper adaptation or testing.
>
>     The previous commits removed broken code from csky, UML, and parisc.
>
>     Another issue is that 'make vdso_install' for ARCH=s390 installs
>     vdso64, but not vdso32.
>
> To address these problems, this commit introduces the generic vdso_install.
>
> Architectures that support vdso_install need to define vdso-install-y
> in arch/*/Makefile.
>
> vdso-install-y lists the files to install. For example, arch/x86/Makefile
> looks like this:
>
>   vdso-install-$(CONFIG_X86_64)           += arch/x86/entry/vdso/vdso64.so.dbg
>   vdso-install-$(CONFIG_X86_X32_ABI)      += arch/x86/entry/vdso/vdsox32.so.dbg
>   vdso-install-$(CONFIG_X86_32)           += arch/x86/entry/vdso/vdso32.so.dbg
>   vdso-install-$(CONFIG_IA32_EMULATION)   += arch/x86/entry/vdso/vdso32.so.dbg
>
> These files will be installed to $(MODLIB)/vdso/ with the .dbg suffix,
> if exists, stripped away.
>
> vdso-install-y can optionally take the second field after the colon
> separator. This is needed because some architectures install vdso
> files as a different base name.
>
> The following is a snippet from arch/arm64/Makefile.
>
>   vdso-install-$(CONFIG_COMPAT_VDSO)      += arch/arm64/kernel/vdso32/vdso.so.dbg:vdso32.so
>
> This will rename vdso.so.dbg to vdso32.so during installation. If such
> architectures change their implementation so that the file names match,
> this workaround will go away.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Acked-by: Sven Schnelle <svens@linux.ibm.com> # s390

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
