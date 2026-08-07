Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC2FC5AC7C
	for <linux-um@archiver.kernel.org>; Fri,  7 Aug 2026 06:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ZZb4uA/vUP3DFegyRJn+OPpJApz2OlWvu9RoArL4Bs=; b=y4pPMy2EChCmYO5YEhD+IeWLs4
	9/M2ncDWz174PM7niCnbN3dH69zb+59ObMr5TVhi5f/v8MsIsr/1+KHkn1CFYT45hSNS/4GnGr1RL
	JW3mzvqsDeMF5rr6fvjafgcC0CEXo5YZUZD3HAuhAhawUEJBamOIqRdsptmTqNX5UVUOK5Ba5sPU1
	RD3u01NB151pMt68aNTvXnR1KcpfNgLEU7HNx5pXShNgPD0BltqUCybAw1eq59HguQqa8kuCbSUnc
	3qkbXyM2/Pv7rufVyrL/bchFgyZnipZHkTLtndXCvmPF5N/r3abM7pLsH8JUMGSTLI53POPZuns2j
	Zuas2Skw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsERs-00000007C80-3etJ;
	Fri, 07 Aug 2026 06:52:56 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsERq-00000007C7h-1hBN
	for linux-um@lists.infradead.org;
	Fri, 07 Aug 2026 06:52:55 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-cb20b0a387bso317108a12.0
        for <linux-um@lists.infradead.org>; Thu, 06 Aug 2026 23:52:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786085573; cv=none;
        d=google.com; s=arc-20260327;
        b=EunhCiAUo0alZlcDFF7hH8oa1iZMaHv5WyxtJZPu7z7dUnrW4T+lnIZju3bZNTcl55
         0kuS31C2OELrFxWeMcacsOqe2vMJ2cJA+gvSySMKSoe+z9GjxM9EO6IePEUgRZ3jvy2g
         nfmI9umH/0jnngWZxjmRiSOJf0CfX11M+oih/smuARy/+I7eTHZ4qWvXY5XrjL+BskCe
         j8vy96prtKVP7yJVmI0x5iUyAdleenrcFXccsw3iyA/6rNqXUC3QmZkgSKPMPA9dS9tK
         xBJZh7/ULmJzTgev4b2tC/IbRFvyLz4PgPow4Qc9708yN/DpYAOuANl9sCKwNHWmPHAi
         fuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ZZb4uA/vUP3DFegyRJn+OPpJApz2OlWvu9RoArL4Bs=;
        fh=2utben7IdcOzlqDXuBd3QqXlDkLdVEpJ6OyXzDZjos0=;
        b=idW2IYseMjDK4Hxlb5NQFSiuOk5SJHbY5JkEeOauk0XdFtVZhrlxrVwzvx9yaYose1
         qVNAiva+fY0bXQ1bKQE/8viykO8tG/XcXxbgX9hxiGi/oXrmhcefeCznlwJw8FjnNrwv
         HOSnmBh/oWYZtdvLNMOqhkMvBRq1lGHdf6LnND9KqeP+b2kiablNMZFnpFSHJc2d940z
         COklat2JXfg9KXZpcEBcgtYO8sk2O5LAXvUnhecoArfsL4Vu7Rs/CyXMRFEieyZdY1/p
         gwpi+fH5x01KJADWEWszT6iPewSVzkmk1k/bbbgN924XPl3O4RVCvgaySkafVoXtJARV
         Xhdw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786085573; x=1786690373; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9ZZb4uA/vUP3DFegyRJn+OPpJApz2OlWvu9RoArL4Bs=;
        b=LnPXAdWMRuzX0GDusJIeJS0RNpNZCtmTCli9hFv1PcmMVigLUZsqDaKj9D4qQH1GL8
         kj/S7l3TgjCuOYEGMh19O57UrBH/PCYopfEg+QMn1IMrGcZCzIjcUIg9Kx0/A3U4C7Je
         IGYl653GitSbfW8Cv6XCDuKl5QERDzjrtYVXGnTTMDSxMFy8ScSZaDKBfub2EgZLkrc6
         9bfharc8TZh89KAIzgtcqRkAF3tpBtn9WMo6Ah+OXsVvhBa5djorQcQ7Dr+QgSp/g/tM
         HjwBNOjr3Cd/bTmHI+G6VjcsK8OtyLFAYXlGevzED6G0borcq1YS4y9nIciA9VW4Gvbh
         nnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786085573; x=1786690373;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ZZb4uA/vUP3DFegyRJn+OPpJApz2OlWvu9RoArL4Bs=;
        b=b2Rt774LP5HAvQ/NqG4533bpT4e8MRpOCs3cZfa88T1mjkzc9JJ8aHCfWsmQHHACyH
         xA5r1PlPNSfQbdtTUSD9xzJA2xdw7/HUDuFY4QO0HZ1n9JO2IHNZAYDrNzyuIz/3xq40
         mjVDpBn3+JliPnAVeCWD4xViQ65JM/W/J8MtZceQJLL0es0Bbbgpo3jQK2Bd6PxHUtti
         pVebKPZxsB2HUe2ubD1+HUy6VXHk7dMdnq7eSsHl2OlBekbnc0PLOgHOiMa8pvmB2hKE
         o8PDYPR7uZRIMxX7K08dR9JfmWFWMYWXoCNBmC1majcgyBSGKBxh+fXCKuo5qmCsTP9K
         O+FA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+kMki4PWzntkTj+kvffoiYCVa559uNX1SuEpNo9FOwDAC+RbRy59Xsz9A7rn04WEG7UaGoIT60w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4gOSmb1FAnWjzD7zJ/qdPcNUYLbmqumSqxVsufoKXKExXTnjH
	6bvJnc9TVmnpDiGYJ6/19PjNc5lANpm7Ti5X01DYIAG4+clSM4YjuAUv8AU0mVtljkDjI/efsc2
	AAizcPz5xm2vvQhwbPqAsWcN4SYJ2d6s=
X-Gm-Gg: AR+sD10g4K+wzqy2TYqGcU4p4ZS3dLk8eImqAxUs1wmz2Yw51Ow0anBSEsrEtZO76Bn
	RVGYaQ+P+D7eMNP+GR+Dbuo+amiUFgW6aQgbdx40j5uCN1vZNri8+bpRauJGFQZCUSjo3lO2HLv
	WRJvRJDYB+Bu2CiAoO5bGNv0ZQXiDi0yOOfylkEb6/FFZiiOfGmhaOM4bhzbbmBB9Rk4jzl/khc
	S2Bk+OMlvycoHpwA0/hTksimcGeOIIdIZLITXjtPzTVJgCSuGdiCFAUIZU9uDZIQVMO3RurYY4O
	okNkpxGz3IST+frpOtTDofCl3LGorW+p36dUHdl9yKjdfq+71PUJfuqXnmoIR/FEmc2dHQSh8wm
	7fFZUjzTbTwm1U3g/C8ST3wGaK8txEu+kkhflOBwR47/SRh7s6MNDhMEPi3EM
X-Received: by 2002:a17:903:184b:b0:2ca:ecf6:9105 with SMTP id
 d9443c01a7336-2d0ca6010d1mr169669205ad.1.1786085572579; Thu, 06 Aug 2026
 23:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260801022501.722493-1-tomo@flapping.org>
In-Reply-To: <20260801022501.722493-1-tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Aug 2026 08:52:38 +0200
X-Gm-Features: AUfX_mxj2A-IR7_iAbCUKcJ0mhFhqopvk-MPVA4_QBPaPZ6FidBVU90MxLk2040
Message-ID: <CANiq72kzmPnu_UPHryLMSwGMmTruirNUL5H+aD4tMiNUqqRELw@mail.gmail.com>
Subject: Re: [PATCH v1] rust: bug: fix warn_on macro build error on UML
To: FUJITA Tomonori <tomo@flapping.org>
Cc: ojeda@kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, a.hindborg@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	dakr@kernel.org, daniel.almeida@collabora.com, gary@garyguo.net, 
	lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev, 
	rust-for-linux@vger.kernel.org, linux-um@lists.infradead.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_235254_445884_895E3315 
X-CRM114-Status: UNSURE (   7.99  )
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

On Sat, Aug 1, 2026 at 5:41=E2=80=AFAM FUJITA Tomonori <tomo@flapping.org> =
wrote:
>
> Use the free function `as_char_ptr_in_const_context()` instead, as other =
exported macros already do.

I reproduced this and the fix works -- thanks Tomonori!

Do we need to use the free function? i.e. this is not a const context,
so should we do e.g.

    $crate::str::CStrExt::as_char_ptr

?

Also:

Cc: stable@vger.kernel.org

And Cc'ing David for UML in case he is interested.

Cheers,
Miguel

