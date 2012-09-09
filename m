Return-Path: <richard@nod.at>
In-Reply-To: <CAMuHMdVBEYk0wvG+Xd-pk3DUj852ab1CFwSjg_os3MJpRXcBpA@mail.gmail.com>
References: <201209022245.20413.PeterHuewe@gmx.de> <201209091452.19700.PeterHuewe@gmx.de> <504C9227.1020700@nod.at> <201209091511.32970.PeterHuewe@gmx.de> <504C992D.606@nod.at> <CAMuHMdVBEYk0wvG+Xd-pk3DUj852ab1CFwSjg_os3MJpRXcBpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Richard Weinberger <richard@nod.at>
Date: Sun, 09 Sep 2012 17:00:54 +0200
Message-ID: <709c5ec5-fff8-46af-bd7e-31e1f660285b@email.android.com>
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?ISO-8859-1?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>, Jean Delvare <khali@linux-fr.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>



Geert Uytterhoeven <geert@linux-m68k.org> schrieb:

>On Sun, Sep 9, 2012 at 3:27 PM, Richard Weinberger <richard@nod.at>
>wrote:
>>> For my stub driver I don't need any of that, I'd be fine with the
>move of
>>> HAS_IOMEM as proposed by Jean.
>>
>> IMHO you should replace the HAS_IOMEM with GENERIC_IO.
>> Otherwise you may break the build on s390.
>
>s390 has neither of HAS_IOMEM and GENERIC_IO, so it won't break their
>build.
>
>Gr{oetje,eeting}s,
>
>                        Geert
>
>--
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
>geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a
>hacker. But
>when I'm talking to journalists I just say "programmer" or something
>like that.
>                                -- Linus Torvalds

That's why it may break. If you remove the depends on HAS_IOMEM, it will be built on s390 and fail if that codes uses io memory functions. Depending on GENERIC_IO fixes that.

