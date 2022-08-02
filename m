Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <YukYByl76DKqa+iD@casper.infradead.org>
 <CANiq72k7JKqq5-8Nqf3Q2r2t_sAffC8g86A+v8yBc=W-1--_Tg@mail.gmail.com> <YukuUtuXm/xPUuoP@casper.infradead.org>
In-Reply-To: <YukuUtuXm/xPUuoP@casper.infradead.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 2 Aug 2022 17:09:05 +0200
Message-ID: <CANiq72kgwssTSE7F+4xkRrXBGVgHeWxCyjeZ-NHLUXWnFjMyTg@mail.gmail.com>
Subject: Re: [PATCH v8 00/31] Rust support
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
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, live-patching@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Tue, Aug 2, 2022 at 4:01 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> No objections to any of this.  I love the idea of being able to write
> filesystems in Rust.  I just think it would go more smoothly if
> linux-fsdevel were involved more closely so people at least have the
> option of being able to follow design decisions, and hopefully influence
> them.  That goes both ways, of course; I hardly think our current
> operations structures are the optimum way to implement a filesystem,
> and having fresh eyes say things like "But that shouldn't be part of the
> address_space_operations" can impel better abstractions.

I will send the patches to fsdevel then!

As for following development closely and design decisions, we have
been doing it in GitHub so far pre-merge, so the easiest until the
merge (for us) would be to ping you there. We can also send you copies
of the `fs` related patches too if you would like that. I would highly
recommend joining the monthly informal calls too.

(I appreciate the kind answer, by the way!)

> The obvious answer is to split out the 'fs module' into its own patch
> ;-)  I presume it was part of the kernel crate which would have been
> either patch 17 or 11 in that series?

Yeah, patch 17, exactly (patch 11 is the `alloc` import). I have asked
Konstantin privately about them.

In any case, I will split the patches further for v9 which should help.

Meanwhile, you can also see the `fs` module here, if you are curious:

    https://github.com/Rust-for-Linux/linux/blob/rust-next/rust/kernel/fs.rs
    https://github.com/Rust-for-Linux/linux/blob/rust-next/rust/kernel/fs/param.rs

Cheers,
Miguel

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

