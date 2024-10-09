Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6EBCF043B
	for <linux-um@archiver.kernel.org>; Wed,  9 Oct 2024 04:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=thDgyfP+u4RJkN9ygN4eA5i7zuNDmPDTp6v1MVROO00=; b=VGOEITYQ7+YtlZNMvAj7IL6c35
	SiHWpAIRNXvNAh9KHRgwfX/t/3yGsU4/VJIEZ6ElloK2Ju7V/JnmOxeI0UbRSN6BaeKY+hJa9aFzm
	t+DPnkWqWDDeOA27HcMIox6OQKvqTa2mpPAM2wsJE/v7zu09F/S6DsGRtGTPzg2dBit0LH5Qt/Vd7
	3REhuJR/osMXTOCBIqJfKC2DS0iY/3VMDF4mXkctQd+yWchrZQrQ7JRVW7WXff98HQO/vXR+UFhjz
	HJ8ypvSaHIrurCvfJgd7Ni8Xi1cUA7kBJRsG1tpbu1++CD3dJXPWe6pW11N6/Aj+Kp6XK2QXSJrgO
	ipipQrOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syOLV-00000007sZU-1gR4;
	Wed, 09 Oct 2024 04:30:45 +0000
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syNDF-00000007li2-49qE
	for linux-um@lists.infradead.org;
	Wed, 09 Oct 2024 03:18:12 +0000
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6cbc4b2ac1cso8944216d6.3
        for <linux-um@lists.infradead.org>; Tue, 08 Oct 2024 20:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1728443879; x=1729048679; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thDgyfP+u4RJkN9ygN4eA5i7zuNDmPDTp6v1MVROO00=;
        b=QlSyaW0IK3STVicFab6ROLM6NFvGUPqUTYX6KsXLfG4D0hol00bMLlLNc81Olz/Mt8
         VpfzgW4lBEAn/4eEubfekUDcdZO86nMV5/Mk/5SIE4GoVu4hh88bytpOLrhmTgpl1UtE
         N4MdlZOOXUW+YBtU7Szp/peNgPBvqo4V2J/XjLPEFJ7IgbybrvdehR2VGaYsknLm5Ytu
         pv25TL/eWekOEMvV5M+hVnmaCfce18/9EDz+xpWCwVJdxCk4J9ycEknMz5lt8u7h36Vk
         CQ5Att5Ta6bmk3KEznOsD4KISLAPkJ9jGExRwh/ifbRnYdampu7EUNxDLnxbsdc6wO1S
         wc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728443879; x=1729048679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thDgyfP+u4RJkN9ygN4eA5i7zuNDmPDTp6v1MVROO00=;
        b=U7XC4J7bLuzl01rtYM17kV+rPPSBjNvtl9Xhw0gO7ir/XyetSmSBo7QXYahQrQmUzQ
         sH3e/OWN2iPt2lLT0tW1hN3Ooc+2v/MdxNtqAXqcprqueqjSqwf5MR0meciXBboDfVo5
         OfYbkNRmxHwhfdPsnW32/qb4q6AuZ+GXXMaElkHSHyfGKDdiX83Akf+zQg2VsZNyvLYN
         yXbC/KY1gYBEQ5s/XTwDaApAsaWM+HNSqkImJPRTvXcl0N9vtZURdOx/G0HjpVDrgeB8
         w3lTbiKq4K6bsua0s8qHDpEb+FluNOLIoge+xwDjm5AtfJwUWERPlgjTL4kUEFL6dSw8
         8IQA==
X-Forwarded-Encrypted: i=1; AJvYcCX8c0oQq4R/HLGb5UzO3oi6OQwPokinKfXQH999KUjDfaoqB/VhDQlAuGPf9lJTl+5V6HHrLL5+Iw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzBXcy+R/73rgeEw28CumqPVYZ0e75ux3s8F9KZMjhL1jVPVx7h
	Ozw3FMryllDscjrRuddLpsFwVYTjsuLlxGPMMoosJt4wESh3qRAxl7BQsb8ezA==
X-Google-Smtp-Source: AGHT+IEhn9w/MP0oB2WKldelhVAKmKiL1d/EbmMPMKgnT2doMp+iZMaSHOVIOpO2jisfYNBEVmkdXg==
X-Received: by 2002:a05:6214:5a04:b0:6cb:99db:bdbf with SMTP id 6a1803df08f44-6cbc95d4684mr18380106d6.43.1728443879197;
        Tue, 08 Oct 2024 20:17:59 -0700 (PDT)
Received: from node0.small1.linux-mcdc-pg0.clemson.cloudlab.us ([130.127.134.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbcaad37f5sm1820886d6.130.2024.10.08.20.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 20:17:58 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: nathan@kernel.org
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	wentaoz5@illinois.edu,
	x86@kernel.org,
	chuckwolber@gmail.com
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code Coverage and MC/DC with Clang
Date: Tue,  8 Oct 2024 22:17:38 -0500
Message-ID: <20241009031738.2851980-1-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003232938.GA1663252@thelio-3990X>
References: <20241003232938.GA1663252@thelio-3990X>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_201810_045883_EBB093EC 
X-CRM114-Status: GOOD (  17.02  )
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

On 2024-10-03 18:29, Nathan Chancellor wrote:
> ...
>>> I was able to successfully build that same configuration and setup with
>>> my primary workstation, which is much beefier. Unfortunately, the
>>> resulting kernel did not boot with my usual VM testing setup. I will see
>>> if I can narrow down a particular configuration option that causes this
>>> tomorrow because I did a test with defconfig +
>>> CONFIG_LLVM_COV_PROFILE_ALL and it booted fine. Perhaps some other
>>> option that is not compatible with this? I'll follow up with more
>>> information as I have it.
>>
>> Good to hear that you've run it and thanks for reporting the booting issue.
>> You may send me the config if appropriate and I'll also take a look.
> 
> I seem to have narrowed down it to a few different configurations on top
> of x86_64_defconfig but I will include the full bad configuration as an
> attachment just in case anything else is relevant.
> 
> $ echo 'CONFIG_LLVM_COV_KERNEL=y
> CONFIG_LLVM_COV_PROFILE_ALL=y' >kernel/configs/llvm_cov.config
> 
> $ echo CONFIG_FORTIFY_SOURCE=y >kernel/configs/fortify_source.config
> 
> $ echo CONFIG_AMD_MEM_ENCRYPT=y >arch/x86/configs/amd_mem_encrypt.config
> 

Chuck and I can confirm the issue is reproducible these options, and we
are still looking into it. Thanks for catching this!

> ...
> 
> Another thing I noticed with this series is there is no entries added to
> MAINTAINERS. Who is going to be responsible for maintaining this code?
> 

We are going to add the following as the fifth patch in v3:

diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76..55438cb90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13262,6 +13262,12 @@ F:	include/net/llc*
 F:	include/uapi/linux/llc.h
 F:	net/llc/

+LLVM-COV BASED KERNEL PROFILING
+M:	Wentao Zhang <wentaoz5@illinois.edu>
+M:	Chuck Wolber <chuck.wolber@boeing.com>
+S:	Maintained
+F:	kernel/llvm-cov/
+
 LM73 HARDWARE MONITOR DRIVER
 M:	Guillaume Ligneul <guillaume.ligneul@gmail.com>
 L:	linux-hwmon@vger.kernel.org

Other than the booting issue, v3 is ready and being tested locally.

Thanks,
Wentao

> Cheers,
> Nathan

