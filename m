Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZyxlI-0005Xe-4a
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 08:06:40 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZyxlG-0001Cl-Fm
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 08:06:40 +0000
References: <1446480997-155855-1-git-send-email-aivanov@brocade.com>
	<563D2217.1070002@nod.at>
	<CAKD1Yr29+9ZiG+ovhmpQE_Rm7Cp7u0sDDsN7fF6Co+y40cF3Gw@mail.gmail.com>
	<564C21FA.1010808@kot-begemot.co.uk>
	<CAKD1Yr0uNgTk90J00URiaxaWgeDB6rxUA7+Osy1-macXz3dQ_Q@mail.gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <564C3186.60803@nod.at>
Date: Wed, 18 Nov 2015 09:06:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAKD1Yr0uNgTk90J00URiaxaWgeDB6rxUA7+Osy1-macXz3dQ_Q@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH v4] um: Switch clocksource to hrtimers
To: Lorenzo Colitti <lorenzo@google.com>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Thomas Meyer <thomas@m3y3r.de>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Am 18.11.2015 um 08:10 schrieb Lorenzo Colitti:
> On Wed, Nov 18, 2015 at 4:00 PM, Anton Ivanov
> <anton.ivanov@kot-begemot.co.uk> wrote:
>> It is.
>>
>> You need -lrt to link in HR timers. However, the original patch should add
>> that to the library list. I need to understand why it does not in the dm
>> tree.
> 
> I noticed that command already does contain "-lrt", just in a
> different place. It starts off with:
> 
> gcc -Wl,-rpath,/lib64 -m64 -Wl,-rpath,/lib -Wl,--wrap,malloc
> -Wl,--wrap,free -Wl,--wrap,calloc -Wl,-m -Wl,elf_x86_64 -lrt <...>
> 
> That command line doesn't work, but if you remove the -lrt and put it
> at the end of the line, it starts working. Is the order significant?
> Or is it a bug in GCC's command line parsing?

The order matters.
-lrt has to be placed after all object files which need the rt library.
Can you double check whether this is the case?

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

