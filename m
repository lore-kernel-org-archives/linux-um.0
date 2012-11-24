Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <50B08D28.40809@gmail.com>
Date: Sat, 24 Nov 2012 10:02:32 +0100
From: Marco Stornelli <marco.stornelli@gmail.com>
MIME-Version: 1.0
References: <508276D3.5000708@gmail.com> <50A8A382.7020400@gmail.com>
In-Reply-To: <50A8A382.7020400@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] hostfs: fix a not needed double check
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Il 18/11/2012 09:59, Marco Stornelli ha scritto:
> Il 20/10/2012 12:02, Marco Stornelli ha scritto:
>> With the commit 3be2be0a32c18b0fd6d623cda63174a332ca0de1 we removed
>> vmtruncate,
>> but actaully there is no need to call inode_newsize_ok() because the
>> checks are
>> already done in inode_change_ok() at the begin of the function.
>>
>> Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>

I didn't receive any feedback from Weinberger, could you consider this 
patch for next -rc?

Thanks.

Marco
