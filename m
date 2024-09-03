Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F712CD37AB
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 17:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DzpwJQwOT3F0kC0YR4xC7AP8eabN0PyPAbZ0DqFkPfA=; b=qZCnTthrqOyQJMA0JVi04fKdJJ
	//SvVwyzln066GE2U7Ne+EtOuKmEauTiS0tq5mgaLJMXzQUPbI7tzQc+vI0u9PgLMXYpU3/volIuF
	p+Urrx93IyWVKTzvBrGETa2CEp6/kNuzHqb66wWrz2dE8J6jXWm0ghFrGcvqzxhu81JhrvmYeqhAj
	0pRqTPeEGXVrAEvgZ3A8LEIE2MSG/6dTBaEjtvxrTq0/ROfyj7lEcdnhPBkjzTYlaQsz5i1tzyxKi
	g2+4jFf76jewCj9BIh5Tz+2bj23Z4BahkWLoCQn+UPXM4Z9VffT0/GVWG/25e0PenfgxfH+NAmhpS
	kFVPBxrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXZo-00000001LEo-3Ur1;
	Tue, 03 Sep 2024 17:44:24 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXZm-00000001LDJ-2LTr
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 17:44:23 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-71420e66ecfso448196b3a.0
        for <linux-um@lists.infradead.org>; Tue, 03 Sep 2024 10:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725385462; x=1725990262; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzpwJQwOT3F0kC0YR4xC7AP8eabN0PyPAbZ0DqFkPfA=;
        b=M2lYzgecnTGnpf8TNYrWiUcuBpF11EWTZI9ps40gzyZYfJFV3qSbrJ6vPTj5TX1Z1o
         tP7hIaa0aFHxlhzZXQtT4lwvl9h6eEy1q8Z/zhx9mRZzV+u0r9LdTOYuf1AMT9jCGAeI
         22SGu3xCX+JlZpS+DKVTXa8gfdEZmrv5cDIM1fHToLdr6l9VAEw0Jkcb2Iu3UZEb+6RW
         HiTCXN8Z5bV0Z39uyTzBRAf+HVXtofab+4Pvd8pqRDOAhM09UUw/6Bbxw63hCpoADTCz
         0+xQ/WZi4ISmCivWIcmctfzkEhvxlAzJdd37D3RC+3v2ff10F+1Fc67EJmDY3+BZ7rEb
         c/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725385462; x=1725990262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzpwJQwOT3F0kC0YR4xC7AP8eabN0PyPAbZ0DqFkPfA=;
        b=fOvsrEfIJ6MNiybz8tx5RSkObbxkzcw4si0y4arCUUQRw/3yaw1RKhsIyiTRillCzN
         yr/kV8DbhZgoZg8pmHgm2RBp3wxD5bWIDSjE72vGfSJVxkqZGJ7d+uQY2so0M9V+8mS6
         +eth8hp7miUegZj4CglARSbjg/aYVMwP0DCTAs1ujvZ00LIGV1FpXK50ucHk8QSt4Ieq
         hjWX1ao0lu9zr6nqueEEu0oxS+0DHbo0y7XtQ3Z8WUYAajFkSvmKahP+pF16U3QZibdn
         hddph2XTJA2bjISIMd9p/bYwLCDQgvsXhxbEMeQbYVNeF3I0eVmsCprUiRSzFUSineFT
         D9rA==
X-Forwarded-Encrypted: i=1; AJvYcCX8HemoaBCc3Vn7leKFD9xgeWJQwCWRH0bF43sTDyfXvgijEqG9fJM1ax5g57LKhq8gwhAP/NsTWQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzD5XN5XRsSq9tJDd73pwgKX3dwKCQlV1TDMPkwJKnJ5R/TQLMP
	hC4OJVlQcuWYWCkZd+/DP6Ak5g3at11HES0Wb2tzAfMPHhpb81srIRNG1MEM5HEz9PTLlQ9OmKa
	m8TLjADo10r3+BWtXfPZ86fpcezg=
X-Google-Smtp-Source: AGHT+IEr2msm5yg48J8o10JFNcKqa18Qf0QpuKetck9mzQgqKhHQ/7Pg+OEHdxchtehB6dyn3bXmyxfB4BSsSfVqxbo=
X-Received: by 2002:a05:6a00:1816:b0:70e:acd0:d8b6 with SMTP id
 d2e1a72fcca58-71730458903mr8460968b3a.0.1725385461577; Tue, 03 Sep 2024
 10:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com> <20240903-mips-rust-v1-3-0fdf0b2fd58f@flygoat.com>
In-Reply-To: <20240903-mips-rust-v1-3-0fdf0b2fd58f@flygoat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Sep 2024 19:44:08 +0200
Message-ID: <CANiq72=z1yJm-B_ie=GfueOF1qksaSD9txgFU1YQo2tZx0qQPg@mail.gmail.com>
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
	rust-for-linux@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_104422_617233_89FC2191 
X-CRM114-Status: GOOD (  12.77  )
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

On Tue, Sep 3, 2024 at 7:15=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.com=
> wrote:
>
> We don't use builtin target as there is no sutiable baremetal
> target for us that can cover all ISA variants supported by kernel.

Since we should try to go away from using `target.json`: what was not
possible to enable via e.g. `-Ctarget-features` or other flags? i.e. I
see the `+mips*` features there in the supported list, and from a
quick test the data layout also seems to match, but I assume I missed
something.

If it is not possible, then we should definitely ping upstream Rust about i=
t. :)

Cheers,
Miguel

