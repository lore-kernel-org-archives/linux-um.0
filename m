Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: linux-next: Tree for Oct 18 ('make' error on ARCH=um)
References: <20211018203023.036d8362@canb.auug.org.au>
 <a1b2bdda-d1cf-807b-6a84-73a3e347639c@infradead.org>
 <20211019085811.362b4304@canb.auug.org.au>
 <CANiq72=+5w7KzVKmN57ud5+GGEiuRbtgezfROGAuO=b-OYeWAA@mail.gmail.com>
 <20211020155627.7d6f6637@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <81c2e5c6-7388-3d1d-87a9-1b000517661b@infradead.org>
Date: Wed, 20 Oct 2021 07:23:42 -0700
MIME-Version: 1.0
In-Reply-To: <20211020155627.7d6f6637@canb.auug.org.au>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, Alex Gaynor <alex.gaynor@gmail.com>, Geoffrey Thomas <geofft@ldpreload.com>, Finn Behrens <me@kloenk.de>, Adam Bratschi-Kaye <ark.email@gmail.com>, Wedson Almeida Filho <wedsonaf@google.com>, Boqun Feng <boqun.feng@gmail.com>, Sumera Priyadarsini <sylphrenadin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Sven Van Asbroeck <thesven73@gmail.com>, Gary Guo <gary@garyguo.net>, Boris-Chengbiao Zhou <bobo1239@web.de>, Fox Chen <foxhlchen@gmail.com>, Ayaan Zaidi <zaidi.ayaan@gmail.com>, Douglas Su <d0u9.su@outlook.com>, Yuki Okushi <jtitor@2k36.org>

On 10/19/21 9:56 PM, Stephen Rothwell wrote:
> Hi Randy,
> 
> On Tue, 19 Oct 2021 00:18:44 +0200 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> On Mon, Oct 18, 2021 at 11:58 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>
>>> In commit
>>>
>>>    c862c7fee526 ("Kbuild: add Rust support")
>>>
>>> from the rust tree, these bits should probably not be there:
>>>
>>> -ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
>>>   include $(srctree)/scripts/Makefile.clang
>>> -endif
>>
>> So this was on purpose -- we need the Clang flags even in GCC builds
>> for bindgen. But now there is that `$(error ...)` added there :(
>>
>>> Miguel, does that seem reasonable?
>>
>> Of course, for today please feel free to apply your fix (i.e. to put
>> the conditional back to where it was). I will solve it on my side
>> tomorrow.
> 
> Can you please check that this is fixed for you after I do the release
> today?
> 

I will. It's part of my nightly cron job.

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

