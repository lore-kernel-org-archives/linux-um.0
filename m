Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: kselftests results under uml
References: <c1eef43f-fac4-49b7-a069-6922f641ddfc@email.android.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <db3b0a6c-d1f5-56f8-0ef5-7422085b1336@osg.samsung.com>
Date: Thu, 24 Aug 2017 14:20:25 -0600
MIME-Version: 1.0
In-Reply-To: <c1eef43f-fac4-49b7-a069-6922f641ddfc@email.android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Meyer <lkml@m3y3r.de>
Cc: Thomas Meyer <thomas@m3y3r.de>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Shuah Khan <shuahkh@osg.samsung.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 08/24/2017 02:06 PM, Thomas Meyer wrote:
> Am 24.08.2017 9:34 nachm. schrieb Shuah Khan <shuahkh@osg.samsung.com>:
> 
>     Hi Thomas,
> 
>     On 08/24/2017 01:12 PM, Thomas Meyer wrote:
>     > Hi,
>     >
>     > I am writing a script which bundles all kselftests and run them under an UML
>     > kernel.
> 
>     Nice!
> 
>     >
>     > The script is available here:
>     > https://github.com/thomasmey/uml/blob/master/uml-fedora-kselftest.sh
>     >
>     > kselftests needed some fixing on debian. See the commits here:
>     > https://github.com/thomasmey/linux/commits/devel
> 
>     I will take a look at these. Would you be interested in sending upstream
>     patches for these fixes?
> 
> I did send all um fixes upstream. Regarding https://github.com/thomasmey/linux/commit/6b0ed22e4a0990e4990f95b5aa98c19d14367bd7
> 
> I would like to send it upstream bit I don't know how to tell clang to include the glibc headers in a portable way (is this maybe an Debian bug?!)
> 

I am not sure. I don't use clang.

> 
>     >
>     > The results are against 4.13.0-rc5-00220-g770414c23190-dirty
>     >
>     > Is anybody interested in those results? If so I can try to further automate
>     > these runs.
> 
>     Yes. Please send them to me and cc linux-kselftest@vger.kernel.org as you
>     have done for this message.
> 
> Okay I'll work some more on this then.
> 
> 
>     >
>     > Some tests fails because either the distro used still misses
>     > some packages, or the uml is buggy, or the tests are buggy. It's on my todo
>     > list to look at all errors in details.
> 
>     Probably both. There are some tests that fail instead of skip when config
>     isn't enabled. We have been fixing them as we find them. You can find fixes
>     and enhancements slated for 4.14-rc1 in linux-kselftest next.
> 
> One question regarding modules:
> As my kernel uses an allmodconfig, some test seems to modprobe the modules they need by itself, some fail when a necessary module is not loaded, what's your opinion on that?
> 

Right. Several tests fail the test if modules isn't loaded which isn't correct.
Doing a dry-run and skip the test as opposed failing is the desired behavior.
Please see lib/printf.sh for the correct way to handle it.

Several tests that use modprobe need fixing.

thanks,
-- Shuah

