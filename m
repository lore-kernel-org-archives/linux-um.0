Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCuaz-0007jz-Fy
 for linux-um@lists.infradead.org; Wed, 17 Oct 2018 22:47:19 +0000
Received: by mail-wr1-x441.google.com with SMTP id a13-v6so31467547wrt.5
 for <linux-um@lists.infradead.org>; Wed, 17 Oct 2018 15:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-23-brendanhiggins@google.com>
In-Reply-To: <20181016235120.138227-23-brendanhiggins@google.com>
From: Rob Herring <rob.herring@linaro.org>
Date: Wed, 17 Oct 2018 17:46:54 -0500
Message-ID: <CABGGiswwS9NJJ__WVgimcFUiTy_76AtDOxeSbSuv-oz1xjjD5w@mail.gmail.com>
Subject: Re: [RFC v1 22/31] kunit: mock: add the concept of spyable functions
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
To: brendanhiggins@google.com
Cc: brakmo@fb.com, richard@nod.at, Michael Ellerman <mpe@ellerman.id.au>, Tim.Bird@sony.com, keescook@google.com, jdike@addtoit.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-um@lists.infradead.org, Julia Lawall <julia.lawall@lip6.fr>, mcgrof@kernel.org, joel@jms.id.au, linux-kselftest@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, shuah@kernel.org, khilman@baylibre.com, kunit-dev@googlegroups.com

On Tue, Oct 16, 2018 at 6:54 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Adds the concept of spying like in Mockito
> (http://static.javadoc.io/org.mockito/mockito-core/2.20.0/org/mockito/Mockito.html#spy-T-).
> This allows a function declaration to be labled as spyable which allows
> the function to be mocked *and* to allow the mock to invoke the original
> function definition.

We can already hook into arbitrary functions ftrace. Wouldn't
utilizing that simplify features like this and avoid having to touch
existing code for testing? Not sure what it would take to enable
ftrace on UML. It is at least partially compiler dependent.

Rob

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

