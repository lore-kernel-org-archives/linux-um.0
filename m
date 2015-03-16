Return-Path: <richard@nod.at>
Message-ID: <5506CA23.8090106@nod.at>
Date: Mon, 16 Mar 2015 13:18:43 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1426506079-26183-1-git-send-email-richard@nod.at>	<1426506079-26183-8-git-send-email-richard@nod.at> <CAMuHMdXpkyvoTRYZ5X4dVNKoHA=seiYpS7pFSZc+fzxFRM=r2Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXpkyvoTRYZ5X4dVNKoHA=seiYpS7pFSZc+fzxFRM=r2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [uml-devel] [PATCH 07/15] hostfs: Remove open coded strcpy()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 16.03.2015 um 13:03 schrieb Geert Uytterhoeven:
> On Mon, Mar 16, 2015 at 12:41 PM, Richard Weinberger <richard@nod.at> wrote:
>> --- a/fs/hostfs/hostfs_kern.c
>> +++ b/fs/hostfs/hostfs_kern.c
>> @@ -105,11 +105,10 @@ static char *__dentry_name(struct dentry *dentry, char *name)
> 
> This code looks fishy to me...
> 
> First we have:
> 
>     len = strlen(root);
>     strlcpy(name, root, PATH_MAX);
> 
> (I notice the code used strncpy() before. One difference with strlcpy()
>  is that strncpy() fills the remaining of the destination buffer with zeroes.)
> 
> Then:
> 
>>                 __putname(name);
>>                 return NULL;
>>         }
>> -       if (p > name + len) {
>> -               char *s = name + len;
> 
> Unless strlcpy() truncated the string (which is unlikely, as root
> cannot be longer
> than PATH_MAX?), s = name + len now points to the zero terminator.
> So the below would copy just one single byte:
> 
>> -               while ((*s++ = *p++) != '\0')
>> -                       ;
>> -       }
>> +
>> +       if (p > name + len)
>> +               strcpy(name + len, p);
>> +
> 
> What is this code really supposed to do?

Hostfs' __dentry_name() builds the real path. i.e, the prefix on the host side
plus the requested path in UML.

"strlcpy(name, root, PATH_MAX);" copies the host prefix into name and then
the "strcpy(name + len, p);" copies the requested path into it.

The trick is that both share the same buffer, allocated by dentry_path_raw().
Therefore this bounds check works:
        if (len > p - name) {
                __putname(name);
                return NULL;
        }

Is it now clearer or did I miss something?
I agree that this code is tricky. :)

Thanks,
//richard

