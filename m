Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3Oyr-00034y-TK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Mar 2004 16:32:21 -0800
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B3Oyq-0001Rf-In for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Mar 2004 16:32:20 -0800
Message-ID: <306501c40bb8$228bece0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <200403120313.i2C3DstV005296@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] uml-patch-2.6.4-1
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
Date: Wed, 17 Mar 2004 01:38:14 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

did some stresstesting (i/o, scheduler - system loadavg ~50) - and my first impression is:

rock solid!

thanks jeff!

regards
roland


----- Original Message ----- 
From: "Jeff Dike" <jdike@addtoit.com>
To: <linux-kernel@vger.kernel.org>; <user-mode-linux-devel@lists.sourceforge.net>
Sent: Friday, March 12, 2004 4:13 AM
Subject: [uml-devel] uml-patch-2.6.4-1


> This patch updates UML to 2.6.4.  Besides the update, there were the following
> changes since the last patch:
> a bug which caused either a crash in the kernel or a BUG at exit.c:793
> was fixed
> a bug which caused a crash when a process tried to dump core was fixed
> the hang early in boot on GHz hosts is gone
> various other
> 
> The 2.6.4-1 UML patch is available at
> http://www.user-mode-linux.org/mirror/uml-patch-2.6.4-1.bz2
> 
> BK users can pull my 2.5 repository from
> http://www.user-mode-linux.org:5000/uml-2.5
> 
> For the other UML mirrors and other downloads, see 
>         http://user-mode-linux.sourceforge.net/dl-sf.html
>  
> Other links of interest:
>  
>         The UML project home page : http://user-mode-linux.sourceforge.net
>         The UML Community site : http://usermodelinux.org
> 
> Jeff
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
