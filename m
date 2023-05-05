Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AF3C77B7F
	for <linux-um@archiver.kernel.org>; Fri,  5 May 2023 11:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bh0N55Q/KZ5TPZpnMgP+ATuTRyFWhqgP0tqCoGo6AKs=; b=DZwbwodoPGzmxq
	1Yg5zV/6LLvELIKGigt58u5wLXl6JUgSSX6S6vBIf+MBBRDYTi63x3F2sRiOhVkRKtZZNKDusGx3B
	hK9iJeyKvaTctP5Vt5Ued+eESXjB4xlePe63YAvd7pUqrzAfSkyoLJtKBmbTbM4hVAhEXKCdmBs0V
	L3CagQk3Kcn0aDkZ1uznoh9hgPiUWP57mJy1ZuTcj0EhVC+XOCl8mEXfEfXb+IlqS720bBLAfQc9O
	cLurC9FwXijk4ggRYOqNtjGIjLX9auIbuwYEy2T/WwfG7y8N3aC5sHmeoDiXU/3hg9gn4Md2sjQnO
	07v0o46nkgrh6wGccwcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1putNR-00AdAL-0k;
	Fri, 05 May 2023 11:13:29 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1putNM-00Ad6k-28;
	Fri, 05 May 2023 11:13:26 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3062db220a3so1112688f8f.0;
        Fri, 05 May 2023 04:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683285175; x=1685877175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ijXnLFs/E46BZ9vNzrvv52u6Szz+pPucPk3iNgQDX0=;
        b=ktYmbTRAlaZPDQsuTHy/0W24MvI1iC67ZUpDtDkZ9YSlqzbJBWP+0kFoH8q3O4qUut
         VM98hi2uHsFbz/a0TfWfO7KvfyYzl17T7JQzv6CKZmpSJ0F1+rUE3+8BcLPCasHpRYBh
         w3+xRL+jvzEaqldrTuZFIITUxQJF8VKhNY10/FJ3qtw7usjlZkbrZUAEo1vviX7GohaY
         5KKPw12O6XNmC6HTyUrMnlnnG+8ZbqEy6bBgQvW67d6vp4NcGNVms7IDdScdHK7wbMIz
         1yO76Y4+hDmJbQFYJkb/AMHKBQEFiuadthz9Nyn15POXLgi9VcW19GgSdXDTnt49g9KG
         6fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683285175; x=1685877175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ijXnLFs/E46BZ9vNzrvv52u6Szz+pPucPk3iNgQDX0=;
        b=g0hW6tPJWF4WOkeCsTlUYhXaYu1wY/15Y5v5XjIwCx0syNxCH4/cOFVUVQzHE2tKGF
         JGWjsOXeHp2HLv0yEMptr+TP9ULDdxZoAy/87Us/soBy/lSTVGnsDozupt92qIbrKbfZ
         YPhh5/dPA9o44KmEcDSjSiNVmBDVt1KW1Ls2DiKu2ix8rph2mNzcUJGRBBSb93RZntYY
         HHRuTYti6ZPV366xuZB2Nis5jVzZKgNirfxFJ0sK4kEPVDt3biTjS7qqrdMm4siTcOcL
         sEiRxMrRGvFriU1Huhyyenq4DCMgH4MlPnH9yDL5n4egjQBuUOXFOsEZ4R35FCJYggRQ
         er3A==
X-Gm-Message-State: AC+VfDzJLgxone+H2NEzCbfybxQSMyNFJhl9cu/gULaZY6SkRRPXAZ9a
	xQkQpU+InlPl4GqiRISL3sk=
X-Google-Smtp-Source: ACHHUZ7VBqUiJxZux5Zvw1CbWJkUScVvhwDiZ8l56Xhc08qtgy5n+5w+8QOylGPS6kQyJv2SQvxZfw==
X-Received: by 2002:adf:f188:0:b0:306:37ac:ef8e with SMTP id h8-20020adff188000000b0030637acef8emr1077455wro.56.1683285174620;
        Fri, 05 May 2023 04:12:54 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id g11-20020adff40b000000b002c8476dde7asm2054187wro.114.2023.05.05.04.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 04:12:53 -0700 (PDT)
Date: Fri, 5 May 2023 12:12:52 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-um@lists.infradead.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [linux-next:master] BUILD REGRESSION
 145e5cddfe8b4bf607510b2dcf630d95f4db420f
Message-ID: <1c8aade0-5859-40f3-b6af-5211d1f6a941@lucifer.local>
References: <20230505024758.umVTa%lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230505024758.umVTa%lkp@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_041324_721515_E4AC6A01 
X-CRM114-Status: GOOD (  11.30  )
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

On Fri, May 05, 2023 at 10:47:58AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 145e5cddfe8b4bf607510b2dcf630d95f4db420f  Add linux-next specific files for 20230504
>
> Error/Warning reports:
>
> https://lore.kernel.org/oe-kbuild-all/202304102354.Q4VOXGTE-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202304220119.94Pw6YsD-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202304230014.YbScpx20-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202304250419.YtCLtUhG-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202305042329.Gyk53keD-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202305050237.1cQ4fBKs-lkp@intel.com
>
> Error/Warning: (recently discovered and may have been fixed)
>
> arch/um/drivers/harddog_user.c:6:10: fatal error: stdio.h: No such file or directory
> drivers/accel/habanalabs/gaudi/gaudi.c:117:19: warning: unused variable 'gaudi_irq_name' [-Wunused-const-variable]
> drivers/base/regmap/regcache-maple.c:113:23: warning: 'lower_index' is used uninitialized [-Wuninitialized]
> drivers/base/regmap/regcache-maple.c:113:36: warning: 'lower_last' is used uninitialized [-Wuninitialized]
> drivers/bluetooth/btnxpuart.c:1332:34: warning: unused variable 'nxpuart_of_match_table' [-Wunused-const-variable]
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6339:6: warning: no previous prototype for 'amdgpu_dm_connector_funcs_force' [-Wmissing-prototypes]
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6395:21: warning: variable 'count' set but not used [-Wunused-but-set-variable]
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:494:13: warning: variable 'j' set but not used [-Wunused-but-set-variable]
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:48:38: warning: unused variable 'golden_settings_gc_9_4_3' [-Wunused-const-variable]
> drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h:62: warning: wrong kernel-doc identifier on line:
> drivers/gpu/drm/i915/i915_pmu.h:41: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> drivers/gpu/drm/i915/i915_request.h:176: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> drivers/gpu/drm/i915/i915_vma.h:145: warning: expecting prototype for i915_vma_offset(). Prototype was for i915_vma_size() instead
> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
> mm/gup.c:2813:14: error: implicit declaration of function 'folio_fast_pin_allowed'; did you mean 'folio_test_pinned'? [-Werror=implicit-function-declaration]
> mm/gup.c:2813:7: error: call to undeclared function 'folio_fast_pin_allowed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

The folio_fast_pin_allowed() declaration should be fixed in v9 of the series that introduced it [1].

[1]:https://lore.kernel.org/all/cover.1683235180.git.lstoakes@gmail.com/

> phy-mtk-hdmi-mt8195.c:(.text+0x186): undefined reference to `__floatundidf'
> riscv64-linux-ld: phy-mtk-hdmi-mt8195.c:(.text+0x198): undefined reference to `__ltdf2'
> riscv64-linux-ld: phy-mtk-hdmi-mt8195.c:(.text+0x1b8): undefined reference to `__gedf2'

[snip]

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
