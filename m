Return-Path: <richard@nod.at>
Message-ID: <5547734A.6070702@nod.at>
Date: Mon, 04 May 2015 15:25:30 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1430744021-4140-1-git-send-email-richard@nod.at> <CAMuHMdVEJPoBJmMV7EPLNBunpER86ZXKGSTfVDhR3y6GYM-xrg@mail.gmail.com>
In-Reply-To: <CAMuHMdVEJPoBJmMV7EPLNBunpER86ZXKGSTfVDhR3y6GYM-xrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] hostfs: Use correct mask for file mode
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, markus.stenberg@iki.fi
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 04.05.2015 um 15:22 schrieb Geert Uytterhoeven:
> On Mon, May 4, 2015 at 2:53 PM, Richard Weinberger <richard@nod.at> wrote:
>> --- a/fs/hostfs/hostfs_kern.c
>> +++ b/fs/hostfs/hostfs_kern.c
>> @@ -581,7 +581,7 @@ static int hostfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
>>         if (name == NULL)
>>                 goto out_put;
>>
>> -       fd = file_create(name, mode & S_IFMT);
>> +       fd = file_create(name, mode & 0777);
> 
> "(S_IRWXU | S_IRWXG | S_IRWXO)"?

I thought about that too but did not see a real benefit
as 0777 is well known and self describing.

Thanks,
//richard

