Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C787DCD5BAC
	for <linux-um@archiver.kernel.org>; Sat, 23 May 2026 10:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1dyS+M/daJJ0p+CMZXykovqcqcs90fDCCGX+ejHCgHw=; b=3yS3rWgd1q1q8+8XRm9OfQL/2f
	4WbRFFzBluCPuz1ZBwDfz54TuUVq+pyQQJZ9Cj4XUQpLgZol9yRcx6K+xyvKvr9iOey0N10dD75IN
	5jN7pOcqj10CdPPCK7+7zMxrXYPs0CITftSlhk+o5QqQuv2Yg2KsQUY7rA0+BLA9ELM/OfYlEGNrO
	I+LyAbJGHQzj2F3tP91ER5K1/fd9u1XknboHV9mqU+PSMYEMP+NZ27jUYZMdR6GEjSw7//HeK4PU3
	rhG0SWmSaunFeKJLTzfzxwqneO+mnrvpRQy8jI7voepHG5fhBayWHwE/EynGlBYmmXvzfJLhFc9kw
	nWwWMBaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQjBX-0000000D3va-3hwM;
	Sat, 23 May 2026 10:02:23 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQjBU-0000000D3v0-2H1N
	for linux-um@lists.infradead.org;
	Sat, 23 May 2026 10:02:21 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso7306196f8f.2
        for <linux-um@lists.infradead.org>; Sat, 23 May 2026 03:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779530538; x=1780135338; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dyS+M/daJJ0p+CMZXykovqcqcs90fDCCGX+ejHCgHw=;
        b=Oog1gf1b658XVCzPW/rBWrxzF1uDdyjmY7p/Nk4Ze4Y8Jx4kYWNaaNK66wqP/ljLTm
         5acrqzfcIsKuZLOmolZIFW19JdHgbyESxoN5E9hy3LoigQxpQrACL4uNA8CwqOIBtw0p
         Y/lFJr5KI2VSgtkUEZK9WLIOkmGhOTlIV0wuDUkFQKn1IFz9NWyJiFBILMWFvBcfrRjX
         0MspWABsUnrn8590fM5BlDkRAOZBaodDiRAGvO4KdOvVtr9YJrfHoBgnGOxVHLH4wdRf
         TWcsAYfBGMe2wuUoGTmTsVEwohe9Kd4degckYVEAfv5aXGIBv2IwjhICRZz+IkIQGYqY
         DYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779530538; x=1780135338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1dyS+M/daJJ0p+CMZXykovqcqcs90fDCCGX+ejHCgHw=;
        b=Y98FHBHz+VKa97INsOgR0F7l40xmsRkR/uooLGgqjRqDuwaKWsswuFVfXpKit4w1Ki
         4Qo6RJUi1vTXXVyLp4Fk+aLqiTbkkA7VnonMfcCXFNEx9Eki3HyzLFFth0v1ChhnQpV3
         GkgOEriV/Q8gDHtI+6lKEpVRoOs1mNHJC2Ju2LW9zNZXzs+QcsvubaeHbUqdrJxKF6jC
         dBjJQMNmHZ3lYiWWUPZ52xJsL8OKqbhOonJeaYTaA/fQwS82hVrjQbEvD/7FjzFMd2eT
         +4l5u/KiytSgSVYz/MWD3Y4r4MbrMEoAGfgTtt6gaoMqABKTG3InxUA/lZ0yuLUdFnkb
         Tziw==
X-Forwarded-Encrypted: i=1; AFNElJ+HcpGSPyRa7jBkCD8NgUim7boyIZYRH0Iz4fBmpUAAmYlx7LPKGHU8trCMmVesGQvtoi9+Xh8GYg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyXVHtA8C1Dkf6kxqmqXvmH3zea+vmkniXYEfev6BMJPfJF507B
	Ra8zUACklXF4dmBAD6fETQLHlGDU/KDv87YnYEf+GVRT8TIis9Yo80vV
X-Gm-Gg: Acq92OFroG1E8Ip5HD7JR3fQ5pjTqq3CHg8cGLtwc+BfTD4hscmZa11vQoKavPD5n1t
	Tk6/mV48wo1hc0s1NVlHlNMbmPMZX3wbk9m/qqsXuT4Y8Xo/VX+KOLEXYt2dqcUVYgaoF4ydI4C
	jmb9RqqxlOQdli9amdIeIi007H37sMlWX/cfw+O1OKJs4whD9v4uZykWqfpfImnnNwNxLVYaoxE
	kMpNabBOlvduo030NJzBEUkqPz7aOkUsuq1U1wSZ2Z8dfNZHbiy6x+ICJllBPYiIW46DiOsEa7R
	Veg+VeLOVa10bd0R/vuPK3AjxBhLNbnNCv+phbGPZseENtwQX5u0/mnSeilMORn3uiWCARcc+Jf
	e1Ra7rroyv5T9FRvoh0YIptc+/XeKuArURmBOWnQQrAtZvq6vfPbqOHpJKkjL2dk/B0UcbD8rKw
	7uwsbQOFRkFgWDEKmHlxNDSBNbDtBQ/A6/7DbL6nT36f55A4WOApK5RhYNs4XeKPpG0dYbB9Dy+
	Pn7LEImjIa5Uw==
X-Received: by 2002:a05:6000:4283:b0:43d:50c:6f33 with SMTP id ffacd0b85a97d-45eb38badbcmr11789586f8f.26.1779530538082;
        Sat, 23 May 2026 03:02:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6ccd211sm14335557f8f.10.2026.05.23.03.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 03:02:17 -0700 (PDT)
Date: Sat, 23 May 2026 11:02:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Richard Weinberger" <richard@nod.at>, "Anton Ivanov"
 <anton.ivanov@cambridgegreys.com>, "Johannes Berg"
 <johannes@sipsolutions.net>, "Thomas Gleixner" <tglx@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Will Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, "Yury Norov" <yury.norov@gmail.com>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>, "Boris Ostrovsky"
 <boris.ostrovsky@oracle.com>, "Alexander Usyskin"
 <alexander.usyskin@intel.com>, "Anthony L Nguyen"
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH 8/8] x86: simplify 32-bit instruction set selection
Message-ID: <20260523110216.2724bf6b@pumpkin>
In-Reply-To: <9789e44c-cad6-4fb9-b684-ed132347a92d@app.fastmail.com>
References: <20260522141959.1071595-1-arnd@kernel.org>
	<20260522141959.1071595-9-arnd@kernel.org>
	<20260522223349.155dfe20@pumpkin>
	<9789e44c-cad6-4fb9-b684-ed132347a92d@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260523_030220_605945_8FAEB69F 
X-CRM114-Status: GOOD (  13.56  )
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

On Sat, 23 May 2026 10:51:41 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Fri, May 22, 2026, at 23:33, David Laight wrote:
...
> > But neither is really anything like even Sandy bridge.  
> 
> Sandy Bridge was well into the 64-bit era. Even when that was
> new, you wouldn't have run a 32-bit kernel on it (or cared
> about CPU optimizations if you did). For x86-64 there is no
> CPU selection and we just always build with -mtune=generic.
> This works well with any out-of-order microarchitecture.

For some reason I was thinking the same mtune list would apply to 64bit
(even though some would clearly be pointless).

I probably got fooled by you saying that the other ten are aliases.

-- David

> 
>        Arnd


