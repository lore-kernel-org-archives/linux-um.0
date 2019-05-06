MIME-Version: 1.0
Date: Mon, 6 May 2019 09:45:04 +0200
References: <20190503213249.30008-1-johannes@sipsolutions.net>
	<20190503213249.30008-3-johannes@sipsolutions.net>
	<95430ca975e73addc7f65e331488bc280974fd72.camel@sipsolutions.net>
	<9f844312-dca3-d20e-485b-13c1f249edb0@cambridgegreys.com>
In-Reply-To: <9f844312-dca3-d20e-485b-13c1f249edb0@cambridgegreys.com>
Message-ID: <CAMuHMdXi7Yd9p8dahixBbH=kuY1Zmyz3OHCxrH9tKDo23cGHhw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arch: um: support virtual time
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>
List-ID: <linux-um.lists.infradead.org>

On Sat, May 4, 2019 at 10:43 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
> On 04/05/2019 20:05, Johannes Berg wrote:
> > On Fri, 2019-05-03 at 21:32 +0000, Johannes Berg wrote:
> I can understand your use case for patch 3. What I am not clear is where
> should that config option live. It should be somewhere under
> debug/kernel hacking with a sufficient number of big fat warnings so
> people do not enable it accidentally by mistake.

I think enabling the config option should not also enable the feature, but
just add code that allows to enable the feature by a kernel command line
option, and/or by a special file in debugfs.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

