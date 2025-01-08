Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94116E77188
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 08:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pOEC2ltbcQe+tq7ZmRD8TABI8MoI6c9rWsuU3Z2A+Lo=; b=TeNzpJh9J7zXiO
	ujCFlbktenDxv/l0QqS3Tz+5zLg/9xbkhCDlmWpLxWe7Lmd+YUtsMntRu2B1mU41DU1L1SMpGi1fJ
	BR+/qGcE36D0BcNfCq8L0wdZc5tqLTTyQEckSaS0mVm0HHDNnUOzvC1dIn26SLebUY5uZ7FXzu02F
	XycEBu4zhPfvwiDrXk4YjeeyvmGFjINZyJMTv8kyGfcNhokVyLN+nNbVl1PjmdxM3pldvrYm2Z2ba
	5MA99fp/l25b1NcVrLPhT9XjabUsT7aicOHavAFKpPH0pgKXsQohG1mIp2eiDD/kSYEBN/2P06Grd
	We2Be2zGrwufVgBMxDCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVRML-00000007Xgs-47T7;
	Wed, 08 Jan 2025 08:24:13 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVRMJ-00000007XgO-2pT5
	for linux-um@lists.infradead.org;
	Wed, 08 Jan 2025 08:24:13 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6dd43aa1558so122022516d6.0
        for <linux-um@lists.infradead.org>; Wed, 08 Jan 2025 00:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20230601.gappssmtp.com; s=20230601; t=1736324650; x=1736929450; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOEC2ltbcQe+tq7ZmRD8TABI8MoI6c9rWsuU3Z2A+Lo=;
        b=17qz6aEXOc8hw5WWOwAoUv67Qph4RY7SyBBIDHv8uvVDnLA+iYK1dNQwBYXdxkuaba
         pV69Y8TR+U1HrRoJSIH+focvGdJ1VjluV54iURTDDNALT0mYdQeFkD6trPz07RBYjq0r
         RkU3W6OABlgbm3sI4vG3phRSx0+dqKZDXbzaUrdGY82oqCnZikF732nqoK1t4SSMHHfn
         UlhQRje9MMjMzHNc20zvNEwyDJQT5XgZ/mtgVQr3xeD19SGR6rjbkxxX7tg9GnRQpcQq
         PBQKjh+AJPAK90pfpouoOPoaTc1OiValoIkE75/a0t8xMpupWnxfIv404Lgsop0EW/Br
         lZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736324650; x=1736929450;
        h=content-transfer-encoding:mime-version:reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOEC2ltbcQe+tq7ZmRD8TABI8MoI6c9rWsuU3Z2A+Lo=;
        b=rt2QKkjFnQbbNwb1UZCqwjtFYKXs18rJn3fhu92V93FIuHdJLONuYLFAKZ0BU5XuNm
         Vc1MfCLy/at8pxCgr9u9eGoRvPG1XgzwgDe3U5RSfHHe6C85oogB41xUss7KiEP1ZeP6
         U3KlEfazMC+LAXK5KYngMDV/3DBD++0nPaaIl0T2qrBFcRjvplAfCN4A/OhOUkLH8/ra
         463N742zuDBIgVAztXOTEi5UtJKsmqAJEtLQX8VWY1YAV7rdFp3Gvm20QfG1NwU0i/8s
         dGMyp26MwyHkxbuuwBR+gfWzLrfkbmyMGL0Y/kGQszIPqXN73LmO8YrtJ5Nx6h3NZ1tb
         2CJA==
X-Gm-Message-State: AOJu0Yw4/Zt1C4BsDs2Ab60ZL1q4rBKHd6tHzARN52X238Rb2s9urtwG
	MqTRW5R6yK3b3oXrIq/GSK0s3RHWaPvP+d/EhyuA6T06fyAJV7dyvz0XzmFApqEX9zhPunxfUjM
	=
X-Gm-Gg: ASbGnctSaMxDsmjMSqmWa9XNPu2NEKsdfC1fpbPx9fg4VYC9Zb5vJZCH48YN6CDy/Jl
	+yYhHYI2xALRJ1we3ebGjasyAK9STZApAZpiL8nFen7xBaQO3ijPTwURiJRAe4nHOZPMP9F4llp
	n7H+hJlOFaV7b4vo8cT2OL4Aef8wyoilESxQhHqLkzwK01r4JSPS498MdbF6qPNfWi3vFTKTb6/
	yGIRPsCVFtwGR/AOwJHlEgvox3cgvN0S1RQUaQKtxOc1P8pSxJZyu2Aq8XEIPu0yH0wBHlhbZ8L
X-Google-Smtp-Source: AGHT+IHQZPCs+i+zKSfk3AKMi+WMqxO19nLA4u4+VUlqvkXMBS8tuBDZYk2diT37pkRslUctktnV1w==
X-Received: by 2002:a05:6214:19c5:b0:6d8:8256:41d4 with SMTP id 6a1803df08f44-6df9b1f00c4mr35364856d6.19.1736324649931;
        Wed, 08 Jan 2025 00:24:09 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([199.58.83.12])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181bb50esm189108406d6.89.2025.01.08.00.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 00:24:09 -0800 (PST)
Date: Wed, 8 Jan 2025 02:24:04 -0600
From: Glenn Washburn <development@efficientek.com>
To: linux-um <linux-um@lists.infradead.org>
Cc: Richard Weinberger <richard@nod.at>, Johannes Berg 
 <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: close_range is not available on older systems, preventing the
 building of a UML kernel
Message-ID: <20250108022404.05e0de1e@crass-HP-ZBook-15-G2>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_002411_879429_03E9B766 
X-CRM114-Status: GOOD (  11.95  )
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

Hi all,

I'm wanting to build a UML kernel on Debian bullseye, which is at
kernel version 5.10, which does not support close_range(). It appears
as though close_range() support is required on the host since commit
32e8eaf263d ("um: use execveat to create userspace MMs"). Was there a
conscious decision to break support for kernels less than 5.11, when
close_range() was added. What is the policy on support of the host
kernel? Since 5.4 is still supported as a longterm release. I think it
would be nice to at least support 5.4. Is there any interest in
removing this restriction?

Also, this system is at glibc 2.31, which does not have execveat()
support, which is required by that same commit above. Since execveat()
has been supported since 3.19, this kernel should support it. Perhaps
the issue can be resolved by defining a syscall wrapper in the UM
headers if support is not found in glibc.

Glenn

