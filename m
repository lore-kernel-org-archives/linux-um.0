Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltcHV-007fuA-UM
 for linux-um@lists.infradead.org; Wed, 16 Jun 2021 20:37:03 +0000
Received: by mail-pf1-x42f.google.com with SMTP id g6so3186756pfq.1
 for <linux-um@lists.infradead.org>; Wed, 16 Jun 2021 13:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210522044241.2763088-1-davidgow@google.com>
 <20210522044241.2763088-2-davidgow@google.com>
In-Reply-To: <20210522044241.2763088-2-davidgow@google.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 16 Jun 2021 13:36:46 -0700
Message-ID: <CAFd5g44-zP7VWwBMxSMv=PNPQWNHB-y90kQ4E8WVqs2mWCE2dQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kunit: Move default config from arch/um ->
 tools/testing/kunit
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
Cc: Shuah Khan <shuah@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Jonathan Corbet <corbet@lwn.net>, KUnit Development <kunit-dev@googlegroups.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, May 21, 2021 at 9:43 PM David Gow <davidgow@google.com> wrote:
>
> The default .kunitconfig file is currently kept in
> arch/um/configs/kunit_defconfig, but -- with the impending QEMU patch
> -- will no-longer be exclusively used for UML-based kernels.
>
> Move it alongside the other KUnit configs in
> tools/testing/kunit/configs, and give it a name which matches the
> existing all_tests.config and broken_on_uml.config files.
>
> Also update the Getting Started documentation to point to the new file.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

