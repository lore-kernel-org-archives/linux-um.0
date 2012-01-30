Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4F26EB2F.1080403@nod.at>
Date: Mon, 30 Jan 2012 20:10:39 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1327512234-22578-1-git-send-email-richard@nod.at> <20120130182333.GK23916@ZenIV.linux.org.uk>
In-Reply-To: <20120130182333.GK23916@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] um: Use generic io.h
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 30.01.2012 19:23, schrieb Al Viro:
> On Wed, Jan 25, 2012 at 06:23:53PM +0100, Richard Weinberger wrote:
>> There is no need to implement our own basic io functions.
>> All we need exists already in asm-generic/io.h
>
> Then just do
>
> git rm arch/um/include/asm/io.h
> echo 'generic-y += io.h'>>arch/um/include/asm/Kbuild
> git add arch/um/include/asm/Kbuild
>
> and be done with that.  We are already using generic-y for a bunch of
> headers there...

Will do.

Thanks,
//richard
