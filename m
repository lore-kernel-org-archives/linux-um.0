Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-eopbgr710117.outbound.protection.outlook.com
 ([40.107.71.117] helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCtDH-0002h3-A4
 for linux-um@lists.infradead.org; Wed, 17 Oct 2018 21:18:45 +0000
From: <Tim.Bird@sony.com>
Subject: RE: [RFC v1 06/31] arch: um: enabled running kunit from User Mode
 Linux
Date: Wed, 17 Oct 2018 21:18:25 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF805248BE@USCULXMSG01.am.sony.com>
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-7-brendanhiggins@google.com>
 <f0d64a0a-7914-f390-c0b5-dc7626b45476@ideasonboard.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF8052436B@USCULXMSG01.am.sony.com>
 <CAFd5g45owvjnVh633_kqf9DKeWQDYdGNi9j1crNZC3k02r=v1A@mail.gmail.com>
In-Reply-To: <CAFd5g45owvjnVh633_kqf9DKeWQDYdGNi9j1crNZC3k02r=v1A@mail.gmail.com>
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
To: brendanhiggins@google.com
Cc: brakmo@fb.com, richard@nod.at, mpe@ellerman.id.au, gregkh@linuxfoundation.org, jdike@addtoit.com, linux-um@lists.infradead.org, kieran.bingham@ideasonboard.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr, mcgrof@kernel.org, joel@jms.id.au, linux-kselftest@vger.kernel.org, keescook@google.com, joe@perches.com, shuah@kernel.org, khilman@baylibre.com, kunit-dev@googlegroups.com



> -----Original Message-----
> From: Brendan Higgins 
> 
> On Wed, Oct 17, 2018 at 10:52 AM <Tim.Bird@sony.com> wrote:
> > >
> > > It might be of interest to the automated testing mailing list too ? (Tim?)
> >
> >  I think this is interesting to groups doing automated testing of the kernel
> > (including myself) as another set of tests to run.  Right now I don't see it
> > as having any special attributes related to automation.  But I could be
> wrong.
> 
> Pardon my ignorance, but by automated testing you mean a CI server
> with presubmits, nightlys, and things of the sort?
Yes.

> 
> If that's the case, KUnit could be helpful because of the low resource
> cost in running them and the speed at which they run.
True.

> There are some
> other features we would like to add which would help with that goal as
> well like test isolation. We actually have a presubmit server
> internally for running KUnit tests that can usually respond to patches
> with test results within a couple minutes. Would something like that
> be interesting?
I think the code and architecture of the software that handles presubmit,
mail-list scanning, notifications, etc. would be of interest.  But KUnit features
themselves (macro definitions, mocking vs. faking, etc.) would not. 
I only say that in the context of CC-ing the automated testing list on the patch set.
Of course the KUnit features are interesting by themselves for testers doing
unit testing.
 -- Tim

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

