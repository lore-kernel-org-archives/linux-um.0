Return-Path: <khali@linux-fr.org>
Date: Sun, 9 Sep 2012 17:48:48 +0200
From: Jean Delvare <khali@linux-fr.org>
Message-ID: <20120909174848.41646ddf@endymion.delvare>
In-Reply-To: <709c5ec5-fff8-46af-bd7e-31e1f660285b@email.android.com>
References: <201209022245.20413.PeterHuewe@gmx.de>
	<201209091452.19700.PeterHuewe@gmx.de>
	<504C9227.1020700@nod.at>
	<201209091511.32970.PeterHuewe@gmx.de>
	<504C992D.606@nod.at>
	<CAMuHMdVBEYk0wvG+Xd-pk3DUj852ab1CFwSjg_os3MJpRXcBpA@mail.gmail.com>
	<709c5ec5-fff8-46af-bd7e-31e1f660285b@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: Richard Weinberger <richard@nod.at>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Peter =?ISO-8859-1?B?SPx3?= =?ISO-8859-1?B?ZQ==?= <PeterHuewe@gmx.de>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, 09 Sep 2012 17:00:54 +0200, Richard Weinberger wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> schrieb:
> >s390 has neither of HAS_IOMEM and GENERIC_IO, so it won't break their
> >build.
>
> That's why it may break. If you remove the depends on HAS_IOMEM, it will be built on s390 and fail if that codes uses io memory functions. Depending on GENERIC_IO fixes that.

Where "that" is a problem which may not exist in the first place.

-- 
Jean Delvare

