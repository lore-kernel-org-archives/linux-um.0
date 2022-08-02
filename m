Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 2 Aug 2022 15:01:54 +0100
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v8 00/31] Rust support
Message-ID: <YukuUtuXm/xPUuoP@casper.infradead.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
 <YukYByl76DKqa+iD@casper.infradead.org>
 <CANiq72k7JKqq5-8Nqf3Q2r2t_sAffC8g86A+v8yBc=W-1--_Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANiq72k7JKqq5-8Nqf3Q2r2t_sAffC8g86A+v8yBc=W-1--_Tg@mail.gmail.com>
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
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, live-patching@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Tue, Aug 02, 2022 at 03:45:50PM +0200, Miguel Ojeda wrote:
> Hi Willy,
> 
> On Tue, Aug 2, 2022 at 2:26 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > None of this (afaict) has been discussed on linux-fsdevel.  And I may
> > have missed somethiing, but I don't see the fs module in this series
> > of patches.  Could linux-fsdevel be cc'd on the development of Rust
> > support for filesystems in the future?
> 
> In order to provide example drivers and kernel modules, we need to
> have some safe abstractions for them, thus we are adding some as we
> need them.
> 
> More importantly, the abstractions also serve as a showcase of how
> they may be written in the future if Rust support is merged.
> 
> This does not mean these abstractions are a final design or that we
> plan to develop them independently of subsystem maintainers. In fact,
> we would prefer the opposite: in the future, when the support is
> merged and more people start having more experience with Rust, we hope
> that the respective kernel maintainers start developing and
> maintaining the abstractions themselves.
> 
> But we have to start somewhere, and at least provide enough examples
> to serve as guidance and to show that it is actually possible to write
> abstractions that restrict the amount of unsafe code.
> 
> And, of course, if you are already interested in developing them, that
> would be actually great and we would love your input and/or that you
> join us.

No objections to any of this.  I love the idea of being able to write
filesystems in Rust.  I just think it would go more smoothly if
linux-fsdevel were involved more closely so people at least have the
option of being able to follow design decisions, and hopefully influence
them.  That goes both ways, of course; I hardly think our current
operations structures are the optimum way to implement a filesystem,
and having fresh eyes say things like "But that shouldn't be part of the
address_space_operations" can impel better abstractions.

> As for the `fs` module, I see in lore 2 patches didn't make it
> through, but I didn't get a bounce (I do get bounces for the
> rust-for-linux ML, but I was told that was fine as long as LKML got
> them). Sorry about that... I will ask what to do.

The obvious answer is to split out the 'fs module' into its own patch
;-)  I presume it was part of the kernel crate which would have been
either patch 17 or 11 in that series?

> Meanwhile, you can see the patches in this branch:
> 
>     https://github.com/Rust-for-Linux/linux.git rust-next
> 
> Cheers,
> Miguel

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

