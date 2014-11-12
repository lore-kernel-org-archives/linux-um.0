Return-Path: <richard.weinberger@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXkFo--38rRKSpGTb8U58KavPzmm7vwwdN6_SP01Zxt8w@mail.gmail.com>
References: <1415785566-12758-1-git-send-email-geert@linux-m68k.org>
	<CAMuHMdXkFo--38rRKSpGTb8U58KavPzmm7vwwdN6_SP01Zxt8w@mail.gmail.com>
Date: Wed, 12 Nov 2014 11:19:02 +0100
Message-ID: <CAFLxGvzof00w3ah4kenjfK=6_ydP6NN6PRsaUjMnwDLH8hzEOw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [uml-devel] Build regressions/improvements in v3.18-rc4
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Geert,

On Wed, Nov 12, 2014 at 10:48 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Nov 12, 2014 at 10:46 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> JFYI, when comparing v3.18-rc4[1]  to v3.18-rc3[3], the summaries are:
>>   - build errors: +5/-6
>
>   + /home/kisskb/slave/src/fs/hostfs/hostfs_user.c: error: 'AT_FDCWD'
> undeclared (first use in this function):  => 378
>   + /home/kisskb/slave/src/fs/hostfs/hostfs_user.c: error: (Each
> undeclared identifier is reported only once:  => 378
>   + /home/kisskb/slave/src/fs/hostfs/hostfs_user.c: error: for each
> function it appears in.):  => 378

I've never seen this failure.
Both 3.18-rc3/4 x86_64/i386 build fine here.

What toolchain are you using?
It looks like AT_FDCWD is missing on your host side.

-- 
Thanks,
//richard

