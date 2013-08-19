MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20130819091839.GX5918@redhat.com>
References: <1376777374-17521-1-git-send-email-richard@nod.at>
	<20130819091839.GX5918@redhat.com>
Date: Mon, 19 Aug 2013 12:13:14 +0200
Message-ID: <CAMuHMdXgGPFx6OwHdc73bY6Cb1jYHbjpEqq6e+YC9RuvJYRxDw@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: ubd: Add REQ_FLUSH suppport
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Richard Weinberger <richard@nod.at>, Al Viro <viro@zeniv.linux.org.uk>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Richard,

On Mon, Aug 19, 2013 at 11:18 AM, Richard W.M. Jones <rjones@redhat.com> wrote:
> On Sun, Aug 18, 2013 at 12:09:34AM +0200, Richard Weinberger wrote:
>> UML's block device driver does not support write barriers,
>> to support this this patch adds REQ_FLUSH suppport.
>> Every time the block layer sends a REQ_FLUSH we fsync() now
>> our backing file to guarantee data consistency.
>
> This fixes the sync problem I saw before.  So:

What's the impact on your performance figures?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

