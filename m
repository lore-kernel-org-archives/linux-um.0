Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPoUf-00CigP-82
	for linux-um@lists.infradead.org; Sun, 21 Aug 2022 17:12:17 +0000
Received: by mail-ej1-x62d.google.com with SMTP id gb36so17193573ejc.10
        for <linux-um@lists.infradead.org>; Sun, 21 Aug 2022 10:12:06 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id l26-20020aa7cada000000b0043ba437fe04sm6798959edt.78.2022.08.21.10.12.03
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Aug 2022 10:12:03 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id k17so4514850wmr.2
        for <linux-um@lists.infradead.org>; Sun, 21 Aug 2022 10:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQJFc9AnH_9CW+bSRotkKvOmkO9jq-RF6dmyPYOpq691Yg@mail.gmail.com>
 <20220819190640.2763586-1-ndesaulniers@google.com>
In-Reply-To: <20220819190640.2763586-1-ndesaulniers@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Aug 2022 10:11:46 -0700
Message-ID: <CAHk-=whLcuvDDS3rZfEgDrwbdJrTx8HCRNiZ5cDc80-_gzHCxw@mail.gmail.com>
Subject: Re: [PATCH v2] asm goto: eradicate CC_HAS_ASM_GOTO
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, kvm@vger.kernel.org, llvm@lists.linux.dev, Alexandre Belloni <alexandre.belloni@bootlin.com>, Borislav Petkov <bp@suse.de>, Alexei Starovoitov <alexei.starovoitov@gmail.com>

Applied directly, just because I love seeing old nasty stuff like this go away.

             Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

