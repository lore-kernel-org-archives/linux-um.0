Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4433109E550
	for <linux-um@archiver.kernel.org>; Thu, 26 Mar 2026 05:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GAsmk2Bxir/aEOlCq/1mI6TxB8tMf98VYj7NlGYlXuE=; b=3D3BWENZCerIS9Kk1q57Y2gdCu
	hoTrEY7VsRHnx+jG7+iaYm7TD9XSFRZ1FjUQp+rp1i/oMuwi/rceqoFebpki21efYo2ZU72Lw4USc
	S78iq8jTzSQS0YXC+bwV+96H+f5Qo1KPlpVWBUtSqRjjULwWf++grfyZWxg6Jzze/xyihU9Khwy9X
	KKHCV0bb/8Pv41z7M4HRldqAebzfbNjG0eRzdpzFyzXdHZuSoJdxJAPdcH0LS8WBo2Y32LzKIMZvw
	CSA5S9jOOpn20vG3RDYq4lizf3160Bw0BEk+D3boOb2Sr35Wzqg7d8L4uUVAIYsspD5NEeuwW2dZY
	2eCSnayA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5dN2-00000004kOB-20zB;
	Thu, 26 Mar 2026 05:35:04 +0000
Received: from sphereful.davidgow.net ([2404:9400:4:0:216:3eff:fee2:5328])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5dMw-00000004kKh-2U5N;
	Thu, 26 Mar 2026 05:35:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1774503290;
	bh=n9xjHtpRhSH9ix3QmcQLv0kr4+Yq4N4rwcbqb/HE28g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ijgkR2m3ExNXd2ith8CSWReGK6oM8F+dwRcN39lTcaP5QRKaFSL2C7Hry7+WTcTEv
	 fLpTTixlufdp1FjAzY91YETdJPIkJX4CotIeLNltvQQtmbQtiCcat3dkq1K4Zrmen4
	 CyP5KubsCneIzrox4OAoqDPlgNa+NVpW5z5LDiHaIz97yCpqANNeyMaKJ20XZIxG6u
	 QkTrXwsfgas7w8i1czLe2DPYmWhBAMAMhIi7Msai1TXaJueYxcUnvaAvggh4ucfvor
	 OsD0RXxdk6gO6vEcb5XRybbtwrtonLUphRvS5J0fqDqQcvdzQWR1mRFsdJYP3XkzS2
	 enIVECQ4Vc98dzvMEYyAMNhUtG3rqKX7K7KePl8F6UaRWzBSDNn++WsPQev9REGcM6
	 laduIln+ZZSR8TC1YcIwLA/Q2bPL75jVfD3O2itd+XFwK0VxfsGRe+iz+YQ+aEPlIA
	 HsY2uKAjaVrx4f2w2Pr8OjOKJDAyiYTpgovWbnYQwDvEvCTUt4z+7RYiH4JxgBxfcU
	 4YAkQwlBf+M+ki5fPPkEP9kWsuxjHBI14t2LQZModPKQOGUEJbc9/gOubHm4p1UIW6
	 CBIA3YoVUd5FpHd/lWaVxfhzkPeuVcE0FwfC+ck3tgnNaLDNhjw6tjLdyl5M7BfRkn
	 KeCU8ffvDKTc6ch+pcecUYn0=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 7E1AF1E8338; Thu, 26 Mar 2026 13:34:50 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1774503287;
	bh=n9xjHtpRhSH9ix3QmcQLv0kr4+Yq4N4rwcbqb/HE28g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ldcLAgFv276uo5NW6LPy7yICCVgujhSzmWWh6jq+0as7zdXji4UzHT6jmt4Pz/+33
	 S3izhb/lP9G6bwJL2/2H1qTs2LUaVuCj/ABRbszrZp4q62JjEXq55nTfRp2SvLuI9R
	 fm906bBysocD7LOT3MwsI7/Yswz4Tiu7PEgJoKZ1suCr2uP3hzygBpq9Y/uHrCvnlV
	 hL320KohBE1/nJw3XzMRLlA2C6A8q7IH7kiC+wl1eGgKbZUpqeffPGP1oYo0M96OJC
	 b7+eOTWzv4JyqwtBOF8ElsXU3R7ytXb6QQaJ6JxxljEQwj2nIYkCAf94e9nYx5u4JE
	 4903DdFW1gSuzq8xO+jxBKsA7ZEGlu1on8XW++IES/3QjXnfMvh/tT99aAmzDk70mK
	 Q12zsoXnahHRQZEKsNXsV7IS8i6e64DETF7+FG/6LFPOLnJzdxuyTYZMWVs6YLIIDG
	 aFSeffc9zYPYLL5KHnYpKyLYtJTLbeBA1SbKt6JO1LkMj8NOUC7hfwUzjxN/oHDv2z
	 3/L5hJqEG8WzvGUCwLtLeVT2cCVUWYkRhKzxdIUzYLENGP4vUxvX5aCNKe1wTm38eG
	 Uoepqbm42xqept2Sy0Ah2AWCkqIRpUM2alnyL+hUrW0AW3Nejd9c4XWG434jAvhFQB
	 SI3cbpjzbw15rKzFZT3TjCdA=
Received: from [IPV6:2001:8003:8824:9e00:6d16:7ef9:c827:387c] (unknown [IPv6:2001:8003:8824:9e00:6d16:7ef9:c827:387c])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id DC56A1E737C;
	Thu, 26 Mar 2026 13:34:46 +0800 (AWST)
Message-ID: <e6bcf016-4739-4ba4-a46c-c0416c07400f@davidgow.net>
Date: Thu, 26 Mar 2026 13:34:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Russell King <linux@armlinux.org.uk>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, aliceryhl@google.com
Cc: linux-um@lists.infradead.org, llvm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
 a.hindborg@kernel.org, acourbot@nvidia.com, akpm@linux-foundation.org,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
 gary@garyguo.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lossin@kernel.org, mark.rutland@arm.com, mmaurer@google.com,
 nicolas.schier@linux.dev, peterz@infradead.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu, urezki@gmail.com,
 will@kernel.org
References: <20260203-inline-helpers-v2-0-beb8547a03c9@google.com>
 <20260322192159.88138-1-ojeda@kernel.org>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260322192159.88138-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_223459_831425_1E8FB9C7 
X-CRM114-Status: GOOD (  17.76  )
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

Le 23/03/2026 à 3:21 AM, Miguel Ojeda a écrit :
> On Tue, 03 Feb 2026 11:34:07 +0000 Alice Ryhl <aliceryhl@google.com> wrote:
>>
>> To get rid of these helper symbols, provide functionality to inline
>> helpers into Rust using llvm-link. This option complements full LTO, by
>> being much cheaper and avoiding incompatibility with BTF.
> 
> I have been testing this. I think we can go ahead with it, with a few
> notes.
> 
> I will reply to a couple other bindings in separate emails to avoid
> spamming people too much.
> 
>    - I will mark the Kconfig option as "(EXPERIMENTAL)", since that is
>      what the commit message says and it allows us to be a bit
>      conservative.
> 
> 
>    - Clang passes `-Werror=unused-command-line-argument`, which means
>      under arm (i.e. 32-bit) we get:
> 
>        clang: error: argument unused during compilation: '-U arm' [-Werror,-Wunused-command-line-argument]
> 
>      And under UML I see:
> 
>        clang: error: argument unused during compilation: '-I ./arch/um/include/shared' [-Werror,-Wunused-command-line-argument]
>        clang: error: argument unused during compilation: '-I ./arch/x86/um/shared' [-Werror,-Wunused-command-line-argument]
>        clang: error: argument unused during compilation: '-I ./arch/um/include/shared/skas' [-Werror,-Wunused-command-line-argument]
> 
>      So we would need e.g. `-Wno-unused-command-line-argument` there
>      close to the `-Wno-override-module` one, unless Kbuild or
>      ClangBuiltLinux thinks it is important to keep it for this case.
> 
>      On the other hand, regardless of whether we fix this (and another
>      issue in a separate email found thanks to the UML build), we could
>      instead add `depends on` listing explicitly the architectures where
>      this is going to be actually tested. That way maintainers can decide
>      whether they want to support it when they are ready. Thoughts?
> 
>      Cc'ing Nathan, Nicolas, Nick, Bill, Justin, David, UML, ARM.
I'm quite happy personally to just have 
-Wno-unused-command-line-argument here, given that it otherwise is 
working pretty well on UML and 32-bit UML.

That being said, I expect it won't get a lot of testing (regardless of 
architecture) while it's hidden behind CONFIG_EXPERT.

Cheers,
-- David

