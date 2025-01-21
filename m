Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58BCC02182
	for <linux-um@archiver.kernel.org>; Tue, 21 Jan 2025 04:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lt2+fspcWCaxIpsRpP1sJZkCVdUNx58apRxZ3UC+NEc=; b=M8scMEVXpY64SDMJDWtdmBFX6x
	+PNlxGmRNTFk+80LmbxAmel1RWzEgpVbugl5euz0lWqiyD5my9n6N2BeeKwvq0qlhOoIpph8tBn/X
	PkCzZ0oVUNG+dkorvzGBgRtzaIe6V/vYqegjMXxxwHbsCaMp3pvzgdq2I/ylTkq5FTrVrMAWPR4XK
	6pB8aCvKeK27mTojzHovnzHAWQ6ulK+AT8Vb1Pco0JU0iLW/J6pNaqjf483u3tt+RgANfNtlkk5bL
	RGF0YbQtbi70Uvw1AJKIRgFXfEyoKDWE+b+zptutQ5bfxnssS7Vr+9faqti5+ewlWOl1F9YQgM0Vn
	HY7QvpXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ta5li-00000006rP1-1cUU;
	Tue, 21 Jan 2025 04:21:38 +0000
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ta5lf-00000006rOc-2O2B
	for linux-um@lists.infradead.org;
	Tue, 21 Jan 2025 04:21:37 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6dd43b08674so45924106d6.3
        for <linux-um@lists.infradead.org>; Mon, 20 Jan 2025 20:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20230601.gappssmtp.com; s=20230601; t=1737433294; x=1738038094; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lt2+fspcWCaxIpsRpP1sJZkCVdUNx58apRxZ3UC+NEc=;
        b=UBNSDQH4JiI/T1Et1V3Y2lJOUFc7RXZiFGwYXVpKOZw1w4lubMOBvxLgywBBrpPUcm
         +fg8yBWqZZwpTDDuGjvQvCzMfA1MzRd0s7pCKbLUIXi7bGQ4+aCGesQ47NYgRjkGaoJT
         BiZgFA6AJOvm8p3jTMt67NpwXwm3vKJe0Tn5VNLsfhZ5QFOnCVVzHX00lxGVt1GPNTOb
         J9+C+fQAbX/azVPdC/kcpU7atmYQ4xU2JPWX2SE/lJs1nfLL4l6S9Lb6xjT30CMlrfv1
         sJLLO656iWBIuFuMfsMhxc4nRrY9cxKumvpwTHzKaw7A2Tjlv64ZFZdK0w2axJTgy644
         9JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737433294; x=1738038094;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lt2+fspcWCaxIpsRpP1sJZkCVdUNx58apRxZ3UC+NEc=;
        b=GaRAwtY2SpTR4rRnmwy1I+70oOnV6ewN9Ecxxr11Jd5CmDkuZw8bv8a2U2yh2a0tKq
         tbiv8sLg2nF7kmkoQQ5/6LqX1JQMsYsARhFAMtotFN3X9FVPM3DOO19fJnI6hZ6O/byQ
         oeJjnzUkluES4wkqb9E0dT35el7b/HrJBLCzDjDlrJiFbsZ7GCym1pS8HIJdl0OjCIGR
         qQZaOEw2QNDFUQ1IYDrP0DOK4eAbrixZOiRWeQcYUYvmU6+zaT2bi3RkBO/Z8/+cTygO
         MXajMIL+tRwf3rZKE3hyjzMFxxgWWYFk9/8r6Ei3M/eOaOEVBuMttkEPFYwh8QSSCUWc
         tOig==
X-Forwarded-Encrypted: i=1; AJvYcCWdR05OVXtek54yhAn0XixQptHyygwW9bznFv6BE5krMAEWG66gZt15syUZXuFTnunNNZoAhSnl9g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxk/T+OSr7f82dEeWliXywbQLucVViGDhwZcT3FLYBrLGL6B1ew
	ghYoPbJZ9HXkRd/QZvZocj5w8ns3dZLuqqozfLfEIgT1xIUCssJNAk46r7MZpg==
X-Gm-Gg: ASbGncsuZxpFXytia4uRAOOMG04i1io1fz8gkb0Vo0FavpWTA4xxgfChWmANDmo86Uv
	F2RjI8iVH5kVun3geKa2ZkmtPCrp6brPCxA+j/KdLLybxVKUvWIP5WL1d12BuCuBd3EDehxUWoK
	/goIEpqXuWMx1x7Fx9QbuxMrRDw2GtF6sTXAAGooeAkJck1j09k+3yM0+O1N7YDRs57sZppL0eD
	a8AhTk7r9j2Xh6wlrLLsXfm45/d2ExX8lgLPWmmUAYPLapu9btvzjQqvxCmuFTGRhDlCvMrqPLd
	D24zpUwu0scTew==
X-Google-Smtp-Source: AGHT+IHeyD7Yud2Pn3YgBX4MERDKxUBlBzBDAl1P4h+nzWDkUkdTF0BETAXg9JqVmZsWRyqX87p+nA==
X-Received: by 2002:a05:6214:430a:b0:6dc:d101:2baf with SMTP id 6a1803df08f44-6e1b218687amr247057316d6.17.1737433293765;
        Mon, 20 Jan 2025 20:21:33 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([199.58.83.12])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afcd3895sm47757326d6.83.2025.01.20.20.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 20:21:32 -0800 (PST)
Date: Mon, 20 Jan 2025 22:21:20 -0600
From: Glenn Washburn <development@efficientek.com>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Thomas Meyer <thomas@m3y3r.de>, linux-um <linux-um@lists.infradead.org>,
 Richard Weinberger <richard@nod.at>, Johannes Berg 
 <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: Re: UML failing at "Failed to initialize default registers" on
 kernel 5.10
Message-ID: <20250120222120.3cb1b064@crass-HP-ZBook-15-G2>
In-Reply-To: <3ab03a41da31bd20a0c386559c102a153db86ff1.camel@sipsolutions.net>
References: <20250119172535.42b4bca5@crass-HP-ZBook-15-G2>
	<74506C86-D705-4B68-8779-BB839B305B9B@m3y3r.de>
	<3ab03a41da31bd20a0c386559c102a153db86ff1.camel@sipsolutions.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250120_202135_881929_B8245F43 
X-CRM114-Status: GOOD (  25.74  )
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
Reply-To: development@efficientek.com
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, 20 Jan 2025 10:56:36 +0100
Benjamin Berg <benjamin@sipsolutions.net> wrote:

> On Mon, 2025-01-20 at 07:07 +0100, Thomas Meyer wrote:
> > 
> > 
> > Am 20. Januar 2025 00:25:35 MEZ schrieb Glenn Washburn
> > <development@efficientek.com>:
> > > Hi Benjamin,
> > > 
> > > After applying the close_range patch, I'm now getting a failure at
> > > runtime where the last line printed from UML is "Failed to
> > > initialize
> > > default registers". The host is on Debian 11 at kernel 5.10.216.
> > > I've
> > > bisected the issue and it looks like the bad commit is: 3f17fed2149
> > > ("um: switch to regset API and depend on XSTATE").
> > > 
> > > On another machine which is on Debian 12 and kernel 6.1.119 the UML
> > > binary compiled from v6.13-rc1 runs fine.
> > > 
> > > I notice that the bad commit appears to be using ptrace in a
> > > different
> > > way. Perhaps there is a difference in how ptrace operate from 5.10
> > > to
> > > 6.1 kernels. I've tried debugging this without much success, as GDB
> > > can't be used. Any idea on what's going on here?
> > 
> > What processor does those machines have?
> 
> Some relatively old CPU or maybe inside a VM?

The failing 5.10 host is not in a VM, infact the 6.1 is in a proxmox
VM. The processor looks like its 15 years old. I suppose that's
relatively old.

Here is the cpuinfo for processor 0:
vendor_id       : GenuineIntel
cpu family      : 6
model           : 44
model name      : Intel(R) Xeon(R) CPU           X5670  @ 2.93GHz
stepping        : 2
microcode       : 0x1f
cpu MHz         : 2926.218
cache size      : 12288 KB
physical id     : 1
siblings        : 12
core id         : 0
cpu cores       : 6
apicid          : 32
initial apicid  : 32
fpu             : yes
fpu_exception   : yes
cpuid level     : 11
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2
popcnt aes lahf_lm epb pti ssbd ibrs ibpb stibp tpr_shadow vnmi
flexpriority ept vpid dtherm ida arat flush_l1d vmx flags       : vnmi
preemption_timer invvpid ept_x_only ept_1gb flexpriority tsc_offset
vtpr mtf vapic ept vpid unrestricted_guest ple bugs            :
cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs
itlb_multihit mmio_unknown bogomips        : 5852.43 clflush size    :
64 cache_alignment : 64 address sizes   : 40 bits physical, 48 bits
virtual power management:

> 
> I would guess it is the same problem as reported by
> https://lore.kernel.org/all/20241203070218.240797-1-sj@kernel.org/
> 
> Please try applying
> https://patch.msgid.link/20241204074827.1582917-1-benjamin@sipsolutions.net
> and check whether that fixes it.

This does indeed fix the issue. Hope this gets picked up in the next
release candidate.

Glenn

