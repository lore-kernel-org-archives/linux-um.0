Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFB3CD5BB3
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 21:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z9LGZE9LUGiUFHbvTe+3X1oZ8+Pw+tBYCwgcLVodZ8Q=; b=JwaSu+zun3oR9GgVpdQitikN2o
	OHeE05JhIuNyWP4Sbd9njcEHp7g4ofmvygKUjppW35dtMb4g2yYHaRVjReDkmxwdxNlP1F/4+uvFG
	S5/ONvXVqZVDYh6c87OhgRgHqgbY6fINvEoKhVlGNLjU4fq79nzh0zVS81TTHKa+V64beUdt6/VE+
	wDEOMQf3Cf3prR1G/q7OxV8VZ6MUWbz61yWDsvZwTNtIBbtNQM4yXUmDGSpzs95+4ET5/NhdPTaql
	eAMVRkzQBm7Z8XfnQbY/zwBS6mcfS6hGEvms5QL3KhASmN4k3Nosr0N89+U6CCVVd+rzyhsTFO51q
	59rV+mNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQXVE-0000000C0II-3HYJ;
	Fri, 22 May 2026 21:33:56 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQXVC-0000000C0HJ-0CPy
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 21:33:55 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso58857775e9.1
        for <linux-um@lists.infradead.org>; Fri, 22 May 2026 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779485632; x=1780090432; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9LGZE9LUGiUFHbvTe+3X1oZ8+Pw+tBYCwgcLVodZ8Q=;
        b=VLF6zh9+5oeCsZbMHcY3GHWZB1haVZ20uj5GULNpkSoK0/vZsRUXy9qQzupSOKF/k4
         TGk58dr5aTIIzkMxjZH0w3wbOZYp+vJFgnR/Q3MMtUBhSkEaIQCeJ4ebx+VcFJt/UooM
         96KoOO0qsDew6xXm9A1iurZQWMD5ch6QH2QZQmwx05KPdWYblww17QR+fOY92MAjzTAj
         JjJipiktfyfHl/wHnIzCgID/eiNMAfOcAK5SxNq9vHMa93MWnUi7OdNd3q630JFfU1+O
         ewPHx+ajvtgRcOpo5EQCr0AWWQ4e7RjfXwXzfMWBNtOjAtZl5XAvdAdVz6bLC2Os3Ua8
         MCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779485632; x=1780090432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z9LGZE9LUGiUFHbvTe+3X1oZ8+Pw+tBYCwgcLVodZ8Q=;
        b=StNnuqBY/OEbkq5FzceyLR0nQM2u9BL78DVlx/0ZpH8VCaJx5mOsrUYCOe4dPvu0NY
         YZxrsiGk9ECbBa2IXcA9xMH7/ML1GPuBqNfg5/Ntuddk4bFG6Yv9vbfHuh1ZHbPmVLGZ
         aj5di2fIy/b+1x4XNylFHWOYWRM8EeOC7lSlm2Lhab4PNzsvBe2vcmAcaLucv7nP7CEP
         gPOxtfhMUz/AO5gHlGfsN0cpIQTGFEeTXMHw+b3issw1TgROpSZJdgCAT5fD10T31Da7
         /KhSeK6XtrYO57HyhjM+CLi0mzTSWRPZ0NDPZR+eoWN42pKLxDPWdZYvRCMrRAYNkYDv
         y6Ew==
X-Forwarded-Encrypted: i=1; AFNElJ+JvevoaSn3ufmPY622eYJkS2ovwMRKHgmuN9FPb62MnpcUTwVRYgGZ2TYt94PHC3ZaGNgmsEivVQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzEISYEy4JXmwyOoDG5UAw0OVXR5FpjDh63U8QsOzJCBb0N4irv
	zWP2leT5uYOEFCLrKqahVQqSO3UqA3rXtk2wNnWlX75bL4SyFf2JQQ4h
X-Gm-Gg: Acq92OHAtt7kL/Ro3Uz3kt+HcvMCHwxVeeQaHv4+xBbVGmcAEsgJ+iBgF01jZCzyhEM
	4PqDdMcF4nU6AnKo46sGcCHM/mk3yFq3A1aezEnCM+rHWCTyyz5U7+D+P2m++1LIjGLg/mIQJo5
	/jdrR/2ZLoU2lMs2pqAPZEya6oGMm7cRRpvbDICz9Kz4CVuxR6fm29ksWV4tgbNFFuFJJYX+lQ9
	Kf+zoUfmXU0mtI6czhmpYLyDZtgAmHO6piyw4sZmHeo+xL+1B6UGN5H1X+nF7l7qPVUY03LScP6
	eYzonnxP+3d8CdM8I8dTH2b3t4s5KnBC04xjOurgvW4oAkJK1ZSmgzM/wA9g4Ts3+pMltE6/afu
	zW2z3I6aG+e7g4rdRzE7rygcyzVuExktLFerNHLyAC5I4l//uE8pB7jMFpqxXFtbkxVnFoSedKX
	Pmh0WHVwiyzslJiCaJL3pNmdGTvoYswKUUXkrB3k4dHqO4EXrmwLkUKJkK8W5GRwjpkBjD+xCTt
	ODiwX2G2dnflw==
X-Received: by 2002:a05:600c:4706:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-49042487e09mr73282765e9.4.1779485631817;
        Fri, 22 May 2026 14:33:51 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045282201sm77281575e9.8.2026.05.22.14.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:33:51 -0700 (PDT)
Date: Fri, 22 May 2026 22:33:49 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon
 <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Alexander Usyskin <alexander.usyskin@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH 8/8] x86: simplify 32-bit instruction set selection
Message-ID: <20260522223349.155dfe20@pumpkin>
In-Reply-To: <20260522141959.1071595-9-arnd@kernel.org>
References: <20260522141959.1071595-1-arnd@kernel.org>
	<20260522141959.1071595-9-arnd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_143354_138494_B8623C54 
X-CRM114-Status: GOOD (  11.08  )
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

On Fri, 22 May 2026 16:19:59 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
...
> Change the CPU selection to build everything with either -march=i586
> or -march=i686 and make the specific options only change the -mtune=
> parameter where this was previously handled by -march=. Note that
> the only -mtune= options that gcc or clang understand for x86-32
> are i486, pentium, pentiumpro, pentium4, atom, geode, k6 and athlon,
> the other ten are just aliases for one of them.

Hmmm... That rather implies there is nothing for anything designed
in the last 20 years.
No wonder code generation choices look strange at times.

You don't want to pick p4, so I guess either p-pro or athlon?
But neither is really anything like even Sandy bridge.

-- David

