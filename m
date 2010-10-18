Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Date: Mon, 18 Oct 2010 13:22:41 +0200
From: Richard Weinberger <richard@nod.at>
Subject: Re: Fwd: Re: UML kernel crash of v2.6.36-rcX kernel
In-Reply-To: <201010181314.27780.toralf.foerster@gmx.de>
References: <201010131328.06465.toralf.foerster@gmx.de>
 <201010181105.17077.toralf.foerster@gmx.de>
 <AANLkTi=UyWg6PUrE_jEs0oqZ_tVw1mMQsoUrDnnqtcHa@mail.gmail.com>
 <201010181314.27780.toralf.foerster@gmx.de>
Message-ID: <64b54ba40b0fdec8e5437061e86457b4@radon2.swed.at>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, Christoph Hellwig <hch@lst.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, 18 Oct 2010 13:14:26 +0200, Toralf Förster
<toralf.foerster@gmx.de> wrote:
> richard -rw- weinberger wrote at 11:31:31
>> Does this help?
>>
>> --- linux-2.6.36-rc8/fs/hostfs/hostfs_user.c.orig       2010-10-18
>> 11:24:33.844592000 +0200
>> +++ linux-2.6.36-rc8/fs/hostfs/hostfs_user.c    2010-10-18
>> 11:24:44.594679000 +0200
>> @@ -388,6 +388,6 @@
>>         spare_out[1] = buf.f_spare[1];
>>         spare_out[2] = buf.f_spare[2];
>>         spare_out[3] = buf.f_spare[3];
>> -       spare_out[4] = buf.f_spare[4];
>> +
>>         return 0;
>>  }
> 
> yes - definitely (BTW I like a preceeding "diff --git" line to make
> the patch
> utility happy ;) )

Good to know. I'll submit a patch (with git ;)).

Thanks,
//richard
