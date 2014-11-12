Return-Path: <richard@nod.at>
Message-ID: <546335AF.7030301@nod.at>
Date: Wed, 12 Nov 2014 11:25:51 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1415785566-12758-1-git-send-email-geert@linux-m68k.org>	<CAMuHMdXkFo--38rRKSpGTb8U58KavPzmm7vwwdN6_SP01Zxt8w@mail.gmail.com>	<CAFLxGvzof00w3ah4kenjfK=6_ydP6NN6PRsaUjMnwDLH8hzEOw@mail.gmail.com> <CAMuHMdWP=9c4w2-H1QGT37qePZzZ8TL-vGuCRB00CH6+60LZkA@mail.gmail.com>
In-Reply-To: <CAMuHMdWP=9c4w2-H1QGT37qePZzZ8TL-vGuCRB00CH6+60LZkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [uml-devel] Build regressions/improvements in v3.18-rc4
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Michael Ellerman <michael@ellerman.id.au>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 12.11.2014 um 11:22 schrieb Geert Uytterhoeven:
> On Wed, Nov 12, 2014 at 11:19 AM, Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>>>   + /home/kisskb/slave/src/fs/hostfs/hostfs_user.c: error: 'AT_FDCWD'
>>> undeclared (first use in this function):  => 378
>>>   + /home/kisskb/slave/src/fs/hostfs/hostfs_user.c: error: (Each
>>> undeclared identifier is reported only once:  => 378
>>>   + /home/kisskb/slave/src/fs/hostfs/hostfs_user.c: error: for each
>>> function it appears in.):  => 378
>>
>> I've never seen this failure.
>> Both 3.18-rc3/4 x86_64/i386 build fine here.
>>
>> What toolchain are you using?
>> It looks like AT_FDCWD is missing on your host side.
> 
> There's obviously more wrong with the host side:
> http://kisskb.ellerman.id.au/kisskb/buildresult/12305953/

Hmm, I bet this is a x86 cross-toolchain with horrible
outdated linux-headers.

Thanks,
//richard

