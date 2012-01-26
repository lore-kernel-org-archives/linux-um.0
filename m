Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <58311.79.160.186.248.1327615864.squirrel@www.nlc.no>
In-Reply-To: <CAFLxGvw85fWdsAodBn1Z0vFYZx0U+vYg6hgsBYbmfuyaFTgznA@mail.gmail.com>
References: <CAFLxGvw85fWdsAodBn1Z0vFYZx0U+vYg6hgsBYbmfuyaFTgznA@mail.gmail.com>
Date: Thu, 26 Jan 2012 23:11:04 +0100 (CET)
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Subject: Re: [uml-devel] /sys/class/tty/tty0/active?
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Greg KH <gregkh@suse.de>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

> Hi!
>
> systemd goes nuts on UML.
> While hunting down all issues I found out that systemd wants to read from
> /sys/class/tty/tty0/active.

Kernel version?
http://comments.gmane.org/gmane.comp.sysutils.systemd.devel/3079 indicates
that the given file appears in 2.6.37

Stian Skjelstad

