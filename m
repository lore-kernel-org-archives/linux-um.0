Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-by2nam03on0093.outbound.protection.outlook.com
 ([104.47.42.93] helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fnq6g-0008Do-OH
 for linux-um@lists.infradead.org; Thu, 09 Aug 2018 18:56:24 +0000
Date: Thu, 9 Aug 2018 11:56:04 -0700
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v6 4/4] MIPS: Workaround GCC __builtin_unreachable
 reordering bug
Message-ID: <20180809185604.qqamyfd3etdacy3a@pburton-laptop>
References: <20180809174444.31705-1-paul.burton@mips.com>
 <20180809174444.31705-5-paul.burton@mips.com>
 <CAK8P3a2WVrPc0yu3SXL4qRHsC0C8y=t_4srEy1ELdSBYx4ME=w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a2WVrPc0yu3SXL4qRHsC0C8y=t_4srEy1ELdSBYx4ME=w@mail.gmail.com>
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
To: Arnd Bergmann <arnd@arndb.de>, Matthew Fortune <mfortune@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, Ralf Baechle <ralf@linux-mips.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, James Hogan <jhogan@kernel.org>, Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>

Hi Arnd,

On Thu, Aug 09, 2018 at 08:12:27PM +0200, Arnd Bergmann wrote:
> On Thu, Aug 9, 2018 at 7:45 PM Paul Burton <paul.burton@mips.com> wrote:
> 
> > +/*
> > + * With GCC v4.5 onwards can use __builtin_unreachable to indicate to the
> > + * compiler that a particular code path will never be hit. This allows it to be
> > + * optimised out of the generated binary.
> > + *
> > + * Unfortunately GCC from at least v4.9.2 to current head of tree as of May
> > + * 2016 suffer from a bug that can lead to instructions from beyond an
> 
> Has anything happened to address this in gcc in the meantime?
> Could you update this text to reflect whatever is in current gcc-9?

Good question. I can reproduce the problem using the test case from [1]
using both GCC 6.4.0 & 7.3.0, but 8.1.0 generates wildly different code
which looks good.

Nothing relevant is listed in the release notes for GCC 8.x though, and
I can't see anything obvious in gcc's commit logs. It doesn't looks like
the fix Robert suggested went in. So I don't know whether current GCC's
have resolved the problem or just get lucky enough not to hit it with
the existing testcase.

I've copied Matthew (GCC MIPS maintainer) in case he has any relevant
information.

Thanks,
    Paul

[1] https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

