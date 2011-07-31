Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
Date: Sun, 31 Jul 2011 23:24:21 +0100
In-Reply-To: <CAFLxGvy0QqoySDFwZpygHeXvQ7hG-B7z5iZq8qx3GUkFX8w2RQ@mail.gmail.com>
References: <1312066693.22074.50.camel@i7.infradead.org>
	 <1312066923.22074.53.camel@i7.infradead.org>
	 <CAFLxGvy0QqoySDFwZpygHeXvQ7hG-B7z5iZq8qx3GUkFX8w2RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1312151063.18010.25.camel@i7.infradead.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/5] um: Use __i386__ in ifdef for vsyscall exports, not
 SUBARCH_i386
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Arnaud Lacombe <lacombar@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, 2011-08-01 at 00:11 +0200, richard -rw- weinberger wrote:
> 
> Why do we need this? 

The arch/x86_64 and arch/i386 directories were removed from the kernel
four years ago, and replaced by the 'x86' arch. UML is still dependent
on the legacy SUBARCH=i386 and SUBARCH=x86_64 settings, and the patch
sequence I just posted makes it cope with SUBARCH=x86.

-- 
dwmw2

