Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D38FC5B572
	for <linux-um@archiver.kernel.org>; Fri, 14 Aug 2026 22:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n2EAblvWDRelmfnXh27a45O70JHPB4giXZ+AN2NzhtQ=; b=MenD2ihLuDKmcqHM7xsIEB6kiR
	wE4p7xJe8KmG0NuG1c1LAUeTbQeLxjstpzoeFF/8eBjhTJUyltMhTbZzx8Qz33tOwFFNzIAyQEsxA
	oPXdnvsnVW/GrrMTkpxZLQOxlS3cF8tBRjw2lqGm7OWD8cQmDfDRK2DBKMHDMe4rVik4WQ25LWaAx
	IZxkGLq4DJ4J2QwH3YaU3u+vwvLqDb8wW1RsRypPkaz5LuacyJx66pjqCqyVqav8U/KYj9NqGKFfa
	5wtMCnppXfoCkXbggYC23kklVGZBTxs1wkx/nRDYalkx18swLXMHgA7MbSCrKIlLu1wU/JU1t+ULW
	dIVXaF7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv0Uy-00000003H0r-0R3R;
	Fri, 14 Aug 2026 22:35:36 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv0Ut-00000003H08-3rTu
	for linux-um@lists.infradead.org;
	Fri, 14 Aug 2026 22:35:35 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so1131983a91.1
        for <linux-um@lists.infradead.org>; Fri, 14 Aug 2026 15:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786746931; x=1787351731; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n2EAblvWDRelmfnXh27a45O70JHPB4giXZ+AN2NzhtQ=;
        b=k+ZMmgDKaMdFDLJuJgWxaR8suZVM+hjzcmiypkzoTL6IC+jEBu5mrTvkNkjoVh8nMg
         TFKv5S2fvnKxeIAwZjW80jl2P2MQCt54ADc6FB4yjomkjJ3Mbt+npt1i26RgUfBbBnxR
         I9pJDWWOkZj84F2KpTmSc3GC+qH8z95uKZxMhR/l0qVW+2D6Lu9gsTdOcy3zknXL7lM5
         rRqMbHc/MbJkfymiLFxu4mLQVPA6CeNWVZhPn9dHgyD3DdBoOOnX4hVEUkzL6v7AN0oh
         COZq2PF1XdfFabS0eZ2bDxPItAPgwKEfL7ZZwt0cVYdKQ/EZAY8envImjXD02ZhfQTGH
         DWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786746931; x=1787351731;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n2EAblvWDRelmfnXh27a45O70JHPB4giXZ+AN2NzhtQ=;
        b=murs50dAix6fkYhVEsZcKh84b4R8hUjoJ1wNkMm2AwBdSLN4Tsu1ADjxrlFmV0a/jL
         buM5DeCi4aHhCZv6rJGtwlhkfH3Sr+KTMc7s8SD60EdjCqWHoPsmT3dAUeDjQCpd/ypq
         gccJU2AtC0o6lVd8OEZtyCvmXV8MVkh4NafLgGCJr/OpXJ3o3RXZYvZmYrC+FejS1UQE
         3pgtjwiHP5MUXY5L9J7AKr+VDo95oUsbZk8ZY45slGt2vvlGIAKY30QkCdhuqrdd+p5J
         P4OjIWeT1JyPdbL/6d0sdk4RNxEm4TNmbH/FP93RfqIyNVvkoBryK1RF8mGq2lnrFOBA
         W/Hw==
X-Forwarded-Encrypted: i=1; AHgh+RqlsEI6JKh+gqusapRf+ANFgSVPDcKPbgrL3jADKyG6GPNjiaQnEW/KJC61K6LCbfkLfvXgzGI6Fg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCIY+WWMBTWitUFomxvcElO+pfoBinkXUVDkbR6NbuCVEglIye
	ExzGdUgvbmfgWsvgKArA8FS3xOS0tCQBFYD9rk2uQ9wKofYP72TD8Ji2
X-Gm-Gg: AR+sD12IsW4wpsJMCYeBzK5QiRMs/yLSrOAh9chT3CcasNgJ8Drxwza7KjxZXaXVBEY
	eag3UDOmf5zggLZPd6zcJUo1ar3r2ROIRUJay8mwqfoOfVhnO53hupUc9LHLAp/e67QsVOj9Il4
	sMCQ7HUOAn/GzkUw1NaejmVjgBBljOb0lCm1HnrSdHTo7x3oo+aHkkrSjrnWmtPwEqgasPTbfF6
	7snkwgjZIe+gOOToSWATIESCixQqjXbxxMdVqqkOxQ3qDUDMVW6nH6dZbKlXsD/iTgiMxRRYZQz
	Zw6iOiclWd48QVScK8KLZhM4C/VA8W+AaPPnZ1DASnC93CRkVReoik5TPKDrA2ZokatKfaDB4dd
	JlB6FDuzbn9Jhg+ItyO6c4TmSG6F6qpsd362XUzmH3JBWnhRbAM9xmq3yD/s0VBDV32+NC8lul2
	Up+t1aspfoyB1TFkxUY4jRwX+k+DOIk+Vv3GswksvWYHqjqQpyhQwLq/rL6klXLaaEYEDw8wlY9
	xj1bK/9815yI2tXczD+naFb1fIHYujautA4OK2rYDV9pZjGn34KzdRg+lzL/tAmzYlm4hEquLsS
	Rupljg==
X-Received: by 2002:a17:90b:3c91:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-3933b78e3c2mr11247940a91.7.1786746930611;
        Fri, 14 Aug 2026 15:35:30 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b699e47sm2074781a91.4.2026.08.14.15.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:35:29 -0700 (PDT)
Date: Sat, 15 Aug 2026 07:35:26 +0900
Message-ID: <m2wltspbyp.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: ljs@kernel.org
Cc: linux-mm@kvack.org,
	geert@linux-m68k.org,
	daniel@thingy.jp,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [RFC PATCH 6/6] selftests/mm: add nommu mmap and mremap behavior tests
In-Reply-To: <an8SvW3jv3JuAFc8@lucifer>
References: <20260813063401.1786548-1-thehajime@gmail.com>
	<20260813063401.1786548-7-thehajime@gmail.com>
	<an8SvW3jv3JuAFc8@lucifer>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_153533_726128_06E7F078 
X-CRM114-Status: GOOD (  26.80  )
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


On Fri, 14 Aug 2026 22:28:53 +0900,
Lorenzo Stoakes (ARM) wrote:
> 
> On Thu, Aug 13, 2026 at 03:34:01PM +0900, Hajime Tazaki wrote:
> > Introduce a kselftest utility to validate memory mapping capabilities
> > under nommu kernels, aligned with
> > Documentation/admin-guide/mm/nommu-mmap.rst.
> >
> > The test implements basic checks into a generic architecture-agnostic
> > test matrix applicable across nommu targets. It evaluates:
> >
> > 1. MAP_FIXED allocation rejections.
> > 2. Standard MAP_PRIVATE and MAP_ANONYMOUS allocation resilience.
> > 3. MAP_UNINITIALIZED allocations via optional kernel configurations.
> > 4. Regular file mappings via standard filesystem storage.
> > 5. Memory-backed file mapping with /dev/zero
> > 6. Block device subsystem mappings (gracefully skipping if node is
> >    missing).
> > 7. Shared vs Private backing discrepancies under nommu conditions.
> > 8. mremap limits, ensuring non-expandable restrictions behave properly.
> 
> Thanks for adding these.
> 
> It's horrible to not have the kselftest harness for these, but as established,
> fork() doesn't work for nommu (!)
> 
> A lot of these tests seem to relate to functionality I'm not really happy with
> in the rest of the series so let's see how things pan out with the series
> overall I guess!

(snip)

> > diff --git a/tools/testing/selftests/mm/nommu_mremap_test.c b/tools/testing/selftests/mm/nommu_mremap_test.c
> > new file mode 100644
> > index 000000000000..b1b8a4e64b55
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/nommu_mremap_test.c
> > @@ -0,0 +1,583 @@
(snip)
> > +
> > +static int get_shared_writable_file_expected_error(const char *path)
> > +{
> > +	if (get_fs_type(path) == RAMFS_MAGIC)
> > +		return EPERM; /* ramfs failed */
> > +
> > +	return 0;
> > +}
> > +
> > +static int pre_conf_trim_page(void)
> > +{
> > +	return set_nr_trim_pages("0\n");
> > +}
> > +
> > +static int post_conf_trim_page(int value)
> > +{
> > +	char buf[32];
> > +
> > +	if (snprintf(buf, sizeof(buf), "%d\n", value) < 0)
> > +		return -EIO;
> > +
> > +	return set_nr_trim_pages(buf);
> > +}
> > +
> > +struct mremap_case_t {
> > +	const char *name;
> > +	const char *pathname;
> > +	int open_flags;
> > +	int mmap_prot;
> > +	int mmap_flags;
> > +	int exp_err;
> > +	int (*resolve_exp_err)(const char *path);
> > +	unsigned int old_pages;
> > +	unsigned int new_pages;
> > +	int (*pre_hook)(void);
> > +	int (*post_hook)(int value);
> > +};
> > +
> > +static struct mremap_case_t mremap_cases[] = {
> > +	{
> > +		.name = "anonymous shrink (r--)",
> > +		.pathname = NULL,
> > +		.open_flags = O_CREAT | O_RDWR | O_EXCL,
> > +		.mmap_prot = PROT_READ,
> > +		.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE,
> > +		.exp_err = 0,
> > +		.resolve_exp_err = 0,
> > +	},
> > +	{
> > +		.name = "shared file shrink (r--)",
> > +		.pathname = "/tmp/ksft.nommu-remap-XXXXXX",
> > +		.open_flags = O_CREAT | O_RDWR | O_EXCL,
> > +		.mmap_prot = PROT_READ,
> > +		.mmap_flags = MAP_SHARED,
> > +		.exp_err = 0,
> > +#ifdef CONFIG_NOMMU
> > +		.resolve_exp_err = get_shared_writable_file_expected_error,
> > +#else
> 
> Hmm aren't these all nommu tests anyway?

those tests are indeed for nommu but also compare with mmu systems.
actually I was trying to implement test behaviors which are described
in Documentation/admin-guide/mm/nommu-mmap.rst.

this particular case ("shared file shrink (r--)") is not described in
the doc, but test with a conditional error on nommu, and expects
success on mmu kernel, which is interesting (at least for nommu folks)
to validate future regressions.

I think now if I split into several series of this patchset, I would
drop this particular chunk which is needed for other series, and keep
only basic tests for nommu kernel which is described in the doc.

-- Hajime

