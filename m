Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1756632AbZIVOFI@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CCABB2CC-E9F7-4153-8B60-85619DE71A13@kernel.crashing.org>
References: <Pine.LNX.4.64.0909192149250.27171@ask.diku.dk>
	 <20090921160532.GC3868@hack>
	 <CCABB2CC-E9F7-4153-8B60-85619DE71A13@kernel.crashing.org>
Date: Tue, 22 Sep 2009 22:05:08 +0800
Message-ID: <2375c9f90909220705m6767ace3y5b431d1aa26ef945@mail.gmail.com>
Subject: Re: [PATCH 5/5] arch/um: remove duplicate structure field 
	initialization
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Julia Lawall <julia@diku.dk>, jdike@addtoit.com, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Sep 22, 2009 at 12:26 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>> "
>> The initialization shall occur in initializer list order, each
>> initializer provided for a particular subobject overriding any
>> previously listed initializer for the same subobject [...]
>> "
>>
>> I am wondering why gcc doesn't (can't?) complain about this?
>
> Does -Woverride-init (included in -Wextra / -W) not work?  If so, please
> file a bug report.

Hmm, right, it works, but it seems that Linux kernel doesn't use it.
Maybe we should add it? :-/
