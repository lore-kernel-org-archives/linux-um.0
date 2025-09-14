Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971A2CAC582
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 04:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LXtvCmrZRR9OgP0sG11mqG9m/nOQIjqm8VdJ9uLACjc=; b=nnKLyaCVSSoAKvD6SyJkeYW8gG
	9H296XVnjSbjIzscgn6THK0xIAYMg8QsthB+D8GSqFjD/rHji77pwsgns6XRBGzyOv99eAE7nH04x
	YH2dwN0fJS/sCiNUgWMDwXVJOPednVDqNUxSOJgKk4CoWC3l0R3C6wywha8zIg4hhsRM0Uof7k/Aa
	dq5EyIn5zG1RCbIcnTyM4Se0DWh08eC45T+Qbtt8DaiXBBJudpdySh9MPbudAguugYP9pg4kGSiMb
	KNcQ2JLrTzLn6RHW516hlx8I2QVsb6BttTGj66LqcGFVfvT3/ImOa3uG9LxteU/3mwPiOte3UCaUr
	hVORgb+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxeD7-0000000HUqF-3Ddr;
	Sun, 14 Sep 2025 04:19:33 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxeD4-0000000HUoY-2L6B
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 04:19:32 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-b042cc39551so517040366b.0
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 21:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757823569; x=1758428369; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXtvCmrZRR9OgP0sG11mqG9m/nOQIjqm8VdJ9uLACjc=;
        b=i61K4bxjQxphbKR5XDfL9ITN2JqnD8OT+w31bCn8eI6HYw/Coi1JYcuIEbL/PXghKv
         eL4gzJriILRpdbtLoAaLpzmAKolqCHgWUzURnhMbVrFQ2ClwjSS/N6RN8CyuBPUY57rv
         EN48beJxu3EnnxjGPuHKBeh9w8y9L+y5PRfMMEKmQMPM8aJMXefdcHwyCeAd3dxDalLR
         gIBfNLzcl2VumagVps/Onnx3Sw7gKMxfDBi0vS5O+Kjfsi8U7CGSdEILLm6pp3Xe+HMP
         nxqrPwS0Mut363cT1h3FKE/0f8w2n/qbnPKPGs4rOrFiroMlEdT1/2bMmAVGMZc6L4ly
         aXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757823569; x=1758428369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXtvCmrZRR9OgP0sG11mqG9m/nOQIjqm8VdJ9uLACjc=;
        b=hb9qJmY1GXyU2v+KXC18cnaiYKEcMvnM3l6p4CJU8ceb2iGGBEnjmu++01Wfix7+/u
         7Az3DOzzNU3wAz+MCVMa9bdZXHOU3wQLQY+WHp1tx0bXGyRJ32eKA+cN4Wlnfbl5WLU/
         0+N1yQlYFS422Mbqu60UXfpA4inKD+p/eM/7/+zEX21Hjd2QQoE5xTTsTu8VyH3kiOoS
         LVJha5viFIWCDQ7WPAnBQD0BU/G8aydl4pnnBiR16in9x/bECfxTGjNXR98o1xTNVBRf
         7eLAQA4F8og4rCiP5HnG4uGDKmqQeHGvWffAcXDyZu3pZGNyrRD8Jt4IKfIgipY6eXr0
         O3qg==
X-Forwarded-Encrypted: i=1; AJvYcCWyUZ0adqntosnvZ/ChVTgyTzGs0IAq2WW+8g37hAB3jGNyYNf9QF+tNcxRg1v5DMyxO2MSKiAWbg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0O2Y5JLJpv4TUICa68R0uTStFAJ2mq8FMfPvgB405p07HBD/H
	iGWscKarBjUnKw9yg+Ejl+2u6vr8EyW03fzXsJ1liYQlhC1hWZ0b1DI7
X-Gm-Gg: ASbGncu35L/VWtlLz7GS716uQaqWQauh+xMgkxItdBAsn9X/sSi3HKKYlXAYiommaIc
	lAQN5Hp4Ue+1EiTVlxY1mqRE5FpH0BmQ4sdWlNuJCGpxq0BLftsH4iMk4sfNyXihOwwQETDo5Lk
	9Av64wm7G/+KuDAv3dHcTeOpPxRuLSfb2RPkoWrohLuf4J3LId7hQhnZlpoxXd2AwEszYicYIks
	8pouZRqh5tDdEou9yw8VNu4zjy57Lhd/BvlH9DXA3My9ZpjIp3ryjMNWhAqUEYNT0V3lqwo5XYL
	7eqr5uzCsgJXWj7aCumNhlDDEjG0zlW/Vn1JVz95/KM4nPK50PzZ5vS9Yfc0k/wcgn6Rday+jjh
	xad5usKcMdd2WHfEkIj0ExT5DtcXQLQ==
X-Google-Smtp-Source: AGHT+IF6mujdx9qWAhF6oXDc9ZfcQYBKEdRbKR8jum+cm7upWvg9UYWarRjAWufJtq6SFHzRS8+jpA==
X-Received: by 2002:a17:907:9809:b0:b04:25e6:2ddc with SMTP id a640c23a62f3a-b07c353a723mr763099266b.8.1757823568595;
        Sat, 13 Sep 2025 21:19:28 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07c28f190fsm504796666b.39.2025.09.13.21.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:19:28 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	cyphar@cyphar.com,
	devicetree@vger.kernel.org,
	ecurtin@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	mcgrof@kernel.org,
	mingo@redhat.com,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	patches@lists.linux.dev,
	rob@landley.net,
	sparclinux@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	x86@kernel.org
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
Date: Sun, 14 Sep 2025 07:19:23 +0300
Message-ID: <20250914041923.4119219-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_211930_606291_ADF3EFD4 
X-CRM114-Status: UNSURE (   3.93  )
X-CRM114-Notice: Please train this message.
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

Gmail banned me after first bunch of letters.
Just now I sent remaining letters.
So now the patchset is ready for review

-- 
Askar Safin

