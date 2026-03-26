Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134AC10A62F9
	for <linux-um@archiver.kernel.org>; Thu, 26 Mar 2026 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jv2EfhMbcWOA2sU2awQXAMiSQ1dwjbJBc3BzfW+6rZQ=; b=yBE1PUmEJqzXWMdBvAQBXr+nur
	p/GINcklfiRpE6Dbp3dO8aFHew951p+XTl0oGeLxvWL9rtuwX0lY6ijAZ8x2P5ddzImxOfdXUh2Fk
	KYgpSNLeg2i4x5b71tUYLjasKj2rYDd4u3aNws8WV3iTkWr2a5mPOWZik1tQIgHNCl7+eejr70Lce
	+LQE7EPXlqWrw2Ok3mM445Y/fL3w+4ZRQe08cjtoklluzASapfRzCDvQRa7rk58Cq2nHJQihwq2yn
	IJV4OqnVJF+5Xotk5KsZDtDi7SlRnS7IgQednncPawqXWAbB175rszbTBeeMuNuIPjyAafXUyKyEu
	X3esOaQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5lkM-00000005eW0-38Vs;
	Thu, 26 Mar 2026 14:31:42 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5lkH-00000005eSA-2GoH
	for linux-um@lists.infradead.org;
	Thu, 26 Mar 2026 14:31:38 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-43b87970468so1033231f8f.3
        for <linux-um@lists.infradead.org>; Thu, 26 Mar 2026 07:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774535492; x=1775140292; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jv2EfhMbcWOA2sU2awQXAMiSQ1dwjbJBc3BzfW+6rZQ=;
        b=FVSZE9XIRQrqa4G1JJlw6XGNaK8Cl5vDDhPIFbLFasRkI0ENAksXG8XhiPcrOukSVO
         Or26RZqpYWh2vbY0wt1Z5AVaOZ0yNid9EAfFvKqtFS159Co+ZDl8ilma7WpX05FdZG6V
         UDB4E9sioA/W2iocL9CcbKyY1i9gKIx7Z/WQ6J/G1FHfYfN5u13jHsMK6kVUm/7wrY5M
         EfWrj7Us+t4fJQDbgtA+nA0HDRp24d3hY0JAlxn+ipnDuzXZVrbBSS/bJxmECRNWkhGN
         ZYBcE9rAU2kaTv3hLgV4Q/ptmKCj5Q4krnzrYEXCnLNzL6yXaSI+J7TVD/1MGt87LoXw
         ba9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774535492; x=1775140292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jv2EfhMbcWOA2sU2awQXAMiSQ1dwjbJBc3BzfW+6rZQ=;
        b=LynZNV9BDcX7xWZQFo4MMaM6aJGdGpzlPyQjygIPYk+mTXdWIPTUrwmFVzXl83TfYS
         Wx6b5PBNpBOXCR+dFLi1xONoQh3kbnWCBHCBYX03TXJLOThbLKuTeynWJk+I7v4mHidI
         gR7n5Xslr4sFUbsNiYtCbaOd2JMlosZW+5IiAJtkqGo8O1s8+10LIB2G5plwPYXKY446
         1+AKYmn1e2xvTfu24QOXuBr3kv41DQiwnE6rfSNh54e+KoGwkaX9nhRlyfs8phfkbQpo
         W2ykjNM1FlClnO04SU7hZqLGjUGg9ze43jGnoB7g4I/hZ4k7xdHVyQ+8PJD5xYDH8b02
         swFg==
X-Forwarded-Encrypted: i=1; AJvYcCUyI9Xp954lCSDgiQenCmBBd+V3+4YlB/iZB9b7k67g5wGB22zH7f7w5OyTBgTogH9gtoKPGA80xg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxF8JaPLXGuLeD1ui0r7nRfi33JL693FWJQxjEcBA1+HzANHuLh
	Dk6LHzVXgodBtPeKq0H9kKQ5CL8m+g8o7OqD1gq6ytebHh2JNYMyify3
X-Gm-Gg: ATEYQzzUtJIO6suxYpPKbbigh3RZftGfgto6oubbJBznoUbNSx6ru8QsSKz8voOPTxj
	DBy2POj7I5k4/jeObEXL1phnmlpVGP5c4ZD5sXtaDZDBQWbGKGCr5vpQ3AaELqf6pMXmC95Q4el
	t4AM4FaJ1Cr7FuADpSzuno4yezMxXvwTl/WLCa2wVSm4K24iirK23YCse9eKR/VTQRgdOA7BYwr
	BTOxkGVIOwJ6jh17aBjUAEqKTgyWcNoOP++IX4TiG4Ra329E04y6rtO7bHoTsICvFMsRT1IjgB6
	jPLmIFPwSwpcLwi5kgAXcaHFNBOvtoMawyfbdb130/jmgw+bdlf6IlrqvPfORHnJNddBfCYtYoC
	KIssAdOxUfg+hM+9pzzyrsfe7qURRTzCgiyXSAj8dztQ4SXGs+oDrVQqqX6zEdyLHGtSSMZbNMD
	S1Rq7BJcMASvG4Goq+u0ttB8yexUdigymWzgwY
X-Received: by 2002:a05:6000:4381:b0:43b:5672:f02 with SMTP id ffacd0b85a97d-43b88a21651mr11427910f8f.7.1774535491079;
        Thu, 26 Mar 2026 07:31:31 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:d2a7::cebd? ([2001:871:22a:d2a7::cebd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e528sm8063097f8f.1.2026.03.26.07.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 07:31:29 -0700 (PDT)
Message-ID: <9cf5a94c-0f37-446c-b63d-ddac5674d220@gmail.com>
Date: Thu, 26 Mar 2026 15:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Ard Biesheuvel <ardb@kernel.org>,
 Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, acourbot@nvidia.com,
 akpm@linux-foundation.org, anton.ivanov@cambridgegreys.com,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
 david@davidgow.net, gary@garyguo.net, johannes@sipsolutions.net,
 justinstitt@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-um@lists.infradead.org, llvm@lists.linux.dev,
 lossin@kernel.org, mark.rutland@arm.com, mmaurer@google.com,
 morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 nicolas.schier@linux.dev, nsc@kernel.org, peterz@infradead.org,
 richard@nod.at, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 urezki@gmail.com
References: <20260322192159.88138-1-ojeda@kernel.org>
 <20260323000327.111235-1-ojeda@kernel.org>
 <acEP7tl8pqFA3tK8@shell.armlinux.org.uk> <acUGAsjYvNvTEO92@google.com>
 <CANiq72mzPpkELXis1CiSbKUmBXNQYMiMmjj-7-sYiLh4T_JSOQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <CANiq72mzPpkELXis1CiSbKUmBXNQYMiMmjj-7-sYiLh4T_JSOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_073137_590979_075A222A 
X-CRM114-Status: GOOD (  15.27  )
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

Hi Miguel,

On 3/26/26 2:47 PM, Miguel Ojeda wrote:
> On Thu, Mar 26, 2026 at 11:10 AM Alice Ryhl <aliceryhl@google.com> wrote:
>>
>> I noticed that the Makefile currently uses the arm-unknown-linux-gnueabi
>> target. It should probably not be -linux target to avoid this? Probably
>> it should just be armv7a-none-eabi, right? We gate HAVE_RUST on
>> CPU_32v7, so we should not need to consider the other variants.
> 
> I think Christian tried several targets back then and eventually
> picked that one.
> 
> Christian: what was the reason to pick the `-linux-` one? e.g. was
> there something you wanted to rely on that target spec that you
> couldn't enable or disable via `rustc` flags or similar?

It should probably be fine to use armv7a-none-eabi. I've mostly used
arm-unknown-linux-gnueabi since I though it needed to match the
bindgen-target (which is -linux-gnu for all architectures) and 
because from what I understand clang also uses arm-linux-gnueabi [1].
Also when I selected the target I thought that we would also support
armv6, but since I had no v6 hardware to test on I disabled it.
[1]: https://github.com/Rust-for-Linux/linux/blob/rust-next/scripts/Makefile.clang#L4

Cheers,
Christian

