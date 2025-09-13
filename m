Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF41CAC593
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 01:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPS175BLdkdbkMvPyh09bMwfY79gXnuJYPms+9/x8xc=; b=li/E225O1DYt6/PcCdf+Fw04Vp
	DnbX+iWFSRrqDKN8yCf9kJHIY2UI2f7Ckif/T6ZdVfMlPxqaz/yhAXeqKml6CMW/JsxPpE1HOVdyo
	jgtBWYfn3fPIDlYeyKZAcmY/LwSYUElU64uX/Nli7q6dOWyyrk2sPw059k7yKiKWu+tQZkCkVtpqE
	a/bn2GoU7jnR4WoOiWvynSQn3j/dLCvNmkYz2YlT7ZGqpbufmLQYL6O7pZjCwGReSlTuzSwdMCnjr
	/hElWyG2m0ojYX70jVkhMRgKwnDdJAZ1/3FpDVLlqj48wZHv9xOKMNKL/ZPpXiEBhF3u0g/hJt+dv
	WwJ+GqiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEoy-0000000CYGh-1GAp;
	Sat, 13 Sep 2025 01:12:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEox-0000000CYFL-0FpX
	for linux-um@bombadil.infradead.org;
	Sat, 13 Sep 2025 01:12:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=CPS175BLdkdbkMvPyh09bMwfY79gXnuJYPms+9/x8xc=; b=b/0vs4KO2MssCjOTHvgWfu1jbL
	7+RJyjydRkyYo5Mqqe/SYR1MDoF2d8Z9/PoHuWMszl15NwFWFxFJFkK7yXSz/gjSorRn5D4pLsfmI
	M0Gqa3OZ85GKbIuOdyGSDSeQuVuPwRwOebtzfoNvyZ/3wxWwjrrDKOHLmO7Zn4fvfUVPY+Z4+fXOR
	KGIRzY1PD8ZhB2Lj0pr1cBR27rJPqZkZ1i3fCERLP/JpNLIv2zCcAW1OaZXGx31q7eijCRUTiHpK0
	4R6Mc5GIjZJtKWKmSXfq/EUJBccwXArwWq3O1ZUFGCGH+nEMhvDu9ZlSvBANmYnhGTzf/IyBDqGWI
	gni8c92A==;
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEot-00000006WWF-3CxN
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 01:12:53 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-b07d01fd4fbso150674066b.0
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 18:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725970; x=1758330770; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPS175BLdkdbkMvPyh09bMwfY79gXnuJYPms+9/x8xc=;
        b=Ke54ZzuMSSqzQtuK7Vd1KR0VHEx8UzZmbgxy1/QpZXpda3WQZDKIfRMN+ztVICrZmv
         ROIlr7eOhj4KbEO582GmKNZy3jFv/TLR7qBc3ncF5Yiy+knlEh765dUQ2nYrpLuwoWRb
         6UrIM+oLfyfBt06u5JZC0tWka1sgaNfBrjxRHXoBISDP4UNEoxnL7iJzP5T8qEW+NEf9
         WSeob8xwuf9zA/FnA/J06A6+sS7nSpb5ky4cvjyp2yxQlWniJglDxqPVmJZbhZB/lXzh
         9ud6+vv7KpY6YDpUTf7yKI0LZsEYlJTkCYmfgxwd9d0DMuJ+OXgUpAt2ZsGeYFEvWAq/
         8/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725970; x=1758330770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPS175BLdkdbkMvPyh09bMwfY79gXnuJYPms+9/x8xc=;
        b=TJ1scQOJCURJP1Ezm4qwgcxhfeSfOfUrYbKTL8xq1h0mPQxnbrvfyTregsOOrfPIjX
         aRMkxUYQX0eqdtoDXBzwddJu0u2SffrMzc//NFLs8Bvy8nu3MSjkedSsWDkiATpi/JoO
         /dMKT05tztmadWFIKJNojhAjBuZY99S4zfYobC2k6tuSYfr8W1LqrRVJGL/u3LxTFdda
         ocd71doCslFVB1tADZlAkxI4uNuOU2R4Y0SFUu4I9aaovsCjILTKtFaGecg8fE8UVNDg
         q22okp98BlbdDlwj5SIBcY/y5XIUA7O/bidSigJ1AT0+K0nZojrXOmSIeTuMyNVkWLXz
         9y5w==
X-Forwarded-Encrypted: i=1; AJvYcCWKOBqiKirWGOxEiy527xK6SxPYvyMH/adafdGmZG7APgVSdUm6n+qK0RWbEWlioHvhAYAn+F1Usg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3ja5U0Q3WaPv7NxDZSk/MqxyiRIYfWyQxQe1FXpFqV7QwZWC1
	UCrnWm4u00HsUnFWChGK0t5g/grBNV+XwBFxd3QHZ/aVtR7VztSUd/AN
X-Gm-Gg: ASbGncvg2d23rnMsgILtrRWX2GLOE/6LdDM3O0llsv7v5sYOE/a8CLQ2gqKY1st2Dfn
	iUhImN0zEq1Y86AawRbOQPydyc9dNgWDenssmZ+/xZzKWLeyULNy4IgFHH912k40VVao+dmqktX
	ZgZhAmtanav0nh461+snSzlvHiYTFf0MKek87AOGjpqgiFrggvP9rhd1/R9KXNV9Ktm7Yho1d3j
	HEyoRFM8kxGo226EYU7kpB0tYVWc08rDf8CAU2xzcgvH7Q7VexNU2M0emLYrbQw7igaEzNiwAvN
	Rifk1xrRB98CPlG3i9HuEAfCuXV3uLmlGNaeV/UKoYQrOnhGzspjyzn7YZ/WUL9KF4nACKzcF+W
	W3O2M3rZg+41Ca8VNreg4wXC+Yo7eFOEMxQ3h8ZbA
X-Google-Smtp-Source: AGHT+IExCbHobezsJZBylPatDCb3rXiTmvHjuHynF55nxxCc14bpP2oPLB71sx+Li40Hkl4GjqRelQ==
X-Received: by 2002:a17:907:97d2:b0:b04:31c6:a434 with SMTP id a640c23a62f3a-b07c324cf12mr467235966b.0.1757725969783;
        Fri, 12 Sep 2025 18:12:49 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b30da327sm479612566b.11.2025.09.12.18.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:12:49 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 30/62] doc: remove documentation for block device 4 0
Date: Sat, 13 Sep 2025 00:38:09 +0000
Message-ID: <20250913003842.41944-31-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_021251_971787_14071D01 
X-CRM114-Status: GOOD (  11.42  )
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

It doesn't work. I tested this both in system booted
using initramfs and in system booted from real root
device directly

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/devices.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 27835389ca49..6ce0940233a8 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -138,12 +138,6 @@
 		number for BSD PTY devices.  As of Linux 2.1.115, this
 		is no longer supported.	 Use major numbers 2 and 3.
 
-   4 block	Aliases for dynamically allocated major devices to be used
-		when its not possible to create the real device nodes
-		because the root filesystem is mounted read-only.
-
-		   0 = /dev/root
-
    5 char	Alternate TTY devices
 		  0 = /dev/tty		Current TTY device
 		  1 = /dev/console	System console
-- 
2.47.2


