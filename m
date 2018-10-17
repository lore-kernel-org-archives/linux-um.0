Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCZJ9-0008RZ-7n
 for linux-um@lists.infradead.org; Wed, 17 Oct 2018 00:03:28 +0000
Received: by mail-ot1-x342.google.com with SMTP id q50so24429955otd.0
 for <linux-um@lists.infradead.org>; Tue, 16 Oct 2018 17:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-13-brendanhiggins@google.com>
 <bad13afe8c71860a85f12130a57fe9a96f017cf3.camel@perches.com>
In-Reply-To: <bad13afe8c71860a85f12130a57fe9a96f017cf3.camel@perches.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 16 Oct 2018 17:03:01 -0700
Message-ID: <CAFd5g44VQqJVhUPQLHWzaXMbjJeGNs2nDZYTmzQ8OV7dyTXfVg@mail.gmail.com>
Subject: Re: [RFC v1 12/31] checkpatch: added support for struct MOCK(foo)
 syntax
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
To: joe@perches.com
Cc: brakmo@fb.com, richard@nod.at, mpe@ellerman.id.au, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, jdike@addtoit.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rostedt@goodmis.org, linux-um@lists.infradead.org, julia.lawall@lip6.fr, mcgrof@kernel.org, Joel Stanley <joel@jms.id.au>, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, shuah@kernel.org, khilman@baylibre.com, kunit-dev@googlegroups.com

On Tue, Oct 16, 2018 at 4:59 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2018-10-16 at 16:51 -0700, Brendan Higgins wrote:
> > This adds struct MOCK(foo) as a NonptrType so that it is recognized
> > correctly in declarations.
>
> I think this commit message is lacking context.

Oh sorry, you are right. We added macros for generating mocks from
types, so we decided to name the generated mock types struct MOCK(foo)
(where the base type is struct foo); this commit makes checkpatch not
complain at this new syntax.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

