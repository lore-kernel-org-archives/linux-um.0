Return-Path: <PeterHuewe@gmx.de>
From: Peter =?utf-8?q?H=C3=BCwe?= <PeterHuewe@gmx.de>
Date: Sun, 9 Sep 2012 21:12:16 +0200
References: <201209022245.20413.PeterHuewe@gmx.de> <CAMuHMdVBEYk0wvG+Xd-pk3DUj852ab1CFwSjg_os3MJpRXcBpA@mail.gmail.com> <709c5ec5-fff8-46af-bd7e-31e1f660285b@email.android.com>
In-Reply-To: <709c5ec5-fff8-46af-bd7e-31e1f660285b@email.android.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201209092112.16527.PeterHuewe@gmx.de>
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: Richard Weinberger <richard@nod.at>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jean Delvare <khali@linux-fr.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

> That's why it may break. If you remove the depends on HAS_IOMEM, it will be
> built on s390 and fail if that codes uses io memory functions. Depending
> on GENERIC_IO fixes that.

Everything I can select in I2C subsystem compiles fine on s390.
(using defconfig + menuconfig).
Just compiled it.

Thanks,
Peter


