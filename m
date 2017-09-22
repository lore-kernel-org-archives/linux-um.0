Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] arch: remove unused *_segments() macros/functions
References: <20170922074242.20868-1-tklauser@distanz.ch>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <9d3545c5-367c-da94-bbbf-b260ef4bf2d8@synopsys.com>
Date: Fri, 22 Sep 2017 09:16:24 -0700
MIME-Version: 1.0
In-Reply-To: <20170922074242.20868-1-tklauser@distanz.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-am33-list@redhat.com, linux-c6x-dev@linux-c6x.org, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-metag@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 09/22/2017 12:42 AM, Tobias Klauser wrote:
> Some architectures define the no-op macros/functions copy_segments,
> release_segments and forget_segments. These are used nowhere in the
> tree, so removed them.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>   arch/arc/include/asm/processor.h        |  3 ---

Acked-by: Vineet Gupta <vgupta@synopsys.com>   [for arch/arc]

Thx,
-Vineet

