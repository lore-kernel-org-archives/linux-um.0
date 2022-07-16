Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220716124214.329949-1-conor@kernel.org>
In-Reply-To: <20220716124214.329949-1-conor@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 16 Jul 2022 15:36:22 +0200
Message-ID: <CANiq72nYRkHV6N2bGpTz3td=2Vto21apvZW0igTT-mV8TZtB2g@mail.gmail.com>
Subject: Re: [PATCH v7 00/25] Rust support
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
To: Conor Dooley <conor@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Jarkko Sakkinen <jarkko@kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-perf-users@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, linux-um@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, live-patching@vger.kernel.org, rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Conor,

On Sat, Jul 16, 2022 at 2:42 PM Conor Dooley <conor@kernel.org> wrote:
>
> Maybe I am just missing something blatantly obvious here, but trying
> to build rust support in -next fails for me. I am using ClangBuiltLinux
> clang version 15.0.0 5b0788fef86ed7008a11f6ee19b9d86d42b6fcfa and LLD
> 15.0.0. Is it just expected that building -next with rust support is
> not a good idea?

Please see https://github.com/Rust-for-Linux/linux/issues/795 for
details about the maple tree issue.

I will update the `rust-next` branch next week with the new version of
the patches; but if you are interested in developing, please use the
development `rust` branch instead in GitHub for the moment.

Cheers,
Miguel

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

