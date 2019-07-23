Return-Path: <deller@gmx.de>
Subject: Re: Build regressions/improvements in v5.3-rc1
References: <20190723080441.19110-1-geert@linux-m68k.org>
 <CAMuHMdVuVqXnW8SEnpcbvh8agYvPh775rv9tmV9kGUa6Q2wcwA@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <738c1891-6ef3-8cd1-d25e-b9a36255e3e7@gmx.de>
Date: Tue, 23 Jul 2019 23:30:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVuVqXnW8SEnpcbvh8agYvPh775rv9tmV9kGUa6Q2wcwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-um@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On 23.07.19 17:39, Geert Uytterhoeven wrote:
> On Tue, Jul 23, 2019 at 5:22 PM Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>> Below is the list of build error/warning regressions/improvements in
>> v5.3-rc1[1] compared to v5.2[2].
>
>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/5f9e832c13707=
5045d15cd6899ab0505cfb2ca4b/ (241 out of 242 configs)
>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0ecfebd2b5240=
4ae0c54a878c872bb93363ada36/ (all 242 configs)
>>
>>
>> *** ERRORS ***
>> ...
>>    + /kisskb/src/include/linux/kprobes.h: error: implicit declaration o=
f function 'kprobe_fault_handler'; did you mean 'kprobe_page_fault'? [-Wer=
ror=3Dimplicit-function-declaration]:  =3D> 477:9
>
> parisc-allmodconfig

I've a patch queued up for the next pull request (in the parisc git tree) =
to fix this:

https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/co=
mmit/?h=3Dfor-next&id=3Df5e03d3a04978d2866f82cb11cc7a6b808c8ce07

Helge

