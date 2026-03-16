Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2102DFB5E8F
	for <linux-um@archiver.kernel.org>; Mon, 16 Mar 2026 23:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=; b=YXLLHgOjije4VGgNOaPFz3Uh9o
	0ZUpKi0jdT+GOjyAXw2+NAmJVdtzueItOKuexVRd68E2KVmoMBjJNVaeoT78M2JgXTpk+twi0Q73I
	jYfoVlya+6DSWaTQ4ki+ey92XxvBPlO/bxIcU3N2GqNjGy++6/bdAH7189oLMOo1GDViqUdr55CI5
	NS7ev6FiMVCR/sx0mBq9ohxJpR1OK7AE4JjBPDl9EVJfpsgMri96wlhbiLeTHoMpdgcZvwzIZL6px
	v2UzZEeQFnqxHgq9rsIMkjcV4AY2vYRqUVWfrVDuDHrEueAZ7SqNtDv5e3TwuWCIzvv0rCgBve/RF
	ub4/MOPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2HHO-0000000542P-1DPI;
	Mon, 16 Mar 2026 23:23:22 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2HHJ-0000000540L-4AYI
	for linux-um@lists.infradead.org;
	Mon, 16 Mar 2026 23:23:20 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2ab39b111b9so21638155ad.1
        for <linux-um@lists.infradead.org>; Mon, 16 Mar 2026 16:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773703396; cv=none;
        d=google.com; s=arc-20240605;
        b=VjJatTl0kRmrgfUnp/uu4oAAaIRIC93FfUPf86+XTEjFTxgK+7Q3zZKdStKD21Fk44
         bsig2b2ab6a/U+tptBNlbNmk/67t97MV39lipJUzHHqSCE1N2A7r7XHKV4XRagp0wcwN
         LbQ8hVag8wbviuE7kTOc4x36SmZyCHHlJtXv+8v+U0SmP66yieZZznKltS1ZhvJ9MAmG
         XckY8saz3Xguh5HqLuCpr4MOpLiMPUJvcLhm/aXydMVzsGvpEfx7EM+LjmDWtr/obXbq
         3Jflh2BXNzWc3/P4Lr2zSEPFMGctUGb3XhpN/6uVeQMO5tn773ayu2pa2Kg7HCa7NUr0
         O+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=;
        fh=STbNUwErWAtNh8LpeI125foq/kRI5wrGuLaArHZqXnU=;
        b=XjlphAguQJx8pEtP5kEpq5u1brwajjLq/3ixY8DmgOxp8FrkufzUaqaVZgbdjKxtwa
         pTO6b84N3kkqf78mQhgZ0VHyF5k4Ra0BADK9ArXoMuZIZWtgh93x0BuoGqMxUNHUOnsU
         /XYaMhX6BQvL4hM5vSlE+hm5bMevHJy7mRYf3QiuMXo3TIV3YiVvf2h8C865efUUgeL5
         WNXMIok4rhZV9aG1NYkB7snuqtwGznwFOKvMhQ6l5dh+mLlKa9lUFFxl20zOW4a5RbP0
         JKOO66Za0cRb2ZFKFWT/WiI7obRPDeArrEzYJ7n/AchApCxFb6oP38Js5Xi/xlXTx+wC
         APJA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773703396; x=1774308196; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=;
        b=XjCO0r7E4b+6b64RL+ov8nvAeWWvpCrzjBc+pYFpEgJmq7oIV5HPjrgeElogjsobgo
         P5rYuyFPfJSm4eikxwFMomWSNEklCWtRNSchzGkV989de5MVSdwVVfND6OF0TBHvstpt
         hAyvRjf7Badg6ufOX1uDYlNFt2Tkz9O7voW+HaQfGzIvsjrEgDWkIEIUeckoub6jF9lJ
         2TMYb+1yqUIaLxvGyXK/qhAa5vm9TSq25w/kerDR7tt+sJeVgLiMfaCMSS/w85FhidWU
         x0aFj28x5wU9f3E71ecppOWi9d6Wnxb1p73bPBC84pKJ2iv3VN1PcpBLGo6sz688B3eO
         hzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773703396; x=1774308196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=;
        b=LH0SCpKtJtPIc0LE7G/IPJEKFlto7PoeRX9IUr4ITghGCKbHqGR/fRE8BTQIExndR0
         HIXhllOkqz6xWLq8rayG//1kux2GfL1riiknCcPyyc3Zrm/I5eIze4NllTxvPHzkZ7sK
         A4JdOqAR71U8zkRI5YEhQPWqk6sFeaaqhnCrxmI5BWcOs4U88BTdrl389NmLX6pb67Xg
         plZN/b7Bb+pMpfcR8goqdEmktY9Hcg3M25NCUH8w0UvxkObwr4kPz1YJJDu1q/J8i6ek
         /A1jVyYrKy2RWxMDdoZkV55835YrHurCsZzTjvciT0M9IV1Rkt6usjRP954ZbfUjGhC+
         ruFA==
X-Forwarded-Encrypted: i=1; AJvYcCXh/9FGHVtFfy8WKZqeiweIPLmNGNOH+WEQsTyTmZykmKES1GMKsi5T6uCu9fay+6wu4tWU4UQVog==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzi5TgMWNFTlUB1BUyjSq/kgQx949KTMZv0U89ekfym6pblCENC
	/qCviMMyUSnTRbeNn2HScIgBDkuM9ZvRso3E9crZ/CF5rf3BwdNySldgEmZjYf8gnOAPDzbusCV
	L3tv1tzlfUsdP62L9cWoeFb1FPY8/eav6OrQdYlns
X-Gm-Gg: ATEYQzyapM+ul7w+7fy87WFEv3CI6UIREAEnGk+6wuJrV0GthBSvsx/sNCvRMpa7zPS
	hmjWNqc+AMTKsiIMs+9TBdoQdxdarEoPKNgszqvtcahtRp4GbkujqqWNjEzuTjARAuvnI7IIgZc
	lMUiVYojiF6MB8O/qT272YU31Q6Uouc2eLV+zTm2Q2pZMkt34AO6c6Nc6qXPQ6tNxQeqdjRwXf1
	fYE28XYcNJ/o8V4OlrtKqAo7iDzR0xKtkL+h3WFRRKm3Px8sU5ZElk7OQNVQKMbRCLKMz+wbLQ8
	zNy9WiWPyKBmY5r95Q==
X-Received: by 2002:a17:902:ea06:b0:2b0:5c3f:c0d8 with SMTP id
 d9443c01a7336-2b05c3fc4damr40223235ad.47.1773703396327; Mon, 16 Mar 2026
 16:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773665966.git.ljs@kernel.org> <063af0422d99bee0195589aa63f8f44edaf409fa.1773665966.git.ljs@kernel.org>
In-Reply-To: <063af0422d99bee0195589aa63f8f44edaf409fa.1773665966.git.ljs@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Mar 2026 19:23:04 -0400
X-Gm-Features: AaiRm50DdYFqfixz3H6HRwMmLfdf5osoLUZfr0b1blDqz3IzGNPvd_xOI_ajOas
Message-ID: <CAHC9VhR2T8ujtfvz-HgkgSFByptTLmhbCYS+scY53aYg=sgfqw@mail.gmail.com>
Subject: Re: [PATCH v2 17/23] mm: convert do_brk_flags() to use vma_flags_t
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_162318_466615_0F8CC4D4 
X-CRM114-Status: GOOD (  26.71  )
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

On Mon, Mar 16, 2026 at 9:09=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> In order to be able to do this, we need to change VM_DATA_DEFAULT_FLAGS a=
nd
> friends and update the architecture-specific definitions also.
>
> We then have to update some KSM logic to handle VMA flags, and introduce
> VMA_STACK_FLAGS to define the vma_flags_t equivalent of VM_STACK_FLAGS.
>
> We also introduce two helper functions for use during the time we are
> converting legacy flags to vma_flags_t values - vma_flags_to_legacy() and
> legacy_to_vma_flags().
>
> This enables us to iteratively make changes to break these changes up int=
o
> separate parts.
>
> We use these explicitly here to keep VM_STACK_FLAGS around for certain
> users which need to maintain the legacy vm_flags_t values for the time
> being.
>
> We are no longer able to rely on the simple VM_xxx being set to zero if t=
he
> feature is not enabled, so in the case of VM_DROPPABLE we introduce
> VMA_DROPPABLE as the vma_flags_t equivalent, which is set to
> EMPTY_VMA_FLAGS if the droppable flag is not available.
>
> While we're here, we make the description of do_brk_flags() into a kdoc
> comment, as it almost was already.
>
> We use vma_flags_to_legacy() to not need to update the vm_get_page_prot()
> logic as this time.
>
> Note that in create_init_stack_vma() we have to replace the BUILD_BUG_ON(=
)
> with a VM_WARN_ON_ONCE() as the tested values are no longer build time
> available.
>
> We also update mprotect_fixup() to use VMA flags where possible, though w=
e
> have to live with a little duplication between vm_flags_t and vma_flags_t
> values for the time being until further conversions are made.
>
> Finally, we update the VMA tests to reflect these changes.
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> ---
>  arch/arc/include/asm/page.h        |  2 +-
>  arch/arm/include/asm/page.h        |  2 +-
>  arch/arm64/include/asm/page.h      |  3 +-
>  arch/hexagon/include/asm/page.h    |  2 +-
>  arch/loongarch/include/asm/page.h  |  2 +-
>  arch/mips/include/asm/page.h       |  2 +-
>  arch/nios2/include/asm/page.h      |  2 +-
>  arch/powerpc/include/asm/page.h    |  4 +--
>  arch/powerpc/include/asm/page_32.h |  2 +-
>  arch/powerpc/include/asm/page_64.h | 12 ++++----
>  arch/riscv/include/asm/page.h      |  2 +-
>  arch/s390/include/asm/page.h       |  2 +-
>  arch/x86/include/asm/page_types.h  |  2 +-
>  arch/x86/um/asm/vm-flags.h         |  4 +--
>  include/linux/ksm.h                | 10 +++----
>  include/linux/mm.h                 | 47 ++++++++++++++++++------------
>  mm/internal.h                      |  3 ++
>  mm/ksm.c                           | 43 ++++++++++++++-------------
>  mm/mmap.c                          | 13 +++++----
>  mm/mprotect.c                      | 46 +++++++++++++++++------------
>  mm/mremap.c                        |  6 ++--
>  mm/vma.c                           | 34 +++++++++++----------
>  mm/vma.h                           | 14 +++++++--
>  mm/vma_exec.c                      |  5 ++--
>  security/selinux/hooks.c           |  4 ++-
>  tools/testing/vma/include/custom.h |  3 --
>  tools/testing/vma/include/dup.h    | 42 ++++++++++++++------------
>  tools/testing/vma/include/stubs.h  |  9 +++---
>  tools/testing/vma/tests/merge.c    |  3 +-
>  29 files changed, 186 insertions(+), 139 deletions(-)

Not that the SELinux changes are really all that significant, but they
look fine to me.

Acked-by: Paul Moore <paul@paul-moore.com> (SELinux)

--=20
paul-moore.com

