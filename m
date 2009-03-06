MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <10f740e80903060150p565e9703u81d4fe47cb599ab@mail.gmail.com>
References: <200903060042.19084.rob@landley.net>
	 <20090306084848.GO22605@hack.private>
	 <10f740e80903060150p565e9703u81d4fe47cb599ab@mail.gmail.com>
Date: Fri, 6 Mar 2009 10:51:12 +0100
Message-ID: <10f740e80903060151w779bbd11ld2fcc437ac7ac321@mail.gmail.com>
Subject: Re: [PATCH] Fix ARCH=um segfault on x86-64.
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Mar 6, 2009 at 10:50, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
> On Fri, Mar 6, 2009 at 09:48, Am=C3=A9rico Wang <xiyou.wangcong@gmail.com=
> wrote:
>> On Fri, Mar 06, 2009 at 12:42:14AM -0600, Rob Landley wrote:
>>>Apparently, nobody other than me has ever attempted to use User Mode Lin=
ux
>>>built from 2.6.28 on x86-64, because it doesn't work. =C2=A0It still doe=
sn't work
>>>in current git. =C2=A0I complained about it not working back in January:
>>>
>>>http://sourceforge.net/mailarchive/forum.php?thread_name=3D200901130159.=
04389.rob%40landley.net&forum_name=3Duser-
>>>mode-linux-devel
>>>http://lkml.indiana.edu/hypermail/linux/kernel/0901.2/00669.html
>>>
>>>And today, I bothered to track down why.
>>>
>>>This is the commit that broke it, when Peter Anvin merged x86 and x86-64=
 for
>>>ARCH=3Dum: http://kernel.org/hg/linux-2.6/rev/117978
>>>
>>>Here's a patch that fixes it for me:
>>
>> Thanks, Bob!
>
> I've just did a build of plain v2.6.28 on amd64 aka x86-64. The
> resulting image ran fine.

So I'm wondering: why does it work for me and not for you?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds

