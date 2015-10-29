Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <saurabh.truth@gmail.com>
 <1446110203-21968-1-git-send-email-saurabh.truth@gmail.com>
 <1446130255.2757.168.camel@perches.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <563234A0.1010901@nod.at>
Date: Thu, 29 Oct 2015 16:00:48 +0100
MIME-Version: 1.0
In-Reply-To: <1446130255.2757.168.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3] um: net: replace GFP_KERNEL with GFP_ATOMIC when
 spinlock is held
To: Joe Perches <joe@perches.com>, Saurabh Sengar <saurabh.truth@gmail.com>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 29.10.2015 um 15:50 schrieb Joe Perches:
> On Thu, 2015-10-29 at 14:46 +0530, Saurabh Sengar wrote:
>> replace GFP_KERNEL with GFP_ATOMIC while spinlock is held,
>> as code while holding a spinlock should be atomic.
>> GFP_KERNEL may sleep and can cause deadlock,
>> where as GFP_ATOMIC may fail but certainly avoids deadlock
>>
>> Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
>> ---
>> v3: removed the atomic variable, as per Richard comment
> 
> Trivia: You could remove the gfp_mask variables too
> 	and just use GFP_KERNEL and GFP_ATOMIC directly.

Yep.
And "int gfp_mask" does also not make sense, GFP_* is of type
gfp_t.

Thanks,
//richard
