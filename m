Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5718c625-bf94-dbd7-c7f5-14957d6b04d9@nod.at>
References: <20161110015326.GA51351@juliacomputing.com> <81f0fb21-e336-ed4c-4346-5f54836f5d8c@nod.at>
 <CABV8kRyfAWTMPoaTid2vDvOUWajegvsiYzwcUTe0_J1H-s9JVQ@mail.gmail.com> <5718c625-bf94-dbd7-c7f5-14957d6b04d9@nod.at>
From: Keno Fischer <keno@juliacomputing.com>
Date: Tue, 15 Nov 2016 22:45:11 -0500
Message-ID: <CABV8kRwdoL6tdneEWBLQcMsKpdG4nAAP+R98O7pBUKJ+-HdWJg@mail.gmail.com>
Subject: Re: [PATCH] um: Fix compile failure due to current_text_address() definition
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Just as an FYI, the linker bug has been fixed in binutils.

On Fri, Nov 11, 2016 at 5:07 PM, Richard Weinberger <richard@nod.at> wrote:
> On 11.11.2016 22:03, Keno Fischer wrote:
>> Did you have CONFIG_INET set? I'm attaching my full .config. This is
>> on vanilla Ubuntu 16.10.
>
> Yes, CONFIG_INET is set. Let my try on Ubuntu. ;-\
>
>> I did see the same error when building with `CONFIG_STATIC_LINK=y`.
>> Note that I also, separately, ran into a linker problem, though I
>> believe it is unrelated to this patch
>> (though perhaps is related to the problem you're seeing?):
>> https://sourceware.org/bugzilla/show_bug.cgi?id=20800.
>
> This seems to be an UML<->glibc issue.
> memmove() is now an ifunc and for whatever reason it does not work with UML.
>
>> I'd also be happy to provide you with ssh access to the machine that
>> I'm seeing this on if that
>> would be helpful.
>
> Okay, let me try myself first. I think I'm able to install Ubuntu. :)
>
> Thanks,
> //richard

