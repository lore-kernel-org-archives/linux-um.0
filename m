Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYjku-00BqCm-K9
 for linux-um@lists.infradead.org; Tue, 20 Apr 2021 06:21:08 +0000
Received: by mail-pj1-x1035.google.com with SMTP id cu16so17270360pjb.4
 for <linux-um@lists.infradead.org>; Mon, 19 Apr 2021 23:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210419153213.1337562-1-zhuyifei1999@gmail.com>
 <546324c4e77ebe65f27b0f06fea3ace28dd75fe6.camel@sipsolutions.net>
 <CABqSeASZLeK8dq-75dcM51zmkHUteuJc07bS8ixKVhEAAeuPDw@mail.gmail.com>
 <CABqSeAQdwhJCTyO9w6f2cmyobh2bnA5wG6ZgCS9gD0b7ZSi=yw@mail.gmail.com>
In-Reply-To: <CABqSeAQdwhJCTyO9w6f2cmyobh2bnA5wG6ZgCS9gD0b7ZSi=yw@mail.gmail.com>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Tue, 20 Apr 2021 01:20:52 -0500
Message-ID: <CABqSeATFW7F3cJkm6t3h1yzJite8yCCbvAQZbafHk=+VbfHntQ@mail.gmail.com>
Subject: Re: [PATCH v2] um: Fix stack pointer alignment
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
To: Johannes Berg <johannes@sipsolutions.net>, Colin Ian King <colin.king@canonical.com>
Cc: linux-um@lists.infradead.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Benjamin Berg <benjamin@sipsolutions.net>

On Tue, Apr 20, 2021 at 12:47 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>   movaps (%rdx),%xmm0
>   movaps %xmm0,(%r12)
>
> The move from xmm0 to stack is omitted.

I looked into this a bit further and thought I should clarify, these
two instructions belong to `current_poll = next_poll`. AFAICT, `tmp =
current_poll` is compiled to:

  movabs $0x605198b0,%r12 ; <current_poll>
  [...]
  movabs 0x605198b8,%rax ; <current_poll+8>
  mov    (%r12),%rcx

and `next_poll = tmp` is:

  movabs %rax,0x605198a8 ; <next_poll+8>
  mov    %rcx,(%rdx)

So it uses two registers, rax and rcx to store tmp, rather than on the stack.

YiFei Zhu

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

