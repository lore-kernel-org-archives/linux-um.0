Return-Path: <chris.obbard@collabora.com>
Subject: Re: Build regressions/improvements in v5.10-rc1
References: <20201026081811.3934205-1-geert@linux-m68k.org>
 <CAMuHMdXbsJPnsXg6bA_e32zJkBG1Zzqj-ja5WzHDKL0d9OcfPg@mail.gmail.com>
From: Christopher Obbard <chris.obbard@collabora.com>
Message-ID: <ed39a579-62c9-de88-3550-f21382b804a8@collabora.com>
Date: Mon, 26 Oct 2020 10:17:16 +0000
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXbsJPnsXg6bA_e32zJkBG1Zzqj-ja5WzHDKL0d9OcfPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, arcml <linux-snps-arc@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>, Joe Perches <joe@perches.com>
List-ID: <linux-um.lists.infradead.org>

Hi Geert,

On 26/10/2020 09:48, Geert Uytterhoeven wrote:
> On Mon, Oct 26, 2020 at 10:46 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Below is the list of build error/warning regressions/improvements in
>> v5.10-rc1[1] compared to v5.9[2].
>>
>> Summarized:
>>    - build errors: +3/-7
>>    - build warnings: +26/-28
>>
>> Happy fixing! ;-)
>>
>> Thanks to the linux-next team for providing the build service.
>>
>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3650b228f83adda7e5ee532e2b90429c03f7b9ec/ (all 192 configs)
>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bbf5c979011a099af5dc76498918ed7df445635b/ (all 192 configs)
>>
>>
>> *** ERRORS ***
>>
>> 3 error regressions:
>>    + /kisskb/src/arch/um/kernel/skas/clone.c: error: expected declaration specifiers or '...' before string constant:  => 24:16

For me, reverting commit 33def8498fdde180023444b08e12b72a9efed41d 
("treewide: Convert macro and uses of __section(foo) to 
__section("foo")") fixed this compile error and one other introduced by 
the same patch.
Unfortunately I wasn't able to come up with a fix for that, but I have 
CC the author of that patch.

Thanks!
Christopher Obbard

> 
> um-all{mod,yes}config
> 
>>    + error: hotplug-memory.c: undefined reference to `of_drconf_to_nid_single':  => .text+0x5e0)
> 
> powerpc-gcc5/pseries_le_defconfig+NO_NUMA
> 
>>    + {standard input}: Error: inappropriate arguments for opcode 'adc':  => 170
> 
> arc-gcc10/axs101_defconfig
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

