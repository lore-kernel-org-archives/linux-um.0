Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFB0CA5FCE
	for <linux-um@archiver.kernel.org>; Sun,  4 Oct 2026 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OU10JUkOnCjExkP9pLJslSiL15VSpV7uAw3VaBnuTMo=; b=CSJJb+ZF1N62uVjR2t0bUHS4Rd
	nBjwyJdJdpPVG9S+uPESsFKBr+Z1Q1oUUB6M04GdHzt6WJP4PkTQN3Y9an9HotQR/TRXrmJREsO1C
	gucMvYhbPJzLH1Y5hab1/0mruSg+Qo6V6P73V3xHzq1CPfyRUoddS2f2yh4AB3TXP6VgQ7ZF9B3eX
	c4I8zWzvsFfm66r+g8SOuUE4+xYLIhNhCx07g5Sunp21Ll1wR3t/T3YzxbmRPLZmEqpjgNbIViO57
	HIMOMJnveiOz1yTZf1pW2R4rre8y2j5+tG6+ARKYYFHtz/312HNhCnSCDrgv8CYpC0ztvn+nA3fAF
	BZ5n7poA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDOdA-0000000F14b-2PZX;
	Sun, 04 Oct 2026 16:00:04 +0000
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDJoW-0000000Eg95-1s2d
	for linux-um@lists.infradead.org;
	Sun, 04 Oct 2026 10:51:29 +0000
Received: by mail-dy2-x0e.google.com with SMTP id 5a478bee46e88-3510b42f4e3so843154eec.2
        for <linux-um@lists.infradead.org>; Sun, 04 Oct 2026 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791111087; x=1791715887; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OU10JUkOnCjExkP9pLJslSiL15VSpV7uAw3VaBnuTMo=;
        b=lh9c2G94Gs3uBEk+/u8uKKrxBUivH1XqNWg1lGMrjqtlhuJE4BtpRsoPD6yaRM81vw
         Cy1kX90W0cUo/uIsMvIyl6mIVp2qLT59XLN9ImI08eFDVRaZRmNkY/u7oJLKBq2o+dMU
         ScZquHrNJeMAQKP4FdehHK83ja713gQZsE+eKQs5+RsViDryzson93ku/IOzZvKIX3fc
         OZyfeADbCLSZY1bxzrTYMUY+1+8NOM6kGfCCFX1zmtUz47YFc51Lvp+C/Vn0fbzgYV4N
         Du67A4m2SeaNFlX/jwtY+lzJ9S9/yn2naJwxb6mVis/5AQ/wrNWNa74VyuMTbsd9fl5T
         On3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791111087; x=1791715887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OU10JUkOnCjExkP9pLJslSiL15VSpV7uAw3VaBnuTMo=;
        b=KlzkugHe444DcZgkRg9pK2eB4hRX+s4cDhS5+VtBUog10ckXheDrb64tL2U7kg9OP1
         QQrj+HKLJ7iicZAKYgSFEXt7ZkAGaA73rVlg8HWVkCgzkykExc9Zcl8JEcqH/CCsXvhC
         DAcuMrYdj2PcStpf7+5E662o5QT8ZFxZ1u6Nqq8F+rd2ekNkri3H7ScLOUwwwIGlWdqI
         zVRlqFUqfyiZGxxV6NqR2o0UbWWa0RaPeIrVPtcGyxNS8/pqbvJQ3LT9SL9lS2e3YIei
         sUgvbLA+X55BpMag/wJSJWUVdGjIDiuWG2LElBzYpj3mPPomhioxANUm/miXfZ1l6MPk
         Pzvg==
X-Forwarded-Encrypted: i=1; AKwUvBxAhl58Gfol59CyLtcficYAQItPJs0s3MiqPDsWTo3UZmwwoPnJPXITOg+WB/aACFt98TckbQV9pw==@lists.infradead.org
X-Gm-Message-State: AFq9FYIM3sdvnSaD8Fiz2u9nXuOH2dhMuM+LekBQbZAzoTFILxBnUc19
	sLPFXxGibHCUNjFShhl4mmCC7H520A9Ej/t8229y6tZ1XfEQ4OUUpbLQ
X-Gm-Gg: AYBFou1AHWCyw9ZnQWm6xFPAJRHNGuVH5e2QP9KrDHyv8SoOi65oAN44XASRihjVh35
	leRtWjwj4jjnrPjnNMxPdVMYkoiKByY8e0H/mav5HMcEeWW86RrFC8yEwCaHYHUJ2C+dRXWhktW
	G41bVAbbZ7/F/6Axj9XSDA6arOrIdncbG/nkV5uTIbaQyqHsoi0YnjnRzdginkMzGksftId3OLu
	6y9iML49cso0JK42PGYglFO0iiR2WCrhMBGzcYXKuc9JAWpdFueBFrK6RSCDTCLqrGrMLSBC29V
	1ca6SjUGqLJOANyyPGGyJ71NtqMl+UaMNVsv7voTEqjKYJ364oqbolsQRzacMdHakSXIT1PLqb4
	9fguZvQkkRTFIuPHn5XhvhN8FOpDt5Y9ipaskWIFqcu99bVwE2DL0NL2TM8P1Cxsp2FYzrPOcRW
	6kByS0taw79dFerAyUAlwxsTEW9p5hO41DwWhf+p+mFEnXrWkbJhqsUm2Z7YrvKLiMbdXptOQkl
	QnB/JgF8eluxEWmINIfhGZ+N/dlnVZV0JpMo6X8HzfPk+M=
X-Received: by 2002:a05:7300:e5c2:b0:341:3ca2:de2d with SMTP id 5a478bee46e88-34f15077edfmr9383419eec.6.1791111087081;
        Sun, 04 Oct 2026 03:51:27 -0700 (PDT)
Received: from Anshuman ([123.63.59.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127161474sm3815965eec.13.2026.10.04.03.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 03:51:26 -0700 (PDT)
From: Anshuman <anshumantewari123@gmail.com>
To: kees@kernel.org
Cc: Frank.Li@kernel.org,
	James.Bottomley@HansenPartnership.com,
	airlied@gmail.com,
	akpm@linux-foundation.org,
	andriy.shevchenko@linux.intel.com,
	anton.ivanov@cambridgegreys.com,
	apparmor@lists.ubuntu.com,
	atomlin@atomlin.com,
	benjamin.berg@intel.com,
	bhelgaas@google.com,
	bp@alien8.de,
	bvanassche@acm.org,
	corey@minyard.net,
	da.gomez@kernel.org,
	daniel.lezcano@kernel.org,
	dave.hansen@linux.intel.com,
	david.e.box@linux.intel.com,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	dvyukov@google.com,
	elver@google.com,
	eperezma@redhat.com,
	georgia.garcia@canonical.com,
	glider@google.com,
	gor@linux.ibm.com,
	gregkh@linuxfoundation.org,
	hansg@kernel.org,
	hare@suse.de,
	hca@linux.ibm.com,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	intel-gfx@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	jasowang@redhat.com,
	jbaron@akamai.com,
	jgg@ziepe.ca,
	jim.cromie@gmail.com,
	jirislaby@kernel.org,
	jmorris@namei.org,
	johannes@sipsolutions.net,
	john.johansen@canonical.com,
	joonas.lahtinen@linux.intel.com,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	laurent.pinchart@ideasonboard.com,
	lenb@kernel.org,
	leon@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukasz.luba@arm.com,
	macro@orcam.me.uk,
	martin.petersen@oracle.com,
	mcgrof@kernel.org,
	mchehab@kernel.org,
	mingo@redhat.com,
	mst@redhat.com,
	netdev@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	paul@paul-moore.com,
	pbonzini@redhat.com,
	pengpeng@iscas.ac.cn,
	peterz@infradead.org,
	petr.pavlu@suse.com,
	qemu-devel@nongnu.org,
	rafael@kernel.org,
	richard@nod.at,
	rodrigo.vivi@intel.com,
	rui.zhang@intel.com,
	samitolvanen@google.com,
	seanjc@google.com,
	serge@hallyn.com,
	simona@ffwll.ch,
	somlo@cmu.edu,
	srinivas.pandruvada@linux.intel.com,
	stable@vger.kernel.org,
	stern@rowland.harvard.edu,
	tglx@kernel.org,
	tiwei.btw@antgroup.com,
	tursulin@ursulin.net,
	usb-storage@lists.one-eyed-alien.net,
	virtualization@lists.linux.dev,
	vkoul@kernel.org,
	x86@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH 01/11] params: bound array element output to the caller's page buffer
Date: Sun,  4 Oct 2026 16:17:41 +0530
Message-ID: <20261004104741.51238-1-anshumantewari123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260521133326.2465264-1-kees@kernel.org>
References: <20260521133326.2465264-1-kees@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261004_035128_501791_38164794 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sun, 04 Oct 2026 09:00:01 -0700
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

On Thu, May 21, 2026 at 06:33:14AM -0700, Kees Cook wrote:
> ret = min(ret, (int)(PAGE_SIZE - 1 - off));
> if (!ret)
> 	break;

One question about the truncation behavior here: when an element does
not fully fit in the remaining buffer, this min() can cause only part
of that element to be copied. For example, if the remaining space is
4 bytes and the next element produces "123456789\n", the resulting
output could contain only "1234".

This leaves the reader with no way to distinguish a genuinely short
value from one that was truncated due to the PAGE_SIZE limit, while
the array otherwise still looks like a normal comma-separated list.

Is this partial-element truncation intentional for this patch, or is
the expectation that it gets handled as part of the later seq_buf
conversion? Would it be preferable to avoid copying an element unless
it fits completely, and leave the larger-buffer case to be addressed
later in the series?

