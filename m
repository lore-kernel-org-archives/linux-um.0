Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: <Conor.Dooley@microchip.com>
Subject: Re: [PATCH v7 00/25] Rust support
Date: Sat, 16 Jul 2022 13:51:02 +0000
Message-ID: <4a6240da-9003-cd74-cd47-f95ba2d9e7ae@microchip.com>
References: <20220523020209.11810-1-ojeda@kernel.org>
 <20220716124214.329949-1-conor@kernel.org>
 <CANiq72nYRkHV6N2bGpTz3td=2Vto21apvZW0igTT-mV8TZtB2g@mail.gmail.com>
In-Reply-To: <CANiq72nYRkHV6N2bGpTz3td=2Vto21apvZW0igTT-mV8TZtB2g@mail.gmail.com>
Content-Language: en-IE
Content-ID: <2596BE2EC5057B49B1C1166707F15CE6@namprd11.prod.outlook.com>
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
To: miguel.ojeda.sandonis@gmail.com, conor@kernel.org
Cc: ojeda@kernel.org, gregkh@linuxfoundation.org, jarkko@kernel.org, kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org, rust-for-linux@vger.kernel.org, torvalds@linux-foundation.org

On 16/07/2022 14:36, Miguel Ojeda wrote:
> Hi Conor,
> 
> On Sat, Jul 16, 2022 at 2:42 PM Conor Dooley <conor@kernel.org> wrote:
>>
>> Maybe I am just missing something blatantly obvious here, but trying
>> to build rust support in -next fails for me. I am using ClangBuiltLinux
>> clang version 15.0.0 5b0788fef86ed7008a11f6ee19b9d86d42b6fcfa and LLD
>> 15.0.0. Is it just expected that building -next with rust support is
>> not a good idea?
> 
> Please see https://github.com/Rust-for-Linux/linux/issues/795 for
> details about the maple tree issue.

Ah right, sorry for the noise so. I checked the ml but didn't see a
report there.

> 
> I will update the `rust-next` branch next week with the new version of
> the patches; but if you are interested in developing, please use the
> development `rust` branch instead in GitHub for the moment.

Thanks Miguel, good to know! I'll just wait around for a new version.
Just been trying to get my CI etc in order for when rust support lands,
but it sounds like I should be okay as it's a known problem & not some
only-broken-on-riscv thing.

Thanks,
Conor.
_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

