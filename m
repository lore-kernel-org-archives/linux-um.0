Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BG6Am-0003r7-W5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2004 18:05:08 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BG6Am-0000u4-CY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2004 18:05:08 -0700
Message-ID: <072401c4273d$99b857e0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.58.0404162157280.29213@boston.corp.fedex.com>
Subject: Re: [uml-devel] patch for 2.6.6-rc1
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Wed, 21 Apr 2004 03:11:38 +0200
To: Jeff Chua <jeff98@silk.corp.fedex.com>, UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

hi!

i tried to compile a 2.6.6-rc1 today - but it didn`t work for me.

do i need additional patches besides the ones posted in jeff`s mail ? (jeffs patches seem really small sized - uml-patch is usually
>100kb)

applying 00-2.6.6-v0-host-SKAS2.patch.bz2 to a vanilla 2.6.6-rc1 kernel fails. applying the guest patches fails, too.

i assume i missed another patch to apply to 2.6.6-rc1 befory applying jeffs patches
OR
jeff did a mistake
OR
kernel-2.6.6-r1 changed in the meanwhile (being trojanized on kernel.org?) :)

can somebody help me to get a 2.6.6-r1-skas-host and 2.6.6-r1-uml running ?

regards
roland

----- Original Message ----- 
From: "Jeff Chua" <jeff98@silk.corp.fedex.com>
To: "UserModeLinux" <user-mode-linux-devel@lists.sourceforge.net>
Sent: Friday, April 16, 2004 4:04 PM
Subject: [uml-devel] patch for 2.6.6-rc1


>
> Here's patch to make uml compiles and run with 2.6.6-rc1.
>
> 1) Host 2.6.6-rc1 has 00-2.6.6-v0-host-SKAS2.patch.bz2 applied.
>
> 2) Guest has patch.2.6.5-uml1.fix applied, make mrproper ARCH=um, then
>    patch.266rc1-1 applied.
>
> I fudged those filed to make it compile and run. Please verify. I know
> TASK_DEBUGREGS is incorrect, but since I don't use the debug mode, I
> simply set to 1 to make it run, but it may not be right if you need to
> debug uml. Hopefully someone can come up with a better patch.
>
>
> Thanks,
> Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
