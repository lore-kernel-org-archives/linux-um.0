Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C2BCD13D3
	for <linux-um@archiver.kernel.org>; Thu, 30 Apr 2026 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4cHFP+eNWcXFLm2JPg/pPVlADeLLzz8lJF7iSdVxtPU=; b=clQhymR9xuLRcftAs2EGsDzYjq
	Q4fzu2OZu6EDEQIFp7iQyUmbzEkT+W1dIB5eePTmckMBti7KxV4EN2UEcbuuw03il/i2F4BMwzhHL
	56L3QLEASq2MZ3aku8P58ukYtd6D+Ub6BNi4P8NCPPa54HH10b20TXfc9WjdG/wd6+9k1MmjCh7Gu
	354t4U4/thmt1T8YqQ3PGj5HYiBk5fZsvIrcf21mIZQTFbaCotCl/FCYwSp+yaRDKLzRJEWkujKwI
	ywX2agIHiaEYuiLQpNE9qF3qqXGmVZlTbqRsqu/wx9sb6Dd2fXdSrCn9vySkUeT00DbkVIZE+Mzs6
	ns5HNl6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYFP-00000005w1b-3TLP;
	Thu, 30 Apr 2026 20:44:35 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYFN-00000005w1F-3eb6
	for linux-um@lists.infradead.org;
	Thu, 30 Apr 2026 20:44:34 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-12db2e9b3bcso134126c88.3
        for <linux-um@lists.infradead.org>; Thu, 30 Apr 2026 13:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777581873; cv=none;
        d=google.com; s=arc-20240605;
        b=Dzj+L3k+jKvJlnHnsWI+vKOQM1t8nmYmhbQlSD7howcvmxMB3Bv+2qlZI/Kx/ZhNhA
         0McgrHvEZC38PhIjFQfqP7v6vPgIJJu5AEc0of/aiEM4Gz+uO82KVgV/wlubdAa2KJbo
         RqFSmck2FtDcKtfeIHo1JQbVfInOfxktMmqDZZXM4kK7rfmcdbfCIYnY1Pfi0RdV5SC3
         ALjQIzdHka+Hd83ISZUoSrUTTfDBaSxp9stbQTMxhRmTNnUsojeB9lioIZbo53Lgq1uo
         K38pIpjpe4y1JQmEkvbLWuzn5U2Lx7FQ6hb/z81KOsToygiSaKOtjbxteTP+pCYraQEH
         L4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4cHFP+eNWcXFLm2JPg/pPVlADeLLzz8lJF7iSdVxtPU=;
        fh=3Qje+IOmtPqrwKrmR5ISYkddFJn/M6Rz4zUzThq2VbE=;
        b=JIq3QipkZVVxzChX/TOKSyJWUiB/FGTFuzcvqeJZENLO/iJWdnfRjG9kQrGHRrqMBd
         1qNwnGS+NCeGKFn1deVxH6UR9GJ/SAz977Ngt0WvbT1cruLnbJDz5lb9P0uf8IXpyDqX
         3M9bwTqSOjkLyTQRpfkCGy0aTr3una9mfAIWTS4mZ2rguzHrC4OrYWyTtVvIB4NGmIPR
         prZQ5MW/x5U+rRM5kWokD/AD9g4clZu34UjzpQ7kB6mpnM7aXdzaGkhnHPSrTQlRFuT4
         8aiNUjhTQ9jkmqlt/s+djC54jJDD7XbdXuAB8ijYCi/B3QBp4MBsraILvDQTPy6C23uU
         6Aiw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777581873; x=1778186673; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cHFP+eNWcXFLm2JPg/pPVlADeLLzz8lJF7iSdVxtPU=;
        b=VRgZokY9IEQQFACz4POWtvq2DD6tltGuNKmFXY1dvBmDYenNktz5TQXepTpXo0QaJq
         i9hJmnxsfnhRD2evi76+W4XePvwwJnjLqiuxlXHuzfjrVqhukHkGavVDpI4iEiACFucO
         QJ4235UDpHqWpQE580hT2qo1TOlwLvwiI6hetF2eL4bFQVpBC65/clDaCSqNiL6DK42O
         CCaA+gRTQdYQc0/y7u1LeuJfOB/AANQyt9OaKhRJAETleGFUA2wi1yVj3gV9tGS2uFVM
         nmbAA8p+4s1P8VMqdM4pmox0CpZQPmRXsjh43c3JHeWfUB2I8ZSSC374NF+qiJAmm5Er
         lTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777581873; x=1778186673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4cHFP+eNWcXFLm2JPg/pPVlADeLLzz8lJF7iSdVxtPU=;
        b=MFiYpVEGCUPt8YLwx/B2+1XZrgtEGomCEGokDqfV6FudOiIYOd3jm/vorAS7uAGiJc
         iwmn5u/1kHFzreYfJKtSeuiM5qc8E03el8jVsGgWKb8UXGMLFyw1jjnSiTDSzJeHpA/n
         289eoW6s4+JAjHND5TsL4rdzRm9Y6AvPuXVo8TfTa7FnReRlTxdDCrQKorfoCLJI+HVX
         dEIwDNnDWqe8gY4kDcm0zsyEe6fGugwOzHdSGqVj6cu6nS0fpiZxfRHgs58IJ68HtWS4
         2EDVpNueCQTyoQ7DW8G4m/kQ4hKtMD3rcpaOiAQDYR+1p7/wrneCQAvltKgb6M+2doFf
         +vdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kqKBZ9dlzP6kEZHId/EQOleqyrtr2up3w3xmknaTzSJOp5zpoSU6lrO4w9Q2ko35+o6/9zMv9kg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZTegzYi+Hh8J14EgA5wriLQEkPboECJn0mcSP3b+YuAFxTYaw
	rp1E97GGc3AlTGjcEFpw7bjTBABD0o4uBXfTRNuNUxhBbRhN1LBNIVU3ol9f1KnZttq8D8eJWJF
	ecE3mNempegUGWhyEeLhI/r4/wFsH3aA1lFE3
X-Gm-Gg: AeBDiesoo2+6vLnKw7o2sUjflpkFaOdvkGc+y6JDcw884jR+O2s/Vwrq5CT1E2gW5da
	o7Ej38C6Ureicp7FaRj3aw9ZZhMQ52ckyWBbNeZXbi8NvWijthIWoVFZ01EiDXx5cwnB717My+k
	A43GiR8/BUM96HS/BaLyBvtTN7Kvd8TYLH6Ga3aVhSWpJVHgMvCHny0AdekKAQAjz8uZZS9JPqp
	FTFN1PzzjOa4c3//D2dUQj8DzPK/CqKxd7IZCk1CIaHJKKMB/tdaz5TA/bEuH9IGPsX5acvv4x0
	ZXWjAoG9xgL/Yyn7c0Q8GvQSlYiWcAb/j5JT3R99DzfWpTJD6Ks0DJbRMVA1ItAR5/vQUW8fniX
	X3IaDRagCZHvYVL1IhvCMulRochvRi5QE0A==
X-Received: by 2002:a05:7301:5803:b0:2ea:de28:f389 with SMTP id
 5a478bee46e88-2ed3ef6ebd6mr954333eec.8.1777581872817; Thu, 30 Apr 2026
 13:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260425034125.53866-1-david@davidgow.net>
In-Reply-To: <20260425034125.53866-1-david@davidgow.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 30 Apr 2026 22:44:20 +0200
X-Gm-Features: AVHnY4LGNlzdRDP_FsWKzkzH4XH-Svm4aorK1yvmu0rhL8bxBKxh7t8QCy8fXW4
Message-ID: <CANiq72m_wJuy6XyPpZ8+BrF_kQTDH8bST2=C1-vcNcKGN4S-2A@mail.gmail.com>
Subject: Re: [PATCH] rust: arch:um: Fix building 32-bit UML with GCC
To: David Gow <david@davidgow.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	rust-for-linux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_134433_913832_0081FDA8 
X-CRM114-Status: GOOD (  12.36  )
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

On Sat, Apr 25, 2026 at 5:42=E2=80=AFAM David Gow <david@davidgow.net> wrot=
e:
>
> 32-bit UML builds can be configured either by setting CONFIG_64BIT=3Dn or
> with SUBARCH=3Di386. Both work with Rust-for-Linux when clang is the
> compiler, but when SUBARCH=3Di386, we don't set a bindgen target correctl=
y if
> gcc is the compiler.
>
> Add the appropriate bindgen target configuration for i386, as is done in
> Makefile.clang.
>
> Fixes: ab0f4cedc355 ("arch: um: rust: Add i386 support for Rust")
> Signed-off-by: David Gow <david@davidgow.net>

Applied to `rust-fixes` -- thanks!

    [ For reference, the errors look like:

            BINDGEN rust/bindings/bindings_generated.rs
          error: unsupported option '-mno-sse' for target ''
          ...
          error: unknown target triple 'unknown'
          panicked at .../bindgen-0.72.1/ir/context.rs:562:15:
          libclang error; possible causes include:
          ...

        - Miguel ]

    [ Added space in title. - Miguel ]

(I left the comment as-is to keep the match from `Makefile.clang`).

Cheers,
Miguel

