Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <YukYByl76DKqa+iD@casper.infradead.org>
 <CANiq72k7JKqq5-8Nqf3Q2r2t_sAffC8g86A+v8yBc=W-1--_Tg@mail.gmail.com> <YukrFS9NIMSP/I/Q@infradead.org>
In-Reply-To: <YukrFS9NIMSP/I/Q@infradead.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 2 Aug 2022 16:16:53 +0200
Message-ID: <CANiq72=rRxQf+CLhDBpR7YFYkjSFKQoik082q5_bgh_AMCb3rQ@mail.gmail.com>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, live-patching@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Tue, Aug 2, 2022 at 3:48 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> handwaiving and pointing to git trees is not how Linux development
> works.  Please make sure all the patches go to the relevant lists
> and maintainers first, and actually do have ACKs.

Which hand-waving? In fact, we were requested to do it like this.

As for the Cc's, if any ML wants to be Cc'd for an abstraction we
create, even if no C code is modified on their side, I am more than
happy to Cc them. I can even do that by default, but not everyone may
want to hear about the Rust side just yet, so I have not been doing it
so far.

Cheers,
Miguel

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

