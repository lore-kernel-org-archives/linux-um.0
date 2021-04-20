Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYkDj-00BrJG-5f
 for linux-um@lists.infradead.org; Tue, 20 Apr 2021 06:50:55 +0000
Message-ID: <876ff6c99b90f5f37fdeaa22c0874a72c56ee1e0.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: Fix stack pointer alignment
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 20 Apr 2021 08:50:42 +0200
In-Reply-To: <CABqSeASZLeK8dq-75dcM51zmkHUteuJc07bS8ixKVhEAAeuPDw@mail.gmail.com>
 (sfid-20210419_223624_736006_CB63BFF5)
References: <20210419153213.1337562-1-zhuyifei1999@gmail.com>
 <546324c4e77ebe65f27b0f06fea3ace28dd75fe6.camel@sipsolutions.net>
 <CABqSeASZLeK8dq-75dcM51zmkHUteuJc07bS8ixKVhEAAeuPDw@mail.gmail.com>
 (sfid-20210419_223624_736006_CB63BFF5)
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
To: YiFei Zhu <zhuyifei1999@gmail.com>, Colin Ian King <colin.king@canonical.com>
Cc: linux-um@lists.infradead.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Benjamin Berg <benjamin@sipsolutions.net>

Hi,

Sorry, went to sleep after sending the other mail last night :)

On Mon, 2021-04-19 at 15:36 -0500, YiFei Zhu wrote:
> On Mon, Apr 19, 2021 at 2:41 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> > On Mon, 2021-04-19 at 10:32 -0500, YiFei Zhu wrote:
> > > On a side note, musl is unaffected by this issue because it forces
> > > 16 byte alignment via `and $-16,%rsi` in its clone wrapper.
> > > Similarly, glibc i386 is also uneffected because it has
> 
> I realize I forgot to fix the typo here. Can you amend it or shall I send a v3?
> 

Please resend - I most likely won't be the one applying the patch, but
Richard. Just easier that way.

> 
> This could be considered a glibc bug that it doesn't force alignment,
> yeah, considering musl does it for both x86_32 and x86_64, and glibc
> does it for only x86_32 and not x86_64. However, I'm unaware that
> anywhere saying something like "it's libc's duty to align the stack
> pointer to clone()"
> 

True. And the man page does document alignment restrictions at least in
some cases.

> Speaking of aarch64, it looks like that message might be out of date.

Might very well be. I found another reference to "126-bit alignment"
(and have since sent a patch to fix that to say "128-bit"), but I don't
know whether any of that is really accurate.
> > 
> > It must also depend on the glibc version, because I've definitely been
> > testing UML_RTC on 64-bit, on Fedora 32 at the time.
> > 
> 
> Hmm. Interesting. I can't seem to find anything suggesting Fedora has
> a patch that would align the stack within clone() [3][4]. I also got a
> Fedora 32 docker image and could not see the aligning from disassembly
> of clone, and the gcc version installed by yum is 10.2.1-9.fc32, which
> is supposed to be affected by this issue... weird. I would expect this
> to fail outright. I'm considering compiling uml inside this container
> to see what is going on.

Hm, wait. It could also be a *compiler* version thing, right?

And actually, most of my testing probably wasn't on Fedora 33, but
rather on a somewhat dated version of nixos, with gcc 9.3. I could even
give you the description file to reproduce the exact environment, but I
doubt it's really worthwhile. Let's just fix the bug?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

