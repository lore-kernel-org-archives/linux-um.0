Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <58311.79.160.186.248.1327615864.squirrel@www.nlc.no>
References: <CAFLxGvw85fWdsAodBn1Z0vFYZx0U+vYg6hgsBYbmfuyaFTgznA@mail.gmail.com>
	<58311.79.160.186.248.1327615864.squirrel@www.nlc.no>
Date: Thu, 26 Jan 2012 23:12:22 +0100
Message-ID: <CAFLxGvzsg71gtyPEtOAVnS-DtozYzqgoGNK-ZJRvBfq1mf3Oug@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
Subject: Re: [uml-devel] /sys/class/tty/tty0/active?
To: stian@nixia.no
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Greg KH <gregkh@suse.de>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Jan 26, 2012 at 11:11 PM,  <stian@nixia.no> wrote:
>> Hi!
>>
>> systemd goes nuts on UML.
>> While hunting down all issues I found out that systemd wants to read from
>> /sys/class/tty/tty0/active.
>
> Kernel version?

Linus' tree as of today.

-- 
Thanks,
//richard
