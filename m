MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <504C992D.606@nod.at>
References: <201209022245.20413.PeterHuewe@gmx.de>
	<201209091452.19700.PeterHuewe@gmx.de>
	<504C9227.1020700@nod.at>
	<201209091511.32970.PeterHuewe@gmx.de>
	<504C992D.606@nod.at>
Date: Sun, 9 Sep 2012 16:52:06 +0200
Message-ID: <CAMuHMdVBEYk0wvG+Xd-pk3DUj852ab1CFwSjg_os3MJpRXcBpA@mail.gmail.com>
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Richard Weinberger <richard@nod.at>
Cc: =?UTF-8?Q?Peter_H=C3=BCwe?= <PeterHuewe@gmx.de>, Jean Delvare <khali@linux-fr.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Sep 9, 2012 at 3:27 PM, Richard Weinberger <richard@nod.at> wrote:
>> For my stub driver I don't need any of that, I'd be fine with the move of
>> HAS_IOMEM as proposed by Jean.
>
> IMHO you should replace the HAS_IOMEM with GENERIC_IO.
> Otherwise you may break the build on s390.

s390 has neither of HAS_IOMEM and GENERIC_IO, so it won't break their
build.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

