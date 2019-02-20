Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwLTG-0004gD-OP
 for linux-um@lists.infradead.org; Wed, 20 Feb 2019 06:35:08 +0000
Received: by mail-ot1-x341.google.com with SMTP id 98so38530215oty.1
 for <linux-um@lists.infradead.org>; Tue, 19 Feb 2019 22:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <a6ae907e-391b-993e-6011-6f40c761b339@gmail.com>
In-Reply-To: <a6ae907e-391b-993e-6011-6f40c761b339@gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 19 Feb 2019 22:34:54 -0800
Message-ID: <CAFd5g44AmF6eN-HKwHOqPiGZHNc2K_wAmWR3PkV0OX-=YNUKDw@mail.gmail.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
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
To: Frank Rowand <frowand.list@gmail.com>
Cc: brakmo@fb.com, Petr Mladek <pmladek@suse.com>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Richard Weinberger <richard@nod.at>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, Jeff Dike <jdike@addtoit.com>, dan.carpenter@oracle.com, devicetree <devicetree@vger.kernel.org>, "Bird," Timothy" <Tim.Bird@sony.com>, Kees Cook <keescook@google.com>," linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>, Kevin Hilman <khilman@baylibre.com>

On Mon, Feb 18, 2019 at 12:02 PM Frank Rowand <frowand.list@gmail.com> wrote:
<snip>
> I have not read through the patches in any detail.  I have read some of
> the code to try to understand the patches to the devicetree unit tests.
> So that may limit how valid my comments below are.

No problem.

>
> I found the code difficult to read in places where it should have been
> much simpler to read.  Structuring the code in a pseudo object oriented
> style meant that everywhere in a code path that I encountered a dynamic
> function call, I had to go find where that dynamic function call was
> initialized (and being the cautious person that I am, verify that
> no where else was the value of that dynamic function call).  With
> primitive vi and tags, that search would have instead just been a
> simple key press (or at worst a few keys) if hard coded function
> calls were done instead of dynamic function calls.  In the code paths
> that I looked at, I did not see any case of a dynamic function being
> anything other than the value it was originally initialized as.
> There may be such cases, I did not read the entire patch set.  There
> may also be cases envisioned in the architects mind of how this
> flexibility may be of future value.  Dunno.

Yeah, a lot of it is intended to make architecture specific
implementations and some other future work easier. Some of it is also
for testing purposes. Admittedly some is for neither reason, but given
the heavy usage elsewhere, I figured there was no harm since it was
all private internal usage anyway.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

