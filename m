Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH AUTOSEL for 3.18 059/101] x86/um: thin archives build fix
Date: Sun, 15 Apr 2018 15:02:10 +0000
Message-ID: <20180415150208.GT2341@sasha-vm>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
 <20180409004042.164920-9-alexander.levin@microsoft.com>
 <20180409142911.34fe1065@roar.ozlabs.ibm.com>
In-Reply-To: <20180409142911.34fe1065@roar.ozlabs.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50949BEA98A8144B81B840DE6927EEEB@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Apr 09, 2018 at 02:29:11PM +1000, Nicholas Piggin wrote:
>On Mon, 9 Apr 2018 00:41:22 +0000
>Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> [ Upstream commit 827880ec260ba048f95fe646b96a205c394fa0f0 ]
>>
>> The linker does not like vdso-syms.lds in input archive files.
>> Make it an extra-y instead.
>
>I wouldn't say these should be needed on kernels without thin
>archives build.
>
>It shouldn't hurt, but no point risking stable breakage.
>
>Thanks,
>Nick

Now dropped, thanks Nick!=

