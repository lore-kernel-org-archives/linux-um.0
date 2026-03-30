Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8472B1061B23
	for <linux-um@archiver.kernel.org>; Mon, 30 Mar 2026 21:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zlsVcWSeeIpbPnsSYMwOt0k3yfDPRs+s8ihr0jHypXY=; b=X430XVFSrgNbLQdNYUpD2rrXSC
	R7EepIhG04ppHWvJcoDDJ33q+XPk5Qax7laqrJAKu175pW7zKLwKyK5G2CtYltjbLWav0C4jDKWjp
	2CvK5k7Sh/lw95jPeMpEN5AM7rygES+K+VZEb+5kL8yU5jVSPfbaR1qqJ/X9Fl7Rl2jzZWJcRz3WJ
	hiCOQK60PE86Y75fMX024yx8TPFcEGdLBSbe4s7zdUWhPErahujRg9CzqTTBKT8XWB1Uc2piz4ovs
	cqQXX4lEUqjZ6/bTbjjZ3YGVum8R6WG5ySE8Yk4ldSHjwPmOki2xXu9uoDs/97CSXDV8beO2w6ew1
	J+VdHrBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7JrN-0000000BtB5-046X;
	Mon, 30 Mar 2026 21:09:21 +0000
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7JrJ-0000000Bt9H-41yl
	for linux-um@lists.infradead.org;
	Mon, 30 Mar 2026 21:09:19 +0000
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-56cde757d3dso1662583e0c.2
        for <linux-um@lists.infradead.org>; Mon, 30 Mar 2026 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774904956; x=1775509756; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zlsVcWSeeIpbPnsSYMwOt0k3yfDPRs+s8ihr0jHypXY=;
        b=EZwA6/ua8aWp8U89w0Uaq1+YR7XRPVIPXSlf8ZQYEokpKwBmoz15lAbzdk1tOAjeeO
         6fYC2BH3rITBQ53fft+z/p68XiWxUDHrwSp+g9+M93rwVBkp5xPe1v+tqeEDKQDvNDPM
         P0oi0/sAfj8b3pXCKRcFdv+ZiHvoVBVIDootoNKwdzzmVWrz0+VpOb6XNa5XUblU47Br
         bmRkwNN8KDO+VJl71KtiGItTf/hgVy++6kW1LrJ38tNbswZ5U8M69ZowAc3rWSnytAdc
         l/iueRMVVLk+NiLBKvpSLM15Q/tr1eWo3seFI1OeUfEXJX1LgcAfzkFWcVFSRmrdSE3z
         krMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774904956; x=1775509756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlsVcWSeeIpbPnsSYMwOt0k3yfDPRs+s8ihr0jHypXY=;
        b=CoKUXSZeCNGlecgVo+vQfcN7LYyJfrhuDm6kwAlgA/Wgi3RJO0Gi9CtzBDrk+m7gNv
         +m79Yi7RlD3oa7DexI661/raXRj8uO44jVlRS+cjKfJq8h9/oHA8eM8h6UnAMTBwJeY1
         XtQdzNky88agyri44VSBjDFMlY+mElJbhE8WHTWY1sHiqIYW5IsKayM8dnzeD/kqXnNW
         IFcH2376SidIeeyVIf5ZTc7NbpjrpRpv+AuEErdxOSs7PCaUSkQDDj1eFJtQ0GbtTw8g
         QnxlMtvracATt7EaO68ZBg+E+r1WXD1aX0MBye+7I8sPdl79e9FBhyZYObjD8zMsBuFn
         4YUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmQ7ivw4RHIyHiABzlqpsqCWgKaPNnhtWg1/Wb4MQkFWO8DpWWuDTwbKWcJwd+cV9CVLyqAmmb0Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzq2s6rgqPZhaTo+hOjCU7wWyDFaX0Tq+autrYuI2kE2SXkMO0/
	hIxdURqDRdnRMTfu4xeIm/8EQr5qWq+YDMNQf5abfVXaT3w6LIeXQl41
X-Gm-Gg: ATEYQzybYxvj8zYrXtQR2ZJUOdOckhmSp/uGtecGPponimgaloBQrtkCOjYe02J7/ad
	xprKQziOmKANPq9fYnGMinB577GnfOs7mQO8ROyajDsqsgPEomUgIMmwTIYg1KkVZStdvcbp4c7
	vr+oH/j8aaoVwXVXgJ7IP+kMHM5hNBEQXM4pvRXWFYPbxidfhZg3Dizmo/MaQTzqFkSSmFb0od7
	p5ODAOBxCDGFzJdfLlUVZ8kui2SGZFu/DTinVqPP3MgWI8enXy3o2WXFnNaGNoIINOQ6J+AT/sj
	siiRfi8CJ68IfYb+7y830n0n1ZUez9m1QaQR7uhdQ+sUBueFWHlHgMPOOGxVXgk4OvMQrcbCkzX
	UzxpecjFx/mZJk7b4iBMtzXTiflZhatzEdCAQW+8j086VnxN4uDEaOZKclrf7hB+6T8bVp/bY/n
	oVlaJzxPAdp5P4A2YpICyxlv/4/Bdp9NZbDKo2
X-Received: by 2002:a05:6122:3c44:b0:56b:9ba4:1372 with SMTP id 71dfb90a1353d-56d4a5f8c0emr5672211e0c.9.1774904956234;
        Mon, 30 Mar 2026 14:09:16 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:d2a7::cebd? ([2001:871:22a:d2a7::cebd])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a333c9sm9989448e0c.13.2026.03.30.14.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 14:09:15 -0700 (PDT)
Message-ID: <f159850d-5fe6-4329-9703-b355305fd106@gmail.com>
Date: Mon, 30 Mar 2026 23:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Alice Ryhl <aliceryhl@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jamie Cunliffe
 <Jamie.Cunliffe@arm.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Miguel Ojeda <ojeda@kernel.org>,
 a.hindborg@kernel.org, acourbot@nvidia.com, akpm@linux-foundation.org,
 anton.ivanov@cambridgegreys.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, dakr@kernel.org, david@davidgow.net, gary@garyguo.net,
 johannes@sipsolutions.net, justinstitt@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-um@lists.infradead.org, llvm@lists.linux.dev, lossin@kernel.org,
 mark.rutland@arm.com, mmaurer@google.com, morbo@google.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 nicolas.schier@linux.dev, nsc@kernel.org, peterz@infradead.org,
 richard@nod.at, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 urezki@gmail.com
References: <20260322192159.88138-1-ojeda@kernel.org>
 <20260323000327.111235-1-ojeda@kernel.org>
 <acEP7tl8pqFA3tK8@shell.armlinux.org.uk> <acUGAsjYvNvTEO92@google.com>
 <CANiq72mzPpkELXis1CiSbKUmBXNQYMiMmjj-7-sYiLh4T_JSOQ@mail.gmail.com>
 <9cf5a94c-0f37-446c-b63d-ddac5674d220@gmail.com>
 <acVOL5Psz6kHlhq2@shell.armlinux.org.uk>
 <CANiq72=b+cr7Stxph_hXQTmD5crCvwWTqdaGKOJ7W1-66v4i_w@mail.gmail.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <CANiq72=b+cr7Stxph_hXQTmD5crCvwWTqdaGKOJ7W1-66v4i_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260330_140918_002613_83AC3747 
X-CRM114-Status: GOOD (  13.71  )
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

On 3/26/26 6:30 PM, Miguel Ojeda wrote:
> On Thu, Mar 26, 2026 at 4:18 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
>>
>> I'm not sure if this is still true, but I believe it used to be the case
>> that the -linux-gnueabi target has one behaviour for enums (fixed size)
>> whereas -none-eabi, the size of the type depends on the range of values
>> included in the enum.
>>
>> Certianly, when Arm Ltd were proposing EABI, EABI had the latter
>> behaviour, and I think there were cases where Linux used "enum" in
>> its UAPI.
> 
> Short enums? I see `c-enum-min-bits` in the armv7a-none-eabi built-in
> `rustc` target, and indeed:
> 
>     #![no_std]
> 
>     #[repr(C)]
>     enum T {
>         A,
>         B,
>     }
> 
>     pub static S: usize = core::mem::size_of::<T>();
> 
> is 1 for that one, and 4 for the other.

I guess we could use a custom target spec, but I'm not
sure if that is worth the hassle of adding another one.

Cheers,
Christian


