Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: linux-next: Tree for Oct 18 ('make' error on ARCH=um)
From: Randy Dunlap <rdunlap@infradead.org>
References: <20211018203023.036d8362@canb.auug.org.au>
 <a1b2bdda-d1cf-807b-6a84-73a3e347639c@infradead.org>
 <20211019085811.362b4304@canb.auug.org.au>
 <CANiq72=+5w7KzVKmN57ud5+GGEiuRbtgezfROGAuO=b-OYeWAA@mail.gmail.com>
 <20211020155627.7d6f6637@canb.auug.org.au>
 <81c2e5c6-7388-3d1d-87a9-1b000517661b@infradead.org>
Message-ID: <b0eddd67-e62f-c6c3-37d1-8c69f27c51fb@infradead.org>
Date: Wed, 20 Oct 2021 07:46:24 -0700
MIME-Version: 1.0
In-Reply-To: <81c2e5c6-7388-3d1d-87a9-1b000517661b@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, Alex Gaynor <alex.gaynor@gmail.com>, Geoffrey Thomas <geofft@ldpreload.com>, Finn Behrens <me@kloenk.de>, Adam Bratschi-Kaye <ark.email@gmail.com>, Wedson Almeida Filho <wedsonaf@google.com>, Boqun Feng <boqun.feng@gmail.com>, Sumera Priyadarsini <sylphrenadin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Sven Van Asbroeck <thesven73@gmail.com>, Gary Guo <gary@garyguo.net>, Boris-Chengbiao Zhou <bobo1239@web.de>, Fox Chen <foxhlchen@gmail.com>, Ayaan Zaidi <zaidi.ayaan@gmail.com>, Douglas Su <d0u9.su@outlook.com>, Yuki Okushi <jtitor@2k36.org>
List-ID: <linux-um.lists.infradead.org>

On 10/20/21 7:23 AM, Randy Dunlap wrote:
> On 10/19/21 9:56 PM, Stephen Rothwell wrote:
>> Hi Randy,
>>
>> On Tue, 19 Oct 2021 00:18:44 +0200 Miguel Ojeda <miguel.ojeda.sandonis@g=
mail.com> wrote:
>>>
>>> On Mon, Oct 18, 2021 at 11:58 PM Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>>>>
>>>> In commit
>>>>
>>>> =EF=BF=BD=EF=BF=BD c862c7fee526 ("Kbuild: add Rust support")
>>>>
>>>> from the rust tree, these bits should probably not be there:
>>>>
>>>> -ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
>>>> =EF=BF=BD include $(srctree)/scripts/Makefile.clang
>>>> -endif
>>>
>>> So this was on purpose -- we need the Clang flags even in GCC builds
>>> for bindgen. But now there is that `$(error ...)` added there :(
>>>
>>>> Miguel, does that seem reasonable?
>>>
>>> Of course, for today please feel free to apply your fix (i.e. to put
>>> the conditional back to where it was). I will solve it on my side
>>> tomorrow.
>>
>> Can you please check that this is fixed for you after I do the release
>> today?
>>
>=20
> I will. It's part of my nightly cron job.
>=20

Stephen, Miguel,

No problems like this in linux-next 2021-10-20.

thanks.

--=20
~Randy

