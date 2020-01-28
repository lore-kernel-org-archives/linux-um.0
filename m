Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-mw2nam10on2096.outbound.protection.outlook.com
 ([40.107.94.96] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwWeJ-00040E-1F
 for linux-um@lists.infradead.org; Tue, 28 Jan 2020 19:35:48 +0000
From: <Tim.Bird@sony.com>
Subject: RE: [RFC v1 0/6] kunit: create a centralized executor to dispatch
 all KUnit tests
Date: Tue, 28 Jan 2020 19:35:36 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF982C9840@USCULXMSG17.am.sony.com>
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20200106224022.GX11244@42.do-not-panic.com>
 <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
 <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com>
 <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
 <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com>
In-Reply-To: <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: frowand.list@gmail.com, brendanhiggins@google.com
Cc: logang@deltatee.com, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org, sboyd@kernel.org, richard@nod.at, jdike@addtoit.com, knut.omang@oracle.com, linux-kernel@vger.kernel.org, rppt@linux.ibm.com, linux-um@lists.infradead.org, mcgrof@kernel.org, kunit-dev@googlegroups.com, davidgow@google.com, skhan@linuxfoundation.org, akpm@linux-foundation.org, yzaikin@google.com, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com



> -----Original Message-----
> From:  Frank Rowand on January 28, 2020 11:37 AM
> 
> On 1/28/20 1:19 AM, Brendan Higgins wrote:
> > On Mon, Jan 27, 2020 at 9:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
...
> > we could add Kconfigs to control this, but the compiler nevertheless
> > complains because it doesn't know what phase KUnit runs in.
> >
> > Is there any way to tell the compiler that it is okay for non __init
> > code to call __init code? I would prefer not to have a duplicate
> > version of all the KUnit libraries with all the symbols marked __init.
> 
> I'm not sure.  The build messages have always been useful and valid in
> my context, so I never thought to consider that possibility.
> 
> > Thoughts?

I'm not sure there's a restriction on non __init code calling __init
code.  In init/main.c arch_call_reset_init() is in __init, and it calls
rest_init which is non __init, without any special handling.

Is the compiler complaint mentioned above related to  calling
into __init code, or with some other issue?
 -- Tim

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

