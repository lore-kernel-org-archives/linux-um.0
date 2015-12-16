Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1450299596-10780-1-git-send-email-vegard.nossum@oracle.com>
 <5671E30A.8030207@nod.at>
From: Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <5671E3DA.3010506@oracle.com>
Date: Wed, 16 Dec 2015 23:21:14 +0100
MIME-Version: 1.0
In-Reply-To: <5671E30A.8030207@nod.at>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] uml: fix hostfs mknod()
To: Richard Weinberger <richard@nod.at>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 12/16/2015 11:17 PM, Richard Weinberger wrote:
> Am 16.12.2015 um 21:59 schrieb Vegard Nossum:
>> An inverted return value check in hostfs_mknod() caused the function
>> to return success after handling it as an error (and cleaning up).
>>
[...]
>
> Applied! :-)
>
> BTW: How did you create this patch? I had to apply it by hand using -p0...
> git am didn't like it.

Ah, sorry, I have diff.noprefix=true since I like to double click on
filenames in a diff (there's probably a way to configure the selection
to skip '[ab]/' prefixes when you do that but this was easier). git am
-p0 should work too.

Thanks!


Vegard
