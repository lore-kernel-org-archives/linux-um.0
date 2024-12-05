Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432F7E7716D
	for <linux-um@archiver.kernel.org>; Thu,  5 Dec 2024 13:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pMyeiAFcJGCCOZr5gMgISpRON6bLYaLcuwpiI0MwS78=; b=37ZM96/x8jZ+yUZui6exKbAIn8
	gbTOcr7Hzyk79tXntzUBl4z8sO4E5Q3Q5Dp1ojsmJodfnGaMCuzlFS7Dtc1bmwfN5OaqERUwegxcJ
	pAsqzJnSwBuLofZZxgWcHjTgK0Akmqpm33EkqGSt7Wzzj8f2LmM6qlZr1Tw1etRA8e1WxZ6hyQplA
	ANmBTBqFXEltpqLHJhm9xOVqlaN71zt1g4QPrbamksCymm5Wo4lMvDACQMZtHoE18qSMGnFhiDOHg
	zDjG2+asAyO19McydjJCdvLjmcnp2psAAc1OdX40kDXQTVOVjJMDuEDEI3Ynv47caIXRxZmrjF+7C
	1Rhw/e3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCCo-0000000GDih-33P2;
	Thu, 05 Dec 2024 13:47:46 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCBW-0000000GDMm-0C6r
	for linux-um@lists.infradead.org;
	Thu, 05 Dec 2024 13:46:27 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-21561af95c3so7237415ad.3
        for <linux-um@lists.infradead.org>; Thu, 05 Dec 2024 05:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733406385; x=1734011185; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMyeiAFcJGCCOZr5gMgISpRON6bLYaLcuwpiI0MwS78=;
        b=XVg/gIS1NRdvHzy3QKJfAx5Cd8owsn+xE1RZssj6tpcAc/hLlFe4VXuKp8EuSM1lQ7
         yfsZgxxofwh0jjNIRxA2pZqyS6zd8iIqQ1EgUGgrvEKInYW5ptcPrPGOhJxQs5nPA+i7
         kDAyY5WkZRVZ0rWRs5QYiUy9JNgMv4WjHk5UXALsKoFn9t8gRWFEIdVhhA9ILdfGEKOB
         r/lzDAxUIvhgJfSQOGWjYqep5i1vi1Byn4jZbx/f+C+x8YcnFifrwtVZkpky1fkw4iLc
         FQTUlM1cmNPmeq1H0Z4Y81fXecjFLf99DVntLUZjwPda4UO+kD/SSCWzXPSqBECBV2OS
         uDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733406385; x=1734011185;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMyeiAFcJGCCOZr5gMgISpRON6bLYaLcuwpiI0MwS78=;
        b=EkQUjHA7VZuSQoCmLIAHMRvbBU+xo5QRTtdOoUF6r6YmXosaebKvzkK+rN+zJG9nMa
         T4ndwdr7D0cK/ThUAiiU56MCtKLLX/41YZRApjeHuhPc4mX3QnXcZED/56JFj4wXd7nK
         f2i7tVlOyHh6QRprqS+29ihKd700fh2KF5Aa5JBdxTyrJDp1vp0DBSKj62JMURBhNoqL
         rYk1ztXBPnNokn5iZAckkKNXw5M8P6C3U7Ymbh9mhPWHbRk+grwJVFHtdNrdDjaarez0
         y+kRCi5dh7WygqDLO/LFBhTGIVK9ZPIijrLGrqFEPgqVAGGic3asK0FueytVhGgZ9e9g
         hHHw==
X-Gm-Message-State: AOJu0Yz/XSaDoNah2lq2XlXm4OqLtxidR0agsVwheRvkLHQofRb4X8Wh
	zzFd5xLJTruIEngE5+LAwI5mPB801l9wrSFx/EEj5z2gWTZMJKf7
X-Gm-Gg: ASbGncs4fwM8DKan/kE4YxSyR5SAk2Np3U52kWc+NsyOivbl/Pm0YAdGGoa5Z7byjPw
	rv0ZAZPGcGe/HPTvpFMk9MrYfRy1hz1gPpnzPmraNGVoluKZ73HzWTwyq0B+9vymirjlWH9nBbz
	VxmfrF+kqjTLhMGgyBbxpAzGILLTKzUh0U+QcC+XtLSdNT9jhvGDuOrkbBeqnTlUhynOnTQJ+tX
	0u3fy0sNlzJWdXIlFvoQa5wCaZa2lyDHGrtIoCp87D8MZpSPeJvX5R43yVzrJI9bxrlquya63CF
	lwfMkhla1H4w098dAg2CW5nGb06ZuFf1S2Mh
X-Google-Smtp-Source: AGHT+IGXEXdso4I85bNASzZ4xdBoE69kh23CNxF1ZXiX7VL9PxeDGrf/Wif3eI0yi1LyOZ13ReYvEw==
X-Received: by 2002:a17:902:ce92:b0:215:6093:e384 with SMTP id d9443c01a7336-215bd141fdbmr149898175ad.49.1733406385030;
        Thu, 05 Dec 2024 05:46:25 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a904casm1271067b3a.129.2024.12.05.05.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:46:23 -0800 (PST)
Date: Thu, 05 Dec 2024 22:46:20 +0900
Message-ID: <m27c8ew8cz.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH v3 03/13] um: nommu: memory handling
In-Reply-To: <d6c80b918b3febd0eb572b4a945dfc200f6890ee.camel@sipsolutions.net>
References: <cover.1733199769.git.thehajime@gmail.com>
	<1400de8bca3dc72df563156fcbc6eaaf54e2e58a.1733199769.git.thehajime@gmail.com>
	<d6c80b918b3febd0eb572b4a945dfc200f6890ee.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_054626_082201_86AF6BD8 
X-CRM114-Status: GOOD (  31.50  )
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


On Thu, 05 Dec 2024 01:34:49 +0900,
Johannes Berg wrote:
> 
> On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
> > 
> > +++ b/arch/um/include/asm/futex.h
> > @@ -8,7 +8,11 @@
> >  
> >  
> >  int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr);
> > +#ifdef CONFIG_MMU
> >  int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> >  			      u32 oldval, u32 newval);
> > +#else
> > +#include <asm-generic/futex.h>
> > +#endif
> 
> That seems somewhat problematic since it also defines
> arch_futex_atomic_op_inuser ...

indeed, will fix it.

> > +++ b/arch/um/include/shared/os.h
> > @@ -195,7 +195,13 @@ extern void get_host_cpu_features(
> >  extern int create_mem_file(unsigned long long len);
> >  
> >  /* tlb.c */
> > +#ifdef CONFIG_MMU
> >  extern void report_enomem(void);
> > +#else
> > +static inline void report_enomem(void)
> > +{
> > +}
> > +#endif
> 
> That still seems simply wrong? Why is that even called, and why should
> it do *nothing*?
> 
> I'm thinking you might just have patch sequence issues here - I can't
> really see why this would be called at all, eventually.

report_enomem was used in trap.c, which both MMU and !MMU use.  Now I
decouple the file to contain !mmu specific code so, the above chunk
can be reverted.

> > @@ -78,6 +79,7 @@ void __init mem_init(void)
> >   * Create a page table and place a pointer to it in a middle page
> >   * directory entry.
> >   */
> > +#ifdef CONFIG_MMU
> >  static void __init one_page_table_init(pmd_t *pmd)
> >  {
> >  	if (pmd_none(*pmd)) {
> > @@ -149,6 +151,12 @@ static void __init fixrange_init(unsigned long start, unsigned long end,
> >  		j = 0;
> >  	}
> >  }
> > +#else
> > +static void __init fixrange_init(unsigned long start, unsigned long end,
> > +				 pgd_t *pgd_base)
> > +{
> > +}
> > +#endif
> 
> Really not a fan of all these randomly placed ifdefs ...

I decided to introduce nommu directory to avoid those ifdefs.

> > +#ifdef CONFIG_MMU
> >  static const pgprot_t protection_map[16] = {
> >  	[VM_NONE]					= PAGE_NONE,
> >  	[VM_READ]					= PAGE_READONLY,
> > @@ -249,3 +258,4 @@ static const pgprot_t protection_map[16] = {
> >  	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED
> >  };
> >  DECLARE_VM_GET_PAGE_PROT
> > +#endif
> 
> Same here.
> 
> I think we can do better - perhaps move some code to mmu.c and nommu.c
> or something like that.

will fix it.

> > diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
> > index a74f17b033c4..f55d46dbe173 100644
> > --- a/arch/um/kernel/physmem.c
> > +++ b/arch/um/kernel/physmem.c
> > @@ -84,7 +84,11 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
> >  		exit(1);
> >  	}
> >  
> > +#ifdef CONFIG_MMU
> >  	physmem_fd = create_mem_file(len);
> > +#else
> > +	physmem_fd = -1;
> > +#endif
> 
> same here, create_mem_file() can just be in a file only built for mmu,
> and otherwise be an inline that returns -1?

ditto.

> > +#ifdef CONFIG_MMU
> >  	/*
> >  	 * Special kludge - This page will be mapped in to userspace processes
> >  	 * from physmem_fd, so it needs to be written out there.
> >  	 */
> >  	os_seek_file(physmem_fd, __pa(__syscall_stub_start));
> >  	os_write_file(physmem_fd, __syscall_stub_start, PAGE_SIZE);
> > +#endif
> 
> That doesn't even do anything if the fd is -1, do we need the ifdef? ;-)
> 
> Still better as "if (IS_ENABLED())" or something anyway though.

I'll revert this part.

> > +++ b/arch/um/kernel/trap.c
> > @@ -24,6 +24,7 @@
> >  int handle_page_fault(unsigned long address, unsigned long ip,
> >  		      int is_write, int is_user, int *code_out)
> >  {
> > +#ifdef CONFIG_MMU
> >  	struct mm_struct *mm = current->mm;
> >  	struct vm_area_struct *vma;
> >  	pmd_t *pmd;
> > @@ -129,6 +130,9 @@ int handle_page_fault(unsigned long address, unsigned long ip,
> >  		goto out_nosemaphore;
> >  	pagefault_out_of_memory();
> >  	return 0;
> > +#else
> > +	return -EFAULT;
> > +#endif
> >  }
> 
> same comments here ... try not to sprinkle ifdefs everywhere.

will revert it.

-- Hajime

