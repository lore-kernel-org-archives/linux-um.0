Return-Path: <mmarek@suse.cz>
Message-ID: <527A4498.1080609@suse.cz>
Date: Wed, 06 Nov 2013 14:31:04 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
References: <526AD08D.10506@gmx.de>	<CAMuHMdX+GtHDB5r6-oXyehbemqS36rVE=Agpi0w-6TcCPQotZQ@mail.gmail.com>	<526AE051.5020809@gmx.de> <CAMuHMdWotLn5NwtjxL57YVK_X_N1gb2xxB4qd+sciUTJokourQ@mail.gmail.com> <526B940F.5090803@gmx.de>
In-Reply-To: <526B940F.5090803@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [uml-devel] RFC: Shouldn't "./linux --version" always print the
 the git commit id
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kbuild <linux-kbuild@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Dne 26.10.2013 12:06, Toralf F=C3=B6rster napsal(a):
> On 10/26/2013 09:56 AM, Geert Uytterhoeven wrote:
>> On Fri, Oct 25, 2013 at 11:19 PM, Toralf F=C3=B6rster <toralf.foerster=
@gmx.de> wrote:
>>> $ ./linux --version
>>> 3.11.0
>>
>> If there are no additional commits on top of the tag, no number and co=
mmit
>> ID are printed. I guess the rationale is that tags are global, hence p=
resent
>> in all clones, so there's no need to tell what commit ID the tag corre=
sponds
>> to.
>>
>>> which correlates to
>>>
>>> $ git describe
>>> v3.11
>>>
>>> $ git describe --long
>>> v3.11-0-g6e46645
>>
>> This is not UML-specific. If you want to change this, you have to invo=
lve
>> the kbuild people (CC added).
>>
> Well, the reationale behind my idea comes from the (stupid) logic of on=
e
> of my bisect scripts. I used there the commit id derived from the UML
> linux exe as a suffix for gdb back trace files created during the bisec=
t
> process.
> Sure - logic can be easily adapted and was in the mean while.
> But IMO it would be more stringent to have always the commit id
> presented in the version string for similar cases.

You define your own versioning scheme if you build with
CONFIG_LOCALVERSION_AUTO=3Dn and define LOCALVERSION yourself. E.g.

echo "-g$(git rev-parse --short HEAD)" >localversion-git

or set it in kconfig or on the make commandline.

Michal

