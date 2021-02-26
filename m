Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFkBI-0006kf-Nz
 for linux-um@lists.infradead.org; Fri, 26 Feb 2021 20:57:49 +0000
Received: by mail-pf1-x42b.google.com with SMTP id w18so7064187pfu.9
 for <linux-um@lists.infradead.org>; Fri, 26 Feb 2021 12:57:45 -0800 (PST)
MIME-Version: 1.0
References: <20210209071034.3268897-1-davidgow@google.com>
In-Reply-To: <20210209071034.3268897-1-davidgow@google.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 26 Feb 2021 12:57:32 -0800
Message-ID: <CAFd5g47=Tzsj+yw6Poj47Y68__eYnrWhOxfSmvCLwsgBvfn8vQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Disable PAGE_POISONING under --alltests
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
Cc: linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Vlastimil Babka <vbabka@suse.cz>, KUnit Development <kunit-dev@googlegroups.com>

On Mon, Feb 8, 2021 at 11:10 PM David Gow <davidgow@google.com> wrote:
>
> kunit_tool maintains a list of config options which are broken under
> UML, which we exclude from an otherwise 'make ARCH=um allyesconfig'
> build used to run all tests with the --alltests option.
>
> Something in UML allyesconfig is causing segfaults when page poisining
> is enabled (and is poisoning with a non-zero value). Previously, this
> didn't occur, as allyesconfig enabled the CONFIG_PAGE_POISONING_ZERO
> option, which worked around the problem by zeroing memory. This option
> has since been removed, and memory is now poisoned with 0xAA, which
> triggers segfaults in many different codepaths, preventing UML from
> booting.
>
> Note that we have to disable both CONFIG_PAGE_POISONING and
> CONFIG_DEBUG_PAGEALLOC, as the latter will 'select' the former on
> architectures (such as UML) which don't implement __kernel_map_pages().
>
> Ideally, we'd fix this properly by tracking down the real root cause,
> but since this is breaking KUnit's --alltests feature, it's worth
> disabling there in the meantime so the kernel can boot to the point
> where tests can actually run.
>
> Fixes: f289041ed4 ("mm, page_poison: remove CONFIG_PAGE_POISONING_ZERO")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

