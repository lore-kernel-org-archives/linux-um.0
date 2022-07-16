Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220716124214.329949-1-conor@kernel.org>
 <CANiq72nYRkHV6N2bGpTz3td=2Vto21apvZW0igTT-mV8TZtB2g@mail.gmail.com> <4a6240da-9003-cd74-cd47-f95ba2d9e7ae@microchip.com>
In-Reply-To: <4a6240da-9003-cd74-cd47-f95ba2d9e7ae@microchip.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 16 Jul 2022 15:56:00 +0200
Message-ID: <CANiq72nDcJLSB3pLhkdqGdLitfmqqCUVVfkY5EjP9AcwVv9B4A@mail.gmail.com>
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
To: Conor.Dooley@microchip.com
Cc: Conor Dooley <conor@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Jarkko Sakkinen <jarkko@kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-perf-users@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, linux-um@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, live-patching@vger.kernel.org, rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Jul 16, 2022 at 3:51 PM <Conor.Dooley@microchip.com> wrote:
>
> Ah right, sorry for the noise so. I checked the ml but didn't see a
> report there.

No apologies needed -- thanks to you for the report, instead! :)

> Thanks Miguel, good to know! I'll just wait around for a new version.
> Just been trying to get my CI etc in order for when rust support lands,
> but it sounds like I should be okay as it's a known problem & not some
> only-broken-on-riscv thing.

Yeah, it is a simple `bindgen` issue. Thanks a lot for making the
effort to prepare your CI in advance!

Cheers,
Miguel

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

