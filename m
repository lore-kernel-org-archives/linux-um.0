Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCxhU-0003Bg-O4
 for linux-um@lists.infradead.org; Thu, 18 Oct 2018 02:06:14 +0000
Received: by mail-ot1-x344.google.com with SMTP id 14so24258510oth.2
 for <linux-um@lists.infradead.org>; Wed, 17 Oct 2018 19:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <42737f55-0d42-dffe-7b34-e24666e713a0@infradead.org>
In-Reply-To: <42737f55-0d42-dffe-7b34-e24666e713a0@infradead.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 17 Oct 2018 19:05:49 -0700
Message-ID: <CAFd5g440GaxOzii9pXF6ykmeT3ihUFduG8EpbRXCMpTLROPhtQ@mail.gmail.com>
Subject: Re: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
 testing framework
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: brakmo@fb.com, richard@nod.at, mpe@ellerman.id.au, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, jdike@addtoit.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rostedt@goodmis.org, linux-um@lists.infradead.org, Julia Lawall <julia.lawall@lip6.fr>, mcgrof@kernel.org, Joel Stanley <joel@jms.id.au>, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, joe@perches.com, shuah@kernel.org, khilman@baylibre.com, kunit-dev@googlegroups.com

On Wed, Oct 17, 2018 at 4:12 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/16/18 4:50 PM, Brendan Higgins wrote:
> > This patch set proposes KUnit, a lightweight unit testing and mocking
> > framework for the Linux kernel.
>
> Hi,
>
> Just a general comment:
>
> Documentation/process/submitting-patches.rst says:
> <<Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour.>>
>

Thanks! I will fix this in the next revision.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

