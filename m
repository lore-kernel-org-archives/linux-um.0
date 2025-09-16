Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F86CAC597
	for <linux-um@archiver.kernel.org>; Tue, 16 Sep 2025 01:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UM/63QbNRNL2CWSzKhJPtVEvJogEqqs3VcsifJT7nZg=; b=GAtgsQxdQ9YOZ6bZ2zE9otL1Xx
	EVcvjhefk4PGg/EWpCBRDmAQId0b2ep4qaJAUxLZnQt5jNUlSAsOWUQmcVWi4nn/X70BRhGz7pUV2
	Ezlwm2dWCc4KNZ2xKsyUJofWdTRtc8HbzxYcQrcYlJ8nchgwDMteiwkwsG/W77XX47mnhNv5xcQRQ
	ltzd0QKxlEILcO699K0MTN84Ndjmpnl/GNyOrk+i1bOhIU97EJFm3lis8sLNXZnNSzIOxFU7zGO0R
	vq0PrzmiHNhwVScF4gb3vGIPXNJXjEQb6wSj+Ce0mXa3DtIwJ2LWI9jZpGLZFYw129Bke0u7o1cEj
	MDSh2ijA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKoT-00000006C1O-3eAD;
	Tue, 16 Sep 2025 01:48:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKoR-00000006C0J-1PSH
	for linux-um@lists.infradead.org;
	Tue, 16 Sep 2025 01:48:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757987333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM/63QbNRNL2CWSzKhJPtVEvJogEqqs3VcsifJT7nZg=;
	b=JGzWjT6JFY44F9HuG73zfC+XVXSpyEZnpQCAqiavnVJaex4OmR07wPNEUXLEBK3aPPNASb
	DTaTB1gZFE+DJer/o51vsb0HNic3DYvivGyJhMpU+pMvEA5BzK1/RIXnL5VmsY2pUK7A4X
	JJbm37DGkbr6iy5wEYEwqu+Km41BUrY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-mJ7RqxLVPQOSmVImEdk2Zw-1; Mon, 15 Sep 2025 21:48:51 -0400
X-MC-Unique: mJ7RqxLVPQOSmVImEdk2Zw-1
X-Mimecast-MFC-AGG-ID: mJ7RqxLVPQOSmVImEdk2Zw_1757987330
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-571c4a20e8aso1867397e87.3
        for <linux-um@lists.infradead.org>; Mon, 15 Sep 2025 18:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757987330; x=1758592130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UM/63QbNRNL2CWSzKhJPtVEvJogEqqs3VcsifJT7nZg=;
        b=OEaAr83OVUcKe0R9mVrky/Fderkc/P5td1UiOhP4fMhJY+qefWcHR1B+v0sL0oKMSL
         9LMQ665KGwBHuD62slRclLeJhUqyiGXQdDmxmnwAIurForNObQlj0L4QwxBfJ21X/xfn
         dCoGNHGpzd4RcZUF34Mo0x2q0DNBVANoJCv6ladHtOqxVznoBficWk2e/pgGTf38EGCk
         DJ/CnbO2o/cGDfPkzcyJ1UaxsidYL9wcaYiswSim15Ygto7hD3aiTeGjdU/ZFr2pbFm6
         Ehss+6x15xNZKu/nr8+5vQ6RgiRrrnr2LANfJyJcXlWhW5IaVFodNFLautnIU0TkDCee
         y/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcvN4gCY3Q4h4onXbJS2Y44QaVaFLvmfQH1v/ntFVr3vukiTuDC+uWEKMGU6nglk6XKxcPBdwXnQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7EuL/QwIPVh22kGYFq3wZ2XCYhX+9qMYsjwuIkKqlZNz5EJYK
	b4WRz/UEUA9yiMu+YpbFzBy8AwjBSpwIuhFRHd8LWQTKfVB72Rpzfn4PQt+TH5Z8mrRZRv2meCm
	GYeoh01fWPElswZmkY7RPK17tmyByDcf0WsN7Tr3/QNIVGsW53c3w35r7nSQNOhI68byRXrmHvm
	MhorI7vCD5Q+gXvvG5cVx3Fe/mQbRMkfRdUiHygfEY
X-Gm-Gg: ASbGncvISsfdBU+9NsRsT2LDfZsn+MPWD5N/E26dSf6/RlRVRpX7V1tYjFMUlhg+pjA
	C6EGS/v/b+2L5wzDnnyxiKDhkJSRBn7Hg2Bg+ALiSAsGKSUz6pxu5/ADDJ9xetbWo8tBCe3i5yt
	05nwieTQIa0errlraCP2LI2w==
X-Received: by 2002:a05:6512:3f21:b0:563:d896:2d14 with SMTP id 2adb3069b0e04-5704f7a3535mr4252935e87.36.1757987330036;
        Mon, 15 Sep 2025 18:48:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi0qyrJSXhatUAjAN5GaSbgChEfkulnz/zBRoEI09ayrVbCpTRhDlFRFU2ScIQdlOHU/dANXpgiKsiuT/Fm5k=
X-Received: by 2002:a05:6512:3f21:b0:563:d896:2d14 with SMTP id
 2adb3069b0e04-5704f7a3535mr4252904e87.36.1757987329545; Mon, 15 Sep 2025
 18:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250912223937.3735076-1-safinaskar@zohomail.com>
In-Reply-To: <20250912223937.3735076-1-safinaskar@zohomail.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 16 Sep 2025 09:48:40 +0800
X-Gm-Features: AS18NWBkCHbtMZDfiuZiXnfW8KzozFHrUJlGejiASEzNumvZVB8NmHoE7UrrQwg
Message-ID: <CALu+AoRt5wEgx-=S263CReDf8FmLWwjs8dF9cX4_jFcMUkuujQ@mail.gmail.com>
Subject: Re: [PATCH 00/62] initrd: remove classic initrd support
To: Askar Safin <safinaskar@zohomail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RS3Lf2iFhHW0_s8JuUnsSZyEMHVg4XGDgyUJ1R_91q0_1757987330
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_184855_572952_C1BE5EE6 
X-CRM114-Status: UNSURE (   9.38  )
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

Hi,

On Sat, 13 Sept 2025 at 06:42, Askar Safin <safinaskar@zohomail.com> wrote:
>
> Intro
> ====
> This patchset removes classic initrd (initial RAM disk) support,
> which was deprecated in 2020.
> Initramfs still stays, and RAM disk itself (brd) still stays, too.

There is one initrd use case in my mind, it can be extended to co-work
with overlayfs as a kernel built-in solution for initrd(compressed fs
image)+overlayfs.   Currently we can use compressed fs images
(squashfs or erofs) within initramfs,  and kernel loop mount together
with overlayfs, this works fine but extra pre-mount phase is needed.

Thanks
Dave


