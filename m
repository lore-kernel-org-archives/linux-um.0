Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRBk0-0001ly-NF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 10:24:24 -0700
Received: from imap.epfl.ch ([128.178.50.10])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FRBjv-0004Lw-Ph
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 10:24:24 -0700
Received: from [128.178.52.94] (labospc31.epfl.ch [128.178.52.94])
	by imap.epfl.ch (iPlanet Messaging Server 5.0 Patch 3 (built Mar 23
	2001)) with ESMTPA id <0IX90095EF07QG@imap.epfl.ch> for
	user-mode-linux-devel@lists.sourceforge.net; Wed,
	05 Apr 2006 19:24:07 +0200 (MET DST)
From: Olivier Crameri <olivier.crameri@epfl.ch>
Subject: Re: [uml-devel] system call accessing the host os
Message-id: <69927A9D-E6B1-4BD9-A51C-8B71960DBDDC@epfl.ch>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-transfer-encoding: 7BIT
References: <946EDC7F-5F36-4453-93E8-36BBC8D9F032@epfl.ch>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 05 Apr 2006 19:24:04 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Well, yes, I could use this.

But what I'm actually trying to understand is how to properly execute  
regular C within the UML kernel to access the host OS.

Thks,

Olivier

On 5 avr. 06, at 19:18, D. Bahi wrote:

> what about this?
>
> http://user-mode-linux.sourceforge.net/iomem.html
>
> Olivier Crameri wrote:
>> Hi,
>>
>> I'm currently working on a project in which we are using UML to  
>> access
>> the host os and perform some operations.
>> More precisely, we would like to have a system call in UML that  
>> parses
>> a file in the host os.
>>
>> Since the UML kernel is a host process, I naively thought that I  
>> could
>> use regular C directly. Indeed, I was able to create my system call,
>> and then have some other C files compiled using host os headers such
>> as <stdio.h> and <stdlib.h> by putting them in the USER_OBJS list of
>> the Makefile.
>>
>> Unfortunately, I'm having some weird issues that I can't really
>> understand. I can read the file using fread, but only in a buffer  
>> that
>> I allocated using um_kmalloc. If I use a buffer allocated by malloc,
>> the fread fails. Then, even if I replace all  my mallocs by
>> um_kmallocs, some libc functions (such as sscanf) don't seem to work
>> properly. I guess I'm missing something, but I can't figure out what.
>>
>> If anyone of you can help me, I'd really appreciate,
>>
>> With best regards,
>>
>> Olivier
>>
>> P.S.: I'm using 2.6.15.6 with the latest 2.6.15 patch and the guest
>> kernel runs in skas3 mode.
>>
>>
>> -------------------------------------------------------
>> This SF.Net email is sponsored by xPML, a groundbreaking scripting
>> language
>> that extends applications into web and mobile media. Attend the live
>> webcast
>> and join the prime developer group breaking into this new coding
>> territory!
>> http://sel.as-us.falkag.net/sel? 
>> cmd=lnk&kid=110944&bid=241720&dat=121642
>> _______________________________________________
>> User-mode-linux-devel mailing list
>> User-mode-linux-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
