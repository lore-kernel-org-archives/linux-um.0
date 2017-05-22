Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [uml-devel] [PATCH] um: Add mark_rodata_ro support.
References: <1495059066.27187.2.camel@m3y3r.de>
 <CAFLxGvxC2eRKjottu5rW4vSb-keSOwESw2-MLUUz6HhFVMoXvw@mail.gmail.com>
 <7A5DDA50-2F78-4DF2-9D0B-FC6E8A49D6F8@m3y3r.de>
 <d7195d6f-4bfc-d564-e011-1ea86d199649@nod.at>
 <56E4E4A4-1D68-4A1F-A80C-D924BA907BC7@m3y3r.de>
From: Richard Weinberger <richard@nod.at>
Message-ID: <226aeb10-87bc-f891-e709-1125e4d6011c@nod.at>
Date: Mon, 22 May 2017 21:37:17 +0200
MIME-Version: 1.0
In-Reply-To: <56E4E4A4-1D68-4A1F-A80C-D924BA907BC7@m3y3r.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Thomas,

Am 22.05.2017 um 21:18 schrieb Thomas Meyer:
> 
>> Am 22.05.2017 um 20:34 schrieb Richard Weinberger <richard@nod.at>:
>>
>> Thomas,
>>
>>> Am 22.05.2017 um 20:14 schrieb Thomas Meyer:
>>> It's purely cosmetic; to get rid of the boot message: "This architecture does not have kernel memory protection." in init/main.c
>>>
>>> Which isn't true for UML as all read only stuff should end up in a read only ELF section. Shouldn't it?
>>
>> Hmm, reading /proc/<pid of uml>/maps tells a different story on my host.
>> Did you check?
> 
> No... I may should have done so...
> 
> Okay, but it should be possible to mprotect those regions ?

Yes, it should.
Can you give it a try?

Thanks,
//richard

