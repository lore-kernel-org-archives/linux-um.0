Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D991606A31B
	for <linux-um@archiver.kernel.org>; Fri, 23 Oct 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rTTGlMz6;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=LgdCaYZ4;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=bg3EdVPh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HSZuOyG4pKU7vS7IAE1/JM7GV7AMLK9kKAml8a9XFjg=; b=rTTGlMz65OYE96
	/X4yr/dokLPjJIHzh/XdN9lgIEXhU1zu/uVLa2aQuzjl4ViFoznu9bLoi1EVofQwYF1n5FU7Lne0q
	FpsnIdiqwASM6gzyZ++dko7F58VjKgWb87oZjcu4wXB2cT04K5WVmyeVtRbPzYcKF6LYuKBTI7xCE
	9JyB5w0BsyvlKjQxhrXwUKlzQWZL5mCwvkiKPrD6+sPCSHgpfknP3QXLAOEYlmQFR2rNkDbVSO55R
	+BIVoRNC+4RSTSweVMpWoaTzucTnToh9kyuzdnOhkurDvTfuy3TyD9ZdCFMdZd1W3FYwdjqYNvDk/
	nJ51ZAZ8govBuotBSqcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKHK0-0000000GbzY-1kYH;
	Fri, 23 Oct 2026 15:36:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKHJy-0000000GbzB-0mww;
	Fri, 23 Oct 2026 15:36:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=HSZuOyG4pKU7vS7IAE1/JM7GV7AMLK9kKAml8a9XFjg=; b=LgdCaYZ4XeA497jUGfg+O9xl10
	eMQVSbplazV/Gaze7FF0nljn/betoYKFqhwTOrN+ba1Mne1j02brNm+GesUNZbW9yKzL70MKnEPYJ
	dV1sqvLUeDOYnLnBShXZsjBh3W56bhV7oxD6jxUnv42vHLDrkzxhx+1alGonp31g0qGxWZQhk2hpI
	+fPTDS9ysQSfhq1BfQvOH/nJNdkhXFkL4zfEiMAvBH4MC71JzPhGZ88TThZ/GPgP9OroyuFDqJGq4
	568VBBETHlQbRr2JNlDH3PvkN/oFOar/dJ+CJch50nVFgyg8TNvH8WEYO38/RQdcfupSi6LPLaHwV
	7L6cZJjA==;
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKHJv-00000009xyK-0imG;
	Fri, 23 Oct 2026 15:36:41 +0000
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69NFZXZ03099269
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 23 Oct 2026 08:35:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69NFZXZ03099269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1792769740;
	bh=HSZuOyG4pKU7vS7IAE1/JM7GV7AMLK9kKAml8a9XFjg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bg3EdVPhWbIzGb2nl9Fuu7ddKA32ap1IfMZqOW5ffhrypmSKfeUyH9oyqT8VD3Ffz
	 xZsox0txpA5nJa7ukTQnYEsijMIDw9G5ZjUIZiWIb+27Pyu0RsP3R+zGiaKYe7BVy+
	 iRxHHbQf4iwE7FhJHOTs1QJ5w9pUe7E5sHjmWhEmmReaob00Q9qPt+SYyK9PjSybeL
	 +p7u2wZEoGsZue51CvFVoyMDBkPLzVTCMehBpRAesG0upThtigcmczDR9dlEcb9c41
	 ORCX4s+3pvA5/OOHfkjvkVcTf9EC4bUg2TYV5h1Rs0daKiD/q8yN03OHv7o44uTkJq
	 IP7H4102peo1g==
Date: Fri, 23 Oct 2026 08:35:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Thomas Gleixner <tglx@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
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
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
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
        =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bpatch_16/18=5D_x86/entry=3A_Get_rid?=
 =?US-ASCII?Q?_of_the_sys=5Fni=5Fsyscall=28=29_indirection?=
User-Agent: K-9 Mail for Android
In-Reply-To: <871p9g1s3w.ffs@fw13>
References: <20260707181957.433213175@kernel.org> <20260707190254.493733289@kernel.org> <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13> <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com> <871p9g1s3w.ffs@fw13>
Message-ID: <F44B99C1-297F-406C-AEAC-3CC8F4F36AED@zytor.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_163639_548463_D9287EC0 
X-CRM114-Status: GOOD (  13.05  )
X-Spam-Score: -0.2 (/)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On October 23, 2026 6:09:07 AM PDT, Thomas Gleixner <tglx@kernel=2Eorg> wro=
te:
>On Thu, Oct 22 2026 at 17:22, H=2E Peter Anvin wrote:
>> On October 22, 2026 2:34:08 PM PDT, Thomas Gleixner <tglx@kernel=2Eorg>=
 wrote:
>>>-static __always_inline void do_syscall_x32(struct pt_regs *regs, unsig=
ned long nr)
>>>+static __always_inline bool do_syscall_x32(struct pt_regs *regs, unsig=
ned long nr)
>>> {
>>>+	if (!IS_ENABLED(CONFIG_X86_X32_ABI))
>>>+		return false;
>>>+
>>>+	/* Preserve the historic insanity of treating -1 special on x32 */
>>>+	if (nr =3D=3D ULONG_MAX)
>>>+		return true;
>>
>> It was never limited to x32=2E=2E=2E
>
>Tired brain misread the test output:
>
>[RUN]   Running tests under ptrace: modifying the default return
>[RUN]       Checking system calls with msb =3D 0 (0x0)
>[OK]                x32 syscalls 0:-64=2E=2E-2 returned -ENOSYS as expect=
ed
>[OK]                x32 syscall 0:-1 returned MODIFIED_BY_PTRACE as expec=
ted
>[OK]                x64 syscalls 0:-64=2E=2E-1 returned -ENOSYS as expect=
ed
>
>But that's because the "-1" on x32 is actually 0xFFFFFFFF while on x64
>it's 0x7FFFFFFF=2E
>
>The whole mess comes from using -1 as indicator for syscall abort which
>is undistinguishable from a syscall(nr=3D-1)=2E
>
>Bah=2E Let me restore this nonsense=2E
>
>Thanks,
>
>        tglx
>
>
>

Yeah, that was always a WTF=2E

