Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Zz2yh-0005yA-Sl
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 13:40:51 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Zz2yd-0002m1-62
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 13:40:51 +0000
References: <1446480997-155855-1-git-send-email-aivanov@brocade.com>
	<563D2217.1070002@nod.at>
	<CAKD1Yr29+9ZiG+ovhmpQE_Rm7Cp7u0sDDsN7fF6Co+y40cF3Gw@mail.gmail.com>
	<564C21FA.1010808@kot-begemot.co.uk>
	<CAKD1Yr0uNgTk90J00URiaxaWgeDB6rxUA7+Osy1-macXz3dQ_Q@mail.gmail.com>
	<564C3186.60803@nod.at>
	<CAKD1Yr2psSBLn3hDnsci=4S4Mey0UojUE5d_qEd9sdbhn+8EEg@mail.gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <564C7FD6.40909@nod.at>
Date: Wed, 18 Nov 2015 14:40:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAKD1Yr2psSBLn3hDnsci=4S4Mey0UojUE5d_qEd9sdbhn+8EEg@mail.gmail.com>
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
To: Lorenzo Colitti <lorenzo@google.com>
Cc: Thomas Meyer <thomas@m3y3r.de>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Hi!

Am 18.11.2015 um 14:32 schrieb Lorenzo Colitti:
> On Wed, Nov 18, 2015 at 5:06 PM, Richard Weinberger <richard@nod.at> wrote:
>>
>>> That command line doesn't work, but if you remove the -lrt and put it
>>> at the end of the line, it starts working. Is the order significant?
>>> Or is it a bug in GCC's command line parsing?
>>
>> The order matters.
>> -lrt has to be placed after all object files which need the rt library.
>> Can you double check whether this is the case?
> 
> No, it's not the case. The error is when linking arch/um/os-Linux/built-in.o:
> 
> arch/um/os-Linux/built-in.o: In function `os_timer_create':
> /android/kernel/android/arch/um/os-Linux/time.c:51: undefined
> reference to `timer_create'
> 
> and in the generated command line, -lrt appears
> beforearch/um/os-Linux/built-in.o:
> 
> + gcc -Wl,-rpath,/lib64 -m64 -Wl,-rpath,/lib -Wl,--wrap,malloc
> -Wl,--wrap,free -Wl,--wrap,calloc -Wl,-m -Wl,elf_x86_64 -lrt -o
> .tmp_vmlinux1 -Wl,-T,./arch/um/kernel/vmlinux.lds init/built-in.o
> -Wl,--start-group usr/built-in.o arch/um/kernel/built-in.o
> arch/um/drivers/built-in.o arch/um/os-Linux/built-in.o
> arch/x86/crypto/built-in.o arch/x86/um/built-in.o kernel/built-in.o
> certs/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o
> security/built-in.o crypto/built-in.o block/built-in.o lib/lib.a
> lib/built-in.o drivers/built-in.o sound/built-in.o firmware/built-in.o
> net/built-in.o virt/built-in.o -Wl,--end-group -lutil
> 
> Taking -lrt out of arch/um/Makefile and putting it into
> link-vmlinux.sh, as per the patch I suggested above, results in -lrt
> being the last thing on the command line, after -lutil.
> 

Okay, please send a proper patch. :-)

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

