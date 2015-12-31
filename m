Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <781be574-7acc-4891-a12a-571f9e68e2dc@email.android.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56855A9D.8070907@nod.at>
Date: Thu, 31 Dec 2015 17:41:01 +0100
MIME-Version: 1.0
In-Reply-To: <781be574-7acc-4891-a12a-571f9e68e2dc@email.android.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] [PATCH] um: link with -lpthread
To: Thomas Meyer <thomas@m3y3r.de>, Vegard Nossum <vegard.nossum@oracle.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 31.12.2015 um 17:21 schrieb Thomas Meyer:
> Am 31.12.2015 5:06 nachm. schrieb Vegard Nossum <vegard.nossum@oracle.com>:
>>
>> Similarly to commit fb1770aa78a43530940d0c2dd161e77bc705bdac, with gcc 5 
>> on Ubuntu and CONFIG_STATIC_LINK=y I was seeing these linker errors: 
> 
> Hi,
> 
> Oops, yes this patch looks good to me. Honestly I did never test the static link case. Sorry.

Thanks for fixing this.
I'm back from being MIA and start collecting patches soon.

Thanks,
//richard
