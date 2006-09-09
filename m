Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GM0Gf-0000om-UD for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Sep 2006 03:40:58 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GM0Gb-0001MT-2W
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Sep 2006 03:40:57 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 9 Sep 2006 12:40:46 +0200
References: <44FBCC0C.8050304@centecnetworks.com>
In-Reply-To: <44FBCC0C.8050304@centecnetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609091240.46472.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [2.6.18-rc6 UML]WARNING: vmlinux - Section
	mismatch: reference to .init.text:find_link from .got after
	'_GLOBAL_OFFSET_TABLE_' (at offset 0x82496b4)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Miao Qingjun <qmiao@centecnetworks.com>

On Monday 04 September 2006 08:47, Miao Qingjun wrote:
> Hi,
>
> How this warning message is caused?
This is an harmless warning which is spit out when dynamic linking is enabled 
(CONFIG_STATIC_LINKING disabled) - ignore it, the fix would be to whitelist 
this case in the checking.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
