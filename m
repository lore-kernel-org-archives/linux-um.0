Return-Path: <lacombar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGZ=bqLHjzpKQP63dnSK0fML2ZycmfFnSbiApV4naMCN_UrZdg@mail.gmail.com>
References: <1312042478-26012-1-git-send-email-zdevai@gmail.com>
	<20110801083614.GC15578@n2100.arm.linux.org.uk>
	<CAMuHMdUpTDSRP_JmWqcCBtYwzna0hwmaBshpiF8kgvqoNcqYZA@mail.gmail.com>
	<20110801101410.GE15578@n2100.arm.linux.org.uk>
	<CAMuHMdUiLjMVwOqKPF6tHLpPxROrx=rRf3ednfTLrwGuZ2VF7A@mail.gmail.com>
	<CACqU3MVUxTYmD+4VGBAeN8PTs83fR0xQQrQS5h4QGMZXgMxEvA@mail.gmail.com>
	<CAGZ=bqL=VAx5jnSBkE2q5KJSY_+An-VRTRAzJmJ3waQUvrRFFg@mail.gmail.com>
	<CACqU3MUoxSNmcYsSF4zOTgADdedb7TcciPuBPMviG02M5oUPDQ@mail.gmail.com>
	<CAGZ=bqLHjzpKQP63dnSK0fML2ZycmfFnSbiApV4naMCN_UrZdg@mail.gmail.com>
Date: Mon, 1 Aug 2011 13:14:36 -0400
Message-ID: <CACqU3MV1PWWttCdXpafwovc_X-CxUp_Dcng1i8jKx5bA0+NGPQ@mail.gmail.com>
From: Arnaud Lacombe <lacombar@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Remove remaining references of CONFIG_GENERIC_TIME
To: Kyle Moffett <kyle@moffetthome.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Zoltan Devai <zdevai@gmail.com>, linux-kernel@vger.kernel.org, chris@zankel.net, linux-am33-list@redhat.com, trivial@kernel.org, user-mode-linux-devel@lists.sourceforge.net, cmetcalf@tilera.com, linux-arm-kernel@lists.infradead.org, linux-kbuild <linux-kbuild@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi,

On Mon, Aug 1, 2011 at 12:48 PM, Kyle Moffett <kyle@moffetthome.net> wrote:
> On Mon, Aug 1, 2011 at 12:08, Arnaud Lacombe <lacombar@gmail.com> wrote:
>> On Mon, Aug 1, 2011 at 11:15 AM, Kyle Moffett <kyle@moffetthome.net> wro=
te:
>>> On Mon, Aug 1, 2011 at 11:04, Arnaud Lacombe <lacombar@gmail.com> wrote=
:
>>>> On Mon, Aug 1, 2011 at 7:27 AM, Geert Uytterhoeven <geert@linux-m68k.o=
rg> wrote:
>>>>> On Mon, Aug 1, 2011 at 12:14, Russell King - ARM Linux
>>>>>>>[...]
>>>>>>>
>>>>>>> Doesn't kconf error out when trying to select a non-existent symbol=
?
>>>>>>
>>>>>> Nope.
>>>>>
>>>>> You're right. So that's a bug.
>>>>>
>>>> depends on what you are trying to achieve and what the problem is.
>>>>
>>>> Internally kconfig will create a dummy symbol when it encounter a
>>>> missing symbol so that arch/arm/Kconfig can reference a symbol which
>>>> will be fully defined later on. I do not think you want to forward
>>>> decl all the symbol which can be used. That'd be a mess. That said, we
>>>> can come with a form of symbol deprecation that would error-out when
>>>> used.
>>>
>>> Would it be possible instead to make Kconfig go through all the symbols
>>> after everything is processed and identify any remaining "dummy symbols=
"
>>> which were not actually declared anywhere?
>>>
>> this is software, everything is possible.
>>
>>> Right now if you typo a "select" statement you get no warnings that you
>>> are selecting something that does not exist, which is probably a cause
>>> of many kinds of errors beyond this particular one.
>>>
>> d'oh! ... I'm not sure we want that. Dummy symbol are heavily used
>> internally, a trivial implementation[0] triggered:
>>
>> % make REGENERATE_PARSERS=3Dy alldefconfig 2>&1 | grep 'defined without
>> type' | wc -l
>> 817
>>
>> Moreover, this approach is deemed to fail. The current symbol
>> namespace is tied to an arch, so whenever you do:
>>
>> arch/arm/Kconfig:
>> config FOO
>> =A0 =A0bool
>>
>> config BAZ
>> =A0 =A0bool
>>
>> drivers/cpufreq/Kconfig
>> config BAR
>> =A0 =A0depends on ARM && FOO
>> =A0 =A0select BAZ
>>
>> You will end up triggering the warning for every ARCH !=3D ARM...
>
> Perhaps that's an argument for building a single Kconfig namespace?
I'm working on that, but this is a real mess :)

> At the very least, most of the architecture-generic warnings could be
> worked around with trivial predeclarations in an "arch/Kconfig" file:
>
> config ARM
> =A0 =A0 =A0 =A0bool
> [...]
> config X86
> =A0 =A0 =A0 =A0bool
>
> There's probably technical issues that I'm missing that would make
> that inordinately painful, but I can't see them right now... any ideas?
>
not I directly forsee.

 - Arnaud

> Cheers,
> Kyle Moffett
>

