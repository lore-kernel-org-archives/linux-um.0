Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1is0lI-00047l-EC
 for linux-um@lists.infradead.org; Thu, 16 Jan 2020 08:44:25 +0000
Received: by mail-qk1-x741.google.com with SMTP id x129so18361969qke.8
 for <linux-um@lists.infradead.org>; Thu, 16 Jan 2020 00:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
In-Reply-To: <20200115182816.33892-1-trishalfonso@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 16 Jan 2020 09:44:08 +0100
Message-ID: <CACT4Y+bPzRbWw-dPQkLVENPKy_DBdjrbSce0f6XE3=W7RhfhBA@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
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
To: Patricia Alfonso <trishalfonso@google.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, anton.ivanov@cambridgegreys.com

On Wed, Jan 15, 2020 at 7:28 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
> +config KASAN_SHADOW_OFFSET
> +       hex
> +       depends on KASAN
> +       default 0x100000000000
> +       help
> +         This is the offset at which the ~2.25TB of shadow memory is
> +         initialized and used by KASAN for memory debugging. The default
> +         is 0x100000000000.

What are restrictions on this value?
In user-space we use 0x7fff8000 as a base (just below 2GB) and it's
extremely profitable wrt codegen since it fits into immediate of most
instructions.
We can load and add the base with a short instruction:
    2d8c: 48 81 c2 00 80 ff 7f    add    $0x7fff8000,%rdx
Or even add base, load shadow and check it with a single 7-byte instruction:
     1e4: 80 b8 00 80 ff 7f 00    cmpb   $0x0,0x7fff8000(%rax)

While with the large base, it takes 10 bytes just to load the const
into a register (current x86 KASAN codegen):
ffffffff81001571: 48 b8 00 00 00 00 00 fc ff df    movabs
$0xdffffc0000000000,%rax
Most instructions don't have 8-byte immediates, so then we separately
need to add/load/check.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

