Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltcLo-007hIL-TQ
 for linux-um@lists.infradead.org; Wed, 16 Jun 2021 20:41:30 +0000
Received: by mail-pj1-x102a.google.com with SMTP id
 fy24-20020a17090b0218b029016c5a59021fso4773944pjb.0
 for <linux-um@lists.infradead.org>; Wed, 16 Jun 2021 13:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210522044241.2763088-1-davidgow@google.com>
 <20210522044241.2763088-3-davidgow@google.com>
In-Reply-To: <20210522044241.2763088-3-davidgow@google.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 16 Jun 2021 13:41:16 -0700
Message-ID: <CAFd5g46jOwV5iZretZEHOuxTbSvNxan-VSiN7genAXkhgbksAg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kunit: Remove the unused all_tests.config
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
To: David Gow <davidgow@google.com>
Cc: Shuah Khan <shuah@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, KUnit Development <kunit-dev@googlegroups.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, May 21, 2021 at 9:43 PM David Gow <davidgow@google.com> wrote:
>
> This isn't used anywhere. While it's possible that people were manually
> referencing it, the new default config (in default.config in the same
> path) provides equivalent functionality.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

