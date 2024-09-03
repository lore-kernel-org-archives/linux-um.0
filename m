Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A89CD37AA
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 19:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KE5xWwHnPm+WIDf2FbxryrsTqOGezFO5SQcRnazmxKM=; b=evsDknkNsLYbCa4WudEcW7ZVRJ
	hEIb1kdVSKlNlSKfCnUjesM5lbUtDn+YXrHKawPkWiH8RavbF6GYSiHTsJKnCAP+M4NTOvwdQxNeY
	GGzlST45YlctgXPpEa/ifMjy6WxuMDbrzXbxehYOzK/dWy9lhd4T+ZjwiD5w6en0SoXHFpUk8MQQT
	jHKX+ASqoujTpTdMES5uBl/UJB/v9PPrlEWLbskA72FVfHUXi57rZuC95JVXIcptDljUpeCxt3YHX
	Gsufn6s6KbwTw0SsuzuRkCMTUpsxl3PHWtX+rm7fpMYWjHjR+mInvAZjRtJ/+kadgQKxsrTpMmOzH
	AynyyyGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slYmc-00000001Y1n-3Bs6;
	Tue, 03 Sep 2024 19:01:42 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slYmZ-00000001Y0s-2dWc
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 19:01:41 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2d8a9a15a7fso257296a91.0
        for <linux-um@lists.infradead.org>; Tue, 03 Sep 2024 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725390098; x=1725994898; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE5xWwHnPm+WIDf2FbxryrsTqOGezFO5SQcRnazmxKM=;
        b=jTk1WmmPSpbuSaQi4c4PDtud1pAhaphLTu6yKsZ/3U+qVzAHr/N1HpVpB5keedvvGn
         YQpN3AQvq0fIbGxSDcKCfiTUFXvxaWt1vIbSnAgXkKAxjLdWXE/vGUAT86RrrASULCGF
         n3Ekerk+Km2/2gePMEkeilnHF/ThlDMG6iLPLC5WG3ydfmSTtkIgXYpLdWtEy+sdxz/D
         hp1LvVgrPZxfuCuI9qpC586noLZR1bJ4p2/jh35vnfPpeSNZVtwtUTWIH2rmEoebkU6L
         UFD8Vt1jQD55d16S+gVEJBQQU9Frk6X+vizVIUI2vfK/ipIJeJ362iy93+vztPXvCvua
         u+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725390098; x=1725994898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE5xWwHnPm+WIDf2FbxryrsTqOGezFO5SQcRnazmxKM=;
        b=eTVhE1wb7rF3irvD7jDHQY6kUgvjbOFxsBbwHhrfopOdwU6swc6b40mRF+lwRE0VAa
         r+KNULTLdYZa/2ljqGeYB2E3LuE9CbSTBr2pVo4wyy3qdl27VfhYEZbV9bJC4AeIb7Yv
         Abusylpnij5LdYsk/X0FX0av3TViEaXCFSPk13aer929uwGXcUey98asYDYbsM2cxAEW
         G4GqskoDANwCJ9MN12FKBQyJ3H5cWcSjTs9YgWsSVBJvWFT6ntVQv8nwciCPw4xN4FSE
         O9ns9hNsL2szk8/DadEs5RHNTerHIXDshDJrKEmhv/6e4BUxQuLHQom8VpchxIxScX57
         GeFg==
X-Forwarded-Encrypted: i=1; AJvYcCXPXG02anIW1GNiJTtb9gwsPdxy17woDYuV015cfFVMRggeu8Dd1EQTQXJb5P7LV3QQoBxA87qwhQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwRQcYPkbQDj7qRgBcpJmtHan5+lu6Y7tFA9HnT0eubsdm6t/Th
	8rd/Zef4PGnuSFd0+nkPu//BpfqoJQJMQkIYmyVSZkTeiEBQQCdBKljdk+8O7uZfR2PCh+g0Mr9
	BKXVJ85wpD3nAw+W2JBiNIn+qmto=
X-Google-Smtp-Source: AGHT+IGRHnvtSIMPglv/36A6hpMPDiFKSZKiUYGzC4lWBAVbp+fP4jGwB7yTCWBdu31Z0QsqEhbQ0JnFGvwe1zJu2gc=
X-Received: by 2002:a17:90a:dd88:b0:2c9:863c:604 with SMTP id
 98e67ed59e1d1-2d86b82a57amr8603316a91.3.1725390098481; Tue, 03 Sep 2024
 12:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
 <20240903-mips-rust-v1-3-0fdf0b2fd58f@flygoat.com> <CANiq72=z1yJm-B_ie=GfueOF1qksaSD9txgFU1YQo2tZx0qQPg@mail.gmail.com>
 <d9591a84-9a0f-4046-9b2a-437061f6882b@app.fastmail.com> <CANiq72m5iFcqRU_qdUCZkoV8ayPhtQQq3TTEDRUYfMEsnNqTDg@mail.gmail.com>
 <6f6f04d7-55b3-4714-9bcd-cb4e1ae6c86a@app.fastmail.com>
In-Reply-To: <6f6f04d7-55b3-4714-9bcd-cb4e1ae6c86a@app.fastmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Sep 2024 21:01:23 +0200
Message-ID: <CANiq72mvTTgyTjDCWBz_kOdY1f4gopAtWxyC4P4c+Lr0YVkzLA@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: Enable for MIPS
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_120139_802881_E0261D5D 
X-CRM114-Status: GOOD (  13.63  )
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

On Tue, Sep 3, 2024 at 8:32=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.com=
> wrote:
>
> Ahh thanks for the elaboration.

You're welcome!

> However, kernel supports many ISA variants that are not defined by any ru=
st target
> triple, I'm not really sure if it's appropriate to define them all in ups=
tream.

They need to be in upstream Rust somehow, because upstream Rust does
not want to stabilize `target.json` since it is too tied to LLVM (as
far as we have been told). Whether that is via `-Ctarget-feature`, or a
new `-Cglobal-target-feature`, or specific flags like `-Zfixed-x18`
(originally `-Ctarget-feature=3D+reserve-x18`), or (many) new target
triples for different combinations, or something else, it depends on
the case and what upstream Rust wants to do.

That is why we should tell them what is needed, ideally in a new issue
in upstream Rust, and link it in
https://github.com/Rust-for-Linux/linux/issues/355 (please see that
list for similar examples).

I hope that explains a bit more the context.

Cheers,
Miguel

