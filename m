Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220523020209.11810-22-ojeda@kernel.org>
 <CAK7LNAQZOTjxJyS3WC1sM7LE-An7DL8xoW=-s1ONe7cq4YukNQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQZOTjxJyS3WC1sM7LE-An7DL8xoW=-s1ONe7cq4YukNQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 16 Jul 2022 10:57:30 +0200
Message-ID: <CANiq72k1aPQuvAL=TqNQVBZBmxojKfPBKU3v_2_B=731fhuJbQ@mail.gmail.com>
Subject: Re: [PATCH v7 21/25] Kbuild: add Rust support
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
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Finn Behrens <me@kloenk.de>, Adam Bratschi-Kaye <ark.email@gmail.com>, Wedson Almeida Filho <wedsonaf@google.com>, Michael Ellerman <mpe@ellerman.id.au>, Sven Van Asbroeck <thesven73@gmail.com>, Gary Guo <gary@garyguo.net>, Boris-Chengbiao Zhou <bobo1239@web.de>, Boqun Feng <boqun.feng@gmail.com>, Douglas Su <d0u9.su@outlook.com>, Dariusz Sosnowski <dsosnowski@dsosnowski.pl>, Antonio Terceiro <antonio.terceiro@linaro.org>, Daniel Xu <dxu@dxuuu.xyz>, Miguel Cano <macanroj@gmail.com>, David Gow <davidgow@google.com>, Michal Marek <michal.lkml@markovi.net>, Nick Desaulniers <ndesaulniers@google.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>, linux-um@lists.infradead.org

Hi Masahiro,

On Sat, Jul 16, 2022 at 10:23 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Is it intentional to print the successful message to stderr?

I think it makes sense to change it to `stdout`, given the message is
the main point of running `rustavailable` for normal users, and those
that just want the status code may ignore it.

Thanks for taking a look again!

Cheers,
Miguel

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

