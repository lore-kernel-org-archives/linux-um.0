Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75ABCA1013
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 19:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9McvDjxp1cOQ8m8DQ7zr8KAOkClRv+R613f7KwPZqLk=; b=D6vVIAb5kK3OPj01S4QSWYQp2u
	RANYMAnHMTwQ0E46eMOy+Q+1LWYMS32VnrUkEOw7VWyGCfE1i25Xju1R/k3IRmx1UiB+WdiLoVlH0
	gd5vd500oalzXzBYEsIOvmgikPsHCJNTtCsZ+k/Zcou1qt/Anbzt4rvoO30gTZ0K1AiQlVWb1hZYh
	wQcADrRoDGKptP7ghLQY59VPoM88KirnQMWpo6J9JdUZiYJA1GgK2c7eCN39X+lscrXoLq7aKbtQz
	Qd7otV0XCEGA5Uu65kVaHZzYnnku+/yDJyT4qj28aScOlPt++EUQ9ID7YB9Yy79O5jtgTitgV2nOx
	3PTvqeRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzKlp-000000012zx-1AcH;
	Thu, 18 Sep 2025 19:58:21 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzKlm-000000012xm-2F0S
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 19:58:20 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-b0e7bc49263so238070366b.1
        for <linux-um@lists.infradead.org>; Thu, 18 Sep 2025 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758225496; x=1758830296; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9McvDjxp1cOQ8m8DQ7zr8KAOkClRv+R613f7KwPZqLk=;
        b=aVScytwG+5OLN84c5kL14WxP55gqpSNJQtbZJEAFWCrMlLf16w4Biih4D39ULPcNrr
         Z14JUpEaGpRHZnmzBurD14qXWHvojpaoE47EcQpbTG0FYNNZTh0EvwBN5sdMg3MBenWj
         URlsVTmKgGExaYcNGznbc1Wny+L/pav4VBBCbZ73czSIwqnu4dQQm8kCmWNK9xixvSiQ
         I/fNGsuNRhsOZYadZy3980WRuz8B0Yez34uygnauTZc2O6IXUIAyHoMc7pJUrHRQzzGJ
         u+8pf6y+7Fw27ZHjxWmyoQrzvm7qPep7fs12NYLfsapHPh0qUTZXFEJ37S2U1lvYQeHU
         qfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225496; x=1758830296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9McvDjxp1cOQ8m8DQ7zr8KAOkClRv+R613f7KwPZqLk=;
        b=sQZFdEpooW4zSXkjfMJpsjKZoALicYIdZEM1q89LNI5BscRpUY96nMnahdnXKmHTyS
         R5TCdpLWQQ2Puh7BmVI/nKp8lcdQZx4NsvOQWp2vSpCzImLookD6c2VqQyr5yjkBatUZ
         O4ougjrD0r4xTdmUDigKdwf055S+g+ra9+KmsAcHPtNNGsM12kvwl+wahU2fMUr0VrdK
         bWjD3Ti7ur8E2eBkYSQ66LJfANQzSfhq2uLUOpS4ExbDDf6/nx79q5Jwa2kwJ/PLOA8+
         aoWJKQT4ai0M0bv0+gIyP0DlCgKjeFNZDo4u2YzAx1j/doT9kiwP/WfTCPrpg7eu6KkY
         KKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN4cD2Dv+T4W9BqP8+igCm1/Pt0yf99XuXzFkZRtwYnpbwFOEDNcyblNetyB21h6Icv32UIMJcfA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzXtUWpwmGjhYc++YsdANd08HMjXQnCYqwgdWYcCXAdrIs0lhIH
	qSHu/dE9Q+llMvJUrpTCwaCQeJ8Ks9RycV3+fvVrav+6akbDE1ZVU3eg
X-Gm-Gg: ASbGncvyrHjnqHrD+o4du975SYUJyOABph0et8UNApQ/oHwQfJiHw9H3hqVs/OtTb6w
	A9BgYIMdfNi+yjNh232IfdOe2iBNL3y5DeV+/26gSi3B0ZqSEZTBHgdH74g6GSZxB0eoqKA35Ym
	Zpr20N+dWpk9aNLU5ctTPVdu2NJFpqOVWxy+Q94iFZeK/CnZ7NGgRGtc9hQqq3d3CG5gU5SPe+R
	ADH6bN4gxAdlajXdV4L8ug/zXjgpPaBc0ecLZeXS8yuoZxVo4PXXU4cJ+dftsByOxes8Oh/n6WP
	nmGB7lVG2ahJDTrvhgmxFbNwW0epZO70/te5XwSBQ01+ut3RtNN+OjT4tkP79hgVqJIs0Z5jDSr
	MPQFgP2vAbv1Gb8pwTqoBHzeOoBqSuaZZJ3/RkA==
X-Google-Smtp-Source: AGHT+IH2NBu6L+bASXNqg9sJUcZ42MFCB2aqzEFiqoDEW6um54A4CtHcJnO37auTgFbi6nwycKDm8A==
X-Received: by 2002:a17:907:a089:b0:b19:969a:86 with SMTP id a640c23a62f3a-b24f35aa177mr45885966b.37.1758225496090;
        Thu, 18 Sep 2025 12:58:16 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fd1101c44sm264530466b.82.2025.09.18.12.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:58:15 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: nschichan@freebox.fr
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
	safinaskar@gmail.com,
	sparclinux@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	x86@kernel.org
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
Date: Thu, 18 Sep 2025 22:58:06 +0300
Message-ID: <20250918195806.6337-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250918152830.438554-1-nschichan@freebox.fr>
References: <20250918152830.438554-1-nschichan@freebox.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_125818_588750_12351701 
X-CRM114-Status: UNSURE (   6.97  )
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

> When booting with root=/dev/ram0 in the kernel commandline,
> handle_initrd() where the deprecation message resides is never called,
> which is rather unfortunate (init/do_mounts_initrd.c):

Yes, this is unfortunate.

I personally still think that initrd should be removed.

I suggest using workaround I described in cover letter.

Also, for unknown reasons I didn't get your letter in my inbox.
(Not even in spam folder.) I ocasionally found it on lore.kernel.org .

-- 
Askar Safin

