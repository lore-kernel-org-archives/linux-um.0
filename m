Return-Path: <rppt@linux.vnet.ibm.com>
Date: Fri, 05 Oct 2018 18:05:01 +0300
In-Reply-To: <8891277c7de92e93d3bfc409df95810ee6f103cd.camel@kernel.crashing.org>
References: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com> <8891277c7de92e93d3bfc409df95810ee6f103cd.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] memblock: stop using implicit alignement to SMP_CACHE_BYTES
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Message-Id: <59C9470E-F718-4A11-BC65-FD68901723AC@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org
Cc: linux-mips@linux-mips.org, Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>, linux-um@lists.infradead.org, linux-m68k@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>, linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-um.lists.infradead.org>



On October 5, 2018 6:25:38 AM GMT+03:00, Benjamin Herrenschmidt <benh@kern=
el=2Ecrashing=2Eorg> wrote:
>On Fri, 2018-10-05 at 00:07 +0300, Mike Rapoport wrote:
>> When a memblock allocation APIs are called with align =3D 0, the
>alignment is
>> implicitly set to SMP_CACHE_BYTES=2E
>>=20
>> Replace all such uses of memblock APIs with the 'align' parameter
>explicitly
>> set to SMP_CACHE_BYTES and stop implicit alignment assignment in the
>> memblock internal allocation functions=2E
>>=20
>> For the case when memblock APIs are used via helper functions, e=2Eg=2E
>like
>> iommu_arena_new_node() in Alpha, the helper functions were detected
>with
>> Coccinelle's help and then manually examined and updated where
>appropriate=2E
>>=20
>> The direct memblock APIs users were updated using the semantic patch
>below:
>
>What is the purpose of this ? It sounds rather counter-intuitive=2E=2E=2E

Why?
I think it actually more intuitive to explicitly set alignment to SMP_CACH=
E_BYTES rather than use align =3D 0 because deeply inside allocator it will=
 be implicitly reset to SMP_CACHE_BYTES=2E=2E=2E

>Ben=2E

--=20
Sincerely yours,
Mike=2E


