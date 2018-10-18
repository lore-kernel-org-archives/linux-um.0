Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-23-brendanhiggins@google.com> <CABGGiswwS9NJJ__WVgimcFUiTy_76AtDOxeSbSuv-oz1xjjD5w@mail.gmail.com>
In-Reply-To: <CABGGiswwS9NJJ__WVgimcFUiTy_76AtDOxeSbSuv-oz1xjjD5w@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 17 Oct 2018 18:32:27 -0700
Message-ID: <CAFd5g44v3BrRYosoFhD8iP4nxEKdJJ=VjhN3aMexOtWJ87WX-g@mail.gmail.com>
Subject: Re: [RFC v1 22/31] kunit: mock: add the concept of spyable functions
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: rob.herring@linaro.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Kees Cook <keescook@google.com>, mcgrof@kernel.org, shuah@kernel.org, Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com, rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com, Julia Lawall <julia.lawall@lip6.fr>, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

On Wed, Oct 17, 2018 at 3:47 PM Rob Herring <rob.herring@linaro.org> wrote:
>
> On Tue, Oct 16, 2018 at 6:54 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Adds the concept of spying like in Mockito
> > (http://static.javadoc.io/org.mockito/mockito-core/2.20.0/org/mockito/Mockito.html#spy-T-).
> > This allows a function declaration to be labled as spyable which allows
> > the function to be mocked *and* to allow the mock to invoke the original
> > function definition.
>
> We can already hook into arbitrary functions ftrace. Wouldn't
> utilizing that simplify features like this and avoid having to touch
> existing code for testing? Not sure what it would take to enable
> ftrace on UML. It is at least partially compiler dependent.

Regardless of what we end up doing, this definitely needs more work.

After looking at include/linux/ftrace.h, it does look feasible to use
ftrace for spying. I totally agree that we don't want to reinvent this
wheel if we can avoid it, but I have no idea what getting it working
on UML would look like. Dependence on compiler features could be an
issue: pretty much anyone who can build the kernel should be able to
run our tests.

