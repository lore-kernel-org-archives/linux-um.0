Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B46BC369AB
	for <linux-um@archiver.kernel.org>; Tue, 15 Apr 2025 19:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ntkk2EuJ1XJRKx1RttSweaGGZM6MW37mEH+h/pvePak=; b=fapmgll3O3dX3ZYWzsoVVBrBzW
	R6HrSgkPJUI4zLiRP2wHooGSJc1LZTrjMlFUc5Ho1sscffvWMfBwEiChxECEECSEyipPHdS0n+N9G
	7rIB6GDrPJvd+aldg1GnfEezKAfLQ1CU+rqzcL0K42mRwJtOxuwUl5V+OfcifyySXJQbYPAxn6yjG
	iGw7ARaN8skQZLtfKpb8I1ZcCv3ZW5Kk4UKpRPWtfQRAzTLTPLoNsY8ZhdE5pmhBbwy5ZzZHa+RIX
	A3xSvrlmhLmwowPxdHVt6ga5YYkOQD5ooLPWQ+2tyrbr0z5cMNxYhxL0rtate0RgYcID2tUM3VMhi
	7FfVuf0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4lmg-00000006rHC-2QPe;
	Tue, 15 Apr 2025 19:17:26 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4lkL-00000006qjH-1Bac
	for linux-um@lists.infradead.org;
	Tue, 15 Apr 2025 19:15:02 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so1766254a91.1
        for <linux-um@lists.infradead.org>; Tue, 15 Apr 2025 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744744500; x=1745349300; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ntkk2EuJ1XJRKx1RttSweaGGZM6MW37mEH+h/pvePak=;
        b=cHoYFIOt4DajzHDcIBP4DQmcEC+bPvXV/W2pmGrgg0k3iEd2gtLb2C/Nm0PIZ2iNY0
         AuXfTByCpiEbgMKhSeQ4Xyg9DZekhOqTvo+Gz4k41L/vPdp+x+jxutW1+dpyO3n43lcu
         SK9c11BLdAy6/CGyNJJwkFv0iwPfScoF70CLCM1qYJpga2YEcLzeZHT8BDaFeMGCBUyy
         9+/PHl8SC0d+XEjdj0cdsNMm/8Eqq8KSjIH1svLHq/nQcL6M6t10SftI5y1ql/rTQAMf
         FlOfrBDJZrk0Cx/39843PJIkjslie4l/yaxPpYTgyns4UVHM8ZRypRKyKH9tDkQ7V5Nf
         uLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744744500; x=1745349300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ntkk2EuJ1XJRKx1RttSweaGGZM6MW37mEH+h/pvePak=;
        b=lu/u8F0wfP6Z5CJUmuW4N0LG4nRSQBJiN8YxCody/AUfhPRxFKS5marPbq/HE7kBnC
         DuwDWLUkOhq/Ulmji10hl0LXwe0OyFLRiplXCAhiX20OuiSKo054Ti47h4iq3zaxw+ia
         SJC20YfB8aUMQRosZl6AASr4SN9zhJfl2joG4h6ZzEqTJ69KqxKqGgwX/6C4SXBoLX6T
         CpobYirrqjWG4ECrf0c+vYjix0vANaBmzet4lXyZKVHSsubEAUkjMwtIuVg2f8WY2zIm
         WCqWTZHgABlDaoKlCtQMkA38EZC3xWHtaz4CWMhtE/qKd+OLeUdhZ84zB/5qe4i/3KCn
         1pjg==
X-Forwarded-Encrypted: i=1; AJvYcCVKx8sIxxyhradw7D4AxQf3P1MO0eTt7p5ynU+hqFdTj++kcOxAdMO3VrvWk9xPpjK/rkKop8Z30Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YyWODa7omfLq05yiyu0n3ZI3XlCExL37x4rD8XAi/UvPEYQTy9B
	KGsOrmZN4/dlur5xTSAdvuqGBvVFW9qGlU4KK3IqBZx/dCEKDuKD4jVfWeeB7x7teVpMY/+9KR3
	aAvEjAzCJqmUXHcYAlbb5XE8NYf4=
X-Gm-Gg: ASbGnctDvY7+AJ0m2J8/hruQ/NgWWosd/ze3azQ5fgpFWDhWh8sM5pNgdfCJkmtmJA3
	gNTvtPODRlEqgsB75Wejpf9F4KGYPFvRifKxKB85vZdSM84ZWRrcXYx/pMUH4sUQKSDZvnyXdzV
	H45gRLaAlHjKo/wdMEgnmRiw==
X-Google-Smtp-Source: AGHT+IGc5DVYt2SE6BYaqtTqo6hk2/0tRd0JrYscIn68HrcFugnLC6Gj9XZ3iEbYFgiGu0SCjkXVZRFhjUt7k/6oerU=
X-Received: by 2002:a17:90b:17c2:b0:306:e75e:dbc7 with SMTP id
 98e67ed59e1d1-3085ed78171mr234636a91.0.1744744500072; Tue, 15 Apr 2025
 12:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250412005341.157150-1-fujita.tomonori@gmail.com>
In-Reply-To: <20250412005341.157150-1-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Apr 2025 21:14:47 +0200
X-Gm-Features: ATxdqUHlXfvqgCSoo4-vySZAgrgL2xgqbfG1d1cB0y3EXvoKuokh17lk5we2yzg
Message-ID: <CANiq72kKhkVRAmg26DNG=Q8-s_+zkz8jVe5MZa__9RPjRs7f6A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: helpers: Remove volatile qualifier from io helpers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, geert@linux-m68k.org, logang@deltatee.com, 
	sbates@raithlin.com, dakr@kernel.org, dinguyen@kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_121501_320005_85FB10EF 
X-CRM114-Status: UNSURE (   7.74  )
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

On Sat, Apr 12, 2025 at 2:54=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Remove the `volatile` qualifier used with __iomem in helper functions
> in io.c. These helper functions are just wrappers around the
> corresponding accessors so they are unnecessary.
>
> This fixes the following UML build error with CONFIG_RUST enabled:

Applied to `rust-fixes` -- thanks everyone!

    [ Reworded for relative paths. - Miguel ]

Cheers,
Miguel

