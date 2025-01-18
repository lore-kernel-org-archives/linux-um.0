Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D47C02188
	for <linux-um@archiver.kernel.org>; Sat, 18 Jan 2025 04:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w1vtBdwCDfUdjXlAPq/H8CEoUqmusT1ScqFMMfS7dZ8=; b=Xbu8gUcl2+jJbK5T6XDNgZsblw
	iTPFRGW/H9jcr6bwNloe2/I4i0yo8C/Eknh3PPqP85dELy9Mq1QEeJI5+6WquDdEhl6pTSBme+BlY
	0QIeECRdt+oToTZH8H0B3OEdvVnkXKn1o8PAxA2MTc+U0cMkUTTg2RWwa1MFmvnEgHO2jdqdpzjL2
	BdvgainYag/eDJCEsczvPJXUac0zB23i658TOKW+A3r07Npx8Gw2xwZ0nOeLHB2xCL0ySQDvYJH12
	GTVf3ibOwYDIFQ3LeMaYSkdxVh04KxK3NEG8R/63kXAOuR8LkXjpbLi8n35KqaLVDbYqyKz6Duns8
	kK+5qT0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZ0bS-00000001qf9-3mn5;
	Sat, 18 Jan 2025 04:38:34 +0000
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZ0bQ-00000001qea-2gih;
	Sat, 18 Jan 2025 04:38:33 +0000
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50I4YkBo262261
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 17 Jan 2025 20:34:46 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50I4YkBo262261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1737174897;
	bh=w1vtBdwCDfUdjXlAPq/H8CEoUqmusT1ScqFMMfS7dZ8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hdj5mGq9LhBqQz1DGkEXyOAPg5UumXs4rYaXrAxe/XdXtsj44W9H6+brjFlKruZEu
	 KZw5piA42OHN/XcSeaUskoitHUnJNqT+XsxtkAneGSnIvuXW+n6ZC7eW8FnCimYSsG
	 Lq1HAj2fYTDCYOqRHD+qLXvSb6ZxhtiXDCdoJyIe1GRxYKC8axRGOudEZFGw1AbPA8
	 XfSMDwvu4q4o4HAn0vaClp5lq+a2D6iGDyVD9URdyKl9xLKY6kTXhchRX+IiLJk6MT
	 lQqfZZED15R6MYW2CL2TKc8zQ0Rfpn6iPT2QNmGS8gBb8X3N0roFy9uw8TLOeP93LY
	 mjPwqKCNYdQPg==
Date: Fri, 17 Jan 2025 20:34:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Eugene Syromyatnikov <evgsyr@gmail.com>
CC: Charlie Jenkins <charlie@rivosinc.com>, "Dmitry V. Levin" <ldv@strace.io>,
        Oleg Nesterov <oleg@redhat.com>, Mike Frysinger <vapier@gentoo.org>,
        Renzo Davoli <renzo@cs.unibo.it>,
        Davide Berardi <berardi.dav@gmail.com>, strace-devel@lists.strace.io,
        Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.osdn.me>, Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/7=5D_syscall=2Eh=3A_add_syscall=5Fse?=
 =?US-ASCII?Q?t=5Farguments=28=29_and_syscall=5Fset=5Freturn=5Fvalue=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CACGkJdtAmtxsPiKYUzLLmfNGf6oJ9YS-25ZY9VvEEWhz37Qx6Q@mail.gmail.com>
References: <20250113170925.GA392@strace.io> <20250113171140.GC589@strace.io> <Z4hs0X8RhGTuevnn@ghost> <eecada37-9d0e-4e3c-9b70-fefb990835b2@zytor.com> <CACGkJdtAmtxsPiKYUzLLmfNGf6oJ9YS-25ZY9VvEEWhz37Qx6Q@mail.gmail.com>
Message-ID: <B5D44A2A-BF4F-4EEA-992D-0A06F2AE08CA@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_203832_679484_260D1AB0 
X-CRM114-Status: GOOD (  14.45  )
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

On January 17, 2025 7:45:02 AM PST, Eugene Syromyatnikov <evgsyr@gmail=2Eco=
m> wrote:
>On Fri, Jan 17, 2025 at 2:03=E2=80=AFAM H=2E Peter Anvin <hpa@zytor=2Ecom=
> wrote:
>>
>> I link the concept of this patchset, but *please* make it clear in the
>> comments that this does not solve the issue of 64-bit kernel arguments
>> on 32-bit systems being ABI specific=2E
>
>Sorry, but I don't see how this is relevant; each architecture has its
>own ABI with its own set of peculiarities, and there's a lot of
>(completely unrelated) work needed in order to make an ABI that is
>architecture-agnostic=2E  All this patch set does is provides a
>consistent way to manipulate scno and args across architectures;  it
>doesn't address the fact that some architectures have mmap2/mmap_pgoff
>syscall, or that some have fadvise64_64 in addition to fadvise64, or
>the existence of clone2, or socketcall, or ipc; or that some
>architectures don't have open or stat;  or that scnos on different
>architectures or even different bit-widths within the "same"
>architecture are different=2E
>
>> This isn't unique to this patch in any way; the only way to handle it i=
s
>> by keeping track of each ABI=2E
>
>That's true, but this patch doesn't even try to address that=2E
>

I just want it noted in the comment, that's all=2E

