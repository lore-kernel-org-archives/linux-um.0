Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v8 27/31] Kbuild: add Rust support
In-Reply-To: <CAK7LNARTX+2Z=pnGbbUepxskE+KZ1f5YsfQukJ88ijPBQt9_GA@mail.gmail.com>
References: <20220802015052.10452-1-ojeda@kernel.org>
 <20220802015052.10452-28-ojeda@kernel.org>
 <CAK7LNARTX+2Z=pnGbbUepxskE+KZ1f5YsfQukJ88ijPBQt9_GA@mail.gmail.com>
Date: Wed, 07 Sep 2022 09:34:38 +1000
Message-ID: <8735d4t6up.fsf@mpe.ellerman.id.au>
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
To: Masahiro Yamada <masahiroy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Finn Behrens <me@kloenk.de>, Adam Bratschi-Kaye <ark.email@gmail.com>, Wedson Almeida Filho <wedsonaf@google.com>, Sven Van Asbroeck <thesven73@gmail.com>, Gary Guo <gary@garyguo.net>, Boris-Chengbiao Zhou <bobo1239@web.de>, Boqun Feng <boqun.feng@gmail.com>, Douglas Su <d0u9.su@outlook.com>, Dariusz Sosnowski <dsosnowski@dsosnowski.pl>, Antonio Terceiro <antonio.terceiro@linaro.org>, Daniel Xu <dxu@dxuuu.xyz>, Miguel Cano <macanroj@gmail.com>, David Gow <davidgow@google.com>, Tiago Lam <tiagolam@gmail.com>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Michal Marek <michal.lkml@markovi.net>, Nick Desaulniers <ndesaulniers@google.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>, linux-um@lists.infradead.org

Masahiro Yamada <masahiroy@kernel.org> writes:
> On Tue, Aug 2, 2022 at 10:53 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>>
>> Having all the new files in place, we now enable Rust support
>> in the build system, including `Kconfig` entries related to Rust,
>> the Rust configuration printer, the target specification
>> generation script, the version detection script and a few
>> other bits.
...
>> +
>> +config RUSTC_VERSION_TEXT
>> +       string
>> +       depends on RUST
>> +       default $(shell,command -v $(RUSTC) >/dev/null 2>&1 && $(RUSTC) --version || echo n)
>> +
>> +config BINDGEN_VERSION_TEXT
>> +       string
>> +       depends on RUST
>> +       default $(shell,command -v $(BINDGEN) >/dev/null 2>&1 && $(BINDGEN) --version || echo n)
>> +
>
> Where are these config options used?
>
> I grep'ed but no hit.
>
> masahiro@zoe:~/ref/linux-next$ git grep RUSTC_VERSION_TEXT
> init/Kconfig:config RUSTC_VERSION_TEXT
> masahiro@zoe:~/ref/linux-next$ git grep BINDGEN_VERSION_TEXT
> init/Kconfig:config BINDGEN_VERSION_TEXT

That came up before in a review by Nick:

Miguel wrote:
> Nick wrote:
> > Are these two kconfigs used anywhere?
> 
> Not for the moment, but it could still be useful when getting
> `.config` reports (and we could add it to `LINUX_COMPILER` etc. in the
> future).

https://lore.kernel.org/all/CANiq72n2bU3LSGu-4v66nif_95EVq--z2X_F2V7JBPU8v=h8EA@mail.gmail.com/


cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

