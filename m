Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF33E77183
	for <linux-um@archiver.kernel.org>; Fri, 13 Dec 2024 21:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p3XO30CvJa2rLmnkvFL2XnDeax061g/QdjIwndsFiKE=; b=0L9aEdgREilmJj
	IaKRpITn3uCeXzRlow61l7VB1jib/YxsaUob8RNI/oSeQcP2/er5BwvFKmDKtynFRp5O4Hr3DFjfM
	safMy7s2NZtYIVCD53+oDnf6T7+PH+CsjL+S67bnZs9CM9Z9UtH2Jeb85IUbRojjEcrsbd79MiWX5
	aMB6dpc47GxlOC2MvmBwxNSB97AijEp5vAGI+kBcljDq/kmYGP9uC3pmsPczuMeQdgaoaNWJVJn3D
	b0L5cCPxjXTIqx+mZqT3fniEWp4QsBBGpq3lU2JOzboSEPYE+KhPPsQ2avCLPboXkut1z7z5os6aD
	5pqjCNAUCQpwLyU8uLOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMDbh-0000000572x-38VP;
	Fri, 13 Dec 2024 21:53:57 +0000
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMDbf-0000000571q-0Dqf
	for linux-um@lists.infradead.org;
	Fri, 13 Dec 2024 21:53:56 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:56506)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tMDbc-009pZC-L3; Fri, 13 Dec 2024 14:53:52 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:40456 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tMDbb-00AZd8-G0; Fri, 13 Dec 2024 14:53:52 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org,  ricarkol@google.com,
  Liam.Howlett@oracle.com,  kees@kernel.org,  viro@zeniv.linux.org.uk,
  brauner@kernel.org,  jack@suse.cz,  linux-mm@kvack.org,
  linux-fsdevel@vger.kernel.org
References: <cover.1733998168.git.thehajime@gmail.com>
	<d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
	<87r06d0ymg.fsf@email.froward.int.ebiederm.org>
	<m2r06c59t9.wl-thehajime@gmail.com>
	<87bjxf1he1.fsf@email.froward.int.ebiederm.org>
	<m2pllv5lb3.wl-thehajime@gmail.com>
Date: Fri, 13 Dec 2024 15:53:44 -0600
In-Reply-To: <m2pllv5lb3.wl-thehajime@gmail.com> (Hajime Tazaki's message of
	"Sat, 14 Dec 2024 06:23:44 +0900")
Message-ID: <87r06bz1uf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1tMDbb-00AZd8-G0;;;mid=<87r06bz1uf.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19KAHdFFUi5cVQHGBC8QctGuBcxACTIOzs=
Subject: Re: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, kees@kernel.org, Liam.Howlett@oracle.com, ricarkol@google.com, linux-um@lists.infradead.org, thehajime@gmail.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_135355_120468_8A9D3F1D 
X-CRM114-Status: GOOD (  33.67  )
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

Hajime Tazaki <thehajime@gmail.com> writes:

> On Sat, 14 Dec 2024 05:01:58 +0900,
> Eric W. Biederman wrote:
>
>> >> Last time I looked the regular binfmt_elf works just fine
>> >> without an mmu.  I looked again and at a quick skim the
>> >> regular elf loader still looks like it will work without
>> >> an MMU.
>> >
>> > I'm wondering how you looked at it and how you see that it works
>> > without MMU.
>>=20
>> I got as far as seeing that vm_mmap should work.  As all of the
>> bits for mmap to work, are present in both mmu and nommu.
>
> hmm, at least MAP_FIXED doesn't work in current mm/nommu.c.
> # also documented at Documentation/admin-guide/mm/nommu-mmap.rst.

Yes, and that fundamentally makes sense.

>> > I also wish to use the regular binfmt_elf, but it doesn't allow me to
>> > compile with !CONFIG_MMU right now.
>>=20
>> Then I may simply be confused.  Where does the compile fail?
>> Is it somewhere in Kconfig?
>>=20
>> I could be completely confused.  It has happened before.
>
> If I applied to below in addition to my whole patchset,
>
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 419ba0282806..b34d0578a22f 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -4,7 +4,6 @@ menu "Executable file formats"
>=20=20
>  config BINFMT_ELF
>         bool "Kernel support for ELF binaries"
> -       depends on MMU
>         select ELFCORE
>         default y
>         help
> @@ -58,7 +57,7 @@ config ARCH_USE_GNU_PROPERTY
>  config BINFMT_ELF_FDPIC
>         bool "Kernel support for FDPIC ELF binaries"
>         default y if !BINFMT_ELF
> -       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && =
!MMU)
> +       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
>         select ELFCORE
>         help
>           ELF FDPIC binaries are based on ELF, but allow the individual l=
oad

You have my apologies I was most definitely confused.  BINFMT_ELF
currently does not work without an MMU.

> this is the output from `make ARCH=3Dum`.
>
>   GEN     Makefile
>   CALL    ../scripts/checksyscalls.sh
>   CC      fs/binfmt_elf.o
> In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
>                  from ../include/linux/compiler.h:317,
>                  from ../include/linux/build_bug.h:5,
>                  from ../include/linux/container_of.h:5,
>                  from ../include/linux/list.h:5,
>                  from ../include/linux/module.h:12,
>                  from ../fs/binfmt_elf.c:13:
> ../fs/binfmt_elf.c: In function =E2=80=98load_elf_binary=E2=80=99:
> ../include/asm-generic/rwonce.h:44:71: error: lvalue required as unary =
=E2=80=98&=E2=80=99 operand
>    44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(=
x) *)&(x))
>       |                                                                  =
     ^
> ../include/asm-generic/rwonce.h:50:9: note: in expansion of macro =E2=80=
=98__READ_ONCE=E2=80=99
>    50 |         __READ_ONCE(x);                                          =
       \
>       |         ^~~~~~~~~~~
> ../fs/binfmt_elf.c:1006:49: note: in expansion of macro =E2=80=98READ_ONC=
E=E2=80=99
>  1006 |         const int snapshot_randomize_va_space =3D READ_ONCE(rando=
mize_va_space);
>       |=20=20=20
>
> I avoided this issue (with nasty MAP_FIXED workaround) but there seems
> to be still a lot of things that I need to fix to work with nommu.

Yes, at a minimum all of the MAP_FIXED code would need to be
conditionalized on having an MMU.
>
>> I just react a little strongly to the assertion that elf_fdpic is
>> the only path when I don't see why that should be.
>>=20
>> Especially for an architecture like user-mode-linux where I would expect
>> it to run the existing binaries for a port.
>
> I understand your concern, and will try to work on improving this
> situation a bit.
>
> Another naive question: are there any past attempts to do the similar
> thing (binfmt_elf without MMU) ?

At this point what I would recommend is:

Merge your original patch.  Get nommu UML working with binfmt_elf_fdpic.c.
I think it is a proper superset of ELF functionality.

Then I would make it a long term goal to see about removing redundancy
between binfmt_elf.c and binfmt_elf_fdpic.c with a view to merging them
in the long term.

There is a lot of mostly duplicate code between the two and
binfmt_elf_fdpic.c does not get half the attention and use binfmt_elf.c
gets.

Eric


